using UnityEngine;
using UnityEditor;
using System.Collections.Generic;
using System.IO;
using System;

public class AssetBundleEditor : Editor
{
    [MenuItem("BuildAssetBundle/BuildAssets")]
    static void BuildAssets()
    {
        string tmpOutPath = Application.dataPath + "/../StreamingAssets/";
        if (Directory.Exists(tmpOutPath))
        {
            Directory.Delete(tmpOutPath, true);
        }

        if (Directory.Exists(tmpOutPath) == false)
        {
            Directory.CreateDirectory(tmpOutPath);
        }
        //打包资源
        BuildPipeline.BuildAssetBundles(tmpOutPath, BuildAssetBundleOptions.ChunkBasedCompression, EditorUserBuildSettings.activeBuildTarget);

    }

    [MenuItem("Assets/BuildSelectAssetBundleName")]
    static void BuildSelectAssetBundleName()
    {
        EditorUtility.DisplayProgressBar("Clear AssetBundleName", "AssetBundleName", 0f);

        SetAssetBundleName("");

        EditorUtility.ClearProgressBar();


        UnityEngine.Object[] arr = Selection.GetFiltered(typeof(UnityEngine.Object), SelectionMode.TopLevel);

        for (int i = 0; i < arr.Length; ++i)
        {
            string tmpStringFilePath = AssetDatabase.GetAssetPath(arr[i]);

            Debug.Log(tmpStringFilePath);

            AssetImporter tmpAssetImport = AssetImporter.GetAtPath(AssetDatabase.GetAssetPath(arr[i]));

            if (tmpAssetImport == null) return;

            tmpAssetImport.assetBundleName = tmpAssetImport.assetPath;
        }
        AssetDatabase.Refresh();
        AssetDatabase.SaveAssets();
    }

    [MenuItem("BuildAssetBundle/SetAssetBundleName")]
    static void SetAssetBundleName()
    {
        EditorUtility.DisplayProgressBar("SetAssetBundleName", "SetAssetBundleName", 0f);

        SetAssetBundleName("assetbundle.unity3d");

        EditorUtility.ClearProgressBar();
    }
    [MenuItem("BuildAssetBundle/ClearAssetBundleName")]

    static void ClearAssetBundleName()
    {
        EditorUtility.DisplayProgressBar("SetAssetBundleName", "SetAssetBundleName", 0f);

        SetAssetBundleName("");

        EditorUtility.ClearProgressBar();
    }

    static void SetAssetBundleName(string assetbundleName)
    {
        string tmpStringPathR = Application.dataPath + "/";

        //找到目录里所有资源 修改AssetbundleName
        string[] tmpFileArray = Directory.GetFiles(tmpStringPathR, "*.*", SearchOption.AllDirectories);

        for (int i = 0; i < tmpFileArray.Length; i++)
        {
            string tmpStringFilePath = tmpFileArray[i];

            if (tmpStringFilePath.EndsWith(".cs")
                || tmpStringFilePath.EndsWith(".meta"))
            {
                continue;
            }

            tmpStringFilePath = tmpStringFilePath.Replace("\\", "/").Replace(Application.dataPath + "/", "");
            tmpStringFilePath = "Assets/" + tmpStringFilePath;
            Debug.Log(tmpStringFilePath);
            AssetImporter tmpAssetImport = AssetImporter.GetAtPath(tmpStringFilePath);

            if (tmpAssetImport == null) continue;

            if (tmpStringFilePath.EndsWith(".prefab"))
            {
                GameObject go = AssetDatabase.LoadAssetAtPath<GameObject>(tmpAssetImport.assetPath);
                if (go 
                    && (go.GetComponent<UIRoot>() || go.GetComponent<UIAtlas>()))
                {
                    tmpAssetImport.assetBundleName = assetbundleName;
                }
                else
                {
                    tmpAssetImport.assetBundleName = "";
                }
            }
            else
            {
                tmpAssetImport.assetBundleName = "";
            }
            EditorUtility.DisplayProgressBar("Set AssetBundleName", "Setting:" + tmpStringFilePath, i / (float)tmpFileArray.Length);
        }

        AssetDatabase.Refresh();
        AssetDatabase.SaveAssets();
    }

    [MenuItem("BuildAssetBundle/CheckBsdiff")]
    static void CheckBsDiff()
    {
        string newData = Application.dataPath + "/../StreamingAssets/assetbundle.unity3d";

        string oldFile = Application.dataPath + "/../Assetbundle/assetbundle.unity3d";

        string patchFile = Application.dataPath + "/../Assetbundle/pacth.unity3d";

        try
        {
            using (FileStream output = new FileStream(patchFile, FileMode.Create))
            {
                byte[] oldBytes = File.ReadAllBytes(oldFile);
                byte[] newBytes = File.ReadAllBytes(newData);
                BsDiff.BinaryPatchUtility.Create(oldBytes, newBytes, output);

                Debug.Log(string.Format("Old: {0} New: {1} Diff: {2}", oldBytes.Length, newBytes.Length, output.Length));

                AssetDatabase.Refresh();
            }
        }
        catch (FileNotFoundException ex)
        {
            Debug.Log(ex.ToString());
        }
    }
    [MenuItem("BuildAssetBundle/ApplyDsdiff")]
    static void BsDiffApply()
    {
        string patchFile = Application.dataPath + "/../Assetbundle/pacth.unity3d";
        string oldFile = Application.dataPath + "/../Assetbundle/assetbundle.unity3d";
        string newFile = Application.dataPath + "/../StreamingAssets/assetbundle_new.unity3d";

        try
        {
            using (FileStream input = new FileStream(oldFile, FileMode.Open, FileAccess.Read, FileShare.Read))
            {
                using (FileStream output = new FileStream(newFile, FileMode.Create))
                {
                    BsDiff.BinaryPatchUtility.Apply(input, () => {
                        return new FileStream(patchFile, FileMode.Open, FileAccess.Read, FileShare.Read);
                    }, output);
                }
            }

            Debug.Log("newfile:" + newFile);
            AssetDatabase.Refresh();
        }
        catch (Exception e)
        {
            Debug.LogError(e.Message);
        }
    }

    [MenuItem("BuildAssetBundle/SetEditorMode")]
    static void SetEditorMode()
    {
        PlayerPrefs.SetInt("assetmode", 0);
    }
    [MenuItem("BuildAssetBundle/SetAssetBundleMode")]
    static void SetAssetBundleMode()
    {
        PlayerPrefs.SetInt("assetmode", 1);
    }
}
