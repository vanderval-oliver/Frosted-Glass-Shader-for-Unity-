# Frosted-Glass-Shader-for-Unity-
Este shader cria um efeito de vidro fosco no Unity utilizando o Universal Render Pipeline (URP). Ele permite aplicar um desfoque suave ao fundo do objeto e ajustar a transparência, cor, e intensidade do efeito. O shader utiliza um GrabPass para capturar a cena atrás do objeto, permitindo a aplicação de um desfoque realista e ajustável.

Funcionalidades:
Desfoque (Blur) ajustável com 9 amostras para um efeito suave.
Cor ajustável para alterar o tom do vidro.
Opacidade ajustável para controle da transparência do material.
Controle de tiling e offset da textura base (_MainTex).
Ideal para criar efeitos de vidros foscos ou superfícies translúcidas em jogos e simulações 3D.
Como Usar:
Adicione o shader ao seu projeto Unity (URP).
Crie um material e atribua o shader FrostedShader.
Ajuste as propriedades no material:
_Color: Altere a cor do vidro.
_Opacity: Controle a opacidade/transparência.
_BlurAmount: Ajuste a intensidade do desfoque.
Aplique o material ao seu objeto 3D ou 2D para obter o efeito de vidro fosco.
Propriedades:
_MainTex: Textura base (default é branca).
_Color: Cor do vidro (com tint ajustável).
_BlurAmount: Intensidade do desfoque (de 0 a 100).
_Opacity: Controle da opacidade (de 0 a 1).
Requisitos:
Unity 2019.4+ com suporte para Universal Render Pipeline (URP).
