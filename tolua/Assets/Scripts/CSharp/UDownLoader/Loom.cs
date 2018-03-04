using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System;
using System.Threading;


namespace UD
{
    public class Loom : MonoBehaviour
    {
        public static int maxThreads = 8;
        static int numThreads;

        private static Loom mCurrent;
        private int mCount;
        public static Loom Current
        {
            get
            {
                Initialize();
                return mCurrent;
            }
        }

        void Awake()
        {
            mCurrent = this;
            initialized = true;
        }

        static bool initialized;

        static void Initialize()
        {
            if (!initialized)
            {

                if (!Application.isPlaying)
                    return;
                initialized = true;
                GameObject g = new GameObject("Loom");
                GameObject.DontDestroyOnLoad(g);
                mCurrent = g.AddComponent<Loom>();
            }

        }

        private List<Action> mActionList = new List<Action>();
        public struct DelayedQueueItem
        {
            public float time;
            public Action action;
        }
        private List<DelayedQueueItem> mDelayList = new List<DelayedQueueItem>();

        List<DelayedQueueItem> mCurrentDelay = new List<DelayedQueueItem>();

        public static void QueueOnMainThread(Action action)
        {
            QueueOnMainThread(action, 0f);
        }
        public static void QueueOnMainThread(Action action, float time)
        {
            if (time != 0)
            {
                lock (Current.mDelayList)
                {
                    Current.mDelayList.Add(new DelayedQueueItem { time = Time.time + time, action = action });
                }
            }
            else
            {
                lock (Current.mActionList)
                {
                    Current.mActionList.Add(action);
                }
            }
        }

        public static Thread RunAsync(Action a)
        {
            Initialize();
            while (numThreads >= maxThreads)
            {
                Thread.Sleep(1);
            }
            Interlocked.Increment(ref numThreads);
            ThreadPool.QueueUserWorkItem(RunAction, a);
            return null;
        }

        private static void RunAction(object action)
        {
            try
            {
                ((Action)action)();
            }
            catch
            {
            }
            finally
            {
                Interlocked.Decrement(ref numThreads);
            }

        }


        void OnDisable()
        {
            if (mCurrent == this)
            {

                mCurrent = null;
            }
        }


        List<Action> mCurrentActionList = new List<Action>();



        // Update is called once per frame  
        void Update()
        {
            lock (mActionList)
            {
                mCurrentActionList.Clear();
                mCurrentActionList.AddRange(mActionList);
                mActionList.Clear();
            }

            if (mCurrentActionList.Count > 0)
            {
                var tmpIterCurrentActions = mCurrentActionList.GetEnumerator();
                while (tmpIterCurrentActions.MoveNext())
                {
                    tmpIterCurrentActions.Current();
                }
            }

            lock (mDelayList)
            {
                mCurrentDelay.Clear();


                //消除GC产生（取消Linq 语句的使用）
                var delayedTemp = mDelayList.GetEnumerator();
                while (delayedTemp.MoveNext())
                {
                    var d = delayedTemp.Current;
                    if (d.time <= Time.time)
                    {
                        mCurrentDelay.Add(d);
                    }
                }


                if (mCurrentDelay.Count > 0)
                {
                    var tmpIter = mCurrentDelay.GetEnumerator();
                    while (tmpIter.MoveNext())
                    {
                        mDelayList.Remove(tmpIter.Current);
                    }
                }
            }

            if (mCurrentDelay.Count > 0)
            {
                var tmpIterCurrentDelayed = mCurrentDelay.GetEnumerator();
                while (tmpIterCurrentDelayed.MoveNext())
                {
                    tmpIterCurrentDelayed.Current.action();
                }
            }
        }
    }
}


