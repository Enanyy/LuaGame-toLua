// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "CharacterAlpha" {
Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}
	SubShader {
	    Tags{
	        "Queue"="Transparent" 
	        "IgnoreProjector"="True" 
	        "RenderType"="Transparent"
	    }
	    LOD 200
	    Blend SrcAlpha OneMinusSrcAlpha 
	    Cull Off
	    Pass{
	        CGPROGRAM
	        #pragma vertex vert
	        #pragma fragment frag
	        #pragma multi_compile DUMMY PIXELSANP_ON
	        #include "UnityCG.cginc"
	        
	        struct appdata_t{
	            float4 vertex:POSITION;
	            float4 color:COLOR;
	            float2 texcoord:TEXCOORD0;
	        };
	        
	        struct v2f{
	            float4 vertex:POSITION;
	            half2 texcoord:TEXCOORD0;
	            fixed4 color :COLOR;
	        };
	        
	        sampler2D _MainTex;
	        float4 _MainTex_ST;
	        
	        v2f vert(appdata_t i){
	            v2f o;
				UNITY_INITIALIZE_OUTPUT(v2f, o);
	            o.vertex = UnityObjectToClipPos(i.vertex);
	            o.texcoord = TRANSFORM_TEX(i.texcoord,_MainTex).xy;
	            return o;
	        }
	        
	        
	        half4 frag(v2f i):COLOR{
	            half4 col = tex2D(_MainTex,i.texcoord);
				clip(col.a - 0.1);
	            return col;
	        }
	        ENDCG
	    }
	}
	FallBack "Diffuse"
}
