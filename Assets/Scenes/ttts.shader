Shader "Custom/ttts" {
    Properties {
        _MainTex ("Texture", 2D) = "white" {}
        _Scale ("Scale", Range(0.01, 10)) = 1
        _Brightness ("Brightness", Range(0.01, 10)) = 1
    }
    SubShader {
        Tags { "RenderType"="Opaque" }
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
        float _Scale;
        float _Brightness;

        struct Input {
            float2 uv_MainTex;
        };

        float4 SampleStochasticPattern(float2 uv) {
            float4 sum = float4(0, 0, 0, 0);
            float weight = 1.0 / 16.0;
            for (int i = -1; i <= 2; i++) {
                for (int j = -1; j <= 2; j++) {
                    float2 offset = float2(i, j);
                    float2 p = frac(uv / _Scale + offset);
                    sum += tex2D(_MainTex, p) * weight;
                }
            }
            return sum * _Brightness;
        }

        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = SampleStochasticPattern(IN.uv_MainTex).rgb;
            o.Alpha = 1;
        }
        ENDCG
    }
    FallBack "Diffuse"
}