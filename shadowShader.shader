// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "UnlitShadows/UnlitShadowReceive" {
	Properties{ 
		_Color("Main Color", Color) = (0,0,0,1) 
	}

		SubShader{
			Tags { "RenderType" = "Opaque"  "Queue" = "AlphaTest"}
			LOD 100

		Pass
		{
			ZWrite Off
			Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#include "UnityCG.cginc"
		#pragma multi_compile_fwdbase
		#include "AutoLight.cginc"

		fixed4 _Color;
		fixed _Cutoff;

		struct v2f {
		float4 pos : SV_POSITION; LIGHTING_COORDS(0,1)
		 };

		v2f vert(appdata_base v) {
		v2f o; o.pos = UnityObjectToClipPos(v.vertex); TRANSFER_VERTEX_TO_FRAGMENT(o);
		return o;
		 }

		fixed4 frag(v2f i) : COLOR{
		float attenuation = LIGHT_ATTENUATION(i);
			return fixed4(_Color.x, _Color.y, _Color.z, _Color.a * (1.0 - attenuation));
		} 
		
		ENDCG 
			} 
		
		} Fallback "Transparent/Cutout/VertexLit" 
}
