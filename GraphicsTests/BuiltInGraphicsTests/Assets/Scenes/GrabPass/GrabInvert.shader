Shader "Grab/Invert" {

	SubShader{
		Tags{ "Queue" = "Transparent" }

		GrabPass{
	}

	Pass{
		CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"

		UNITY_DECLARE_TEX2DARRAY(_GrabTexture);


	struct appdata {
		float4 vertex : POSITION;
		float4 uv : TEXCOORD0;
		UNITY_VERTEX_INPUT_INSTANCE_ID
	};

	struct v2f {
		float4 vertex : SV_POSITION;
		float4 uv : TEXCOORD0;
		UNITY_VERTEX_INPUT_INSTANCE_ID
			UNITY_VERTEX_OUTPUT_STEREO
	};

	v2f vert(appdata v)
	{
		v2f o;

		UNITY_SETUP_INSTANCE_ID(v);
		UNITY_INITIALIZE_OUTPUT(v2f, o);
		UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
		o.vertex = UnityObjectToClipPos(v.vertex);
		o.uv = ComputeGrabScreenPos(o.vertex);
		return o;
	}

	half4 frag(v2f i) : COLOR
	{
		UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
	return 1 - UNITY_SAMPLE_TEX2DARRAY(_GrabTexture, float3(i.uv.xy / i.uv.w, unity_StereoEyeIndex));

	}

		ENDCG

	}
	}

		SubShader{
		Tags{ "Queue" = "Transparent" }

		GrabPass{
	}

	Pass{
		SetTexture[_GrabTexture]{ combine one - texture }
	}
	}
}