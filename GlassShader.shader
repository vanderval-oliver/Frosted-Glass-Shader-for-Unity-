Shader "Custom/FrostedShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color ("Tint Color", Color) = (1,1,1,1) // Adiciona cor ajustável
        _BlurAmount ("Blur Amount", Range(0, 100)) = 0.5
        _Opacity ("Opacity", Range(0, 1)) = 0.8
       
    }
    SubShader
    {
        Tags {"Queue"="Transparent" "RenderType"="Transparent"}
        GrabPass { "_GrabTexture" } // Captura o fundo atrás do objeto

        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            sampler2D _GrabTexture;
            float4 _MainTex_ST; // Permite ajuste de tiling e offset
            float4 _GrabTexture_TexelSize;
            float4 _Color; // Permite ajuste de cor
            float _BlurAmount;
            float _Opacity;

            struct appdata_t {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata_t v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                
                // Aplica tiling e offset à UV
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = i.uv;

                // Blur com 9 amostras
                fixed4 blur = (
                    tex2D(_GrabTexture, uv + _GrabTexture_TexelSize.xy * _BlurAmount) +
                    tex2D(_GrabTexture, uv - _GrabTexture_TexelSize.xy * _BlurAmount) +
                    tex2D(_GrabTexture, uv + float2(_GrabTexture_TexelSize.x * _BlurAmount, 0)) +
                    tex2D(_GrabTexture, uv - float2(_GrabTexture_TexelSize.x * _BlurAmount, 0)) +
                    tex2D(_GrabTexture, uv + float2(0, _GrabTexture_TexelSize.y * _BlurAmount)) +
                    tex2D(_GrabTexture, uv - float2(0, _GrabTexture_TexelSize.y * _BlurAmount)) +
                    tex2D(_GrabTexture, uv + _GrabTexture_TexelSize.xy * _BlurAmount * 2) +
                    tex2D(_GrabTexture, uv - _GrabTexture_TexelSize.xy * _BlurAmount * 2)
                ) * 0.125;

                // Aplica a cor ajustável do Sprite Renderer
                fixed4 finalColor = blur * _Color;
                finalColor.a = _Opacity; // Aplica opacidade

                return finalColor;
            }
            ENDCG
        }
    }
}
