__define_colors8_TPUT() {
# COLOR VARS :
#                * declare the 8 SYSTEM TERM colors (and their variants :
#                 background & bold) and the modifiers (DOUBLE INTENSITY, DIM,
#                 BLINK, RESET,... ONCE and for ALL.
#
#               * declare the defaults for old TERMS, and adapt to less
#                 horrid defaults for 256-colors TERMS
#
#                 -> This somewhat pollutes the GLOBAL SCOPE but the variable
#                    names are (thought to be) unique enough so that won't cause
#                    problems
#
#               * do that like a grownup (tput, resort to not ANSI escapes only
#                                         as a fallback with `tput
#                                         setaf`)
#
#               * TODO: handle dark vs light background
#
#               * TODO: handle 256 colors (if [ $(tput colors) -ge 256 ] ...)
#
                                                                      # ANSI equivalent
                                                                      # <attr> <fg>  <bg>
                                                                      #
                                                                      # --------------------------------------------------------------
                                                                      #           MODIFIERS
                                                                      # --------------------------------------------------------------
   export __NN_=$( tput sgr0   || : 2>/dev/null )                     # [ 0m                RESET ALL attributes
                                                                      #
                                                                      # STYLES
                                                                      #
   export __EM_=$( tput bold    || : 2>/dev/null )                    # [ 1m                BEGIN DOUBLE INTENSITY (bold) mode
   export __DM_=$( tput dim     || : 2>/dev/null )                    # [ 2m                BEGIN HALF INTENSITY    (dim) mode
   export __UN_=$( tput smul    || : 2>/dev/null )                    # [ 4m                BEGIN UNDESCORE  (underlined) mode
   export __BL_=$( tput blink   || : 2>/dev/null )                    # [ 5m                BEGIN BLINKING                mode
   export __RV_=$( tput rev     || : 2>/dev/null )                    # [ 7m                BEGIN REVERSE VIDEO (reverse) mode
   export __SO_=$( tput smso    || : 2>/dev/null )                    # ?[ 7m               BEGIN STANDOUT      (reverse) mode
   export __IN_=$( tput invis   || : 2>/dev/null )                    # [ 8m                BEGIN INVISIBLE               mode
   export __DEL_=$(tput cub1    || : 2>/dev/null )                    # MOVE cursor LEFT one space

  export __SOQ_=$( tput rmso    || : 2>/dev/null )                    # ?[ 27m              END   STANDOUT      (reverse) mode
  export __UNQ_=$( tput rmul    || : 2>/dev/null )                    # [ 24m               END   UNDESCORE  (underlined) mode
                                                                      #
                                                                      # for all other END style, use `tput sgr0` ($__NN_)
                                                                      #
  if [ $(tput colors) -ne 256 ]; then                                 #
                                                                      #
                                                                      # --------------------------------------------------------------
                                                                      #           COLORS
                                                                      # --------------------------------------------------------------
                                                                      #
                                                                      # ..............................................................
                                                                      #           DEFAULT SYSTEM COLORS
                                                                      # ..............................................................
                                                                      #
                                                                      #
                                                                      #
                                                                      # <Foreground>
    export __K_=$( tput setf 0 || tput setaf 0 || : 2>/dev/null )     # [       0m          SET   FG color to BLACK
    export __R_=$( tput setf 1 || tput setaf 1 || : 2>/dev/null )     # [       1m          SET   FG color to RED
    export __G_=$( tput setf 2 || tput setaf 2 || : 2>/dev/null )     # [       2m          SET   FG color to GREEN
    export __Y_=$( tput setf 3 || tput setaf 3 || : 2>/dev/null )     # [       3m          SET   FG color to YELLOW
    export __B_=$( tput setf 4 || tput setaf 4 || : 2>/dev/null )     # [       4m          SET   FG color to BLUE
    export __M_=$( tput setf 5 || tput setaf 5 || : 2>/dev/null )     # [       5m          SET   FG color to MAGENTA
    export __C_=$( tput setf 6 || tput setaf 6 || : 2>/dev/null )     # [       6m          SET   FG color to CYAN
    export __W_=$( tput setf 7 || tput setaf 7 || : 2>/dev/null )     # [       7m          SET   FG color to WHITE
                                                                      # <Background>
  export __BGK_=$( tput setb 0 || tput setab 0 || : 2>/dev/null )     # [       0m          SET   BG color to BLACK
  export __BGR_=$( tput setb 1 || tput setab 1 || : 2>/dev/null )     # [       1m          SET   BG color to RED
  export __BGG_=$( tput setb 2 || tput setab 2 || : 2>/dev/null )     # [       2m          SET   BG color to GREEN
  export __BGY_=$( tput setb 3 || tput setab 3 || : 2>/dev/null )     # [       3m          SET   BG color to YELLOW
  export __BGB_=$( tput setb 4 || tput setab 4 || : 2>/dev/null )     # [       4m          SET   BG color to BLUE
  export __BGM_=$( tput setb 5 || tput setab 5 || : 2>/dev/null )     # [       5m          SET   BG color to MAGENTA
  export __BGC_=$( tput setb 6 || tput setab 6 || : 2>/dev/null )     # [       6m          SET   BG color to CYAN
  export __BGW_=$( tput setb 7 || tput setab 7 || : 2>/dev/null )     # [       7m          SET   BG color to WHITE
                                                                      # <reset>
   export __NF_=$( tput setf 9 || tput setaf 9 || : 2>/dev/null )     # [       39m         RESET FG color to term's default
   export __NG_=$( tput setb 9 || tput setab 9 || : 2>/dev/null )     # [             49m   RESET BG color to term's default
  export __NFG_=$__NF_$__NB_                                          # [       39;   49m   RESET FG & BG color to term's default
                                                                      #
  else                                                                #
                                                                      # ..............................................................
                                                                      #           LIGHTEN DEFAULT SYSTEM COLORS A BIT
                                                                      # ..............................................................
                                                                      #
                                                                      # <Foreground>
    export __K_=$( tput setf 243 || tput setaf 243 || : 2>/dev/null ) # SET   FG color to BLACK
    export __R_=$( tput setf 196 || tput setaf 196 || : 2>/dev/null ) # SET   FG color to RED
    export __G_=$( tput setf 34  || tput setaf 34  || : 2>/dev/null ) # SET   FG color to GREEN
    export __Y_=$( tput setf 220 || tput setaf 220 || : 2>/dev/null ) # SET   FG color to YELLOW
    export __B_=$( tput setf 33  || tput setaf 33  || : 2>/dev/null ) # SET   FG color to BLUE
    export __M_=$( tput setf 201 || tput setaf 201 || : 2>/dev/null ) # SET   FG color to MAGENTA
    export __C_=$( tput setf 45  || tput setaf 45  || : 2>/dev/null ) # SET   FG color to CYAN
    export __W_=$( tput setf 15  || tput setaf 15  || : 2>/dev/null ) # SET   FG color to WHITE
                                                                      # <Background>
  export __BGK_=$( tput setb 243 || tput setab 243 || : 2>/dev/null ) # SET   BG color to BLACK
  export __BGR_=$( tput setb 196 || tput setab 196 || : 2>/dev/null ) # SET   BG color to RED
  export __BGG_=$( tput setb 34  || tput setab 34  || : 2>/dev/null ) # SET   BG color to GREEN
  export __BGY_=$( tput setb 220 || tput setab 220 || : 2>/dev/null ) # SET   BG color to YELLOW
  export __BGB_=$( tput setb 33  || tput setab 33  || : 2>/dev/null ) # SET   BG color to BLUE
  export __BGM_=$( tput setb 201 || tput setab 201 || : 2>/dev/null ) # SET   BG color to MAGENTA
  export __BGC_=$( tput setb 45  || tput setab 45  || : 2>/dev/null ) # SET   BG color to CYAN
  export __BGW_=$( tput setb 15  || tput setab 15  || : 2>/dev/null ) # SET   BG color to WHITE
                                                                      #
  fi                                                                  #
                                                                      #
                                                                      # --------------------------------------------------------------
                                                                      #           PSOEUDO(BOLD) COLORS
                                                                      # --------------------------------------------------------------
                                                                      # <pseudo Foreground-bold>
                                                                      #
  export __EMK_=$__EM_$__K_                                           # [ 1;    20m         SET   FG color to BOLD BLACK
  export __EMR_=$__EM_$__R_                                           # [ 1;    21m         SET   FG color to BOLD RED
  export __EMG_=$__EM_$__G_                                           # [ 1;    22m         SET   FG color to BOLD GREEN
  export __EMY_=$__EM_$__Y_                                           # [ 1;    23m         SET   FG color to BOLD YELLOW
  export __EMB_=$__EM_$__B_                                           # [ 1;    24m         SET   FG color to BOLD BLUE
  export __EMM_=$__EM_$__M_                                           # [ 1;    25m         SET   FG color to BOLD MAGENTA
  export __EMC_=$__EM_$__C_                                           # [ 1;    26m         SET   FG color to BOLD CYAN
  export __EMW_=$__EM_$__W_                                           # [ 1;    27m         SET   FG color to BOLD RED

  #MISC (non color)
  export __NL_=$( tput cud1 )                                         # most compatible NEWLINE ever

  ##INFO for other scripts of mine which would redefine these
  export __TPUT_COLORS_DEFINED="true"
}
