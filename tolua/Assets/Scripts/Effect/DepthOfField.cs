using UnityEngine;
using System.Collections;

/*
 * 景深效果
 * CharacterAlpha.shader并不支持
 * 
 */

[ExecuteInEditMode]
[RequireComponent(typeof(Camera))]
public class DepthOfField : MonoBehaviour {
 
    /// <summary>
    /// 摄像机焦点
    /// </summary>
    [Range(0.0f, 1000.0f)]
    public float focalDistance = 10.0f;
    //分辨率  
    public int downSample = 1;
    //采样率  
    public int samplerScale = 1;

    public Shader shader;
    private Material mMaterial;
    protected Material material
    {
        get
        {
            if (mMaterial == null)
            {
                mMaterial = new Material(shader);

                mMaterial.hideFlags = HideFlags.DontSave;
            }
            return mMaterial;
        }
    }

    private Camera mCamera = null;
    public Camera mainCamera
    {
        get
        {
            if (mCamera == null)
                mCamera = GetComponent<Camera>();
            return mCamera;
        }
    }

    void OnEnable()
    {
        //maincam的depthTextureMode是通过位运算开启与关闭的  
        mainCamera.depthTextureMode |= DepthTextureMode.Depth;
        if(shader == null)
        {
            shader = Shader.Find("Camera/DepthOfField");
        }
    }

    void OnDisable()
    {
        mainCamera.depthTextureMode &= ~DepthTextureMode.Depth;
    }


    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (material)
        {
            //首先将我们设置的焦点限制在远近裁剪面之间  
            Mathf.Clamp(focalDistance, mainCamera.nearClipPlane, mainCamera.farClipPlane);

            //申请两块RT，并且分辨率按照downSameple降低  
            RenderTexture temp1 = RenderTexture.GetTemporary(source.width >> downSample, source.height >> downSample, 0, source.format);
            RenderTexture temp2 = RenderTexture.GetTemporary(source.width >> downSample, source.height >> downSample, 0, source.format);

            //直接将场景图拷贝到低分辨率的RT上达到降分辨率的效果  
            Graphics.Blit(source, temp1);

            //高斯模糊，两次模糊，横向纵向，使用pass0进行高斯模糊  
            material.SetVector("_offsets", new Vector4(0, samplerScale, 0, 0));
            Graphics.Blit(temp1, temp2, material, 0);
            material.SetVector("_offsets", new Vector4(samplerScale, 0, 0, 0));
            Graphics.Blit(temp2, temp1, material, 0);

            //景深操作，景深需要两的模糊效果图我们通过_BlurTex变量传入shader  
            material.SetTexture("_BlurTex", temp1);

            ////设置shader的参数，主要是焦点和远近模糊的权重，权重可以控制插值时使用模糊图片的权重 
            material.SetFloat("_focalDistance", FocalDistance01(focalDistance));

            //使用pass1进行景深效果计算，清晰场景图直接从source输入到shader的_MainTex中  
            Graphics.Blit(source, destination, material, 1);

            //释放申请的RT  
            RenderTexture.ReleaseTemporary(temp1);
            RenderTexture.ReleaseTemporary(temp2);
        }
    }
    Vector3 worldPosition;
    Vector3 viewPosition;
    float focalDistance01;
    //计算设置的焦点被转换到01空间中的距离，以便shader中通过这个01空间的焦点距离与depth比较  
    private float FocalDistance01(float distance)
    {
        worldPosition = mainCamera.transform.position + mainCamera.transform.forward * (distance - mainCamera.nearClipPlane);
        viewPosition = mainCamera.WorldToViewportPoint(worldPosition);
        focalDistance01= viewPosition.z / (mainCamera.farClipPlane - mainCamera.nearClipPlane);
        return focalDistance01;
    }
}
