using UnityEngine;
using System.Collections;

public class WaterWave : MonoBehaviour {

    private string mShaderName = "Custom/WaterWave";

    public Shader mShader;
    private Material mMaterial;
    Shader shader
    {
        get
        {
            if (mShader == null)
            {
                //找到当前的Shader文件
                mShader = Shader.Find(mShaderName);
            }
            return mShader;
        }
    }

    Material material
    {
        get
        {
            if (mMaterial == null)
            {
                mMaterial = new Material(shader);
                mMaterial.hideFlags = HideFlags.HideAndDontSave;
            }
            return mMaterial;
        }
    }


    //距离系数  
    public float distanceFactor = 60.0f;
    //时间系数  
    public float timeFactor = -30.0f;
    //sin函数结果系数  
    public float totalFactor = 1.0f;

    //波纹宽度  
    public float waveWidth = 0.3f;
    //波纹扩散的速度  
    public float waveSpeed = 0.3f;

    private float waveStartTime;

    private Vector4 center = new Vector4(0.5f, 0.5f, 0, 0);

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (material)
        {
            //计算波纹移动的距离，根据enable到目前的时间*速度求解  
            float waveDistance = (Time.time - waveStartTime) * waveSpeed;
            //设置一系列参数  
            material.SetFloat("_DistanceFactor", distanceFactor);
            material.SetFloat("_TimeFacttor", timeFactor);
            material.SetFloat("_TotalFactor", totalFactor);
            material.SetFloat("_Width", waveWidth);
            material.SetFloat("_WaveDistance", waveDistance);
            material.SetVector("_Center", center);
            Graphics.Blit(source, destination, material);
        }
    }

    void Update()
    {
        if (Input.GetMouseButton(0))
        {
            Vector2 mousePos = Input.mousePosition;
            //将mousePos转化为（0，1）区间  
            center = new Vector4(mousePos.x / Screen.width, mousePos.y / Screen.height, 0, 0);
            waveStartTime = Time.time;
        }

    }
}
