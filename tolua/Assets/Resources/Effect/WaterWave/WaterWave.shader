Shader "Custom/WaterWave" {
	Properties {
		
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		
	
	}
	CGINCLUDE
	#include "UnityCG.cginc"

	uniform  sampler2D _MainTex;
	//使用了TRANSFROM_TEX宏就需要定义XXX_ST  
	uniform float4 _MainTex_ST;
	//Unity内置的像素大小
	float4 _MainTex_TexelSize;

	uniform float _DistanceFactor;
	uniform float _TimeFacttor;
	uniform float _TotalFactor;
	uniform float _Width;
	uniform float _WaveDistance;

	uniform float4 _Center;
	ENDCG

	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		Pass {
			Tags{ "LightMode" = "ForwardBase" }
			ZTest Always
			Cull Off
			ZWrite Off
			Fog{ Mode off }

			CGPROGRAM
			#pragma vertex vert  
			#pragma fragment frag  
			#pragma fragmentoption ARB_precision_hint_fastest   

			struct a2v
			{
				float4 vertex:POSITION;
				
				float2 texcoord:TEXCOORD0;
			};

			struct v2f
			{
				float4 pos:SV_POSITION;
				
				float2 uv:TEXCOORD0;
			
			};

			v2f vert(a2v v)
			{
				v2f o;

				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
			
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);

				return o;
			}

			fixed4 frag(v2f i):SV_Target
			{
#if UNITY_UV_START_AT_TOP
				if (_MainTex_TexelSize.y < 0)
				{
					_Center.y = 1 - _Center.y;
				}
#endif
				float2 direction = _Center.xy - i.uv;
				direction = direction * float2(_ScreenParams.x / _ScreenParams.y, 1);

				float distance = sqrt(direction.x * direction.x + direction.y * direction.y);

				float factor = sin(distance * _DistanceFactor + _Time.y * _TimeFacttor) *_TotalFactor * 0.01;

				float offset = normalize(direction) * factor * clamp(_Width - abs(_WaveDistance - distance), 0, 1) / _Width;

				fixed4 color = tex2D(_MainTex, i.uv + offset);
				
				
				return color;
			}

			ENDCG
		}

		
	}
	FallBack "Diffuse"
}
