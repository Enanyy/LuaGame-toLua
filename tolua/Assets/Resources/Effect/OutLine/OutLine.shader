// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/OutLine" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness("Smoothness", Range(0.1,1)) = 0.5
		_Intensity ("Intensity", Range(0.0,1)) = 0.5
	
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		Pass {
			Tags{ "LightMode" = "ForwardBase" }

			CGPROGRAM
			#pragma vertex vert  
			#pragma fragment frag  
			#include "UnityCG.cginc"

			struct a2v
			{
				float4 vertex:POSITION;
				float3 normal:NORMAL;
				float2 texcoord:TEXCOORD0;
			};

			struct v2f
			{
				float4 pos:SV_POSITION;
				float3 worldPos:TEXCOORD0;
				float3 worldNormal:TEXCOORD1;
				float3 worldViewDir:TEXCOORD2;
				float2 uv:TEXCOORD3;
				//fixed3 color : COLOR;
			};

			fixed4 _Color;
			sampler2D _MainTex;
			//使用了TRANSFROM_TEX宏就需要定义XXX_ST  
			float4 _MainTex_ST;
			float _Glossiness;
			float _Intensity;

			v2f vert(a2v v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				o.worldViewDir = _WorldSpaceCameraPos.xyz - o.worldPos;

				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);

				return o;
			}

			fixed4 frag(v2f i):SV_Target
			{
				fixed4 color = tex2D(_MainTex, i.uv);
				
				fixed3 worldNormal = normalize(i.worldNormal);
				fixed3 worldViewDir = normalize(i.worldViewDir);
				//计算边缘强度
				float rim = 1 - max(0, dot(worldNormal, worldViewDir));
				//color.rgb *= _Color.rgb;// *pow(rim, 1 / _Glossiness);
				//color.rgb += _Color.rgb * smoothstep(1 - _Glossiness, 1.0, rim);
				color.rgb += _Color.rgb * pow(rim, 1/_Glossiness) * _Intensity;
				return color;
			}

			ENDCG
		}

		
	}
	FallBack "Diffuse"
}
