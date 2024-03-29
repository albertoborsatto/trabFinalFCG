#version 330 core

// Atributos de fragmentos recebidos como entrada ("in") pelo Fragment Shader.
// Neste exemplo, este atributo foi gerado pelo rasterizador como a
// interpolação da posição global e a normal de cada vértice, definidas em
// "shader_vertex.glsl" e "main.cpp".
in vec4 position_world;
in vec4 normal;

// Posição do vértice atual no sistema de coordenadas local do modelo.
in vec4 position_model;

// Coordenadas de textura obtidas do arquivo OBJ (se existirem!)
in vec2 texcoords;

// Matrizes computadas no código C++ e enviadas para a GPU
uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform vec4 camera_view_vector;
uniform vec4 camera_position_c;
uniform int flashlightOn;

// Identificador que define qual objeto está sendo desenhado no momento
#define SPHERE 0
#define BUNNY  1
#define PLANE  2
#define WALL   3
#define PISTOL 4
#define M4A1   5
#define CONTAINER 6
#define CAR 7
#define OPENEDCONTAINER 8
#define BARREL 9
#define PALLET 10
#define TRASH 11
#define FERRARI 12
#define FENCE 13
#define CAR2 14
#define TARGET 15
#define UFO 16
uniform int object_id;

// Parâmetros da axis-aligned bounding box (AABB) do modelo
uniform vec4 bbox_min;
uniform vec4 bbox_max;

// Variáveis para acesso das imagens de textura
uniform sampler2D TextureImage0;
uniform sampler2D TextureImage1;
uniform sampler2D TextureImage2;
uniform sampler2D TextureImage3;
uniform sampler2D TextureImage4;
uniform sampler2D TextureImage5;
uniform sampler2D TextureImage6;
uniform sampler2D TextureImage7;
uniform sampler2D TextureImage8;
uniform sampler2D TextureImage9;
uniform sampler2D TextureImage10;
uniform sampler2D TextureImage11;
uniform sampler2D TextureImage12;

// O valor de saída ("out") de um Fragment Shader é a cor final do fragmento.
out vec4 color;

// Constantes
#define M_PI   3.14159265358979323846
#define M_PI_2 1.57079632679489661923

void main()
{

    // Obtemos a posição da câmera utilizando a inversa da matriz que define o
    // sistema de coordenadas da câmera.
    vec4 origin = vec4(0.0, 0.0, 0.0, 1.0);
    vec4 camera_position = inverse(view) * origin;

    vec4 posicao_spotlight = camera_position_c;
    vec4 vetor_spotlight = camera_view_vector;
    float angulo_spotlight = 3.1415926538/6;

    // O fragmento atual é coberto por um ponto que percente à superfície de um
    // dos objetos virtuais da cena. Este ponto, p, possui uma posição no
    // sistema de coordenadas global (World coordinates). Esta posição é obtida
    // através da interpolação, feita pelo rasterizador, da posição de cada
    // vértice.
    vec4 p = position_world;

    // Normal do fragmento atual, interpolada pelo rasterizador a partir das
    // normais de cada vértice.
    vec4 n = normalize(normal);

    // Vetor que define o sentido da fonte de luz em relação ao ponto atual.
    vec4 l = normalize(posicao_spotlight - p);

    // Vetor que define o sentido da câmera em relação ao ponto atual.
    vec4 v = normalize(camera_position - p);

    // Vetor que define o sentido da reflexão especular ideal.
    vec4 r = -l +2*n*(dot(n,l)); // PREENCHA AQUI o vetor de reflexão especular ideal

    vec4 h = normalize(v+l);

    vec4 L = vec4(0.0, 2.0, 1.0, 1.0);
    vec4 vetorDirecao = vec4(0.0, -1.0, 0.0, 0.0);
    float trintaGraus = radians(30);

    // Parâmetros que definem as propriedades espectrais da superfície
    vec3 Kd; // Refletância difusa
    vec3 Ks; // Refletância especular
    vec3 Ka; // Refletância ambiente
    float q; // Expoente especular para o modelo de iluminação de Phong
    vec3 Kd0;
    
    // Coordenadas de textura do plano, obtidas do arquivo OBJ.
    float U = texcoords.x;
    float V = texcoords.y;
    
    
    if ( object_id == SPHERE )
    {
        // PREENCHA AQUI as coordenadas de textura da esfera, computadas com
        // projeção esférica EM COORDENADAS DO MODELO. Utilize como referência
        // o slides 134-150 do documento Aula_20_Mapeamento_de_Texturas.pdf.
        // A esfera que define a projeção deve estar centrada na posição
        // "bbox_center" definida abaixo.

        // Você deve utilizar:
        //   função 'length( )' : comprimento Euclidiano de um vetor
        //   função 'atan( , )' : arcotangente. Veja https://en.wikipedia.org/wiki/Atan2.
        //   função 'asin( )'   : seno inverso.
        //   constante M_PI
        //   variável position_model

        vec4 bbox_center = (bbox_min + bbox_max) / 2.0;

        vec4 vetor_p = normalize(position_model - bbox_center);
        float theta = atan(vetor_p[0], vetor_p[2]);
        float phi = asin(vetor_p[1]);

        U = (theta+M_PI)/(2*M_PI);
        V = (phi+M_PI/2)/M_PI;

        // Obtemos a refletância difusa a partir da leitura da imagem TextureImage0
        Kd0 = texture(TextureImage1, vec2(U,V)).rgb;
        Kd = vec3(0.08,0.4,0.8);
        Ks = vec3(0.8,0.8,0.8);
        Ka = vec3(0.04,0.2,0.4);
        q = 16.0;

    } else if (object_id == PLANE) {
        U = 16*texcoords.x;
        V = 16*texcoords.y;
        Kd0 = texture(TextureImage4, vec2(U,V)).rgb;
    } else if (object_id == WALL) {
        Kd0 = texture(TextureImage3, vec2(U,V)).rgb;
    } else if (object_id == PISTOL) {
        Kd0 = texture(TextureImage1, vec2(U,V)).rgb;
    } else if (object_id == M4A1) {
        Kd0 = texture(TextureImage2, vec2(U,V)).rgb;
    } else if (object_id == CONTAINER) {
        Kd0 = texture(TextureImage9, vec2(U,V)).rgb;
    } else if (object_id == CAR) {
        Kd0 = texture(TextureImage0, vec2(U,V)).rgb;
    } else if (object_id == BARREL) {
        Kd0 = texture(TextureImage6, vec2(U,V)).rgb;
    } else if (object_id == PALLET) {
        Kd0 = texture(TextureImage7, vec2(U,V)).rgb;
    } else if (object_id == TRASH) {
        Kd0 = texture(TextureImage8, vec2(U,V)).rgb;
    } else if (object_id == TARGET) {
        Kd0 = texture(TextureImage11, vec2(U,V)).rgb;
    } else if (object_id == UFO) {
        Kd0 = texture(TextureImage12, vec2(U,V)).rgb;
    }
    
    // Espectro da fonte de iluminação
    vec3 I = vec3(1.0,1.0,1.0); // PREENCH AQUI o espectro da fonte de luz

    // Espectro da luz ambiente
    vec3 Ia = vec3(0.2,0.2,0.2); // PREENCHA AQUI o espectro da luz ambiente

    // Termo difuso utilizando a lei dos cossenos de Lambert
    vec3 lambert_diffuse_term = Kd*I*max(0,dot(n,l)); // PREENCHA AQUI o termo difuso de Lambert

    // Termo ambiente
    vec3 ambient_term = Ka*Ia; // PREENCHA AQUI o termo ambiente

    // Termo especular utilizando o modelo de iluminação de Phong
    vec3 blin_phong_specular_term  = Ks*I*pow(dot(n,h),q); // PREENCH AQUI o termo especular de Phong

    // Equação de Iluminação
    float lambert = max(0,dot(n,l));

    color.rgb = Kd0 * (lambert + 0.01);

    // NOTE: Se você quiser fazer o rendering de objetos transparentes, é
    // necessário:
    // 1) Habilitar a operação de "blending" de OpenGL logo antes de realizar o
    //    desenho dos objetos transparentes, com os comandos abaixo no código C++:
    //      glEnable(GL_BLEND);
    //      glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    // 2) Realizar o desenho de todos objetos transparentes *após* ter desenhado
    //    todos os objetos opacos; e
    // 3) Realizar o desenho de objetos transparentes ordenados de acordo com
    //    suas distâncias para a câmera (desenhando primeiro objetos
    //    transparentes que estão mais longe da câmera).
    // Alpha default = 1 = 100% opaco = 0% transparente
    color.a = 1;

     // Cor final do fragmento calculada com uma combinação dos termos difuso,
    // especular, e ambiente. Veja slide 129 do documento Aula_17_e_18_Modelos_de_Iluminacao.pdf.
    
    color.rgb = pow(color.rgb, vec3(1.0,1.0,1.0)/2.2) + lambert_diffuse_term + ambient_term + blin_phong_specular_term;
}