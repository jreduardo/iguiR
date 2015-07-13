# Criando os gifs para as páginas dos exemplos introdutórios com histograma

## Em uma sessão de terminal Linux (bash).

```{bash}
## Instalar esse programa (Linux).
# sudo apt-get install byzanz

## Definições de posição e tamanho da janela gravada pro gif.
## 7 inches * 96 dpi = 672 pixels.
POS=100  ## Posição X e Y a partir do canto superior esquerdo.
LARH=672 ## Tamanho da janela na horizontal.
LARV=700 ## Tamanho na janela na vertical.

## gWidgets.
cd ~/GitHub/iguiR/gWidgets
byzanz-record --duration=8 --x=$POS --y=$POS --width=$LARH --height=$LARV hist_Button.gif
byzanz-record --duration=5 --x=$POS --y=$POS --width=$LARH --height=$LARV hist_Checkbox.gif
byzanz-record --duration=8 --x=$POS --y=$POS --width=$LARH --height=$LARV hist_Checkboxgroup.gif
byzanz-record --duration=15 --x=$POS --y=$POS --width=$LARH --height=$LARV hist_Numeric.gif
byzanz-record --duration=8 --x=$POS --y=$POS --width=$LARH --height=$LARV hist_Radio.gif
byzanz-record --duration=15 --x=$POS --y=$POS --width=$LARH --height=$LARV hist_Select.gif
byzanz-record --duration=8 --x=$POS --y=$POS --width=$LARH --height=$LARV hist_Slider.gif
byzanz-record --duration=15 --x=$POS --y=$POS --width=$LARH --height=$LARV hist_Text.gif

## gWidgets.
cd ~/GitHub/iguiR/rpanel
byzanz-record --duration=8 --x=$POS --y=$POS --width=$LARH --height=$LARV hist_button.gif
byzanz-record --duration=5 --x=$POS --y=$POS --width=$LARH --height=$LARV hist_checkbox.gif
byzanz-record --duration=8 --x=$POS --y=$POS --width=$LARH --height=$LARV hist_checkboxgroup.gif
byzanz-record --duration=15 --x=$POS --y=$POS --width=$LARH --height=$LARV hist_numeric.gif
byzanz-record --duration=5 --x=$POS --y=$POS --width=$LARH --height=$LARV hist_radio.gif
byzanz-record --duration=10 --x=$POS --y=$POS --width=$LARH --height=$LARV hist_select.gif
byzanz-record --duration=15 --x=$POS --y=$POS --width=$LARH --height=$LARV hist_select2.gif
byzanz-record --duration=8 --x=$POS --y=$POS --width=$LARH --height=$LARV hist_slider.gif
byzanz-record --duration=15 --x=$POS --y=$POS --width=$LARH --height=$LARV hist_text.gif

```

## Em uma sessão R.

```{r}
## Abrir janela gráfica na posição 100 e 100, com largura/altura de 7
## inches.
X11(width=7, height=7, xpos=100, ypos=100)

## Após fazer o source(), usar a interface para ser gravada.
setwd("/home/walmes/GitHub/iguiR/gWidgets")
source("hist_Button.R")
source("hist_Checkbox.R")
source("hist_Checkboxgroup.R")
source("hist_Numeric.R")
source("hist_Radio.R")
source("hist_Select.R")
source("hist_Slider.R")
source("hist_Text.R")

setwd("/home/walmes/GitHub/iguiR/rpanel")
list.files(pattern = "^hist_.*\\.R")
source("hist_button.R")
source("hist_checkbox.R")
source("hist_checkboxgroup.R")
source("hist_numeric.R")
source("hist_radio.R")
source("hist_select.R")
source("hist_select2.R")
source("hist_slider.R")
source("hist_text.R")

```
