growlterm
=========

growl-like notifications for your terminal


# Additional scripts (you should use them!)

add 2 scripts to define TERM safe color variables : `safetermcolors8.sh`
and `safetermcolors-addit-256.sh`

##`safetermcolors8.sh`

safely (*in terms on `terminfo`*) defines the 001-015 color range, which
exist on any TERM which has more than 2 colors capacity, plus modifiers
(underline, reset, bold, ...) (also works on TERMS which don't by
degrading quietly and still provide modifier styles (underline & such)


###NOta Bene

sourcing this script exports the aditional variable 

  export __TPUT_COLORS_DEFINED="true"

so that you can check later on that it's already done


### more info

 COLOR VARS :
                * declare the 8 SYSTEM TERM colors (and their variants :
                 background & bold) and the modifiers (DOUBLE INTENSITY, DIM,
                 BLINK, RESET,... ONCE and for ALL.

               * declare the defaults for old TERMS, and adapt to less
                 horrid defaults for 256-colors TERMS

                 -> This somewhat pollutes the GLOBAL SCOPE but the variable
                    names are (thought to be) unique enough so that won't cause
                    problems

               * do that like a grownup (tput, resort to not ANSI escapes only
                                         as a fallback with `tput
                                         setaf`)

               * TODO: handle dark vs light background

               * TODO: handle 256 colors (if [ $(tput colors) -ge 256 ] ...)

                                                                     # ANSI equivalent
                                                                     # <attr> <fg>  <bg>
### variable list

    | ALL 8-COLOR COMPATIBLE VARIABLES DEFINED |
    | :------------                            | -----------------      | ----------------------------------    |
    | MODIFIERS                                |
    | Variable NAME                            | equivalent ANSI escape | Description                           |
    |                                          | ATTR   FG   BG         |                                       |
    | __NN_                                    | [ 0m                   | RESET ALL attributes                  |
    | STYLES                                   |
    | __EM_                                    | [ 1m                   | BEGIN DOUBLE INTENSITY (bold) mode    |
    | __DM_                                    | [ 2m                   | BEGIN HALF INTENSITY    (dim) mode    |
    | __UN_                                    | [ 4m                   | BEGIN UNDESCORE  (underlined) mode    |
    | __BL_                                    | [ 5m                   | BEGIN BLINKING                mode    |
    | __RV_                                    | [ 7m                   | BEGIN REVERSE VIDEO (reverse) mode    |
    | __SO_                                    | ?[ 7m                  | BEGIN STANDOUT      (reverse) mode    |
    | __IN_                                    | [ 8m                   | BEGIN INVISIBLE               mode    |
    | __DEL_                                   |                        | MOVE cursor LEFT one space            |
    | __SOQ_                                   | ?[ 27m                 | END   STANDOUT      (reverse) mode    |
    | __UNQ_                                   | [ 24m                  | END   UNDESCORE  (underlined) mode    |
    | DEFAULT SYSTEM COLORS                    |
    | <Foreground>                             |
    | __K_                                     | [       0m             | SET   FG color to BLACK               |
    | __R_                                     | [       1m             | SET   FG color to RED                 |
    | __G_                                     | [       2m             | SET   FG color to GREEN               |
    | __Y_                                     | [       3m             | SET   FG color to YELLOW              |
    | __B_                                     | [       4m             | SET   FG color to BLUE                |
    | __M_                                     | [       5m             | SET   FG color to MAGENTA             |
    | __C_                                     | [       6m             | SET   FG color to CYAN                |
    | __W_                                     | [       7m             | SET   FG color to WHITE               |
    | <Backgound>                              |
    | __BGK_                                   | [       0m             | SET   BG color to BLACK               |
    | __BGR_                                   | [       1m             | SET   BG color to RED                 |
    | __BGG_                                   | [       2m             | SET   BG color to GREEN               |
    | __BGY_                                   | [       3m             | SET   BG color to YELLOW              |
    | __BGB_                                   | [       4m             | SET   BG color to BLUE                |
    | __BGM_                                   | [       5m             | SET   BG color to MAGENTA             |
    | __BGC_                                   | [       6m             | SET   BG color to CYAN                |
    | __BGW_                                   | [       7m             | SET   BG color to WHITE               |
    | <reset>                                  |
    | __NF_                                    | [       39m            | RESET FG color to term's default      |
    | __NG_                                    | [             49m      | RESET BG color to term's default      |
    | __NFG_                                   | [       39;   49m      | RESET FG & BG color to term's default |
    | PSOEUDO(BOLD) COLORS                     |
    | <Foreground-bold>                        |
    | __EMK_                                   | [ 1;    20m            | SET   FG color to BOLD BLACK          |
    | __EMR_                                   | [ 1;    21m            | SET   FG color to BOLD RED            |
    | __EMG_                                   | [ 1;    22m            | SET   FG color to BOLD GREEN          |
    | __EMY_                                   | [ 1;    23m            | SET   FG color to BOLD YELLOW         |
    | __EMB_                                   | [ 1;    24m            | SET   FG color to BOLD BLUE           |
    | __EMM_                                   | [ 1;    25m            | SET   FG color to BOLD MAGENTA        |
    | __EMC_                                   | [ 1;    26m            | SET   FG color to BOLD CYAN           |
    | __EMW_                                   | [ 1;    27m            | SET   FG color to BOLD RED            |
    | MISC (non color)                         |
    | __NL_   most compatible NEWLINE ever     |
    [[TITLE]]

##`safetermcolors-addit-256.sh`

In a fancy mood ? add custom variables for all 256 color range
(foreground and background) in a safe (*in terms of `terminfo`*) way



| BACKGROUND COLORS |
| :--------------------------------- | ---------------------------------- | ---------------------------------- | ---------------------------------- |
| \_\_NavyBlue\_          ( or \_\_17\_ )  | \_\_DarkBlue\_          ( or \_\_18\_ )  | \_\_Blue3\_             ( or \_\_19\_ )  | \_\_Blue3\_             ( or \_\_20\_ )  |
| \_\_Blue1\_             ( or \_\_21\_ )  | \_\_DarkGreen\_         ( or \_\_22\_ )  | \_\_DeepSkyBlue4\_      ( or \_\_23\_ )  | \_\_DeepSkyBlue4\_      ( or \_\_24\_ )  |
| \_\_DeepSkyBlue4\_      ( or \_\_25\_ )  | \_\_DodgerBlue3\_       ( or \_\_26\_ )  | \_\_DodgerBlue2\_       ( or \_\_27\_ )  | \_\_Green4\_            ( or \_\_28\_ )  |
| \_\_SpringGreen4\_      ( or \_\_29\_ )  | \_\_Turquoise4\_        ( or \_\_30\_ )  | \_\_DeepSkyBlue3\_      ( or \_\_31\_ )  | \_\_DeepSkyBlue3\_      ( or \_\_32\_ )  |
| \_\_DodgerBlue1\_       ( or \_\_33\_ )  | \_\_Green3\_            ( or \_\_34\_ )  | \_\_SpringGreen3\_      ( or \_\_35\_ )  | \_\_DarkCyan\_          ( or \_\_36\_ )  |
| \_\_LightSeaGreen\_     ( or \_\_37\_ )  | \_\_DeepSkyBlue2\_      ( or \_\_38\_ )  | \_\_DeepSkyBlue1\_      ( or \_\_39\_ )  | \_\_Green3\_            ( or \_\_40\_ )  |
| \_\_SpringGreen3\_      ( or \_\_41\_ )  | \_\_SpringGreen2\_      ( or \_\_42\_ )  | \_\_Cyan3\_             ( or \_\_43\_ )  | \_\_DarkTurquoise\_     ( or \_\_44\_ )  |
| \_\_Turquoise2\_        ( or \_\_45\_ )  | \_\_Green1\_            ( or \_\_46\_ )  | \_\_SpringGreen2\_      ( or \_\_47\_ )  | \_\_SpringGreen1\_      ( or \_\_48\_ )  |
| \_\_MediumSpringGreen\_ ( or \_\_49\_ )  | \_\_Cyan2\_             ( or \_\_50\_ )  | \_\_Cyan1\_             ( or \_\_51\_ )  | \_\_DarkRed\_           ( or \_\_52\_ )  |
| \_\_DeepPink4\_         ( or \_\_53\_ )  | \_\_Purple4\_           ( or \_\_54\_ )  | \_\_Purple4\_           ( or \_\_55\_ )  | \_\_Purple3\_           ( or \_\_56\_ )  |
| \_\_BlueViolet\_        ( or \_\_57\_ )  | \_\_Orange4\_           ( or \_\_58\_ )  | \_\_Grey37\_            ( or \_\_59\_ )  | \_\_MediumPurple4\_     ( or \_\_60\_ )  |
| \_\_SlateBlue3\_        ( or \_\_61\_ )  | \_\_SlateBlue3\_        ( or \_\_62\_ )  | \_\_RoyalBlue1\_        ( or \_\_63\_ )  | \_\_Chartreuse4\_       ( or \_\_64\_ )  |
| \_\_DarkSeaGreen4\_     ( or \_\_65\_ )  | \_\_PaleTurquoise4\_    ( or \_\_66\_ )  | \_\_SteelBlue\_         ( or \_\_67\_ )  | \_\_SteelBlue3\_        ( or \_\_68\_ )  |
| \_\_CornflowerBlue\_    ( or \_\_69\_ )  | \_\_Chartreuse3\_       ( or \_\_70\_ )  | \_\_DarkSeaGreen4\_     ( or \_\_71\_ )  | \_\_CadetBlue\_         ( or \_\_72\_ )  |
| \_\_CadetBlue\_         ( or \_\_73\_ )  | \_\_SkyBlue3\_          ( or \_\_74\_ )  | \_\_SteelBlue1\_        ( or \_\_75\_ )  | \_\_Chartreuse3\_       ( or \_\_76\_ )  |
| \_\_PaleGreen3\_        ( or \_\_77\_ )  | \_\_SeaGreen3\_         ( or \_\_78\_ )  | \_\_Aquamarine3\_       ( or \_\_79\_ )  | \_\_MediumTurquoise\_   ( or \_\_80\_ )  |
| \_\_SteelBlue1\_        ( or \_\_81\_ )  | \_\_Chartreuse2\_       ( or \_\_82\_ )  | \_\_SeaGreen2\_         ( or \_\_83\_ )  | \_\_SeaGreen1\_         ( or \_\_84\_ )  |
| \_\_SeaGreen1\_         ( or \_\_85\_ )  | \_\_Aquamarine1\_       ( or \_\_86\_ )  | \_\_DarkSlateGray2\_    ( or \_\_87\_ )  | \_\_DarkRed\_           ( or \_\_88\_ )  |
| \_\_DeepPink4\_         ( or \_\_89\_ )  | \_\_DarkMagenta\_       ( or \_\_90\_ )  | \_\_DarkMagenta\_       ( or \_\_91\_ )  | \_\_DarkViolet\_        ( or \_\_92\_ )  |
| \_\_Purple\_            ( or \_\_93\_ )  | \_\_Orange4\_           ( or \_\_94\_ )  | \_\_LightPink4\_        ( or \_\_95\_ )  | \_\_Plum4\_             ( or \_\_96\_ )  |
| \_\_MediumPurple3\_     ( or \_\_97\_ )  | \_\_MediumPurple3\_     ( or \_\_98\_ )  | \_\_SlateBlue1\_        ( or \_\_99\_ )  | \_\_Yellow4\_           ( or \_\_100\_ ) |
| \_\_Wheat4\_            ( or \_\_101\_ ) | \_\_Grey53\_            ( or \_\_102\_ ) | \_\_LightSlateGrey\_    ( or \_\_103\_ ) | \_\_MediumPurple\_      ( or \_\_104\_ ) |
| \_\_LightSlateBlue\_    ( or \_\_105\_ ) | \_\_Yellow4\_           ( or \_\_106\_ ) | \_\_DarkOliveGreen3\_   ( or \_\_107\_ ) | \_\_DarkSeaGreen\_      ( or \_\_108\_ ) |
| \_\_LightSkyBlue3\_     ( or \_\_109\_ ) | \_\_LightSkyBlue3\_     ( or \_\_110\_ ) | \_\_SkyBlue2\_          ( or \_\_111\_ ) | \_\_Chartreuse2\_       ( or \_\_112\_ ) |
| \_\_DarkOliveGreen3\_   ( or \_\_113\_ ) | \_\_PaleGreen3\_        ( or \_\_114\_ ) | \_\_DarkSeaGreen3\_     ( or \_\_115\_ ) | \_\_DarkSlateGray3\_    ( or \_\_116\_ ) |
| \_\_SkyBlue1\_          ( or \_\_117\_ ) | \_\_Chartreuse1\_       ( or \_\_118\_ ) | \_\_LightGreen\_        ( or \_\_119\_ ) | \_\_LightGreen\_        ( or \_\_120\_ ) |
| \_\_PaleGreen1\_        ( or \_\_121\_ ) | \_\_Aquamarine1\_       ( or \_\_122\_ ) | \_\_DarkSlateGray1\_    ( or \_\_123\_ ) | \_\_Red3\_              ( or \_\_124\_ ) |
| \_\_DeepPink4\_         ( or \_\_125\_ ) | \_\_MediumVioletRed\_   ( or \_\_126\_ ) | \_\_Magenta3\_          ( or \_\_127\_ ) | \_\_DarkViolet\_        ( or \_\_128\_ ) |
| \_\_Purple\_            ( or \_\_129\_ ) | \_\_DarkOrange3\_       ( or \_\_130\_ ) | \_\_IndianRed\_         ( or \_\_131\_ ) | \_\_HotPink3\_          ( or \_\_132\_ ) |
| \_\_MediumOrchid3\_     ( or \_\_133\_ ) | \_\_MediumOrchid\_      ( or \_\_134\_ ) | \_\_MediumPurple2\_     ( or \_\_135\_ ) | \_\_DarkGoldenrod\_     ( or \_\_136\_ ) |
| \_\_LightSalmon3\_      ( or \_\_137\_ ) | \_\_RosyBrown\_         ( or \_\_138\_ ) | \_\_Grey63\_            ( or \_\_139\_ ) | \_\_MediumPurple2\_     ( or \_\_140\_ ) |
| \_\_MediumPurple1\_     ( or \_\_141\_ ) | \_\_Gold3\_             ( or \_\_142\_ ) | \_\_DarkKhaki\_         ( or \_\_143\_ ) | \_\_NavajoWhite3\_      ( or \_\_144\_ ) |
| \_\_Grey69\_            ( or \_\_145\_ ) | \_\_LightSteelBlue3\_   ( or \_\_146\_ ) | \_\_LightSteelBlue\_    ( or \_\_147\_ ) | \_\_Yellow3\_           ( or \_\_148\_ ) |
| \_\_DarkOliveGreen3\_   ( or \_\_149\_ ) | \_\_DarkSeaGreen3\_     ( or \_\_150\_ ) | \_\_DarkSeaGreen2\_     ( or \_\_151\_ ) | \_\_LightCyan3\_        ( or \_\_152\_ ) |
| \_\_LightSkyBlue1\_     ( or \_\_153\_ ) | \_\_GreenYellow\_       ( or \_\_154\_ ) | \_\_DarkOliveGreen2\_   ( or \_\_155\_ ) | \_\_PaleGreen1\_        ( or \_\_156\_ ) |
| \_\_DarkSeaGreen2\_     ( or \_\_157\_ ) | \_\_DarkSeaGreen1\_     ( or \_\_158\_ ) | \_\_PaleTurquoise1\_    ( or \_\_159\_ ) | \_\_Red3\_              ( or \_\_160\_ ) |
| \_\_DeepPink3\_         ( or \_\_161\_ ) | \_\_DeepPink3\_         ( or \_\_162\_ ) | \_\_Magenta3\_          ( or \_\_163\_ ) | \_\_Magenta3\_          ( or \_\_164\_ ) |
| \_\_Magenta2\_          ( or \_\_165\_ ) | \_\_DarkOrange3\_       ( or \_\_166\_ ) | \_\_IndianRed\_         ( or \_\_167\_ ) | \_\_HotPink3\_          ( or \_\_168\_ ) |
| \_\_HotPink2\_          ( or \_\_169\_ ) | \_\_Orchid\_            ( or \_\_170\_ ) | \_\_MediumOrchid1\_     ( or \_\_171\_ ) | \_\_Orange3\_           ( or \_\_172\_ ) |
| \_\_LightSalmon3\_      ( or \_\_173\_ ) | \_\_LightPink3\_        ( or \_\_174\_ ) | \_\_Pink3\_             ( or \_\_175\_ ) | \_\_Plum3\_             ( or \_\_176\_ ) |
| \_\_Violet\_            ( or \_\_177\_ ) | \_\_Gold3\_             ( or \_\_178\_ ) | \_\_LightGoldenrod3\_   ( or \_\_179\_ ) | \_\_Tan\_               ( or \_\_180\_ ) |
| \_\_MistyRose3\_        ( or \_\_181\_ ) | \_\_Thistle3\_          ( or \_\_182\_ ) | \_\_Plum2\_             ( or \_\_183\_ ) | \_\_Yellow3\_           ( or \_\_184\_ ) |
| \_\_Khaki3\_            ( or \_\_185\_ ) | \_\_LightGoldenrod2\_   ( or \_\_186\_ ) | \_\_LightYellow3\_      ( or \_\_187\_ ) | \_\_Grey84\_            ( or \_\_188\_ ) |
| \_\_LightSteelBlue1\_   ( or \_\_189\_ ) | \_\_Yellow2\_           ( or \_\_190\_ ) | \_\_DarkOliveGreen1\_   ( or \_\_191\_ ) | \_\_DarkOliveGreen1\_   ( or \_\_192\_ ) |
| \_\_DarkSeaGreen1\_     ( or \_\_193\_ ) | \_\_Honeydew2\_         ( or \_\_194\_ ) | \_\_LightCyan1\_        ( or \_\_195\_ ) | \_\_Red1\_              ( or \_\_196\_ ) |
| \_\_DeepPink2\_         ( or \_\_197\_ ) | \_\_DeepPink1\_         ( or \_\_198\_ ) | \_\_DeepPink1\_         ( or \_\_199\_ ) | \_\_Magenta2\_          ( or \_\_200\_ ) |
| \_\_Magenta1\_          ( or \_\_201\_ ) | \_\_OrangeRed1\_        ( or \_\_202\_ ) | \_\_IndianRed1\_        ( or \_\_203\_ ) | \_\_IndianRed1\_        ( or \_\_204\_ ) |
| \_\_HotPink\_           ( or \_\_205\_ ) | \_\_HotPink\_           ( or \_\_206\_ ) | \_\_MediumOrchid1\_     ( or \_\_207\_ ) | \_\_DarkOrange\_        ( or \_\_208\_ ) |
| \_\_Salmon1\_           ( or \_\_209\_ ) | \_\_LightCoral\_        ( or \_\_210\_ ) | \_\_PaleVioletRed1\_    ( or \_\_211\_ ) | \_\_Orchid2\_           ( or \_\_212\_ ) |
| \_\_Orchid1\_           ( or \_\_213\_ ) | \_\_Orange1\_           ( or \_\_214\_ ) | \_\_SandyBrown\_        ( or \_\_215\_ ) | \_\_LightSalmon1\_      ( or \_\_216\_ ) |
| \_\_LightPink1\_        ( or \_\_217\_ ) | \_\_Pink1\_             ( or \_\_218\_ ) | \_\_Plum1\_             ( or \_\_219\_ ) | \_\_Gold1\_             ( or \_\_220\_ ) |
| \_\_LightGoldenrod2\_   ( or \_\_221\_ ) | \_\_LightGoldenrod2\_   ( or \_\_222\_ ) | \_\_NavajoWhite1\_      ( or \_\_223\_ ) | \_\_MistyRose1\_        ( or \_\_224\_ ) |
| \_\_Thistle1\_          ( or \_\_225\_ ) | \_\_Yellow1\_           ( or \_\_226\_ ) | \_\_LightGoldenrod1\_   ( or \_\_227\_ ) | \_\_Khaki1\_            ( or \_\_228\_ ) |
| \_\_Wheat1\_            ( or \_\_229\_ ) | \_\_Cornsilk1\_         ( or \_\_230\_ ) | \_\_Grey100\_           ( or \_\_231\_ ) | \_\_Grey3\_             ( or \_\_232\_ ) |
| \_\_Grey7\_             ( or \_\_233\_ ) | \_\_Grey11\_            ( or \_\_234\_ ) | \_\_Grey15\_            ( or \_\_235\_ ) | \_\_Grey19\_            ( or \_\_236\_ ) |
| \_\_Grey23\_            ( or \_\_237\_ ) | \_\_Grey27\_            ( or \_\_238\_ ) | \_\_Grey30\_            ( or \_\_239\_ ) | \_\_Grey35\_            ( or \_\_240\_ ) |
| \_\_Grey39\_            ( or \_\_241\_ ) | \_\_Grey42\_            ( or \_\_242\_ ) | \_\_Grey46\_            ( or \_\_243\_ ) | \_\_Grey50\_            ( or \_\_244\_ ) |
| \_\_Grey54\_            ( or \_\_245\_ ) | \_\_Grey58\_            ( or \_\_246\_ ) | \_\_Grey62\_            ( or \_\_247\_ ) | \_\_Grey66\_            ( or \_\_248\_ ) |
| \_\_Grey70\_            ( or \_\_249\_ ) | \_\_Grey74\_            ( or \_\_250\_ ) | \_\_Grey78\_            ( or \_\_251\_ ) | \_\_Grey82\_            ( or \_\_252\_ ) |
| \_\_Grey85\_            ( or \_\_253\_ ) | \_\_Grey89\_            ( or \_\_254\_ ) | \_\_Grey93\_            ( or \_\_255\_ ) |


| BACKGROUND COLORS |
| :--------------------------------- | ---------------------------------- | ---------------------------------- | ---------------------------------- |
| \_\_BGGrey0\_             ( or \_\_BG16\_ )  | \_\_BGNavyBlue\_          ( or \_\_BG17\_ )  | \_\_BGDarkBlue\_          ( or \_\_BG18\_ )  | \_\_BGBlue3\_             ( or \_\_BG19\_ )  |
| \_\_BGBlue3\_             ( or \_\_BG20\_ )  | \_\_BGBlue1\_             ( or \_\_BG21\_ )  | \_\_BGDarkGreen\_         ( or \_\_BG22\_ )  | \_\_BGDeepSkyBlue4\_      ( or \_\_BG23\_ )  |
| \_\_BGDeepSkyBlue4\_      ( or \_\_BG24\_ )  | \_\_BGDeepSkyBlue4\_      ( or \_\_BG25\_ )  | \_\_BGDodgerBlue3\_       ( or \_\_BG26\_ )  | \_\_BGDodgerBlue2\_       ( or \_\_BG27\_ )  |
| \_\_BGGreen4\_            ( or \_\_BG28\_ )  | \_\_BGSpringGreen4\_      ( or \_\_BG29\_ )  | \_\_BGTurquoise4\_        ( or \_\_BG30\_ )  | \_\_BGDeepSkyBlue3\_      ( or \_\_BG31\_ )  |
| \_\_BGDeepSkyBlue3\_      ( or \_\_BG32\_ )  | \_\_BGDodgerBlue1\_       ( or \_\_BG33\_ )  | \_\_BGGreen3\_            ( or \_\_BG34\_ )  | \_\_BGSpringGreen3\_      ( or \_\_BG35\_ )  |
| \_\_BGDarkCyan\_          ( or \_\_BG36\_ )  | \_\_BGLightSeaGreen\_     ( or \_\_BG37\_ )  | \_\_BGDeepSkyBlue2\_      ( or \_\_BG38\_ )  | \_\_BGDeepSkyBlue1\_      ( or \_\_BG39\_ )  |
| \_\_BGGreen3\_            ( or \_\_BG40\_ )  | \_\_BGSpringGreen3\_      ( or \_\_BG41\_ )  | \_\_BGSpringGreen2\_      ( or \_\_BG42\_ )  | \_\_BGCyan3\_             ( or \_\_BG43\_ )  |
| \_\_BGDarkTurquoise\_     ( or \_\_BG44\_ )  | \_\_BGTurquoise2\_        ( or \_\_BG45\_ )  | \_\_BGGreen1\_            ( or \_\_BG46\_ )  | \_\_BGSpringGreen2\_      ( or \_\_BG47\_ )  |
| \_\_BGSpringGreen1\_      ( or \_\_BG48\_ )  | \_\_BGMediumSpringGreen\_ ( or \_\_BG49\_ )  | \_\_BGCyan2\_             ( or \_\_BG50\_ )  | \_\_BGCyan1\_             ( or \_\_BG51\_ )  |
| \_\_BGDarkRed\_           ( or \_\_BG52\_ )  | \_\_BGDeepPink4\_         ( or \_\_BG53\_ )  | \_\_BGPurple4\_           ( or \_\_BG54\_ )  | \_\_BGPurple4\_           ( or \_\_BG55\_ )  |
| \_\_BGPurple3\_           ( or \_\_BG56\_ )  | \_\_BGBlueViolet\_        ( or \_\_BG57\_ )  | \_\_BGOrange4\_           ( or \_\_BG58\_ )  | \_\_BGGrey37\_            ( or \_\_BG59\_ )  |
| \_\_BGMediumPurple4\_     ( or \_\_BG60\_ )  | \_\_BGSlateBlue3\_        ( or \_\_BG61\_ )  | \_\_BGSlateBlue3\_        ( or \_\_BG62\_ )  | \_\_BGRoyalBlue1\_        ( or \_\_BG63\_ )  |
| \_\_BGChartreuse4\_       ( or \_\_BG64\_ )  | \_\_BGDarkSeaGreen4\_     ( or \_\_BG65\_ )  | \_\_BGPaleTurquoise4\_    ( or \_\_BG66\_ )  | \_\_BGSteelBlue\_         ( or \_\_BG67\_ )  |
| \_\_BGSteelBlue3\_        ( or \_\_BG68\_ )  | \_\_BGCornflowerBlue\_    ( or \_\_BG69\_ )  | \_\_BGChartreuse3\_       ( or \_\_BG70\_ )  | \_\_BGDarkSeaGreen4\_     ( or \_\_BG71\_ )  |
| \_\_BGCadetBlue\_         ( or \_\_BG72\_ )  | \_\_BGCadetBlue\_         ( or \_\_BG73\_ )  | \_\_BGSkyBlue3\_          ( or \_\_BG74\_ )  | \_\_BGSteelBlue1\_        ( or \_\_BG75\_ )  |
| \_\_BGChartreuse3\_       ( or \_\_BG76\_ )  | \_\_BGPaleGreen3\_        ( or \_\_BG77\_ )  | \_\_BGSeaGreen3\_         ( or \_\_BG78\_ )  | \_\_BGAquamarine3\_       ( or \_\_BG79\_ )  |
| \_\_BGMediumTurquoise\_   ( or \_\_BG80\_ )  | \_\_BGSteelBlue1\_        ( or \_\_BG81\_ )  | \_\_BGChartreuse2\_       ( or \_\_BG82\_ )  | \_\_BGSeaGreen2\_         ( or \_\_BG83\_ )  |
| \_\_BGSeaGreen1\_         ( or \_\_BG84\_ )  | \_\_BGSeaGreen1\_         ( or \_\_BG85\_ )  | \_\_BGAquamarine1\_       ( or \_\_BG86\_ )  | \_\_BGDarkSlateGray2\_    ( or \_\_BG87\_ )  |
| \_\_BGDarkRed\_           ( or \_\_BG88\_ )  | \_\_BGDeepPink4\_         ( or \_\_BG89\_ )  | \_\_BGDarkMagenta\_       ( or \_\_BG90\_ )  | \_\_BGDarkMagenta\_       ( or \_\_BG91\_ )  |
| \_\_BGDarkViolet\_        ( or \_\_BG92\_ )  | \_\_BGPurple\_            ( or \_\_BG93\_ )  | \_\_BGOrange4\_           ( or \_\_BG94\_ )  | \_\_BGLightPink4\_        ( or \_\_BG95\_ )  |
| \_\_BGPlum4\_             ( or \_\_BG96\_ )  | \_\_BGMediumPurple3\_     ( or \_\_BG97\_ )  | \_\_BGMediumPurple3\_     ( or \_\_BG98\_ )  | \_\_BGSlateBlue1\_        ( or \_\_BG99\_ )  |
| \_\_BGYellow4\_           ( or \_\_BG100\_ ) | \_\_BGWheat4\_            ( or \_\_BG101\_ ) | \_\_BGGrey53\_            ( or \_\_BG102\_ ) | \_\_BGLightSlateGrey\_    ( or \_\_BG103\_ ) |
| \_\_BGMediumPurple\_      ( or \_\_BG104\_ ) | \_\_BGLightSlateBlue\_    ( or \_\_BG105\_ ) | \_\_BGYellow4\_           ( or \_\_BG106\_ ) | \_\_BGDarkOliveGreen3\_   ( or \_\_BG107\_ ) |
| \_\_BGDarkSeaGreen\_      ( or \_\_BG108\_ ) | \_\_BGLightSkyBlue3\_     ( or \_\_BG109\_ ) | \_\_BGLightSkyBlue3\_     ( or \_\_BG110\_ ) | \_\_BGSkyBlue2\_          ( or \_\_BG111\_ ) |
| \_\_BGChartreuse2\_       ( or \_\_BG112\_ ) | \_\_BGDarkOliveGreen3\_   ( or \_\_BG113\_ ) | \_\_BGPaleGreen3\_        ( or \_\_BG114\_ ) | \_\_BGDarkSeaGreen3\_     ( or \_\_BG115\_ ) |
| \_\_BGDarkSlateGray3\_    ( or \_\_BG116\_ ) | \_\_BGSkyBlue1\_          ( or \_\_BG117\_ ) | \_\_BGChartreuse1\_       ( or \_\_BG118\_ ) | \_\_BGLightGreen\_        ( or \_\_BG119\_ ) |
| \_\_BGLightGreen\_        ( or \_\_BG120\_ ) | \_\_BGPaleGreen1\_        ( or \_\_BG121\_ ) | \_\_BGAquamarine1\_       ( or \_\_BG122\_ ) | \_\_BGDarkSlateGray1\_    ( or \_\_BG123\_ ) |
| \_\_BGRed3\_              ( or \_\_BG124\_ ) | \_\_BGDeepPink4\_         ( or \_\_BG125\_ ) | \_\_BGMediumVioletRed\_   ( or \_\_BG126\_ ) | \_\_BGMagenta3\_          ( or \_\_BG127\_ ) |
| \_\_BGDarkViolet\_        ( or \_\_BG128\_ ) | \_\_BGPurple\_            ( or \_\_BG129\_ ) | \_\_BGDarkOrange3\_       ( or \_\_BG130\_ ) | \_\_BGIndianRed\_         ( or \_\_BG131\_ ) |
| \_\_BGHotPink3\_          ( or \_\_BG132\_ ) | \_\_BGMediumOrchid3\_     ( or \_\_BG133\_ ) | \_\_BGMediumOrchid\_      ( or \_\_BG134\_ ) | \_\_BGMediumPurple2\_     ( or \_\_BG135\_ ) |
| \_\_BGDarkGoldenrod\_     ( or \_\_BG136\_ ) | \_\_BGLightSalmon3\_      ( or \_\_BG137\_ ) | \_\_BGRosyBrown\_         ( or \_\_BG138\_ ) | \_\_BGGrey63\_            ( or \_\_BG139\_ ) |
| \_\_BGMediumPurple2\_     ( or \_\_BG140\_ ) | \_\_BGMediumPurple1\_     ( or \_\_BG141\_ ) | \_\_BGGold3\_             ( or \_\_BG142\_ ) | \_\_BGDarkKhaki\_         ( or \_\_BG143\_ ) |
| \_\_BGNavajoWhite3\_      ( or \_\_BG144\_ ) | \_\_BGGrey69\_            ( or \_\_BG145\_ ) | \_\_BGLightSteelBlue3\_   ( or \_\_BG146\_ ) | \_\_BGLightSteelBlue\_    ( or \_\_BG147\_ ) |
| \_\_BGYellow3\_           ( or \_\_BG148\_ ) | \_\_BGDarkOliveGreen3\_   ( or \_\_BG149\_ ) | \_\_BGDarkSeaGreen3\_     ( or \_\_BG150\_ ) | \_\_BGDarkSeaGreen2\_     ( or \_\_BG151\_ ) |
| \_\_BGLightCyan3\_        ( or \_\_BG152\_ ) | \_\_BGLightSkyBlue1\_     ( or \_\_BG153\_ ) | \_\_BGGreenYellow\_       ( or \_\_BG154\_ ) | \_\_BGDarkOliveGreen2\_   ( or \_\_BG155\_ ) |
| \_\_BGPaleGreen1\_        ( or \_\_BG156\_ ) | \_\_BGDarkSeaGreen2\_     ( or \_\_BG157\_ ) | \_\_BGDarkSeaGreen1\_     ( or \_\_BG158\_ ) | \_\_BGPaleTurquoise1\_    ( or \_\_BG159\_ ) |
| \_\_BGRed3\_              ( or \_\_BG160\_ ) | \_\_BGDeepPink3\_         ( or \_\_BG161\_ ) | \_\_BGDeepPink3\_         ( or \_\_BG162\_ ) | \_\_BGMagenta3\_          ( or \_\_BG163\_ ) |
| \_\_BGMagenta3\_          ( or \_\_BG164\_ ) | \_\_BGMagenta2\_          ( or \_\_BG165\_ ) | \_\_BGDarkOrange3\_       ( or \_\_BG166\_ ) | \_\_BGIndianRed\_         ( or \_\_BG167\_ ) |
| \_\_BGHotPink3\_          ( or \_\_BG168\_ ) | \_\_BGHotPink2\_          ( or \_\_BG169\_ ) | \_\_BGOrchid\_            ( or \_\_BG170\_ ) | \_\_BGMediumOrchid1\_     ( or \_\_BG171\_ ) |
| \_\_BGOrange3\_           ( or \_\_BG172\_ ) | \_\_BGLightSalmon3\_      ( or \_\_BG173\_ ) | \_\_BGLightPink3\_        ( or \_\_BG174\_ ) | \_\_BGPink3\_             ( or \_\_BG175\_ ) |
| \_\_BGPlum3\_             ( or \_\_BG176\_ ) | \_\_BGViolet\_            ( or \_\_BG177\_ ) | \_\_BGGold3\_             ( or \_\_BG178\_ ) | \_\_BGLightGoldenrod3\_   ( or \_\_BG179\_ ) |
| \_\_BGTan\_               ( or \_\_BG180\_ ) | \_\_BGMistyRose3\_        ( or \_\_BG181\_ ) | \_\_BGThistle3\_          ( or \_\_BG182\_ ) | \_\_BGPlum2\_             ( or \_\_BG183\_ ) |
| \_\_BGYellow3\_           ( or \_\_BG184\_ ) | \_\_BGKhaki3\_            ( or \_\_BG185\_ ) | \_\_BGLightGoldenrod2\_   ( or \_\_BG186\_ ) | \_\_BGLightYellow3\_      ( or \_\_BG187\_ ) |
| \_\_BGGrey84\_            ( or \_\_BG188\_ ) | \_\_BGLightSteelBlue1\_   ( or \_\_BG189\_ ) | \_\_BGYellow2\_           ( or \_\_BG190\_ ) | \_\_BGDarkOliveGreen1\_   ( or \_\_BG191\_ ) |
| \_\_BGDarkOliveGreen1\_   ( or \_\_BG192\_ ) | \_\_BGDarkSeaGreen1\_     ( or \_\_BG193\_ ) | \_\_BGHoneydew2\_         ( or \_\_BG194\_ ) | \_\_BGLightCyan1\_        ( or \_\_BG195\_ ) |
| \_\_BGRed1\_              ( or \_\_BG196\_ ) | \_\_BGDeepPink2\_         ( or \_\_BG197\_ ) | \_\_BGDeepPink1\_         ( or \_\_BG198\_ ) | \_\_BGDeepPink1\_         ( or \_\_BG199\_ ) |
| \_\_BGMagenta2\_          ( or \_\_BG200\_ ) | \_\_BGMagenta1\_          ( or \_\_BG201\_ ) | \_\_BGOrangeRed1\_        ( or \_\_BG202\_ ) | \_\_BGIndianRed1\_        ( or \_\_BG203\_ ) |
| \_\_BGIndianRed1\_        ( or \_\_BG204\_ ) | \_\_BGHotPink\_           ( or \_\_BG205\_ ) | \_\_BGHotPink\_           ( or \_\_BG206\_ ) | \_\_BGMediumOrchid1\_     ( or \_\_BG207\_ ) |
| \_\_BGDarkOrange\_        ( or \_\_BG208\_ ) | \_\_BGSalmon1\_           ( or \_\_BG209\_ ) | \_\_BGLightCoral\_        ( or \_\_BG210\_ ) | \_\_BGPaleVioletRed1\_    ( or \_\_BG211\_ ) |
| \_\_BGOrchid2\_           ( or \_\_BG212\_ ) | \_\_BGOrchid1\_           ( or \_\_BG213\_ ) | \_\_BGOrange1\_           ( or \_\_BG214\_ ) | \_\_BGSandyBrown\_        ( or \_\_BG215\_ ) |
| \_\_BGLightSalmon1\_      ( or \_\_BG216\_ ) | \_\_BGLightPink1\_        ( or \_\_BG217\_ ) | \_\_BGPink1\_             ( or \_\_BG218\_ ) | \_\_BGPlum1\_             ( or \_\_BG219\_ ) |
| \_\_BGGold1\_             ( or \_\_BG220\_ ) | \_\_BGLightGoldenrod2\_   ( or \_\_BG221\_ ) | \_\_BGLightGoldenrod2\_   ( or \_\_BG222\_ ) | \_\_BGNavajoWhite1\_      ( or \_\_BG223\_ ) |
| \_\_BGMistyRose1\_        ( or \_\_BG224\_ ) | \_\_BGThistle1\_          ( or \_\_BG225\_ ) | \_\_BGYellow1\_           ( or \_\_BG226\_ ) | \_\_BGLightGoldenrod1\_   ( or \_\_BG227\_ ) |
| \_\_BGKhaki1\_            ( or \_\_BG228\_ ) | \_\_BGWheat1\_            ( or \_\_BG229\_ ) | \_\_BGCornsilk1\_         ( or \_\_BG230\_ ) | \_\_BGGrey100\_           ( or \_\_BG231\_ ) |
| \_\_BGGrey3\_             ( or \_\_BG232\_ ) | \_\_BGGrey7\_             ( or \_\_BG233\_ ) | \_\_BGGrey11\_            ( or \_\_BG234\_ ) | \_\_BGGrey15\_            ( or \_\_BG235\_ ) |
| \_\_BGGrey19\_            ( or \_\_BG236\_ ) | \_\_BGGrey23\_            ( or \_\_BG237\_ ) | \_\_BGGrey27\_            ( or \_\_BG238\_ ) | \_\_BGGrey30\_            ( or \_\_BG239\_ ) |
| \_\_BGGrey35\_            ( or \_\_BG240\_ ) | \_\_BGGrey39\_            ( or \_\_BG241\_ ) | \_\_BGGrey42\_            ( or \_\_BG242\_ ) | \_\_BGGrey46\_            ( or \_\_BG243\_ ) |
| \_\_BGGrey50\_            ( or \_\_BG244\_ ) | \_\_BGGrey54\_            ( or \_\_BG245\_ ) | \_\_BGGrey58\_            ( or \_\_BG246\_ ) | \_\_BGGrey62\_            ( or \_\_BG247\_ ) |
| \_\_BGGrey66\_            ( or \_\_BG248\_ ) | \_\_BGGrey70\_            ( or \_\_BG249\_ ) | \_\_BGGrey74\_            ( or \_\_BG250\_ ) | \_\_BGGrey78\_            ( or \_\_BG251\_ ) |
| \_\_BGGrey82\_            ( or \_\_BG252\_ ) | \_\_BGGrey85\_            ( or \_\_BG253\_ ) | \_\_BGGrey89\_            ( or \_\_BG254\_ ) | \_\_BGGrey93\_            ( or \_\_BG255\_ ) |






