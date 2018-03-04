using System;
using System.Net;
using System.IO;
using System.Text;

namespace UD
{
    enum AsyncTaskState
    {
        None,
        Prepare,
        DownLoading,
        Failed,
        Complete
    }
    class AsyncTask
    {
        public string url;
        public string savePath;
        public bool isText;
        public long receivedBytes;
        public long totalBytes;

        public const int bufferSize = 10240;
        public StringBuilder requestData;
        public byte[] bufferRead;
        public HttpWebRequest httpWebRequest;
        public HttpWebResponse httpWebResponse;
        public Stream responseStream;

        public AsyncTaskState asyncTaskState;

        public Exception exception;

        public float idleTime;
        public int retryTime;

        public AsyncTask()
        {
            url = string.Empty;
            savePath = string.Empty;
            isText = false;
            receivedBytes = 0;
            totalBytes = 0;

            bufferRead = new byte[bufferSize];
            requestData = new StringBuilder();


            asyncTaskState = AsyncTaskState.None;

            exception = null;

            idleTime = 0f;
            retryTime = 0;
        }


        public void Release()
        {
            if (responseStream != null)
            {
                responseStream.Close();
                responseStream.Dispose();
                responseStream = null;
            }

            if (httpWebRequest != null)
            {
                httpWebRequest.Abort();
                httpWebRequest = null;
            }

            if (httpWebResponse != null)
            {
                httpWebResponse.Close();
                httpWebResponse = null;
            }

        }

    }

    public class UDownLoader
    {
        public Action<string, long, long> OnDownLoadProgress;

        public Action<string, string> OnDownLoadCompleted;

        public Action<string, Exception> OnDownLoadFailed;

        public bool mFullSpeed = false;

        FileStream fileStream = null;

        AsyncTask asyncTask = null;
        

        /// <summary>
        /// 
        /// </summary>
        public UDownLoader()
        {
            
        }

        /// <summary>
        /// DownLoadFileAsync
        /// </summary>
        /// <param name="url"></param>
        /// <param name="savepath"></param>
        public void DownLoadFileAsync(string url, string savepath)
        {
            DownLoadAsync(url, false, savepath);
        }

        /// <summary>
        /// DownLoadStringAsync
        /// </summary>
        /// <param name="url"></param>
        public void DownLoadStringAsync(string url)
        {
            DownLoadAsync(url, true);
        }

        /// <summary>
        /// DownLoad Async
        /// </summary>
        /// <param name="url">url to download</param>
        /// <param name="url">filepath to save</param>
        /// /// <param name="url">is Text or not</param>
        private void DownLoadAsync(string url, bool isText = false,string savepath="")
        {

            Loom.RunAsync(() => 
            {
                asyncTask = new AsyncTask();
                asyncTask.url = url;
                asyncTask.isText = isText;
                asyncTask.asyncTaskState = AsyncTaskState.Prepare;
                
                try
                {
                    //createfile
                    if (!isText)
                    {
                        string dirpath = savepath.Substring(0, savepath.LastIndexOf("/"));
                        if (Directory.Exists(dirpath) == false)
                        {
                            Directory.CreateDirectory(dirpath);
                        }

                        if(File.Exists(savepath))
                        {
                            fileStream = new FileStream(savepath, FileMode.Append);
                        }
                        else
                        {
                            fileStream = new FileStream(savepath, FileMode.CreateNew);
                        }
                    }

                    HttpWebRequest httpWebRequest = WebRequest.Create(url) as HttpWebRequest;
                    if (!isText)
                    {
                        if(File.Exists(savepath))
                        {
                            httpWebRequest.AddRange((int)fileStream.Length);
                        }
                        else
                        {
                            //httpWebRequest.AddRange(0, AsyncTask.bufferSize);
                        }
                    }

                 


                    asyncTask.httpWebRequest = httpWebRequest;

                    httpWebRequest.BeginGetResponse(new AsyncCallback(ResponseCallback), asyncTask);

                   
                    
                }
                catch (WebException exp)
                {

                    asyncTask.asyncTaskState = AsyncTaskState.Failed;
                    asyncTask.exception = exp;
           
                }
                catch (Exception exp)
                {

                    asyncTask.asyncTaskState = AsyncTaskState.Failed;
                    asyncTask.exception = exp;

                    
                    
                }
            });
        }


        private void ResponseCallback(IAsyncResult result)
        {
           
            AsyncTask asyncTask = result.AsyncState as AsyncTask;
            HttpWebRequest httpWebRequest = asyncTask.httpWebRequest;

            {
                HttpWebResponse httpWebResponse = null;
                Stream responseStream = null;
                try
                {
                  
                    httpWebResponse = httpWebRequest.EndGetResponse(result) as HttpWebResponse;
                   
                    responseStream = httpWebResponse.GetResponseStream();
                  

                    asyncTask.asyncTaskState = AsyncTaskState.DownLoading;
                    asyncTask.httpWebResponse = httpWebResponse;
                    asyncTask.responseStream = responseStream;
                    asyncTask.totalBytes = httpWebResponse.ContentLength;

                   
                    int read = responseStream.Read(asyncTask.bufferRead, 0, AsyncTask.bufferSize);
                  

                    if (read > 0)
                    {
                        asyncTask.receivedBytes += read;


                        if (asyncTask.isText)
                        {
                            asyncTask.requestData.Append(System.Text.Encoding.Default.GetString(asyncTask.bufferRead));
                        }
                        else
                        {
                          
                            fileStream.Write(asyncTask.bufferRead, 0, read);

                          
                            fileStream.Flush();

                          
                        }



                        

                        asyncTask.bufferRead = new byte[AsyncTask.bufferSize];



                        while (true)
                        {
                            read = responseStream.Read(asyncTask.bufferRead, 0, AsyncTask.bufferSize);
                            if (read > 0)
                            {
                                asyncTask.receivedBytes += read;
                                if (asyncTask.isText)
                                {
                                    asyncTask.requestData.Append(System.Text.Encoding.Default.GetString(asyncTask.bufferRead));
                                }
                                else
                                {                             
                                    fileStream.Write(asyncTask.bufferRead, 0, read);
                            
                                    fileStream.Flush();

                                }

                                asyncTask.bufferRead = new byte[AsyncTask.bufferSize];
                            }
                            else
                            {
                                break;
                            }

                            if(mFullSpeed==false)
                            {
                                System.Threading.Thread.Sleep(5);
                            }
                        }

                        asyncTask.httpWebRequest.BeginGetResponse(new AsyncCallback(ResponseCallback), asyncTask);

                     
                    }
                    else
                    {
                       
                        asyncTask.asyncTaskState = AsyncTaskState.Complete;
                        fileStream.Flush();

                    }
                }
                catch (WebException exp)
                {
                   
                    if (exp.Response != null)
                    {
                        httpWebResponse = exp.Response as HttpWebResponse;
                        if (httpWebResponse != null)
                        {
                            switch (httpWebResponse.StatusCode)
                            {
                                case HttpStatusCode.RequestedRangeNotSatisfiable:
                                    {
                                        asyncTask.asyncTaskState = AsyncTaskState.Complete;

                                        return;
                                    }
                                    break;
                            }
                        }

                    }
                   


                    asyncTask.asyncTaskState = AsyncTaskState.Failed;

                    asyncTask.exception = exp;
                }
                catch (Exception exp)
                {
                    asyncTask.asyncTaskState = AsyncTaskState.Failed;

                    asyncTask.exception = exp;
                }
            }
        }

        

        public void Release()
        {
            if (asyncTask != null)
            {
                asyncTask.Release();
            }

            if (fileStream != null)
            {
                fileStream.Flush();
                fileStream.Close();
                fileStream = null;
            }

        }


        public void Update()
        {
            if (asyncTask != null)
            {
                switch(asyncTask.asyncTaskState)
                {
                    case AsyncTaskState.DownLoading:
                        {
                            if (asyncTask.totalBytes > 0)
                            {

                                OnDownLoadProgress(asyncTask.url, asyncTask.receivedBytes, asyncTask.totalBytes);

                            }
                        }
                        break;
                    case AsyncTaskState.Complete:
                        {

                            asyncTask.asyncTaskState = AsyncTaskState.None;

                            Release();

                            if (asyncTask.totalBytes > 0)
                            {
                                OnDownLoadProgress(asyncTask.url, asyncTask.receivedBytes, asyncTask.totalBytes);
                            }

                            OnDownLoadCompleted(asyncTask.url, asyncTask.requestData.ToString());

                        }
                        break;
                    case AsyncTaskState.Failed:
                        {
                            
                            asyncTask.asyncTaskState = AsyncTaskState.None;

                            Release();

                            OnDownLoadFailed(asyncTask.url, asyncTask.exception);

                        }
                        break;
                }

            }
        }
    }

}
