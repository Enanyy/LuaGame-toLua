using System;
using UnityEngine;

[RequireComponent(typeof(UITexture))]
public class BlurTexture : MonoBehaviour
{
    RenderTexture mRenderTexture;
    UITexture mTexture;
    UITexture mainTexture
    {
        get {
            if(mTexture== null)
            {
                mTexture = GetComponent<UITexture>();
                if(mTexture==null)
                {
                    mTexture = gameObject.AddComponent<UITexture>();
                   
                }
                mTexture.width = Screen.width;
                mTexture.height = Screen.height;
            }

            return mTexture;
        }
    }

    public BlurEffect mBlurEffect;

    [ContextMenu("Sample")]
    public void Sample()
    {
      if(mBlurEffect)
        {
            mBlurEffect.BeginRender(RenderFinish);
        }
    }

    private void RenderFinish()
    {
        mainTexture.enabled = false;

        mRenderTexture = RenderTexture.GetTemporary(mBlurEffect.currentTexture.width, mBlurEffect.currentTexture.height, 0, mBlurEffect.currentTexture.format);
        Graphics.Blit(mRenderTexture, mBlurEffect.currentTexture);

        mainTexture.mainTexture = mRenderTexture;

        if (mBlurEffect)
        {
            mBlurEffect.enabled = false;
        }
        mainTexture.enabled = true;
        mainTexture.SetAnchor(transform.parent.gameObject, -1, -1, 5, 5);
    }

    private void Update()
    {
        if (mBlurEffect == null) return;
    }

    private void OnDestroy()
    {
        if (mRenderTexture)
        {
            RenderTexture.ReleaseTemporary(mRenderTexture);
        }
    }
}

