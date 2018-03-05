
using System.Collections;

public static class Helper  {

    static public int MakeMask(params int[] layers)
    {
        int mask = 0;
        for (int i = 0; i < layers.Length; i++)
        {
            mask |= 1 << layers[i];
        }
        return mask;
    }
}
