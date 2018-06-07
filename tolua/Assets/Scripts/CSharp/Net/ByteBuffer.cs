using System;
using System.Collections.Generic;
using System.Text;
using UnityEngine;

public class ByteBuffer
{
    List<byte> mBuferList = new List<byte>();

    public void Add(byte b)
    {
        mBuferList.Add(b);
    }

    public void Print()
    {
        string str = "";
        for (int i = 0; i < mBuferList.Count; ++i)
        {
            str += mBuferList[i].ToString() + " ";
        }
        Debug.Log(str);
    }
    public void Print(string varStr)
    {
        Debug.Log(varStr.Length);
        var bytes = Encoding.UTF8.GetBytes(varStr);
        
        string str = "";
        for (int i = 0; i < bytes.Length; ++i)
        {
            str += bytes[i].ToString() + " ";
        }
        Debug.Log(str);
    }

    public byte[] GetBuffer()
    {
        return mBuferList.ToArray();
    }

    public int GetLength()
    {
        return mBuferList.Count;
    }

}

