__growltermversion="1.0.0"

__growltermUsage() {

  #PAGER SHIT

  local __mypager
  # NO PAGER SET
  if [ -z "$PAGER" ]; then 
    if most --version >/dev/null 2>&1 ; then
      __mypager="most"
    elif less --version >/dev/null 2>&1; then
      __mypager="less"
    else
      __mypager="more"
    fi
  else
    __mypager="$PAGER"
  fi

  # Make LESS/MORE eat-up our ESCAPES
  local __myoldLESS="$LESS"
  local __myoldMORE="$MORE"
  if [ "$__mypager" = "less" ] || [ "$__mypager" = "more" ]; then
    LESS="-R"
    MORE="-R"
  fi

  #Display the HELP page
  __growltermHelpmsg | $__mypager

  #Restore SHELL settings

  LESS="$__myoldLESS"
  MORE="$__myoldMORE"
}

__growltermHelpmsg(){

  local __EM_=$( tput bold   || : 2>/dev/null                 ) #   BEGIN DOUBLE INTENSITY (bold) mode
  local __SO_=$( tput smso   || : 2>/dev/null                 ) #   BEGIN STANDOUT      (reverse) mode
  local __SOQ_=$( tput rmso  || : 2>/dev/null                 ) #   END   STANDOUT      (reverse) mode
  local __UN_=$( tput smul   || : 2>/dev/null                 ) #   BEGIN UNDESCORE  (underlined) mode
  local __UNQ_=$( tput rmul  || : 2>/dev/null                 ) #   END   UNDESCORE  (underlined) mode

echo "
${__EM_}NAME : GROWLTERM${__UNQ_} - notifications for your terminal

${__EM_}EXAMPLE USAGE :${__UNQ_} growlterm  -m \"mymessage\" -f \"GIT\" -i 2

${__EM_}OPTIONS :${__UNQ_}

  ${__UN_}-m --message : [required]${__UNQ_}

       message to be displayed. Will be trimmed if exceeds term's width. DO
       quote the message string

  ${__UN_}-o --oneliner :${__UNQ_}

       removes the box around the message (implied with -p 0) in the case
       --position is 1,2,3,4,5,6,7,8 or 9. Does nothing with Fancy Menu
       (position 10,11,12 which is by nature a oneliner )

  ${__UN_}-p --position${__UNQ_}

       * position on screen (default 10)

         old school
    (for use from a prompt)
      ┌───────────────┐            ${__SO_}┌──────────────┐${__SOQ_}
      │1      2      3│ OUTPUTS:   ${__SO_}│ my message ! │${__SOQ_}
      │4      5      6│            ${__SO_}└──────────────┘${__SOQ_}
      │7      8      9│  or with --oneliner option
      │               │
      │               │ OUTPUTS:   ${__SO_}[ my message ! ]${__SOQ_}
      │              0│
      └───────────────┘

         fancy menu
      ┌───────────────┐            ${__SO_}┌────────────────────────────────────────────────┐${__SOQ_}
      │███████10██████│ OUTPUTS:   ${__SO_}│FROM > SOMEONE >    message...    < fatal < TYPE│${__SOQ_}
      │               │            ${__SO_}└────────────────────────────────────────────────┘${__SOQ_}
      │               │                (positionned at top of terminal)
      │               │
      │               │
      │               │
      └───────────────┘

        * positioning is :

        -p 1 => TOP LEFT corner
        -p 2 => TOP CENTER
        -p 3 => TOP RIGHT corner
        -p 0 => same line as prompt

        4,7 only apply if you call growlterm from your PROMPT (\$PS1)
        for displaying parts of your PROMPT someplace else on the TERM's
        screen.
          - use 1 : if your prompt is a oneliner
          - use 4 : if your prompt is 2 lines high
          - use 7 : if your prompt is 3 lines high

          same applies for groups 2,5,8 and 3,6,9

        -p 10 => TOP MENUBAR (the one you will want)

        I personnally use it to display a message when a background job
        has finished running (updating aptitude packages, perlbrew, nvm,
        whatever) : using that to split your PROMPT is not recommended


${__EM_}FOLLOWING OPTIONS ONLY USED with  FANCY MENU : --position 10${__UNQ_}
                 (ignored otherwise)

  ${__UN_}-f --from${__UNQ_}

       appears in the 'FROM' field. DO quote that string

  ${__UN_}-u --underline${__UNQ_}

       underline the message

  ${__UN_}-i --importance${__UNQ_}

       0,1,2,3 or 4 [default :2 ] appears in the right 'TYPE' field, and SETS
       the coloring of the MENUBAR

          0 : info
          1 : remark
          2 : warning
          3 : error
          4 : fatal


  ${__UN_}-x --nostripansi${__UNQ_}

       disable the stripping of fancy ANSI escape sequences that might be in
       the string passed with the --message argument 

       Only reason to use this switch is if Perl is not installed on your
       system, or gives you annoying messages


"



}

__growltermShortUsage() {

    echo "USAGE : growlterm -m \"message\" [ --from \"messageFrom\" ] [ options ]"
    return 1
}

__growltermVersion(){

  echo "growlterm version 1.0.0"
  echo "growlterm -h for more"
  return 0
}

__growltermParseOpts(){

# NOTE : variables come from the scope
#        of the calling function
  local __allOpts="$@"
  local __readSofar=
  local __latestOpts=
  local __NN_=$( tput sgr0   || : 2>/dev/null )
  local  __G_=$( tput setf 2 || tput setaf 2 || : 2>/dev/null )
  local  __Y_=$( tput setf 3 || tput setaf 3 || : 2>/dev/null )
  local  __B_=$( tput setf 4 || tput setaf 4 || : 2>/dev/null )
  for argument in $*
    do

      # Getting parameters
      case $argument in
        -h | --help        )  __growltermUsage        ; return 0 ;;
        -v | --version     ) __growltermVersion                         ;;
        -m | --message     )  __mystring="$2"         ;  shift 2 ;;
        -p | --position    )  __menupos="$2"          ;  shift 2 ;;
        -f | --from        )  __from="$2"             ;  shift 2 ;;
        -i | --importance  )  __importance="$2"       ;  shift 2 ;;
        -o | --oneliner    )  __oneliner="true"       ;  shift 1 ;;
        -u | --underline   )  __underline="true"      ;  shift 1 ;;
        -x | --nostripansi )  __nostripansi="yes"     ;  shift 1 ;;
        -* | --*           ) echo "unknown option $1" ; return 1 ;;
        #[a-zA-Z0-9]*      ) printf "%s\n%s\n%s\n%s\n%s\n\n" $__G_"UNKNOWN OPTION $__Y_$0$__G_ : missing argument somewhere" "PRECEEDED BY [$__Y_$__latestOpts$__G_]" "FOLLOWED BY [$__Y_$2 $3$__G_]" "OPTIONS were : $__B_$__allOpts$__G_" "OPTIONS READ SOFAR ARE : $__B_$__readSofar |$__NN_"; __growltermShortUsage; return 1;;
      esac
    done

  # VALIDITY CHECKS
  # --message
  #echo "__mystring = $__mystring"
  [ -n "$__mystring" ]                                    || { echo "ERROR : --message cannot be empty"                                    ; __growltermShortUsage ; return 1 ; }
  #echo "__from = $__from"

  # --position
  [ -z "$__menupos" ] && __menupos=10; # default value
  #echo "__menupos = $__menupos"
  # check that it's an integer
  declare -i  "tmpvar=$__menupos" 2>/dev/null             || { echo "ERROR : --position has to be an integer"                              ; __growltermShortUsage ; return 1 ; }
  [ "$__menupos" -gt 10 ] || [ "$__menupos" -lt 0 ]           && { echo "ERROR : valid values for --position are 0,1,2,3,4,5,6,7,8,9,10" ; __growltermShortUsage ; return 1 ; }


  # --importance
  [ -z "$__importance" ] && __importance=2; # default value
  #echo "__importance = $__importance"
  # check that it's an integer
  declare -i  "tmpvar=$__importance" 2>/dev/null          || { echo "ERROR : --importance has to be an integer"                            ; __growltermShortUsage ; return 1 ; }
  [ 4 -lt "$__importance" ] || [ 0 -gt "$__importance" ]  && { echo "ERROR : valid values for --importance are 0,1,2,3,4"                  ; __growltermShortUsage ; return 1 ; }


  return 0

}

__growltermAdditLines() {

  #DYNAMIC SCOPE !

  [ -z "$additLines" ] || {
    [ 2 -le $additLines ] && {
    tput cup $(($firstL - 2)) $firstC;
      printf "%s" "$__NN_$blankLine";
    }

    [ 1 -le $additLines ] && {
    tput cup $(($firstL - 1)) $firstC;
      printf "%s" "$__NN_$blankLine";
    }
  }
}

__growltermDefaultTheme(){
  # __________________________________________________________________ #
  #                                                                    #
  #                        GROWLTERM THEME                             #
  #                                                                    #
  # __________________________________________________________________ #
  #                                                                    #
  #    NOTE ABOUT COLORS & UTF8                                        #
  # __________________________________________________________________ #
  #
  # 0) Colors are defined here in a 'terminal-safe way'. The colors
  #    we use are those defined in the adjoint scripts
  #    'safetermcolors8.sh' and 'safetermcolors-addit-256.sh'.
  #
  #    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  #    WE DO NOT MANAGE ANSI ESCAPE CODES BY HAND, let termcap handle
  #    that with 'tput setaf' & 'tput setab' in case of a term using
  #    ANSI ESCAPE CODES for COLOR management, and STORE the results
  #    in VARIABLES
  #    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  #
  # You can source them prior to sourcing your theme if you want to use
  # the fancy variables ($__R_ for red, $__NavyBlue__ or $__17_ for
  # Navy Blue in 256-color TERMS,... )
  #
  # These declarations can resist most (all?) of the oldest terminals
  # (even two colors TERMS) but provide full power on 256-colors TERMS.
  #
  # in order to avoid conflicts with bash's environment, the following
  # "namespacing" convention is used :
  #
  #   $__COLORNAMEorDECIMALCODE_
  #
  #   ( two underscores + variable name + one underscore )
  #
  #  Example : mycolor=$__MediumPurple4_
  #
  # 1) 256-COLORS terms (or not)
  #
  #    If you want your theme to support both 256-colors and
  #    non-256-colors Terminals, you need to provide values for both
  #    these sets of variables :
  #
  #    USERCOLOR1=...
  #    NO256_USERCOLOR1=...
  #
  #  2) MENU BORDERS & ELEMENTS
  #
  #    All fixed UI elements in the menus are characters. If your term
  #    supports UTF-8, you can go fancy and put quite anything that
  #    shows on a command line into the 'MENU BORDER & ELEMENTS'
  #    variables. But you better give a fallback option for the many
  #    non-utf8 supporting terms out there.
  #
  #    USERPARAM1=...
  #    NO8_USERPARAM1=...
  #
  #
  # __________________________________________________________________ #



#//////////////////////////////////////////////////////////////////////#


  # RESET ALL STYLES
  __NN_=$( tput sgr0   || : 2>/dev/null )


  # ==============================================================
  #                      1. FANCY MENU
  # ==============================================================




  # --------------------------------------------------------------
  #                    1.1 - COLORS
  # --------------------------------------------------------------

  # ..............................................................
  #
  #                     LEFT HEADER
  #
  #   ┌────────────────────────────────────────────────┐
  #   │FROM ⮁ SOMEONE ⮀    message...    ⮂ fatal ⮃ TYPE│
  #   └────────────────────────────────────────────────┘
  #   ^^^^^^^^^^^^^^^^^
  #
  # shows the contents of the string passed with the --from option
  #
  # ..............................................................


  # ______________________BACKGROUND COLORS_______________________

  #  BACKGROUND color for HARDCODED FROM field
  #   ┌────────────────────────────────────────────────┐
  #   │FROM ⮁ SOMEONE ⮀    message...    ⮂ fatal ⮃ TYPE│
  #   └────────────────────────────────────────────────┘
  #   ^^^^^
      NO256__COLOR_LEFTHEADER_BG_FROM=$( tput setb 7   || tput setab 7   || : 2>/dev/null )     ; # WHITE     (7)
           __COLOR_LEFTHEADER_BG_FROM=$( tput setb 255 || tput setab 255 || : 2>/dev/null )     ; # Grey82    (252)

  #  BACKGROUND color for CONTENTS of FROM field
  #   ┌────────────────────────────────────────────────┐
  #   │FROM ⮁ SOMEONE ⮀    message...    ⮂ fatal ⮃ TYPE│
  #   └────────────────────────────────────────────────┘
  #           ^^^^^^^
  NO256__COLOR_LEFTHEADER_BG_FROMTEXT=$( tput setb 7   || tput setab 7   || : 2>/dev/null ) ; # WHITE     (7)
       __COLOR_LEFTHEADER_BG_FROMTEXT=$( tput setb 255 || tput setab 255 || : 2>/dev/null ) ; # Grey93    (255)


  # ______________________FOREGROUND COLORS_______________________

  #  FOREGROUND color for HARDCODED FROM field
  #   ┌────────────────────────────────────────────────┐
  #   │FROM ⮁ SOMEONE ⮀    message...    ⮂ fatal ⮃ TYPE│
  #   └────────────────────────────────────────────────┘
  #   ^^^^^
      NO256__COLOR_LEFTHEADER_FG_FROM=$( tput setf 0   || tput setaf 0   || : 2>/dev/null ) ; # BLACK     (0)
           __COLOR_LEFTHEADER_FG_FROM=$( tput setf 33  || tput setaf 33  || : 2>/dev/null ) ; # MediumPurple4 (60)

  #  FOREGROUND color for CONTENTS of FROM field
  #   ┌────────────────────────────────────────────────┐
  #   │FROM ⮁ SOMEONE ⮀    message...    ⮂ fatal ⮃ TYPE│
  #   └────────────────────────────────────────────────┘
  #           ^^^^^^^
  NO256__COLOR_LEFTHEADER_FG_FROMTEXT=$( tput setf 0   || tput setaf 0   || : 2>/dev/null ) ; # BLACK     (0)
       __COLOR_LEFTHEADER_FG_FROMTEXT=$( tput setf 31  || tput setaf 31  || : 2>/dev/null ) ; # MediumPurple4 (60)

  #  FOREGROUND color for LEFT HEADER SEPARATOR ($__LEFTHEADER_SEP see below)
  #
  #  has to be the same as  the BACKGROUND color for CONTENTS of FROM
  #  FIELD ($ __COLOR_LEFTHEADER_BG_FROMTEXT), but transposed to the
  #  equivalent FOREGROUND COLOR
  #
  #  $__BGGrey100_ --> $__Grey100_
  #  or
  #  $__BG255_     --> $__255_
  #
  #   ┌────────────────────────────────────────────────┐
  #   │FROM ⮁ SOMEONE ⮀    message...    ⮂ fatal ⮃ TYPE│
  #   └────────────────────────────────────────────────┘
  #         ^
  NO256__COLOR_LEFTHEADER_FG_FROMSEP=$( tput setf 7   || tput setaf 7   || : 2>/dev/null )      ; # WHITE     (7)
       __COLOR_LEFTHEADER_FG_FROMSEP=$( tput setf 69  || tput setaf 69  || : 2>/dev/null )      ; # Grey93    (255)

  #   ┌────────────────────────────────────────────────┐
  #   │FROM ⮁ SOMEONE ⮀    message...    ⮂ fatal ⮃ TYPE│
  #   └────────────────────────────────────────────────┘
  #                   ^
      NO256__COLOR_LEFTHEADER_FG_SEP=$( tput setf 7   || tput setaf 7   || : 2>/dev/null )      ; # WHITE     (7)
           __COLOR_LEFTHEADER_FG_SEP=$( tput setf 255 || tput setaf 255 || : 2>/dev/null )      ; # Grey93    (255)


  # ..............................................................
  #
  #                MESSAGE (center) ZONE
  #
  #   ┌────────────────────────────────────────────────┐
  #   │FROM ⮁ SOMEONE ⮀    message...    ⮂ fatal ⮃ TYPE│
  #   └────────────────────────────────────────────────┘
  #                     ^^^^^^^^^^^^^^^
  #
  # shows the contents of the string passed with the --message
  # option
  #
  # ..............................................................


  # ______________________BACKGROUND COLORS_______________________

  # BACKGROUND color for MESSAGE (center) ZONE : ONE COLOR per level of IMPORTANCE
  N0256__COLOR_BG_CENTERZONE_IMPORT_0=$( tput setb 7 || tput setab 7 || : 2>/dev/null ) ; # INFO    -> WHITE
  N0256__COLOR_BG_CENTERZONE_IMPORT_1=$( tput setb 7 || tput setab 7 || : 2>/dev/null ) ; # REMARK  -> WHITE
  N0256__COLOR_BG_CENTERZONE_IMPORT_2=$( tput setb 3 || tput setab 3 || : 2>/dev/null ) ; # WARNING -> YELLOW
  N0256__COLOR_BG_CENTERZONE_IMPORT_3=$( tput setb 1 || tput setab 1 || : 2>/dev/null ) ; # ERROR   -> RED
  N0256__COLOR_BG_CENTERZONE_IMPORT_4=$( tput setb 1 || tput setab 1 || : 2>/dev/null ) ; # FATAL   -> RED !

  __COLOR_BG_CENTERZONE_IMPORT_0=$( tput setb 26  || tput setab 26  || : 2>/dev/null )  ; # INFO    -> DarkSeaGreen3 (78)
  __COLOR_BG_CENTERZONE_IMPORT_1=$( tput setb 78  || tput setab 78  || : 2>/dev/null )  ; # REMARK  -> Chartreuse4 (64)
  __COLOR_BG_CENTERZONE_IMPORT_2=$( tput setb 172 || tput setab 172 || : 2>/dev/null )  ; # WARNING -> Orange3 (172)
  __COLOR_BG_CENTERZONE_IMPORT_3=$( tput setb 88  || tput setab 88  || : 2>/dev/null )  ; # ERROR   -> Red1 (196)
  #__COLOR_BG_CENTERZONE_IMPORT_3=$( tput setb 196 || tput setab 196 || : 2>/dev/null )  ; # ERROR   -> Red1 (196)
  __COLOR_BG_CENTERZONE_IMPORT_4=$( tput setb 124 || tput setab 124 || : 2>/dev/null )  ; # FATAL   -> DarkRed (52) !



  # ______________________FOREGROUND COLORS_______________________

  # FOREGROUND color for MESSAGE (center) ZONE : ONE COLOR per level of IMPORTANCE
  N0256__COLOR_FG_CENTERZONE_IMPORT_0=$( tput setf 0 || tput setaf 0 || : 2>/dev/null )                                     ; # INFO    -> BLACK
  N0256__COLOR_FG_CENTERZONE_IMPORT_1=$( tput setf 0 || tput setaf 0 || : 2>/dev/null )                                     ; # REMARK  -> BLACK
  N0256__COLOR_FG_CENTERZONE_IMPORT_2=$( tput setf 7 || tput setaf 7 || : 2>/dev/null )                                     ; # WARNING -> WHITE
  N0256__COLOR_FG_CENTERZONE_IMPORT_3=$( tput setf 7 || tput setaf 7 || : 2>/dev/null )                                     ; # ERROR   -> WHITE
  N0256__COLOR_FG_CENTERZONE_IMPORT_4=$( tput blink  || : 2>/dev/null )                                                     ; # FATAL   -> BLINKING...
  N0256__COLOR_FG_CENTERZONE_IMPORT_4=$N0256__COLOR_FG_CENTERZONE_IMPORT_4$( tput bold    || : 2>/dev/null )                ; # FATAL   -> BOLD...
  N0256__COLOR_FG_CENTERZONE_IMPORT_4=$N0256__COLOR_FG_CENTERZONE_IMPORT_4$( tput setf 7 || tput setaf 7 || : 2>/dev/null ) ; # FATAL   -> WHITE !

  __COLOR_FG_CENTERZONE_IMPORT_0=$( tput setf 255 || tput setaf 255 || : 2>/dev/null )                                      ; # INFO    -> Grey19 (236)
  __COLOR_FG_CENTERZONE_IMPORT_1=$( tput setf 236 || tput setaf 236 || : 2>/dev/null )                                      ; # INFO    -> Grey19 (236)
  __COLOR_FG_CENTERZONE_IMPORT_2=$( tput setf 17  || tput setaf 17  || : 2>/dev/null )                                      ; # WARNING -> NavyBlue (17)
  __COLOR_FG_CENTERZONE_IMPORT_3=$( tput setf 229 || tput setaf 229 || : 2>/dev/null )                                      ; # ERROR   -> Grey93 (255)
  __COLOR_FG_CENTERZONE_IMPORT_4=$( tput blink    || : 2>/dev/null )                                                        ; # FATAL   -> BLINKING...
  __COLOR_FG_CENTERZONE_IMPORT_4=$__COLOR_FG_CENTERZONE_IMPORT_4$( tput bold     || : 2>/dev/null )                         ; # FATAL   -> BOLD...
  __COLOR_FG_CENTERZONE_IMPORT_4=$__COLOR_FG_CENTERZONE_IMPORT_4$( tput setf 255 || tput setaf 255 || : 2>/dev/null )       ; # FATAL   -> DarkGreen (22) !



  # ..............................................................
  #
  #                     RIGHT HEADER
  #
  #   ┌────────────────────────────────────────────────┐
  #   │FROM ⮁ SOMEONE ⮀    message...    ⮂ fatal ⮃ TYPE│
  #   └────────────────────────────────────────────────┘
  #                                      ^^^^^^^^^^^^^^
  #
  # shows the contents of the LEVEL of IMPORTANCE of the message
  # as passed with the --importance=0,1,2,3,4 option
  #
  # ..............................................................


  # ______________________BACKGROUND COLORS_______________________

  #  BACKGROUND color for HARDCODED TYPE field
  #   ┌────────────────────────────────────────────────┐
  #   │FROM ⮁ SOMEONE ⮀    message...    ⮂ fatal ⮃ TYPE│
  #   └────────────────────────────────────────────────┘
  #                                                ^^^^
  NO256__COLOR_RIGHTHEADER_BG_TYPE=$( tput setb 7   || tput setab 7   || : 2>/dev/null )     ; # WHITE     (7)
       __COLOR_RIGHTHEADER_BG_TYPE=$( tput setb 252 || tput setab 252 || : 2>/dev/null )     ; # Grey82    (252)

  #  BACKGROUND color for CONTENTS of TYPE field
  #   ┌────────────────────────────────────────────────┐
  #   │FROM ⮁ SOMEONE ⮀    message...    ⮂ fatal ⮃ TYPE│
  #   └────────────────────────────────────────────────┘
  #                                        ^^^^^
  NO256__COLOR_RIGHTHEADER_BG_TYPETEXT=$( tput setb 7   || tput setab 7   || : 2>/dev/null ) ; # WHITE     (7)
       __COLOR_RIGHTHEADER_BG_TYPETEXT=$( tput setb 252 || tput setab 252 || : 2>/dev/null ) ; # Grey93    (255)


  # ______________________FOREGROUND COLORS_______________________

  #  FOREGROUND color for HARDCODED TYPE field
  #   ┌────────────────────────────────────────────────┐
  #   │FROM ⮁ SOMEONE ⮀    message...    ⮂ fatal ⮃ TYPE│
  #   └────────────────────────────────────────────────┘
  #                                                ^^^^
      NO256__COLOR_RIGHTHEADER_FG_TYPE=$( tput setf 0   || tput setaf 0   || : 2>/dev/null ) ; # BLACK     (0)
           __COLOR_RIGHTHEADER_FG_TYPE=$( tput setf 88  || tput setaf 88  || : 2>/dev/null ) ; # MediumPurple4 (60)

  #  FOREGROUND color for CONTENTS of TYPE field
  #   ┌────────────────────────────────────────────────┐
  #   │FROM ⮁ SOMEONE ⮀    message...    ⮂ fatal ⮃ TYPE│
  #   └────────────────────────────────────────────────┘
  #                                        ^^^^^
  NO256__COLOR_RIGHTHEADER_FG_TYPETEXT=$( tput setf 0   || tput setaf 0   || : 2>/dev/null ) ; # BLACK     (0)
       __COLOR_RIGHTHEADER_FG_TYPETEXT=$( tput setf 52  || tput setaf 52  || : 2>/dev/null ) ; # MediumPurple4 (60)

  #  FOREGROUND color for RIGHT HEADER SEPARATOR ($__RIGHTHEADER_SEP see below)
  #
  #  has to be the same as  the BACKGROUND color for CONTENTS of TYPE
  #  FIELD ($ __COLOR_RIGHTHEADER_BG_TYPETEXT), but transposed to the
  #  equivalent FOREGROUND COLOR
  #
  #  $__BGGrey100_ --> $__Grey100_
  #  or
  #  $__BG255_     --> $__255_
  #
  #   ┌────────────────────────────────────────────────┐
  #   │FROM ⮁ SOMEONE ⮀    message...    ⮂ fatal ⮃ TYPE│
  #   └────────────────────────────────────────────────┘
  #                                              ^
  NO256__COLOR_RIGHTHEADER_FG_TYPESEP=$( tput setf 7   || tput setaf 7   || : 2>/dev/null )  ; # WHITE     (7)
       __COLOR_RIGHTHEADER_FG_TYPESEP=$( tput setf 52  || tput setaf 52  || : 2>/dev/null )  ; # Grey93    (255)

  #   ┌────────────────────────────────────────────────┐
  #   │FROM ⮁ SOMEONE ⮀    message...    ⮂ fatal ⮃ TYPE│
  #   └────────────────────────────────────────────────┘
  #                                      ^
      NO256__COLOR_RIGHTHEADER_FG_SEP=$( tput setf 7   || tput setaf 7   || : 2>/dev/null )  ; # WHITE     (7)
           __COLOR_RIGHTHEADER_FG_SEP=$( tput setf 252 || tput setaf 252 || : 2>/dev/null )  ; # Grey93    (255)




  # ..............................................................
  #
  #                     OPTIONAL UNDERLINE
  #
  # ..............................................................


  # ______________________FOREGROUND COLORS_______________________

  # FOREGROUND color for OPTIONNAL UNDERLINE BAR : ONE COLOR per level of IMPORTANCE
  NO256__COLOR_FG_UNDERLINE_IMPORT_0=$( tput setf 7   || tput setaf 7   || : 2>/dev/null )      ; # WHITE     (7)
  NO256__COLOR_FG_UNDERLINE_IMPORT_1=$( tput setf 7   || tput setaf 7   || : 2>/dev/null )      ; # WHITE     (7)
  NO256__COLOR_FG_UNDERLINE_IMPORT_2=$( tput setf 7   || tput setaf 7   || : 2>/dev/null )      ; # WHITE     (7)
  NO256__COLOR_FG_UNDERLINE_IMPORT_3=$( tput setf 7   || tput setaf 7   || : 2>/dev/null )      ; # WHITE     (7)
  NO256__COLOR_FG_UNDERLINE_IMPORT_4=$( tput setf 7   || tput setaf 7   || : 2>/dev/null )      ; # WHITE     (7)

       __COLOR_FG_UNDERLINE_IMPORT_0=$( tput setf 58  || tput setaf 58  || : 2>/dev/null )      ; # Grey93    (255)
       __COLOR_FG_UNDERLINE_IMPORT_1=$( tput setf 236 || tput setaf 236 || : 2>/dev/null )      ; # Grey93    (255)
       __COLOR_FG_UNDERLINE_IMPORT_2=$( tput setf 60  || tput setaf 60  || : 2>/dev/null )      ; # Grey93    (255)
       __COLOR_FG_UNDERLINE_IMPORT_3=$( tput setf 58  || tput setaf 58  || : 2>/dev/null )      ; # Grey93    (255)
       __COLOR_FG_UNDERLINE_IMPORT_4=$( tput setf 124 || tput setaf 124 || : 2>/dev/null )      ; # Grey93    (255)

  # ______________________BACKGROUND COLORS_______________________

  # FOREGROUND color for OPTIONNAL UNDERLINE BAR : ONE COLOR per level of IMPORTANCE
  NO256__COLOR_BG_UNDERLINE_IMPORT_0=                                                           ; # UNSET
  NO256__COLOR_BG_UNDERLINE_IMPORT_1=                                                           ; # UNSET
  NO256__COLOR_BG_UNDERLINE_IMPORT_2=                                                           ; # UNSET
  NO256__COLOR_BG_UNDERLINE_IMPORT_3=                                                           ; # UNSET
  NO256__COLOR_BG_UNDERLINE_IMPORT_4=                                                           ; # UNSET

       __COLOR_BG_UNDERLINE_IMPORT_0=                                                           ; # UNSET
       __COLOR_BG_UNDERLINE_IMPORT_1=                                                           ; # UNSET
       __COLOR_BG_UNDERLINE_IMPORT_2=                                                           ; # UNSET
       __COLOR_BG_UNDERLINE_IMPORT_3=                                                           ; # UNSET
       __COLOR_BG_UNDERLINE_IMPORT_4=                                                           ; # UNSET


  # ______________________UNDERLINE CHARACTER_____________________


     __UNDERLINE_CHAR="▔"
  NO8__UNDERLINE_CHAR="-"

  # --------------------------------------------------------------
  #              1.2 - CUSTOM UI ELEMENTS
  # --------------------------------------------------------------


  # LEFT HEADER : shows the contents of the string passed with the
  #               --from option
     __LEFTHEADER_FROM=" FROM "
  NO8__LEFTHEADER_FROM=" FROM "
    # Following 4 nedd to be 1 character long !
     __LEFTHEADER_FROM_SEP="⮁"
  NO8__LEFTHEADER_FROM_SEP=" "
  __LEFTHEADER_SEP="⮀"
  NO8__LEFTHEADER_SEP=" "

  # RIGHT HEADER : shows the TYPE of message (see below)
     __RIGHTHEADER_TYPE=" TYPE "
  NO8__RIGHTHEADER_TYPE=" TYPE "
    # Following 4 nedd to be 1 character long !
     __RIGHTHEADER_TYPE_SEP="⮃"
  NO8__RIGHTHEADER_TYPE_SEP=" "
  __RIGHTHEADER_SEP="⮂"
  NO8__RIGHTHEADER_SEP=" "

  # TYPES OF MESSAGES (one per level of importance)
  NO8__TYPEMSG_IMPORT_0="  INFO   "
  NO8__TYPEMSG_IMPORT_1=" REMARK  "
  NO8__TYPEMSG_IMPORT_2=" WARNING "
  NO8__TYPEMSG_IMPORT_3="  ERROR  "
  NO8__TYPEMSG_IMPORT_4="  FATAL  "

     __TYPEMSG_IMPORT_0="   ♫ INFO  "
     __TYPEMSG_IMPORT_1="  ★ REMARK "
     __TYPEMSG_IMPORT_2=" ⚡ WARNING "
     __TYPEMSG_IMPORT_3="  ✖ ERROR  "
     __TYPEMSG_IMPORT_4="  ☠ FATAL  "

  # STRING USED TO TRUNCATE LONG MESSAGES
  __TRUNCATED="…"
  NO8__TRUNCATED=" (...)"


  # --------------------------------------------------------------
  #              1.3 - CENTER MESSAGE PADDING
  # --------------------------------------------------------------
  #
  # the fields (left, center, right) length are calculated automatically
  #
  # PADDING (left and right) added to your message in the CENTER field
  # NB : your message will be trimmed if it exceeds the space left,
  #      depending on your TERM windows's width
  #
  __CENTER_MSG_PADDING="4"





#//////////////////////////////////////////////////////////////////////#





  # ==============================================================
  #                      2. BOX MENU
  # ==============================================================

  # --------------------------------------------------------------
  #                    2.1 - colors
  # --------------------------------------------------------------

  # ..............................................................
  # BOX BORDER COLOR : ONE COLOR per level of IMPORTANCE
  #
  # NB : iy you sourced the color scripts, you can just go like :
  #
  #     N0256__COLOR_BOX_IMPORT_0=$__C_       # CYAN
  #     __COLOR_BOX_IMPORT_0=$__Charteruse3_  # Chartreuse3
  #     __COLOR_BOX_IMPORT_0=$__76_           # Chartreuse3 too
  #
  #     etc...
  #
  # ..............................................................

  N0256__COLOR_BOX_IMPORT_0=$( tput setf 6 || tput setaf 6 || : 2>/dev/null )                           ; # INFO    -> CYAN
  N0256__COLOR_BOX_IMPORT_1=$( tput setf 2 || tput setaf 2 || : 2>/dev/null )                           ; # REMARK  -> GREEN
  N0256__COLOR_BOX_IMPORT_2=$( tput setf 3 || tput setaf 3 || : 2>/dev/null )                           ; # WARNING -> YELLOW
  N0256__COLOR_BOX_IMPORT_3=$( tput setf 1 || tput setaf 1 || : 2>/dev/null )                           ; # ERROR   -> RED
  N0256__COLOR_BOX_IMPORT_4=$( tput blink  || : 2>/dev/null )                                           ; # FATAL   -> BLINKING...
  N0256__COLOR_BOX_IMPORT_4=$N0256__COLOR_BOX_IMPORT_4$( tput bold    || : 2>/dev/null )                ; # FATAL   -> BOLD...
  N0256__COLOR_BOX_IMPORT_4=$N0256__COLOR_BOX_IMPORT_4$( tput setf 4 || tput setaf 1 || : 2>/dev/null ) ; # FATAL   -> RED !

  __COLOR_BOX_IMPORT_0=$( tput setf 78  || tput setaf 78  || : 2>/dev/null )                            ; # INFO    -> DarkSeaGreen3 (78)
  __COLOR_BOX_IMPORT_1=$( tput setf 64  || tput setaf 64  || : 2>/dev/null )                            ; # REMARK  -> Chartreuse4 (64)
  __COLOR_BOX_IMPORT_2=$( tput setf 172 || tput setaf 172 || : 2>/dev/null )                            ; # WARNING -> Orange3 (172)
  __COLOR_BOX_IMPORT_3=$( tput setf 196 || tput setaf 196 || : 2>/dev/null )                            ; # ERROR   -> Red1 (196)
  __COLOR_BOX_IMPORT_4=$( tput blink    || : 2>/dev/null )                                              ; # FATAL   -> BLINKING...
  __COLOR_BOX_IMPORT_4=$__COLOR_BOX_IMPORT_4$( tput bold    || : 2>/dev/null )                ; # FATAL   -> BOLD...
  __COLOR_BOX_IMPORT_4=$__COLOR_BOX_IMPORT_4$( tput setf 52 || tput setaf 52 || : 2>/dev/null )         ; # FATAL   -> DarkRed (52) !

  # ..............................................................
  #
  # TEXT MESSAGE COLOR : ONE COLOR per level of IMPORTANCE
  #
  # ..............................................................

  N0256__COLOR_BOXTEXT_IMPORT_0=$( tput setf 7 || tput setaf 7 || : 2>/dev/null )                               ; # INFO    -> WHITE
  N0256__COLOR_BOXTEXT_IMPORT_1=$( tput setf 7 || tput setaf 7 || : 2>/dev/null )                               ; # REMARK  -> WHITE
  N0256__COLOR_BOXTEXT_IMPORT_2=$( tput setf 2 || tput setaf 2 || : 2>/dev/null )                               ; # WARNING -> GREEN
  N0256__COLOR_BOXTEXT_IMPORT_3=$( tput setf 6 || tput setaf 6 || : 2>/dev/null )                               ; # ERROR   -> YELLOW
  N0256__COLOR_BOXTEXT_IMPORT_4=$( tput bold    || : 2>/dev/null )                                              ; # FATAL   -> BOLD...
  N0256__COLOR_BOXTEXT_IMPORT_4=$N0256__COLOR_BOXTEXT_IMPORT_4$( tput setf 5 || tput setaf 5 || : 2>/dev/null ) ; # FATAL   -> MAGENTA !

  __COLOR_BOXTEXT_IMPORT_0=$( tput setf 252 || tput setaf 252 || : 2>/dev/null )                                ; # INFO    -> Grey82 (252)
  __COLOR_BOXTEXT_IMPORT_1=$( tput setf 29  || tput setaf 29  || : 2>/dev/null )                                ; # REMARK  -> SpringGreen4 (29)
  __COLOR_BOXTEXT_IMPORT_2=$( tput setf 137 || tput setaf 137 || : 2>/dev/null )                                ; # WARNING -> LightSalmon3 (137)
  __COLOR_BOXTEXT_IMPORT_3=$( tput setf 52  || tput setaf 52  || : 2>/dev/null )                                ; # ERROR   -> DarkRed (52)
  __COLOR_BOXTEXT_IMPORT_4=$( tput bold    || : 2>/dev/null )                                                   ; # FATAL   -> BOLD...
  __COLOR_BOXTEXT_IMPORT_4=$__COLOR_BOXTEXT_IMPORT_4$( tput setf 126 || tput setaf 126 || : 2>/dev/null )       ; # FATAL   -> MediumVioletRed (126) !


  #---------------------------------------------------------------
  #             2.2 - MENU BORDERS & ELEMENTS
  #---------------------------------------------------------------

  __BOX_MENU_TOPLEFT="┌"
  __BOX_MENU_TOP="─"
  __BOX_MENU_TOPRIGHT="┐"
  __BOX_MENU_LEFT="│"
  __BOX_MENU_RIGHT="│"
  __BOX_MENU_BOTTOMLEFT="└"
  __BOX_MENU_BOTTOM="─"
  __BOX_MENU_BOTTOMRIGHT="┘"

  NO8__BOX_MENU_TOPLEFT=" "
  NO8__BOX_MENU_TOP="_"
  NO8__BOX_MENU_TOPRIGHT=" "
  NO8__BOX_MENU_LEFT=" "
  NO8__BOX_MENU_RIGHT=" "
  NO8__BOX_MENU_BOTTOMLEFT=" "
  NO8__BOX_MENU_BOTTOM="_"
  NO8__BOX_MENU_BOTTOMRIGHT=" "


  __ONELINER_MENU_LEFT="【"
  __ONELINER_MENU_RIGHT="】"

  NO8__ONELINER_MENU_LEFT="["
  NO8__ONELINER_MENU_RIGHT="]"




  # ==============================================================
  #                3. GROWLTERM GLOBALS
  #                 (to be used soon)
  # ==============================================================

  __growltermHistoryEnabled=1
  __growltermHistoryFile="~/.bash/growlterm/.growlterm_history"
  __growltermHistoryMaxSize=0
  __growltermHistoryRemoveDups=1



  # ==============================================================
  #                4. REGISTER YOUR THEME
  #                (with a GLOBAL variable)
  # ==============================================================

  ## !! Your theme must end with this line to override default theme
  #export __customGrowltermThemeSet="TRUE"

}

__growltermTest(){

growlterm -p 10 -i 0 -f "GIT is not a GIT" -u -m "COOL ! Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
sleep 1.5
growlterm -p 10 -i 1 -f "GIT is nota  GIT" -u -m "OH !   Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
sleep 1.5
growlterm -p 10 -i 2 -f "GIT isnot  a GIT" -u -m "AHH ?  Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
sleep 1.5
growlterm -p 10 -i 3 -f "GITis  not a GIT" -u -m "HMMM ! Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
sleep 1.5
growlterm -p 10 -i 4 -f "GITis  not  aGIT" -u -m "ARGHH !Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

}

growlterm ()
{

  [[ $@ == "" ]] && __growltermVersion

  # Our main variables : declare them so that __growltermParseOpts() has
  # them in it's dynamic scope
  local __menupos=""
  local __mystring=""
  local __oneliner=""
  local __from=""
  local __importance=""

  # $@ MUST BE QUOTED !!
  __growltermParseOpts "$@" || return 1


  # ================================================================== #
  #                                                                    #
  #               DECLARE LOCAL  PARAMETERS                            #
  #                                                                    #
  # ================================================================== #




  # RESET ALL STYLES
  local __NN_=

  #---------------------------------------------------------------
  #             FANCY MENU VARS (see THEMES for info)
  #---------------------------------------------------------------

  local __colBGleft1=
  local __colBGleft2=
  local __colFGleft1=
  local __colFGleft2=
  local __colFGleftFromDelim=
  local __colFGleftDelim=


  local __colBGcenterInfo=
  local __colBGcenterRemark=
  local __colBGcenterWarn=
  local __colBGcenterErr=
  local __colBGcenterFatal=

  local __colFGcenter=
  local __colBGcenter=


  local __colFGcenterInfo=
  local __colFGcenterRemark=
  local __colFGcenterWarn=
  local __colFGcenterErr=
  local __colFGcenterFatal=


  local __colBGright1=
  local __colBGright2=
  local __colFGright1=
  local __colFGright2=
  local __colFGrightTypeDelim=
  local __colFGrightDelim=

  local __importanceMSG=

  local __colUnderlineFG=
  local __colUnderlineBG=


  local __LEFTHEADER_FROM=
  local __LEFTHEADER_FROM_SEP=
  local __LEFTHEADER_SEP=

  local __RIGHTHEADER_TYPE=
  local __RIGHTHEADER_TYPE_SEP=
  local __RIGHTHEADER_SEP=

  local __TYPEMSG_IMPORT_0=
  local __TYPEMSG_IMPORT_1=
  local __TYPEMSG_IMPORT_2=
  local __TYPEMSG_IMPORT_3=
  local __TYPEMSG_IMPORT_4=

  local __TRUNCATED=
  local __CENTER_MSG_PADDING=

  #---------------------------------------------------------------
  #             BOX MENU VARS (see THEMES for info)
  #---------------------------------------------------------------

  local __colBoxMenuBorder=
  local __colTextMenu=

  #---------------------------------------------------------------
  #             MISC VARS
  #---------------------------------------------------------------

  # DISABLING of the ANSI stripping function
  local __nostripansi=

  # TERM capacity detection variables
  local __supports8=
  local __colorPrefix=
  local __UTFprefix=

  # ================================================================== #
  #                                                                    #
  #                    MAIN FUNCTION                                   #
  #                                                                    #
  # ================================================================== #



  #---------------------------------------------------------------------
  # take care of non UTF-8 terminals
  locale >/dev/null 2>&1
  [ $? = 0 ] && locale | grep -i utf-8 >/dev/null 2>&1 && __supports8="true"

  #---------------------------------------------------------------------
  # don't load default theme in case a user defined theme is already loaded
  [ -n "$__customGrowltermThemeSet" ] || __growltermDefaultTheme


  #---------------------------------------------------------------------
  # DETERMINE VARIABLE PREFIXES
  [ 256 = "$(tput colors)" ]  || __colorPrefix="NO256"
  [ "true" = "$__supports8" ] || __UTFprefix="NO8"

  #---------------------------------------------------------------------
  # DYNAMICALLY COMPUTE COLOR VALUES according to those present in the
  # environment (either DEFAULT THEME or user-defined THEME)
  #---------------------------------------------------------------------

  # ....................................................................
  #
  # FANCY MENU
  #
  # ....................................................................

  # COLORS
  __colBGleft1=$(eval               "printf "%s" "\$${__colorPrefix}__COLOR_LEFTHEADER_BG_FROM""                   )
  __colBGleft2=$(eval               "printf "%s" "\$${__colorPrefix}__COLOR_LEFTHEADER_BG_FROMTEXT""               )
  __colFGleft1=$(eval               "printf "%s" "\$${__colorPrefix}__COLOR_LEFTHEADER_FG_FROM""                   )
  __colFGleft2=$(eval               "printf "%s" "\$${__colorPrefix}__COLOR_LEFTHEADER_FG_FROMTEXT""               )
  __colFGleftFromDelim=$(eval       "printf "%s" "\$${__colorPrefix}__COLOR_LEFTHEADER_FG_FROMSEP""                )
  __colFGleftDelim=$(eval           "printf "%s" "\$${__colorPrefix}__COLOR_LEFTHEADER_FG_SEP""                    )



  __colBGcenter=$(eval              "printf "%s" "\$${__colorPrefix}__COLOR_BG_CENTERZONE_IMPORT_${__importance}"" )
  __colFGcenter=$(eval              "printf "%s" "\$${__colorPrefix}__COLOR_FG_CENTERZONE_IMPORT_${__importance}"" )


  __colBGright1=$(eval              "printf "%s" "\$${__colorPrefix}__COLOR_RIGHTHEADER_BG_TYPE""                  )
  __colBGright2=$(eval              "printf "%s" "\$${__colorPrefix}__COLOR_RIGHTHEADER_BG_TYPETEXT""              )
  __colFGright1=$(eval              "printf "%s" "\$${__colorPrefix}__COLOR_RIGHTHEADER_FG_TYPE""                  )
  __colFGright2=$(eval              "printf "%s" "\$${__colorPrefix}__COLOR_RIGHTHEADER_FG_TYPETEXT""              )
  __colFGrightTypeDelim=$(eval      "printf "%s" "\$${__colorPrefix}__COLOR_RIGHTHEADER_FG_TYPESEP""               )
  __colFGrightDelim=$(eval          "printf "%s" "\$${__colorPrefix}__COLOR_RIGHTHEADER_FG_SEP""                   )


  __colUnderlineFG=$(eval           "printf "%s" "\$${__colorPrefix}__COLOR_FG_UNDERLINE_IMPORT_${__importance}""  )
  __colUnderlineBG=$(eval           "printf "%s" "\$${__colorPrefix}__COLOR_BG_UNDERLINE_IMPORT_${__importance}""  )
  __underlineChar=$(eval            "printf "%s" "\$${__colorPrefix}__UNDERLINE_CHAR""                             )

  # MENU BORDERS & ELEMENTS

  # Replace value of these VARS with non-utf8 variant if need be
  [ "true" = "$__supports8" ] || {
    __LEFTHEADER_FROM="$(eval       "printf "%s" "\$${__UTFprefix}__LEFTHEADER_FROM""                              ) "
    __LEFTHEADER_FROM_SEP="$(eval   "printf "%s" "\$${__UTFprefix}__LEFTHEADER_FROM_SEP""                          ) "
    __LEFTHEADER_SEP="$(eval        "printf "%s" "\$${__UTFprefix}__LEFTHEADER_SEP""                               ) "

    __RIGHTHEADER_TYPE="$(eval      "printf "%s" "\$${__UTFprefix}__RIGHTHEADER_TYPE""                             ) "
    __RIGHTHEADER_TYPE_SEP="$(eval  "printf "%s" "\$${__UTFprefix}__RIGHTHEADER_TYPE_SEP""                         ) "
    __RIGHTHEADER_SEP="$(eval       "printf "%s" "\$${__UTFprefix}__RIGHTHEADER_SEP""                              ) "


    __TRUNCATED="$(eval             "printf "%s" "\$${__UTFprefix}__TRUNCATED""                                    ) "

  }

    __importanceMSG="$(eval         "printf "%s" "\$${__UTFprefix}__TYPEMSG_IMPORT_${__importance}""               ) "

  # ....................................................................
  #
  # BOX MENU
  #
  # ....................................................................

  # COLORS
  __colBoxMenuBorder=$(eval "printf "%s" "\$${__colorPrefix}__COLOR_BOX_IMPORT_${__importance}""     )
  __colTextMenu=$(eval      "printf "%s" "\$${__colorPrefix}__COLOR_BOXTEXT_IMPORT_${__importance}"" )



  # MENU BORDERS & ELEMENTS

  # Replace value of these VARS with non-utf8 variant if need be
  [ "true" = "$__supports8" ] || {
    __BOX_MENU_TOPLEFT="$(eval     "printf "%s" "\$${__UTFprefix}__BOX_MENU_TOPLEFT""     )"
    __BOX_MENU_TOP="$(eval         "printf "%s" "\$${__UTFprefix}__BOX_MENU_TOP""         )"
    __BOX_MENU_TOPRIGHT="$(eval    "printf "%s" "\$${__UTFprefix}__BOX_MENU_TOPRIGHT""    )"
    __BOX_MENU_LEFT="$(eval        "printf "%s" "\$${__UTFprefix}__BOX_MENU_LEFT""        )"
    __BOX_MENU_RIGHT="$(eval       "printf "%s" "\$${__UTFprefix}__BOX_MENU_RIGHT""       )"
    __BOX_MENU_BOTTOMLEFT="$(eval  "printf "%s" "\$${__UTFprefix}__BOX_MENU_BOTTOMLEFT""  )"
    __BOX_MENU_BOTTOM="$(eval      "printf "%s" "\$${__UTFprefix}__BOX_MENU_BOTTOM""      )"
    __BOX_MENU_BOTTOMRIGHT="$(eval "printf "%s" "\$${__UTFprefix}__BOX_MENU_BOTTOMRIGHT"" )"

    __ONELINER_MENU_LEFT="$(eval   "printf "%s" "\$${__UTFprefix}__ONELINER_MENU_LEFT""   )"
    __ONELINER_MENU_RIGHT="$(eval  "printf "%s" "\$${__UTFprefix}__ONELINER_MENU_RIGHT""  )"
  }


  if [ -z "$__mystring" ]; then
    :;
  else
    local stripansi="$__mystring"
    [ -z "$__nostripansi" ] && stripansi=$(printf "%s" "$__mystring" | perl -pe 's/\e\[?.*?[\@-~]//g');
    local resLength=$((${#stripansi} + 4));

    local blankLine=$(printf "%s" "$stripansi""####")
    blankLine=$(printf "%${#blankLine}s")
    ##much slower alternative :
    #local blankLine=$(printf "%s" $stripansi"    " | tr "[:print:]" ' ');

    local firstC=
    local firstL=
    local oneliner=
    [ "TRUE" = "$__oneliner" ] || [ "true" = "$__oneliner" ] && oneliner="$__oneliner"
    local sttysize=
    local nlines=
    local ncol=
    local additLines=
    local screenwidemenu=
    local __strlen=
    local __remainmain=
    local __filler1=
    local __filler2=

    sttysize=$(stty size 2>/dev/null)
    [ $? -eq 0 ]  && {
      nlines=${sttysize%% *}
      ncol=${sttysize##* }
    } || {
      nlines=$(tput lines);
      ncol=$(tput cols);
    }



    case $__menupos in

      10) firstL=0                ; firstC=0                            ;                screenwidemenu="true" ;;
      1) firstL=0                 ; firstC=0                                                                   ;;
      2) firstL=0                 ; firstC=$(( ($ncol - $resLength)/2 ))                                       ;;
      3) firstL=0                 ; firstC=$((  $ncol - $resLength ))                                          ;;
      4) firstL=1                 ; firstC=0                            ; additLines=1                         ;;
      5) firstL=1                 ; firstC=$(( ($ncol - $resLength)/2 )); additLines=1                         ;;
      6) firstL=1                 ; firstC=$((  $ncol - $resLength ))   ; additLines=1                         ;;
      7) firstL=2                 ; firstC=0                            ; additLines=2                         ;;
      8) firstL=2                 ; firstC=$(( ($ncol - $resLength)/2 )); additLines=2                         ;;
      9) firstL=2                 ; firstC=$((  $ncol - $resLength ))   ; additLines=2                         ;;
      0) firstL=$(( $nlines - 1 )); firstC=$((  $ncol - $resLength ))   ; additLines=2 ; oneliner="true"       ;;
      #NEW : one line filling top of screen

    esac


    if [ -z "$oneliner" ] && [ -z "$screenwidemenu" ]; then
    # ___________________________________
    # NORMAL MENU WITH UPPER/LOWER BORDER
    #   ┌───────────────┐
    #   │  message      │
    #   └───────────────┘
    #
      local menuBorderTop=$(printf "%s" "$stripansi""##" | tr "[:print:]" $__BOX_MENU_TOP);
      local menuBorderBottom=$(printf "%s" "$stripansi""##" | tr "[:print:]" $__BOX_MENU_BOTTOM);

      tput sc; # Save current cursor position
      __growltermAdditLines
      tput cup $firstL $firstC;
      printf "%s" "$__colBoxMenuBorder$__BOX_MENU_TOPLEFT$menuBorderTop$__BOX_MENU_TOPRIGHT$__NN_";
      tput cup $(($firstL + 1)) $firstC;
      printf "%s" "$__colBoxMenuBorder$__BOX_MENU_LEFT$__NN_" "$__colTextMenu$__mystring$__NN_" "$__colBoxMenuBorder$__BOX_MENU_RIGHT$__NN_";
      tput cup $(($firstL + 2)) $firstC;
      printf "%s" "$__colBoxMenuBorder$__BOX_MENU_BOTTOMLEFT$menuBorderBottom$__BOX_MENU_BOTTOMRIGHT$__NN_";
      tput rc;

    elif [ -z "$screenwidemenu" ]; then

      # _________________________________
      # ONE LINER MENU
      #
      #   │  message      │
      #
      tput sc; # Save current cursor position
      __growltermAdditLines
      tput cup $(($firstL )) $(($firstC + 4));
      printf "%s" "$__NN_$__ONELINER_MENU_LEFT$__mystring$__ONELINER_MENU_RIGHT$__NN_";
      tput rc;
    else

      # _________________________________
      # SCREEN WIDE MENU
      #   ┌────────────────────────────────────────────────┐
      #   │FROM ⮁ SOMEONE ⮀    message...    ⮂ fatal ⮃ TYPE│
      #   └────────────────────────────────────────────────┘
      #



      # ==============================================================
      #                      Zone COMPUTATION
      #
      # ==============================================================

      # --------------------------------------------------------------
      # compute zone1 : LEFT
      # --------------------------------------------------------------

      #Keep it simple : we don't compute nothing : the center field adapts
      __leftstrWithoutEscapes="${__LEFTHEADER_FROM}${__LEFTHEADER_FROM_SEP} ${__from} ${__LEFTHEADER_SEP}"
      __leftStrLen=${#__leftstrWithoutEscapes}

      __leftstr="${__NN_}${__colBGleft1}${__colFGleft1}${__LEFTHEADER_FROM}${__colBGleft2}${__colFGleftFromDelim}${__LEFTHEADER_FROM_SEP}${__colFGleft2} ${__from} ${__colBGcenter}${__colFGleftDelim}${__LEFTHEADER_SEP}${__NN_}"


      # --------------------------------------------------------------
      # compute zone3 : RIGHT
      # --------------------------------------------------------------

      #Keep it simple : we don't compute nothing : the center field adapts
      __rightstrWithoutEscapes="${__RIGHTHEADER_SEP} ${__importanceMSG} ${__RIGHTHEADER_TYPE_SEP}${__RIGHTHEADER_TYPE}"
      __rightStrLen=${#__rightstrWithoutEscapes}

      __rightstr="${__NN_}${__colBGcenter}${__colFGrightDelim}${__RIGHTHEADER_SEP}${__colBGright2}${__colFGright2} ${__importanceMSG} ${__colFGrightTypeDelim}${__RIGHTHEADER_TYPE_SEP}${__colBGright1}${__colFGright1}${__RIGHTHEADER_TYPE}${__NN_}"

      # --------------------------------------------------------------
      # compute fillers for zone2 : CENTER
      #
      # (obviously we do that after computing the other two)
      # --------------------------------------------------------------

      #__strlen="${#__mystring}"
      #__remainmain=$(($ncol - $__strlen))

      # how much space left do we have
      [ -z "$__CENTER_MSG_PADDING" ] && __CENTER_MSG_PADDING=4; #DEFAULT, don't bug the user if his theme is faulty
      __remainmain=$ncol
      __remainmain=$(($__remainmain - $__leftStrLen - $__rightStrLen))
      __remainmain=$(( $__remainmain - $((2 * $__CENTER_MSG_PADDING)) ))

      # ..............................................................
      # compute left, right and padding fillers for CENTER zone
      # (in case message is short)
      # ..............................................................

      # generate a '$__CENTER_MSG_PADDING' long empty string
      __paddingcenter="$(head -c $__CENTER_MSG_PADDING < /dev/zero | tr '\0' ' ')"


      __msg="$__mystring"
      __strlen="${#__mystring}"

      if [ $__strlen -gt $__remainmain ]; then
      # STRING TOO LONG ?

        # TRIM IT !
        __lenTrunc=${#__TRUNCATED}
        __msg="${__msg:0:$(($__remainmain  - $__lenTrunc))}""$__TRUNCATED"

      else
      # STRING TOO SHORT ?

        # ELONGATE IT !

        # compute the half of space left to fill
        __strlendiv2="$(printf "%0.f\n" $((  $(($__remainmain - ${#__msg} )) / 2  )) )"; # rounded to inferior
        # and the remainder if ODD result
        __strlenremain="$((  $(($__remainmain - ${#__msg} )) % 2))"; # remainder : 0 or 1

        [ $__strlendiv2 -gt 0 ] && {
          __filler="$(head -c $__strlendiv2 < /dev/zero | tr '\0' ' ')"
          __msg="$__filler$__msg$__filler"
        }

        [ $__strlenremain = 1 ] && {
          # add one space
          __msg="$__msg"" "
        }

      fi


      __centerstr="${__NN_}${__colBGcenter}${__colFGcenter}${__paddingcenter}${__msg}${__paddingcenter}${__NN_}"




      # ==============================================================
      # display infobar
      #
      # ==============================================================

      __underLiner="$(head -c $ncol < /dev/zero | tr '\0' "$__underlineChar")"

      tput sc; # Save current cursor position
      tput cup $(($firstL )) $(($firstC ));
      printf "%s" "${__NN_}${__leftstr}${__centerstr}${__rightstr}${__NN_}";
      [ -n "$__underline" ] && printf "\n%s" "${__NN_}${__colUnderlineFG}${__colUnderlineBG}${__underLiner}${__NN_}";
      tput rc;
    fi
  fi;
}
