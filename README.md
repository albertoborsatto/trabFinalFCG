RELATÓRIO - 

	Lucas Moreira Schirmbeck - 00324412
	Alberto Vargas Borsatto  - 00287213


Distribuição de tarefas:

	+-----------------------------------------------------+----------------+
	| Critérios Técnicos				                          | Integrante     |
	+-----------------------------------------------------+----------------+
	| Malhas poligonais complexas 			                  | Lucas e Alberto|
	| Transformações geométricas controladas pelo usuário | Lucas	         |
	| Câmera livre e câmera look-at 		                  | Lucas	         |
	| Instâncias de objetos 			                        | Lucas e Alberto|
	| Três tipos de testes de intersecção 		            | Lucas e Alberto|
	| Modelos de Iluminação Difusa e Blinn-Phong 	        | Alberto	       |
	| Modelos de Interpolação de Phong e Gouraud 	        | ?	             |
	| Mapeamento de texturas em todos os objetos 	        | Alberto        |
	| Movimentação com curva Bézier cúbica 		            | Alberto	       |
	| Animações baseadas no tempo ($\Delta t$)	          | Alberto        |
	+-----------------------------------------------------+----------------+


ChatGPT:
	
	  Fizemos o uso do ChatGPT para nos auxiliar nas colisões, especialmente para 'refinar' a função vetor-plano utilizada para implementar a funcionalidade de atirar que havíamos elaborado, e tentar achar erros na implementação, 
  já que em alguns momentos durante o desenvolvimento essa funcionalidade não parecia completamente correta. Sendo assim, passamos a função para o ChatGPT analisar tentar melhorar pontos que julga estarem errados. Dessa forma 
  conseguimos uma função melhorada, já que após seu uso a funcionalidade de atirar estava perceptivelmente melhor. Logo, concluímos que o ChatGPT é uma ferramenta muito poderosa quando utilizada de maneira a melhor ideias já existentes, 
  pois dessa maneira podemos controlar qualquer falha cometida por ele.

Descrição do processo de desenvolvimento:

	Câmera: Começamos o desenvolvimento com uma ideia diferente do que a aplicação seria. Sendo assim, começamos por tentar implementar funções básicas de câmera, como conseguir andar e alterar para a look-at. Para implementar a câmera look-at, 
 fizemos uma função muito semelhante à transformação de matriz para a movimentação da câmera, com o diferencial de que não realizamos as mudanças no ponto da câmera a partir das teclas WASD. Para achar o ponto ideal utilizamos o callback do 
 scroll e printamos a posição. A parte mais trabalhosa foi fazer com que a arma "seguisse" a câmera, pois tinhamos uma ideia errônea de como deveria ser implementada. 

	Instâncias de objetos: Após isso, mudamos nossa ideia original e começamos o desenvolvimento do mapa, colocando objetos complexos na cena e para isso, utilizando de auxílio todo o material disponibilizado no laboratório 4. 

	Texturas: Para as texturas, basicamente tivemos que trazer alterações no código do laboratório 5. Aplicamos dois tipos de mapeamento: um exclusivamente para o globo, e os outros para o restante dos objetos carregados em cena. Todos os 
 objetos carregados já contavam com as coordenadas de textura dentro do ".obj". O que deu mais trabalho para fazer foi a grama, utilizamos o parâmetro GL_MIRRORED_REPEAT para ocultar as linhas divisórias.

	Tipos de colisão: Ponto-BoundingBox - definimos os limites mínimos e máximos da caixa dos objetos com uma estrutura "bbox", e colocamos todos os objetos dentro de um vetor. Percorremos cada objeto testando se todas as coordenadas X, Y e Z 
 da câmera não estão intersectando com os limites do objeto. Caso estiverem, retornamos a posição do jogador à ultima posição antes de colidir com a parede.

	Ponto-Esfera - definimos uma estrutura para os limites da esfera, contendo o ponto central da esfera e o raio da mesma. Traçamos um vetor do ponto da câmera até o ponto central da esfera: caso o tamanho do vetor seja igual ao raio da 
 esfera (+0,3), fazemos o mesmo procedimento que a colisão Ponto-BoundingBox.

	Vetor-BoundingBox - através dessa fonte: https://www.scratchapixel.com/lessons/3d-basic-rendering/minimal-ray-tracer-rendering-simple-shapes/ray-box-intersection.html, e o chatGPT, conseguimos implementar essa colisão. A ideia é traçar 
 um raio a partir do ponto da câmera e vetor view, e realizar testes ao longo desse raio com os mínimos e máximos da "bbox", tentando detectar intersecções.

	Curvas de Bezier: primeiramente foram definidos os pontos de controle da curva, a partir deste site: https://www.desmos.com/calculator/cahqdxeshd?lang=pt-BR. A lógica do intervalo de interpolção 't', é realizada a partir da função "glfwGetTime()" 
 e aplicação do seno do tempo * 0.2, a fim de manter a variável em um intervalo de -1 até 1. Para fazer com que essa interpolação fique entre 0 e 1, quando a variável 't' era negativa, multiplicamos por -1. Então chamamos a função para realizar o 
 Bezier cúbico em cima de todas as coordenadas do ponto de controle dentro do intervalo de interpolação. O retorno era substituído na matriz translate do objeto.

	Animação: aokucanis a mesma lógica do laborátorio 5, que gira o globo, com a modificação da variável que multiplica a váriavel de tempo, para girar mais rápido.

	Blinn-Phong: Definimos o vetor 'n' como sendo "normalize(normal)"  e 'h' como sendo "normalize(v+l)" e ao final somamos ao color.rgb (pow(color.rgb, vec3(1.0,1.0,1.0)/2.2) + lambert_diffuse_term + ambient_term + blin_phong_specular_term) e 
 aplicamos aos objetos. 

Manual de uso:

	W - Se mover para a frente.
	A - Se mover para a esquerda.
	S - Se mover para trás.
	D - Se mover para a direita.
	V - Noclip.
	F - Alterar câmera para a câmera Look At.
	O - Alterar a projeção para uma projeção ortográfica.
	P - Alterar a projeção para uma projeção perspectiva.
	H - Ativar/desativar texto informativo.

	Roda do mouse - Zoom  na câmera perspectiva.
	Botão esquerdo do mouse - Atirar.

Objetivo:

	O jogo consiste em achar três alvos espalhados no mapa (que é inspirado no mapa "Shipment", da série Call of Duty), eliminá-los e tocar no globo enorme localizado no mapa. Dessa forma o jogo acabará e aplicação fechará.

Compilação:
	
	Utilizamos o VSCode para o desenvolvimento da aplicação, seguindo os passos desponibilizados pelo professor. Portanto, é necessário o mingw, CMake, VSCode e seguir os passos do professor. Com o ambiente preparado, para executar a aplicação 
 é necessário clicar no botão de 'play' no canto inferior esquerdo do VSCode. 

Commits:

  Caso deseje comparar commits, sugerimos que olhe na branch mapa_novo, pois a maior parte do trabalho foi feito nela.
