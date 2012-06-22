growlterm
=========

growl-like notifications for your terminal

# Description

## Whatisit ?

* A sugary way to display `background jobs`messages to your terminal (that
was the original purpose
* a revamp of something that I used for a long time to display `git`
  info in my prompt or anywhere else on the screen (top right corner
  being my favorite as it leaves the TERM history copy/pasteable)
* looks TOTALLY inspired by the excellent [Vim-powerline]() plugin for VIM
* Growl server on its way

## Drawbacks

Leaves your terminal in an unclean statr as the `message` erases the
line that was under it.

# Additional scripts (you could even use them!)

The following two scripts are used to define TERM safe color variables
useable throughout your journey in bash scripting : `safetermcolors8.sh`
and `safetermcolors-addit-256.sh`

##USAGE

Just source them in your `.profile` or `.myFavShellRC`
(they are `sh`compliant)

    . safetermcolors8.sh
    . safetermcolors-addit-256.sh

> * note 1 : the second script is, most of the case, totally overkill. I
> never source it as a whole, but rather keep it as a reminder of how to
> quickly insert TERM-SAFE color variables in my scripts. 

> * note 2 : the sourcing of the first script, however, cannot do you no
> harm

##safetermcolors8.sh

safely (*in terms on `terminfo`*) defines the 001-015 color range, which
exist on any TERM which has more than 2 colors capacity, plus modifiers
(underline, reset, bold, ...) (also works on TERMS which don't by
degrading quietly and still provide modifier styles (underline & such)

##safetermcolors-addit-256.sh

In a fancy mood ? add custom variables for all 256 color range
(foreground and background) in a safe (*in terms of `terminfo`*) way


##NOTA BENE

sourcing this script exports the aditional variable 

    export __TPUT_COLORS_DEFINED="true"

so that you can check later on that it's already done


## more info

*COLOR VARS :*

  * declare the 8 SYSTEM TERM colors (and their variants :
    background & bold) and the modifiers (DOUBLE INTENSITY, DIM,
    BLINK, RESET,... ONCE and for ALL.

  * declare the defaults for old TERMS, and adapt to less
    horrid defaults for `256-colors` TERMS

    >This somewhat pollutes the GLOBAL SCOPE but the variable
    >names are (thought to be) unique enough so that won't cause
    >problems

  * do that like a grownup ( use `tput`, and only resort to ANSI escapes
    as a fallback with `tput setaf`)

  * TODO: handle dark vs light background

  * TODO: handle `more than 256 colors terms` (`if [ $(tput colors) -ge 256 ] ...`)

# safetermcolors8.sh : variable list

##ALL 8-COLOR COMPATIBLE VARIABLES DEFINED

###STYLES

| Variable NAME                            | equivalent ANSI escape | Description                           |
|                                          | ATTR                   |                                       |
| :--------------------------------------- | ---------------------- | ------------------------------------: |
| \_\_EM\_                                 | \[ 1m                  | BEGIN DOUBLE INTENSITY (bold) mode    |
| \_\_DM\_                                 | \[ 2m                  | BEGIN HALF INTENSITY    (dim) mode    |
| \_\_UN\_                                 | \[ 4m                  | BEGIN UNDESCORE  (underlined) mode    |
| \_\_BL\_                                 | \[ 5m                  | BEGIN BLINKING                mode    |
| \_\_RV\_                                 | \[ 7m                  | BEGIN REVERSE VIDEO (reverse) mode    |
| \_\_SO\_                                 | ?\[ 7m                 | BEGIN STANDOUT      (reverse) mode    |
| \_\_IN\_                                 | \[ 8m                  | BEGIN INVISIBLE               mode    |
| \_\_DEL\_                                |                        | MOVE cursor LEFT one space            |
| \_\_SOQ\_                                | ?\[ 27m                | END   STANDOUT      (reverse) mode    |
| \_\_UNQ\_                                | \[ 24m                 | END   UNDESCORE  (underlined) mode    |

###DEFAULT SYSTEM FOREGROUND COLORS (or better ones if 256-colors)

| Variable NAME                            | equivalent ANSI escape | Description                           |
|                                          | ATTR....FG             |                                       |
| :--------------------------------------- | ---------------------- | ------------------------------------: |
| \_\_K\_                                  | \[0;....0m             | SET   FG color to BLACK               |
| \_\_R\_                                  | \[0;....1m             | SET   FG color to RED                 |
| \_\_G\_                                  | \[0;....2m             | SET   FG color to GREEN               |
| \_\_Y\_                                  | \[0;....3m             | SET   FG color to YELLOW              |
| \_\_B\_                                  | \[0;....4m             | SET   FG color to BLUE                |
| \_\_M\_                                  | \[0;....5m             | SET   FG color to MAGENTA             |
| \_\_C\_                                  | \[0;....6m             | SET   FG color to CYAN                |
| \_\_W\_                                  | \[0;....7m             | SET   FG color to WHITE               |

###DEFAULT SYSTEM BACKGROUND COLORS (or better ones if 256-colors)

| Variable NAME                            | equivalent ANSI escape | Description                           |
|                                          | ATTR....••••BG         |                                       |
| :--------------------------------------- | ---------------------- | ------------------------------------: |
| \_\_BGK\_                                | \[1;....••••0m         | SET   BG color to BLACK               |
| \_\_BGR\_                                | \[1;....••••1m         | SET   BG color to RED                 |
| \_\_BGG\_                                | \[1;....••••2m         | SET   BG color to GREEN               |
| \_\_BGY\_                                | \[1;....••••3m         | SET   BG color to YELLOW              |
| \_\_BGB\_                                | \[1;....••••4m         | SET   BG color to BLUE                |
| \_\_BGM\_                                | \[1;....••••5m         | SET   BG color to MAGENTA             |
| \_\_BGC\_                                | \[1;....••••6m         | SET   BG color to CYAN                |
| \_\_BGW\_                                | \[1;....••••7m         | SET   BG color to WHITE               |

###RESETS

| Variable NAME                            | equivalent ANSI escape | Description                           |
|                                          | ATTR....FG••••BG       |                                       |
| :--------------------------------------- | ---------------------- | ------------------------------------: |
| \_\_NN\_                                 | \[ 0m                  | RESET ALL attributes                  |
| \_\_NF\_                                 | \[.......39m           | RESET FG color to term's default      |
| \_\_NG\_                                 | \[..........••••49m    | RESET BG color to term's default      |
| \_\_NFG\_                                | \[.......39;••••49m    | RESET FG & BG color to term's default |

###PSOEUDO (BOLD) FOREGROUND COLORS

| Variable NAME                            | equivalent ANSI escape | Description                           |
|                                          | ATTR....FG             |                                       |
| :--------------------------------------- | ---------------------- | ------------------------------------: |
| \_\_EMK\_                                | \[ 1;....20m           | SET   FG color to BOLD BLACK          |
| \_\_EMR\_                                | \[ 1;....21m           | SET   FG color to BOLD RED            |
| \_\_EMG\_                                | \[ 1;....22m           | SET   FG color to BOLD GREEN          |
| \_\_EMY\_                                | \[ 1;....23m           | SET   FG color to BOLD YELLOW         |
| \_\_EMB\_                                | \[ 1;....24m           | SET   FG color to BOLD BLUE           |
| \_\_EMM\_                                | \[ 1;....25m           | SET   FG color to BOLD MAGENTA        |
| \_\_EMC\_                                | \[ 1;....26m           | SET   FG color to BOLD CYAN           |
| \_\_EMW\_                                | \[ 1;....27m           | SET   FG color to BOLD RED            |

###MISC

| Variable NAME                            | equivalent ANSI escape | Description                           |
|                                          | ATTR....COLOR•••BG     |                                       |
| :--------------------------------------- | ---------------------- | ------------------------------------: |
| \_\_NL\_                                 |                        | most compatible NEWLINE ever          |


#safetermcolors-addit-256.sh : variable list

In a fancy mood ? add custom variables for all 256 color range
(foreground and background) in a safe (*in terms of `terminfo`*) way



### FOREGROUND COLORS

| \_\_Fancyname\_ (\_\_DECname\_)     | \_\_Fancyname\_ (\_\_DECname\_)    | \_\_Fancyname\_ (\_\_DECname\_)    | \_\_Fancyname\_ (\_\_DECname\_)     |
| :---------------------------------  | ---------------------------------- | ---------------------------------- | ----------------------------------: |
| \_\_NavyBlue\_ \(\_\_17\_)          | \_\_DarkBlue\_ \(\_\_18\_)         | \_\_Blue3\_ \(\_\_19\_)            | \_\_Blue3\_ \(\_\_20\_)             |
| \_\_Blue1\_ \(\_\_21\_)             | \_\_DarkGreen\_ \(\_\_22\_)        | \_\_DeepSkyBlue4\_ \(\_\_23\_)     | \_\_DeepSkyBlue4\_ \(\_\_24\_)      |
| \_\_DeepSkyBlue4\_ \(\_\_25\_)      | \_\_DodgerBlue3\_ \(\_\_26\_)      | \_\_DodgerBlue2\_ \(\_\_27\_)      | \_\_Green4\_ \(\_\_28\_)            |
| \_\_SpringGreen4\_ \(\_\_29\_)      | \_\_Turquoise4\_ \(\_\_30\_)       | \_\_DeepSkyBlue3\_ \(\_\_31\_)     | \_\_DeepSkyBlue3\_ \(\_\_32\_)      |
| \_\_DodgerBlue1\_ \(\_\_33\_)       | \_\_Green3\_ \(\_\_34\_)           | \_\_SpringGreen3\_ \(\_\_35\_)     | \_\_DarkCyan\_ \(\_\_36\_)          |
| \_\_LightSeaGreen\_ \(\_\_37\_)     | \_\_DeepSkyBlue2\_ \(\_\_38\_)     | \_\_DeepSkyBlue1\_ \(\_\_39\_)     | \_\_Green3\_ \(\_\_40\_)            |
| \_\_SpringGreen3\_ \(\_\_41\_)      | \_\_SpringGreen2\_ \(\_\_42\_)     | \_\_Cyan3\_ \(\_\_43\_)            | \_\_DarkTurquoise\_ \(\_\_44\_)     |
| \_\_Turquoise2\_ \(\_\_45\_)        | \_\_Green1\_ \(\_\_46\_)           | \_\_SpringGreen2\_ \(\_\_47\_)     | \_\_SpringGreen1\_ \(\_\_48\_)      |
| \_\_MediumSpringGreen\_ \(\_\_49\_) | \_\_Cyan2\_ \(\_\_50\_)            | \_\_Cyan1\_ \(\_\_51\_)            | \_\_DarkRed\_ \(\_\_52\_)           |
| \_\_DeepPink4\_ \(\_\_53\_)         | \_\_Purple4\_ \(\_\_54\_)          | \_\_Purple4\_ \(\_\_55\_)          | \_\_Purple3\_ \(\_\_56\_)           |
| \_\_BlueViolet\_ \(\_\_57\_)        | \_\_Orange4\_ \(\_\_58\_)          | \_\_Grey37\_ \(\_\_59\_)           | \_\_MediumPurple4\_ \(\_\_60\_)     |
| \_\_SlateBlue3\_ \(\_\_61\_)        | \_\_SlateBlue3\_ \(\_\_62\_)       | \_\_RoyalBlue1\_ \(\_\_63\_)       | \_\_Chartreuse4\_ \(\_\_64\_)       |
| \_\_DarkSeaGreen4\_ \(\_\_65\_)     | \_\_PaleTurquoise4\_ \(\_\_66\_)   | \_\_SteelBlue\_ \(\_\_67\_)        | \_\_SteelBlue3\_ \(\_\_68\_)        |
| \_\_CornflowerBlue\_ \(\_\_69\_)    | \_\_Chartreuse3\_ \(\_\_70\_)      | \_\_DarkSeaGreen4\_ \(\_\_71\_)    | \_\_CadetBlue\_ \(\_\_72\_)         |
| \_\_CadetBlue\_ \(\_\_73\_)         | \_\_SkyBlue3\_ \(\_\_74\_)         | \_\_SteelBlue1\_ \(\_\_75\_)       | \_\_Chartreuse3\_ \(\_\_76\_)       |
| \_\_PaleGreen3\_ \(\_\_77\_)        | \_\_SeaGreen3\_ \(\_\_78\_)        | \_\_Aquamarine3\_ \(\_\_79\_)      | \_\_MediumTurquoise\_ \(\_\_80\_)   |
| \_\_SteelBlue1\_ \(\_\_81\_)        | \_\_Chartreuse2\_ \(\_\_82\_)      | \_\_SeaGreen2\_ \(\_\_83\_)        | \_\_SeaGreen1\_ \(\_\_84\_)         |
| \_\_SeaGreen1\_ \(\_\_85\_)         | \_\_Aquamarine1\_ \(\_\_86\_)      | \_\_DarkSlateGray2\_ \(\_\_87\_)   | \_\_DarkRed\_ \(\_\_88\_)           |
| \_\_DeepPink4\_ \(\_\_89\_)         | \_\_DarkMagenta\_ \(\_\_90\_)      | \_\_DarkMagenta\_ \(\_\_91\_)      | \_\_DarkViolet\_ \(\_\_92\_)        |
| \_\_Purple\_ \(\_\_93\_)            | \_\_Orange4\_ \(\_\_94\_)          | \_\_LightPink4\_ \(\_\_95\_)       | \_\_Plum4\_ \(\_\_96\_)             |
| \_\_MediumPurple3\_ \(\_\_97\_)     | \_\_MediumPurple3\_ \(\_\_98\_)    | \_\_SlateBlue1\_ \(\_\_99\_)       | \_\_Yellow4\_ \(\_\_100\_)          |
| \_\_Wheat4\_ \(\_\_101\_)           | \_\_Grey53\_ \(\_\_102\_)          | \_\_LightSlateGrey\_ \(\_\_103\_)  | \_\_MediumPurple\_ \(\_\_104\_)     |
| \_\_LightSlateBlue\_ \(\_\_105\_)   | \_\_Yellow4\_ \(\_\_106\_)         | \_\_DarkOliveGreen3\_ \(\_\_107\_) | \_\_DarkSeaGreen\_ \(\_\_108\_)     |
| \_\_LightSkyBlue3\_ \(\_\_109\_)    | \_\_LightSkyBlue3\_ \(\_\_110\_)   | \_\_SkyBlue2\_ \(\_\_111\_)        | \_\_Chartreuse2\_ \(\_\_112\_)      |
| \_\_DarkOliveGreen3\_ \(\_\_113\_)  | \_\_PaleGreen3\_ \(\_\_114\_)      | \_\_DarkSeaGreen3\_ \(\_\_115\_)   | \_\_DarkSlateGray3\_ \(\_\_116\_)   |
| \_\_SkyBlue1\_ \(\_\_117\_)         | \_\_Chartreuse1\_ \(\_\_118\_)     | \_\_LightGreen\_ \(\_\_119\_)      | \_\_LightGreen\_ \(\_\_120\_)       |
| \_\_PaleGreen1\_ \(\_\_121\_)       | \_\_Aquamarine1\_ \(\_\_122\_)     | \_\_DarkSlateGray1\_ \(\_\_123\_)  | \_\_Red3\_ \(\_\_124\_)             |
| \_\_DeepPink4\_ \(\_\_125\_)        | \_\_MediumVioletRed\_ \(\_\_126\_) | \_\_Magenta3\_ \(\_\_127\_)        | \_\_DarkViolet\_ \(\_\_128\_)       |
| \_\_Purple\_ \(\_\_129\_)           | \_\_DarkOrange3\_ \(\_\_130\_)     | \_\_IndianRed\_ \(\_\_131\_)       | \_\_HotPink3\_ \(\_\_132\_)         |
| \_\_MediumOrchid3\_ \(\_\_133\_)    | \_\_MediumOrchid\_ \(\_\_134\_)    | \_\_MediumPurple2\_ \(\_\_135\_)   | \_\_DarkGoldenrod\_ \(\_\_136\_)    |
| \_\_LightSalmon3\_ \(\_\_137\_)     | \_\_RosyBrown\_ \(\_\_138\_)       | \_\_Grey63\_ \(\_\_139\_)          | \_\_MediumPurple2\_ \(\_\_140\_)    |
| \_\_MediumPurple1\_ \(\_\_141\_)    | \_\_Gold3\_ \(\_\_142\_)           | \_\_DarkKhaki\_ \(\_\_143\_)       | \_\_NavajoWhite3\_ \(\_\_144\_)     |
| \_\_Grey69\_ \(\_\_145\_)           | \_\_LightSteelBlue3\_ \(\_\_146\_) | \_\_LightSteelBlue\_ \(\_\_147\_)  | \_\_Yellow3\_ \(\_\_148\_)          |
| \_\_DarkOliveGreen3\_ \(\_\_149\_)  | \_\_DarkSeaGreen3\_ \(\_\_150\_)   | \_\_DarkSeaGreen2\_ \(\_\_151\_)   | \_\_LightCyan3\_ \(\_\_152\_)       |
| \_\_LightSkyBlue1\_ \(\_\_153\_)    | \_\_GreenYellow\_ \(\_\_154\_)     | \_\_DarkOliveGreen2\_ \(\_\_155\_) | \_\_PaleGreen1\_ \(\_\_156\_)       |
| \_\_DarkSeaGreen2\_ \(\_\_157\_)    | \_\_DarkSeaGreen1\_ \(\_\_158\_)   | \_\_PaleTurquoise1\_ \(\_\_159\_)  | \_\_Red3\_ \(\_\_160\_)             |
| \_\_DeepPink3\_ \(\_\_161\_)        | \_\_DeepPink3\_ \(\_\_162\_)       | \_\_Magenta3\_ \(\_\_163\_)        | \_\_Magenta3\_ \(\_\_164\_)         |
| \_\_Magenta2\_ \(\_\_165\_)         | \_\_DarkOrange3\_ \(\_\_166\_)     | \_\_IndianRed\_ \(\_\_167\_)       | \_\_HotPink3\_ \(\_\_168\_)         |
| \_\_HotPink2\_ \(\_\_169\_)         | \_\_Orchid\_ \(\_\_170\_)          | \_\_MediumOrchid1\_ \(\_\_171\_)   | \_\_Orange3\_ \(\_\_172\_)          |
| \_\_LightSalmon3\_ \(\_\_173\_)     | \_\_LightPink3\_ \(\_\_174\_)      | \_\_Pink3\_ \(\_\_175\_)           | \_\_Plum3\_ \(\_\_176\_)            |
| \_\_Violet\_ \(\_\_177\_)           | \_\_Gold3\_ \(\_\_178\_)           | \_\_LightGoldenrod3\_ \(\_\_179\_) | \_\_Tan\_ \(\_\_180\_)              |
| \_\_MistyRose3\_ \(\_\_181\_)       | \_\_Thistle3\_ \(\_\_182\_)        | \_\_Plum2\_ \(\_\_183\_)           | \_\_Yellow3\_ \(\_\_184\_)          |
| \_\_Khaki3\_ \(\_\_185\_)           | \_\_LightGoldenrod2\_ \(\_\_186\_) | \_\_LightYellow3\_ \(\_\_187\_)    | \_\_Grey84\_ \(\_\_188\_)           |
| \_\_LightSteelBlue1\_ \(\_\_189\_)  | \_\_Yellow2\_ \(\_\_190\_)         | \_\_DarkOliveGreen1\_ \(\_\_191\_) | \_\_DarkOliveGreen1\_ \(\_\_192\_)  |
| \_\_DarkSeaGreen1\_ \(\_\_193\_)    | \_\_Honeydew2\_ \(\_\_194\_)       | \_\_LightCyan1\_ \(\_\_195\_)      | \_\_Red1\_ \(\_\_196\_)             |
| \_\_DeepPink2\_ \(\_\_197\_)        | \_\_DeepPink1\_ \(\_\_198\_)       | \_\_DeepPink1\_ \(\_\_199\_)       | \_\_Magenta2\_ \(\_\_200\_)         |
| \_\_Magenta1\_ \(\_\_201\_)         | \_\_OrangeRed1\_ \(\_\_202\_)      | \_\_IndianRed1\_ \(\_\_203\_)      | \_\_IndianRed1\_ \(\_\_204\_)       |
| \_\_HotPink\_ \(\_\_205\_)          | \_\_HotPink\_ \(\_\_206\_)         | \_\_MediumOrchid1\_ \(\_\_207\_)   | \_\_DarkOrange\_ \(\_\_208\_)       |
| \_\_Salmon1\_ \(\_\_209\_)          | \_\_LightCoral\_ \(\_\_210\_)      | \_\_PaleVioletRed1\_ \(\_\_211\_)  | \_\_Orchid2\_ \(\_\_212\_)          |
| \_\_Orchid1\_ \(\_\_213\_)          | \_\_Orange1\_ \(\_\_214\_)         | \_\_SandyBrown\_ \(\_\_215\_)      | \_\_LightSalmon1\_ \(\_\_216\_)     |
| \_\_LightPink1\_ \(\_\_217\_)       | \_\_Pink1\_ \(\_\_218\_)           | \_\_Plum1\_ \(\_\_219\_)           | \_\_Gold1\_ \(\_\_220\_)            |
| \_\_LightGoldenrod2\_ \(\_\_221\_)  | \_\_LightGoldenrod2\_ \(\_\_222\_) | \_\_NavajoWhite1\_ \(\_\_223\_)    | \_\_MistyRose1\_ \(\_\_224\_)       |
| \_\_Thistle1\_ \(\_\_225\_)         | \_\_Yellow1\_ \(\_\_226\_)         | \_\_LightGoldenrod1\_ \(\_\_227\_) | \_\_Khaki1\_ \(\_\_228\_)           |
| \_\_Wheat1\_ \(\_\_229\_)           | \_\_Cornsilk1\_ \(\_\_230\_)       | \_\_Grey100\_ \(\_\_231\_)         | \_\_Grey3\_ \(\_\_232\_)            |
| \_\_Grey7\_ \(\_\_233\_)            | \_\_Grey11\_ \(\_\_234\_)          | \_\_Grey15\_ \(\_\_235\_)          | \_\_Grey19\_ \(\_\_236\_)           |
| \_\_Grey23\_ \(\_\_237\_)           | \_\_Grey27\_ \(\_\_238\_)          | \_\_Grey30\_ \(\_\_239\_)          | \_\_Grey35\_ \(\_\_240\_)           |
| \_\_Grey39\_ \(\_\_241\_)           | \_\_Grey42\_ \(\_\_242\_)          | \_\_Grey46\_ \(\_\_243\_)          | \_\_Grey50\_ \(\_\_244\_)           |
| \_\_Grey54\_ \(\_\_245\_)           | \_\_Grey58\_ \(\_\_246\_)          | \_\_Grey62\_ \(\_\_247\_)          | \_\_Grey66\_ \(\_\_248\_)           |
| \_\_Grey70\_ \(\_\_249\_)           | \_\_Grey74\_ \(\_\_250\_)          | \_\_Grey78\_ \(\_\_251\_)          | \_\_Grey82\_ \(\_\_252\_)           |
| \_\_Grey85\_ \(\_\_253\_)           | \_\_Grey89\_ \(\_\_254\_)          | \_\_Grey93\_ \(\_\_255\_)          |


### BACKGROUND COLORS

| \_\_Fancyname\_ (\_\_DECname\_)        | \_\_Fancyname\_ (\_\_DECname\_)         | \_\_Fancyname\_ (\_\_DECname\_)        | \_\_Fancyname\_ (\_\_DECname\_)        |
| :------------------------------------- | --------------------------------------- | -------------------------------------- | -------------------------------------: |
| \_\_BGGrey0\_ \(\_\_BG16\_)            | \_\_BGNavyBlue\_ \(\_\_BG17\_)          | \_\_BGDarkBlue\_ \(\_\_BG18\_)         | \_\_BGBlue3\_ \(\_\_BG19\_)            |
| \_\_BGBlue3\_ \(\_\_BG20\_)            | \_\_BGBlue1\_ \(\_\_BG21\_)             | \_\_BGDarkGreen\_ \(\_\_BG22\_)        | \_\_BGDeepSkyBlue4\_ \(\_\_BG23\_)     |
| \_\_BGDeepSkyBlue4\_ \(\_\_BG24\_)     | \_\_BGDeepSkyBlue4\_ \(\_\_BG25\_)      | \_\_BGDodgerBlue3\_ \(\_\_BG26\_)      | \_\_BGDodgerBlue2\_ \(\_\_BG27\_)      |
| \_\_BGGreen4\_ \(\_\_BG28\_)           | \_\_BGSpringGreen4\_ \(\_\_BG29\_)      | \_\_BGTurquoise4\_ \(\_\_BG30\_)       | \_\_BGDeepSkyBlue3\_ \(\_\_BG31\_)     |
| \_\_BGDeepSkyBlue3\_ \(\_\_BG32\_)     | \_\_BGDodgerBlue1\_ \(\_\_BG33\_)       | \_\_BGGreen3\_ \(\_\_BG34\_)           | \_\_BGSpringGreen3\_ \(\_\_BG35\_)     |
| \_\_BGDarkCyan\_ \(\_\_BG36\_)         | \_\_BGLightSeaGreen\_ \(\_\_BG37\_)     | \_\_BGDeepSkyBlue2\_ \(\_\_BG38\_)     | \_\_BGDeepSkyBlue1\_ \(\_\_BG39\_)     |
| \_\_BGGreen3\_ \(\_\_BG40\_)           | \_\_BGSpringGreen3\_ \(\_\_BG41\_)      | \_\_BGSpringGreen2\_ \(\_\_BG42\_)     | \_\_BGCyan3\_ \(\_\_BG43\_)            |
| \_\_BGDarkTurquoise\_ \(\_\_BG44\_)    | \_\_BGTurquoise2\_ \(\_\_BG45\_)        | \_\_BGGreen1\_ \(\_\_BG46\_)           | \_\_BGSpringGreen2\_ \(\_\_BG47\_)     |
| \_\_BGSpringGreen1\_ \(\_\_BG48\_)     | \_\_BGMediumSpringGreen\_ \(\_\_BG49\_) | \_\_BGCyan2\_ \(\_\_BG50\_)            | \_\_BGCyan1\_ \(\_\_BG51\_)            |
| \_\_BGDarkRed\_ \(\_\_BG52\_)          | \_\_BGDeepPink4\_ \(\_\_BG53\_)         | \_\_BGPurple4\_ \(\_\_BG54\_)          | \_\_BGPurple4\_ \(\_\_BG55\_)          |
| \_\_BGPurple3\_ \(\_\_BG56\_)          | \_\_BGBlueViolet\_ \(\_\_BG57\_)        | \_\_BGOrange4\_ \(\_\_BG58\_)          | \_\_BGGrey37\_ \(\_\_BG59\_)           |
| \_\_BGMediumPurple4\_ \(\_\_BG60\_)    | \_\_BGSlateBlue3\_ \(\_\_BG61\_)        | \_\_BGSlateBlue3\_ \(\_\_BG62\_)       | \_\_BGRoyalBlue1\_ \(\_\_BG63\_)       |
| \_\_BGChartreuse4\_ \(\_\_BG64\_)      | \_\_BGDarkSeaGreen4\_ \(\_\_BG65\_)     | \_\_BGPaleTurquoise4\_ \(\_\_BG66\_)   | \_\_BGSteelBlue\_ \(\_\_BG67\_)        |
| \_\_BGSteelBlue3\_ \(\_\_BG68\_)       | \_\_BGCornflowerBlue\_ \(\_\_BG69\_)    | \_\_BGChartreuse3\_ \(\_\_BG70\_)      | \_\_BGDarkSeaGreen4\_ \(\_\_BG71\_)    |
| \_\_BGCadetBlue\_ \(\_\_BG72\_)        | \_\_BGCadetBlue\_ \(\_\_BG73\_)         | \_\_BGSkyBlue3\_ \(\_\_BG74\_)         | \_\_BGSteelBlue1\_ \(\_\_BG75\_)       |
| \_\_BGChartreuse3\_ \(\_\_BG76\_)      | \_\_BGPaleGreen3\_ \(\_\_BG77\_)        | \_\_BGSeaGreen3\_ \(\_\_BG78\_)        | \_\_BGAquamarine3\_ \(\_\_BG79\_)      |
| \_\_BGMediumTurquoise\_ \(\_\_BG80\_)  | \_\_BGSteelBlue1\_ \(\_\_BG81\_)        | \_\_BGChartreuse2\_ \(\_\_BG82\_)      | \_\_BGSeaGreen2\_ \(\_\_BG83\_)        |
| \_\_BGSeaGreen1\_ \(\_\_BG84\_)        | \_\_BGSeaGreen1\_ \(\_\_BG85\_)         | \_\_BGAquamarine1\_ \(\_\_BG86\_)      | \_\_BGDarkSlateGray2\_ \(\_\_BG87\_)   |
| \_\_BGDarkRed\_ \(\_\_BG88\_)          | \_\_BGDeepPink4\_ \(\_\_BG89\_)         | \_\_BGDarkMagenta\_ \(\_\_BG90\_)      | \_\_BGDarkMagenta\_ \(\_\_BG91\_)      |
| \_\_BGDarkViolet\_ \(\_\_BG92\_)       | \_\_BGPurple\_ \(\_\_BG93\_)            | \_\_BGOrange4\_ \(\_\_BG94\_)          | \_\_BGLightPink4\_ \(\_\_BG95\_)       |
| \_\_BGPlum4\_ \(\_\_BG96\_)            | \_\_BGMediumPurple3\_ \(\_\_BG97\_)     | \_\_BGMediumPurple3\_ \(\_\_BG98\_)    | \_\_BGSlateBlue1\_ \(\_\_BG99\_)       |
| \_\_BGYellow4\_ \(\_\_BG100\_)         | \_\_BGWheat4\_ \(\_\_BG101\_)           | \_\_BGGrey53\_ \(\_\_BG102\_)          | \_\_BGLightSlateGrey\_ \(\_\_BG103\_)  |
| \_\_BGMediumPurple\_ \(\_\_BG104\_)    | \_\_BGLightSlateBlue\_ \(\_\_BG105\_)   | \_\_BGYellow4\_ \(\_\_BG106\_)         | \_\_BGDarkOliveGreen3\_ \(\_\_BG107\_) |
| \_\_BGDarkSeaGreen\_ \(\_\_BG108\_)    | \_\_BGLightSkyBlue3\_ \(\_\_BG109\_)    | \_\_BGLightSkyBlue3\_ \(\_\_BG110\_)   | \_\_BGSkyBlue2\_ \(\_\_BG111\_)        |
| \_\_BGChartreuse2\_ \(\_\_BG112\_)     | \_\_BGDarkOliveGreen3\_ \(\_\_BG113\_)  | \_\_BGPaleGreen3\_ \(\_\_BG114\_)      | \_\_BGDarkSeaGreen3\_ \(\_\_BG115\_)   |
| \_\_BGDarkSlateGray3\_ \(\_\_BG116\_)  | \_\_BGSkyBlue1\_ \(\_\_BG117\_)         | \_\_BGChartreuse1\_ \(\_\_BG118\_)     | \_\_BGLightGreen\_ \(\_\_BG119\_)      |
| \_\_BGLightGreen\_ \(\_\_BG120\_)      | \_\_BGPaleGreen1\_ \(\_\_BG121\_)       | \_\_BGAquamarine1\_ \(\_\_BG122\_)     | \_\_BGDarkSlateGray1\_ \(\_\_BG123\_)  |
| \_\_BGRed3\_ \(\_\_BG124\_)            | \_\_BGDeepPink4\_ \(\_\_BG125\_)        | \_\_BGMediumVioletRed\_ \(\_\_BG126\_) | \_\_BGMagenta3\_ \(\_\_BG127\_)        |
| \_\_BGDarkViolet\_ \(\_\_BG128\_)      | \_\_BGPurple\_ \(\_\_BG129\_)           | \_\_BGDarkOrange3\_ \(\_\_BG130\_)     | \_\_BGIndianRed\_ \(\_\_BG131\_)       |
| \_\_BGHotPink3\_ \(\_\_BG132\_)        | \_\_BGMediumOrchid3\_ \(\_\_BG133\_)    | \_\_BGMediumOrchid\_ \(\_\_BG134\_)    | \_\_BGMediumPurple2\_ \(\_\_BG135\_)   |
| \_\_BGDarkGoldenrod\_ \(\_\_BG136\_)   | \_\_BGLightSalmon3\_ \(\_\_BG137\_)     | \_\_BGRosyBrown\_ \(\_\_BG138\_)       | \_\_BGGrey63\_ \(\_\_BG139\_)          |
| \_\_BGMediumPurple2\_ \(\_\_BG140\_)   | \_\_BGMediumPurple1\_ \(\_\_BG141\_)    | \_\_BGGold3\_ \(\_\_BG142\_)           | \_\_BGDarkKhaki\_ \(\_\_BG143\_)       |
| \_\_BGNavajoWhite3\_ \(\_\_BG144\_)    | \_\_BGGrey69\_ \(\_\_BG145\_)           | \_\_BGLightSteelBlue3\_ \(\_\_BG146\_) | \_\_BGLightSteelBlue\_ \(\_\_BG147\_)  |
| \_\_BGYellow3\_ \(\_\_BG148\_)         | \_\_BGDarkOliveGreen3\_ \(\_\_BG149\_)  | \_\_BGDarkSeaGreen3\_ \(\_\_BG150\_)   | \_\_BGDarkSeaGreen2\_ \(\_\_BG151\_)   |
| \_\_BGLightCyan3\_ \(\_\_BG152\_)      | \_\_BGLightSkyBlue1\_ \(\_\_BG153\_)    | \_\_BGGreenYellow\_ \(\_\_BG154\_)     | \_\_BGDarkOliveGreen2\_ \(\_\_BG155\_) |
| \_\_BGPaleGreen1\_ \(\_\_BG156\_)      | \_\_BGDarkSeaGreen2\_ \(\_\_BG157\_)    | \_\_BGDarkSeaGreen1\_ \(\_\_BG158\_)   | \_\_BGPaleTurquoise1\_ \(\_\_BG159\_)  |
| \_\_BGRed3\_ \(\_\_BG160\_)            | \_\_BGDeepPink3\_ \(\_\_BG161\_)        | \_\_BGDeepPink3\_ \(\_\_BG162\_)       | \_\_BGMagenta3\_ \(\_\_BG163\_)        |
| \_\_BGMagenta3\_ \(\_\_BG164\_)        | \_\_BGMagenta2\_ \(\_\_BG165\_)         | \_\_BGDarkOrange3\_ \(\_\_BG166\_)     | \_\_BGIndianRed\_ \(\_\_BG167\_)       |
| \_\_BGHotPink3\_ \(\_\_BG168\_)        | \_\_BGHotPink2\_ \(\_\_BG169\_)         | \_\_BGOrchid\_ \(\_\_BG170\_)          | \_\_BGMediumOrchid1\_ \(\_\_BG171\_)   |
| \_\_BGOrange3\_ \(\_\_BG172\_)         | \_\_BGLightSalmon3\_ \(\_\_BG173\_)     | \_\_BGLightPink3\_ \(\_\_BG174\_)      | \_\_BGPink3\_ \(\_\_BG175\_)           |
| \_\_BGPlum3\_ \(\_\_BG176\_)           | \_\_BGViolet\_ \(\_\_BG177\_)           | \_\_BGGold3\_ \(\_\_BG178\_)           | \_\_BGLightGoldenrod3\_ \(\_\_BG179\_) |
| \_\_BGTan\_ \(\_\_BG180\_)             | \_\_BGMistyRose3\_ \(\_\_BG181\_)       | \_\_BGThistle3\_ \(\_\_BG182\_)        | \_\_BGPlum2\_ \(\_\_BG183\_)           |
| \_\_BGYellow3\_ \(\_\_BG184\_)         | \_\_BGKhaki3\_ \(\_\_BG185\_)           | \_\_BGLightGoldenrod2\_ \(\_\_BG186\_) | \_\_BGLightYellow3\_ \(\_\_BG187\_)    |
| \_\_BGGrey84\_ \(\_\_BG188\_)          | \_\_BGLightSteelBlue1\_ \(\_\_BG189\_)  | \_\_BGYellow2\_ \(\_\_BG190\_)         | \_\_BGDarkOliveGreen1\_ \(\_\_BG191\_) |
| \_\_BGDarkOliveGreen1\_ \(\_\_BG192\_) | \_\_BGDarkSeaGreen1\_ \(\_\_BG193\_)    | \_\_BGHoneydew2\_ \(\_\_BG194\_)       | \_\_BGLightCyan1\_ \(\_\_BG195\_)      |
| \_\_BGRed1\_ \(\_\_BG196\_)            | \_\_BGDeepPink2\_ \(\_\_BG197\_)        | \_\_BGDeepPink1\_ \(\_\_BG198\_)       | \_\_BGDeepPink1\_ \(\_\_BG199\_)       |
| \_\_BGMagenta2\_ \(\_\_BG200\_)        | \_\_BGMagenta1\_ \(\_\_BG201\_)         | \_\_BGOrangeRed1\_ \(\_\_BG202\_)      | \_\_BGIndianRed1\_ \(\_\_BG203\_)      |
| \_\_BGIndianRed1\_ \(\_\_BG204\_)      | \_\_BGHotPink\_ \(\_\_BG205\_)          | \_\_BGHotPink\_ \(\_\_BG206\_)         | \_\_BGMediumOrchid1\_ \(\_\_BG207\_)   |
| \_\_BGDarkOrange\_ \(\_\_BG208\_)      | \_\_BGSalmon1\_ \(\_\_BG209\_)          | \_\_BGLightCoral\_ \(\_\_BG210\_)      | \_\_BGPaleVioletRed1\_ \(\_\_BG211\_)  |
| \_\_BGOrchid2\_ \(\_\_BG212\_)         | \_\_BGOrchid1\_ \(\_\_BG213\_)          | \_\_BGOrange1\_ \(\_\_BG214\_)         | \_\_BGSandyBrown\_ \(\_\_BG215\_)      |
| \_\_BGLightSalmon1\_ \(\_\_BG216\_)    | \_\_BGLightPink1\_ \(\_\_BG217\_)       | \_\_BGPink1\_ \(\_\_BG218\_)           | \_\_BGPlum1\_ \(\_\_BG219\_)           |
| \_\_BGGold1\_ \(\_\_BG220\_)           | \_\_BGLightGoldenrod2\_ \(\_\_BG221\_)  | \_\_BGLightGoldenrod2\_ \(\_\_BG222\_) | \_\_BGNavajoWhite1\_ \(\_\_BG223\_)    |
| \_\_BGMistyRose1\_ \(\_\_BG224\_)      | \_\_BGThistle1\_ \(\_\_BG225\_)         | \_\_BGYellow1\_ \(\_\_BG226\_)         | \_\_BGLightGoldenrod1\_ \(\_\_BG227\_) |
| \_\_BGKhaki1\_ \(\_\_BG228\_)          | \_\_BGWheat1\_ \(\_\_BG229\_)           | \_\_BGCornsilk1\_ \(\_\_BG230\_)       | \_\_BGGrey100\_ \(\_\_BG231\_)         |
| \_\_BGGrey3\_ \(\_\_BG232\_)           | \_\_BGGrey7\_ \(\_\_BG233\_)            | \_\_BGGrey11\_ \(\_\_BG234\_)          | \_\_BGGrey15\_ \(\_\_BG235\_)          |
| \_\_BGGrey19\_ \(\_\_BG236\_)          | \_\_BGGrey23\_ \(\_\_BG237\_)           | \_\_BGGrey27\_ \(\_\_BG238\_)          | \_\_BGGrey30\_ \(\_\_BG239\_)          |
| \_\_BGGrey35\_ \(\_\_BG240\_)          | \_\_BGGrey39\_ \(\_\_BG241\_)           | \_\_BGGrey42\_ \(\_\_BG242\_)          | \_\_BGGrey46\_ \(\_\_BG243\_)          |
| \_\_BGGrey50\_ \(\_\_BG244\_)          | \_\_BGGrey54\_ \(\_\_BG245\_)           | \_\_BGGrey58\_ \(\_\_BG246\_)          | \_\_BGGrey62\_ \(\_\_BG247\_)          |
| \_\_BGGrey66\_ \(\_\_BG248\_)          | \_\_BGGrey70\_ \(\_\_BG249\_)           | \_\_BGGrey74\_ \(\_\_BG250\_)          | \_\_BGGrey78\_ \(\_\_BG251\_)          |
| \_\_BGGrey82\_ \(\_\_BG252\_)          | \_\_BGGrey85\_ \(\_\_BG253\_)           | \_\_BGGrey89\_ \(\_\_BG254\_)          | \_\_BGGrey93\_ \(\_\_BG255\_)          |






