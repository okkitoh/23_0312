Shader "ShaderPractice/WaterTexture"
{
    Properties
    {
        _MainTint ("Diffuse Tint", Color) = (1, 1, 1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}

    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200


        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

        #include "UnityCG.cginc"


        fixed4 _MainTint;
        sampler2D _MainTex;

        struct Input {
            float2 uv_MainTex;
        };


        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float2 v = float2(10,0);

            fixed translateX = IN.uv_MainTex.x + _Time * v.x;
            fixed translateY = IN.uv_MainTex.y + _Time * v.y;
            
            fixed4 c = tex2D (_MainTex, float2(translateX, translateY));
            o.Albedo = c.rgb * _MainTint;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
