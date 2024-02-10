# Relatório de Desenvolvimento

**Desenvolvedores:**
- Lucas Moreira Schirmbeck - 00324412
- Alberto Vargas Borsatto - 00287213

## Imagens

  ![image](https://github.com/albertoborsatto/trabFinalFCG/assets/93798209/5cb90ba0-2855-492d-aa30-64ababbca791)

  ![image](https://github.com/albertoborsatto/trabFinalFCG/assets/93798209/fc3bd734-29aa-4d6d-9ef1-4f5fffe11b97)

  
## Distribuição de Tarefas

| Critérios Técnicos                                    | Integrante    |
|--------------------------------------------------------|---------------|
| Malhas poligonais complexas                            | Lucas e Alberto|
| Transformações geométricas controladas pelo usuário     | Lucas         |
| Câmera livre e câmera look-at                           | Lucas         |
| Instâncias de objetos                                  | Lucas e Alberto|
| Três tipos de testes de interseção                      | Lucas e Alberto|
| Modelos de Iluminação Difusa e Blinn-Phong             | Alberto       |
| Modelos de Interpolação de Phong e Gouraud             | ?             |
| Mapeamento de texturas em todos os objetos             | Alberto       |
| Movimentação com curva Bézier cúbica                   | Alberto       |
| Animações baseadas no tempo ($\Delta t$)               | Alberto       |

## ChatGPT

O ChatGPT foi utilizado de forma eficaz para aprimorar a função de detecção de colisões. Especificamente, a função vetor-plano foi refinada com a orientação do ChatGPT, melhorando significativamente a funcionalidade de atirar no jogo. A utilização do ChatGPT como uma ferramenta de refinamento e correção de código mostrou-se valiosa.

## Descrição do Processo de Desenvolvimento

### Câmera
O desenvolvimento iniciou com a implementação de funções básicas da câmera, permitindo movimento e alternância entre modos de câmera livre e look-at. A câmera look-at foi implementada usando o callback de scroll para ajustar a posição da câmera. A sincronização da arma com a câmera foi uma parte desafiadora, corrigida por meio de uma abordagem mais adequada.

### Instâncias de Objetos
A ideia inicial foi modificada, dando lugar ao desenvolvimento de um mapa com objetos complexos. Utilizou-se o material do laboratório 4 como referência.

### Texturas
A implementação de texturas envolveu ajustes no código do laboratório 5. Aplicou-se dois tipos de mapeamento, sendo um exclusivo para o globo e os demais para os objetos na cena. As texturas foram aplicadas com êxito, com destaque para a grama que exigiu a utilização do parâmetro GL_MIRRORED_REPEAT para ocultar linhas divisórias.

### Tipos de Colisão
Foram implementados três tipos de testes de colisão: ponto-BoundingBox, ponto-Esfera e vetor-BoundingBox. A lógica e algoritmos foram derivados de fontes confiáveis, incluindo um artigo online e consultas ao ChatGPT.

### Curvas de Bézier
Definiram-se pontos de controle para curvas de Bézier cúbicas, e a animação foi baseada no tempo. A lógica do intervalo de interpolação 't' foi implementada usando a função "glfwGetTime()" e o seno do tempo, resultando em movimentos suaves.

### Animação
A animação foi desenvolvida seguindo a lógica do laboratório 5, com modificações na variável multiplicadora do tempo para controlar a velocidade de rotação.

### Blinn-Phong
O modelo de iluminação de Blinn-Phong foi implementado, utilizando vetores normalizados 'n' e 'h' e aplicando os termos difuso, ambiente e especular. A cor final do fragmento foi calculada e aplicada aos objetos.

## Manual de Uso

- **W**: Mover para frente.
- **A**: Mover para a esquerda.
- **S**: Mover para trás.
- **D**: Mover para a direita.
- **V**: Ativar/desativar modo noclip.
- **F**: Alternar entre câmera livre e câmera look-at.
- **O**: Alternar para projeção ortográfica.
- **P**: Alternar para projeção perspectiva.
- **H**: Ativar/desativar texto informativo.
- **Roda do Mouse**: Zoom na câmera perspectiva.
- **Botão Esquerdo do Mouse**: Atirar.

**Objetivo do Jogo:**
Encontrar e eliminar três alvos no mapa (inspirado no mapa "Shipment" de Call of Duty) e tocar no globo para encerrar o jogo.

## Compilação

O ambiente de desenvolvimento foi preparado usando VSCode, Mingw, CMake e os passos fornecidos pelo professor. A execução da aplicação pode ser realizada pressionando o botão de 'play' no VSCode.
O executável main será encontrado dentro da pasta do projeto. O caminho é "./bin/Debug/main.exe".

## Conclusão

O desenvolvimento da aplicação envolveu a implementação de diversos elementos, desde movimentação e câmeras até colisões, animações e iluminação. A combinação de esforços entre os desenvolvedores e a utilização eficaz do ChatGPT contribuíram para o sucesso do projeto. O jogo proposto oferece uma experiência interativa e desafiadora para os usuários.
