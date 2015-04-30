# Plano de trabalho
----

Ata da reunião do dia 30/04/2005, 14h00. Estiveram presentes: Eduardo,
Henrique e Walmes.

Reuniões serão feitas semanalmente todas as quintas-feiras, a partir das
14h00, no LEG.

As bibliotecas serão trabalhadas uma por vez na seguinte ordem:
  1. gWidgets - tcl/tk;
  2. rpanel;
  3. shiny.

Elementos interativos (widgets) básicos:
  * Caixa de seleção (checkbox, CB);
  * Entrada de texto/número (text/numeric input, TI);
  * Botões/caixa de incremento (text/numeric input, TI);
  * Deslizador (slider, SL); 
  * Lista em cascata (list box, dropdown list, LB);
  * Lista empilhada (radio buttons, RB);
  * Botões de ação (action buttons, AB);
  * Abas/guias/folhas (tabs, TB).

Exemplos introdutórios:
  * Histograma:
    - CB para frequência absoluta ou relativa;
    - TI ou SL para sugestão do número de classes;
    - LB para escolha da cor das barras;
  * Densidade empírica:
    - CB incluir rug;
    - RB para escolha da função kernel;
    - SL para controlar a largura de banda;
  * Digrama de dispersão:
    - RB para escolher a transformação em x e y;
    - CB para ajustar um modelo de regressão linear simples;
    - LB para escolher a posição da legenda;
  * Medidas descritivas;
    - CB para escolher que medidas retornar;
    - TB para mostrar saída em tabela formatada e verbatim;
  * Produção de certificados (mala direta):
    - TI para fornecer o nome do participante;
    - AB para produzir um documento pdf, o certificado, via LaTex;
  * Ilustração de propriedades de estimador;
    - AB para disparar um laço e fazer uma animação;
  * Método Newton-Raphson encontrar as raízes de uma função:
    - TI para passar os valores iniciais;
    - AB para ir para próxima etapa do método Newton-Raphson;
  
Exemplos avançados:
  * Regressão semiparamétrica;
  * Regressão não linear (`wzRfun::rp.nls`);

Estrutura do diretório:
```
  /gWidgets
    hist.R
    dens.R
    ...
  /rpanel
    hist.R
    dens.R
    ...
  /shiny
    /hist
      ui.R
      server.R
    /dens.R
      ui.R
      server.R
    ...
```

Sugestão de cabeçalho para os arquivos R.

```
##=============================================================================
##             60ª RBras e o 16º SEAGRO - Presidente Prudente - SP
##
##           B6MC2: Explorando interfaces gráficas interativas no R
##
##                                                        www.leg.ufpr.br/iguiR
##                                                   github.com/JrEduardo/iguiR
##
##                      Walmes Marques Zeviani - UFPR
##                      Vanessa Ferreira Sehaber - UFPR
##                      Eduardo Elias Ribeiro Junior - UFPR
##                      Henrique Aparecido Laureano - UFPR
##                      Karina Brotto Rebuli - UFPR
##
## Título do Script
##    * Tópico 1
##    * Tópico 2
##=============================================================================

```
