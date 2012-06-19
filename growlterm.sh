  __infobar ()
  {

    # position the '__mystring' argument on the screen
    #
    # options : 1,2,3,4,5,6,7,8,9 position menu at top of screen
    #
    #   option  : 0         --> menu on same line as prompt
    #                           right of terminal
    #
    #   options : 1,2,3     --> your prompt is 1 line  high
    #   options : 4,5,6     --> your prompt is 2 lines high
    #   options : 1,2,3     --> your prompt is 3 lines high
    #
    #   option  : 10,11,12  --> terminal-wide top menu
    #     10 --> prompt 1 line
    #     11 --> prompt 2 lines
    #     12 --> prompt 3 lines
    #
    #   ┌───────────────┐
    #   │1      2      3│
    #   │4      5      6│
    #   │7      8      9│
    #   │               │
    #   │               │
    #   │              0│
    #   └───────────────┘
    #   ┌───────────────┐
    #   │█████10|2|3████│
    #   │               │
    #   │               │
    #   │               │
    #   │               │
    #   │               │
    #   └───────────────┘
    #
    #
    #

    __menupos=$1;     # either one of 0,1,2,3,4,5,6,7,8,9,10,11,12
    __mystring="$2";  # message to be displayed
    __iserr="$3";     # if message is an error message (=1, =0 otherwise)
    __oneliner="$4";  # set to TRUE to get rid of the menu decoration in
                      # positions 1,2,3,4,5,6,7,8,9,10,11,12
    __from=$5;         # info about "who/what" is messaging
    __importance=$6;   # importance of message : either one of 
                      #  0    info
                      #  1    remark
                      #  2    warning
                      #  3    error
                      #  4    fatal

    # ================================================================== #
    #                                                                    #
    #               GLOBAL PARAMETERS : TWEAK to your needs              #
    #                                                                    #
    # ================================================================== #


    # __________________________________________________________________ #
    #                                                                    #
    #    colors                                                          #
    #                                                                    #
    # __________________________________________________________________ #
    #
    # Colors are defined here in a 'terminal-safe way'. The colors we use
    # are those defined in the adjoint script 'defineSafeColors.sh' that
    # you can source too (or include in your .bashrc) and defines colors
    # which are resistant to the oldest terminals (even two colors TERMS)
    # but provide full power on 256-colors TERMS.
    #
    # in order to avoid conflicts with bash's environment, the following
    # "namespacing" convention is used :
    #
    #   $__COLORNAME_
    #
    #   ( two underscores + variable name + one underscore )
    #
    # You can use the variables referenced in the adjoint script to define
    # your colors in a Geekless fashion
    #
    # mycolor=$__MediumPurple4_
    # __________________________________________________________________ #


    # Background colors for left zone
    __colBGleft=$__BGGrey100_
    __colBGleft2=$__BGGrey93_
    # Foreground colors for left zone's text
    __colFGleft=$__MediumPurple4_
    # Foreground color for left delimiter
    # (has to be the same as  $__colBGleft, but transposed to equivalent FG
    #  color. IE : __BGGrey100_ --> __Grey100_)
    __colFGleftDelim=$__Grey100_


    # Background colors for center zone (adapts to $__importance)
    __colBGcenterInfo=$__BGDarkOliveGreen2_
    __colBGcenterRemark=$__BGChartreuse1_
    __colBGcenterWarn=$__BGOrange1_
    __colBGcenterErr=$__BGDarkRed_
    __colBGcenterFatal=$__BGRed3_
    # Foreground colors for center zone (adapts to $__importance)
    __colFGcenterInfo=$__LightSteelBlue3_
    __colFGcenterRemark=$__Grey19_
    __colFGcenterWarn=$__Grey93_
    __colFGcenterErr=$__Grey100_
    __colFGcenterFatal=$__Chartreuse3_


    # Background colors for right zone
    __colBGright=$__BGNavyBlue_
    # Foreground colors for right zone
    __colFGright=$__Gold3_
    # Foreground color for right delimiter
    # (has to be the same as  $__colBGright, but transposed to equivalent FG
    #  color. IE : __BGGrey100_ --> __Grey100_)
    __colFGrightDelim=$__NavyBlue_



    # __________________________________________________________________ #
    #                                                                    #
    #    FIELDS LENGTH                                                   #
    #                                                                    #
    # __________________________________________________________________ #
    #
    # the fields (left, center, right) length are calculated automatically
    #
    # However, you can adapt the following values to your needs


    #DEPRECATED : the center zone adapts, PERIOD!
    ## total length of the LEFT field
    ## (header takes 6 characters out of that, space left is for the $__from
    ##  string passed as parameter)
    #__leftstrlen=22
    #
    ## total length of the RIGHT field
    ## (header takes 6 characters out of that, space left is for the 
    ## $__importance string passed as parameter)
    ##
    ## As these are hardcoded, you should not need to change that (but you can)
    ##
    #__rightstrlen=16


    # PADDING (left and right) added to your message in the CENTER field
    # NB : your message will be trimmed if it exceeds the space left, 
    #      depending on your TERM windows's width
    #
    __centerpadding=4





    # ================================================================== #
    #                                                                    #
    #                    MAIN FUNCTION                                   #
    #                                                                    #
    # ================================================================== #

    # take care of non UTF-8 terminals
    __supports8=
    locale >/dev/null 2>&1
    [ $? = 0 ] && locale | grep -i utf-8 >/dev/null 2>&1 && __supports8="true"



    export __menu_border=$__B_

    [ "true" = "$__supports8" ] && {
      export __menu_topleft="┌"
      export __menu_top="─"
      export __menu_topright="┐"
      export __menu_left="│"
      export __menu_right="│"
      export __menu_bottomleft="└"
      export __menu_bottom="─"
      export __menu_bottomright="┘"
    } || {
      export __menu_topleft=" "
      export __menu_top="_"
      export __menu_topright=" "
      export __menu_left=" "
      export __menu_right=" "
      export __menu_bottomleft=" "
      export __menu_bottom="_"
      export __menu_bottomright=" "
    }


    #TODO: next test is not necessary
    #[ -z "$__menupos" ] && __menupos="3" #default : top right corner

    #TODO: NOCOLORS for delimiters !!
    #result=$(tartify "n/b - l");
    local border=$__NN_$__B_;
    tput sc;
    if [ -z "$__mystring" ]; then
      :;
    else
      local stripansi=$(printf "%s" "$__mystring" | perl -pe 's/\e\[?.*?[\@-~]//g');
      local resLength=$((${#stripansi} + 4));
      local menuBorderTop=$(printf "%s" "$stripansi""##" | tr "[:print:]" $__menu_top);
      local menuBorderBottom=$(printf "%s" "$stripansi""##" | tr "[:print:]" $__menu_bottom);

      local blankLine=$(printf "%s" "$stripansi""####")
      blankLine=$(printf "%${#blankLine}s")
      ##much slower alternative :
      #local blankLine=$(printf "%s" $stripansi"    " | tr "[:print:]" ' ');

      local firstC=
      local firstL=
      local oneliner=
      [ "TRUE" = "$__oneliner" ] && oneliner="$__oneliner"
      local additLines=
      local sttysize=
      local nlines=
      local ncol=
      local __strlen=
      local __remainmain=
      local __filler1=
      local __filler2=
      local __msgcolor="$__BGG_"
      [ $__iserr = 1 ] && __msgcolor="$__BGR_"

      sttysize=$(stty size 2>/dev/null)
      [ $? -eq 0 ]  && {
        nlines=${sttysize%% *}
        ncol=${sttysize##* }
      } || {
        nlines=$(tput lines);
        ncol=$(tput cols);
      }


      case $__menupos in

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
        10) firstL=0                ; firstC=0                            ;                screenwidemenu="true" ;;
        11) firstL=0                ; firstC=0                            ; additLines=1 ; screenwidemenu="true" ;;
        12) firstL=0                ; firstC=0                            ; additLines=2 ; screenwidemenu="true" ;;
        13) firstL=0                ; firstC=0                            ; additLines=3 ; screenwidemenu="true" ;;
        14) firstL=0                ; firstC=0                            ; additLines=4 ; screenwidemenu="true" ;;

      esac

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

      [ -z "$oneliner" ] && [ -z "$screenwidemenu" ] && {
      # ___________________________________
      # NORMAL MENU WITH UPPER/LOWER BORDER
      #   ┌───────────────┐
      #   │  message      │
      #   └───────────────┘
      #

        tput cup $firstL $firstC;
        printf "%s" "$__menu_border$__menu_topleft$menuBorderTop$__menu_topright$__NN_";
        tput cup $(($firstL + 1)) $firstC;
        printf "%s" "$__menu_border$__menu_left$__NN_" "$__mystring" "$__menu_border$__menu_right$__NN_";
        tput cup $(($firstL + 2)) $firstC;
        printf "%s" "$__menu_border$__menu_bottomleft$menuBorderBottom$__menu_bottomright$__NN_";
      } || [ -z "$screenwidemenu" ] && {

        # _________________________________
        # ONE LINER MENU
        #
        #   │  message      │
        #
        tput cup $(($firstL )) $(($firstC + 4));
        printf "%s" "$__NN_$__mystring$__NN_";
      } || {

        # _________________________________
        # SCREEN WIDE MENU
        #   ┌───────────────┐
        #   │████message████│
        #   └───────────────┘
        #


        # ==============================================================
        #              COMPUTE ALERTS AND COLORS
        #
        # ==============================================================

        case "$__importance" in
          0 )  __colFGcenter=$__colFGcenterInfo   ;  __colBGcenter=$__colBGcenterInfo   ; __importanceMSG="  info   "  ;;
          1 )  __colFGcenter=$__colFGcenterRemark ;  __colBGcenter=$__colBGcenterRemark ; __importanceMSG=" remark  "  ;;
          2 )  __colFGcenter=$__colFGcenterWarn   ;  __colBGcenter=$__colBGcenterWarn   ; __importanceMSG=" warning "  ;;
          3 )  __colFGcenter=$__colFGcenterErr    ;  __colBGcenter=$__colBGcenterErr    ; __importanceMSG="  error  "  ;;
          4 )  __colFGcenter=$__colFGcenterFatal  ;  __colBGcenter=$__colBGcenterFatal  ; __importanceMSG="  fatal  "  ;;
        esac




        # ==============================================================
        #                      Zone COMPUTATION
        #
        # ==============================================================

        # --------------------------------------------------------------
        # compute zone1 : LEFT
        # --------------------------------------------------------------

        # Define HARDCODED HEADERS
        [ "true" = "$__supports8" ] && __fromfield="FROM ⮁ " || __fromfield="FROM >"
        [ "true" = "$__supports8" ] && __endfromfield="⮀" || __endfromfield=">"
        __truncatedsymbol=" (...)"; __lenTrunc=${#__truncatedsymbol}


        #Keep it simple : we don't compute nothing : the center field adapts
        __leftstrWithoutEscapes="${__fromfield}${__from} ${__endfromfield}"
        __leftStrLen=${#__leftstrWithoutEscapes}

        __leftstr="${__NN_}${__colBGleft}${__colFGleft}${__fromfield}${__from} ${__colBGcenter}${__colFGleftDelim}${__endfromfield}${__NN_}"


        # --------------------------------------------------------------
        # compute zone3 : RIGHT
        # --------------------------------------------------------------

        # Define HARDCODED HEADERS
        [ "true" = "$__supports8" ] && __typeField=" ⮃ TYPE" || __typeField=" < TYPE"
        [ "true" = "$__supports8" ] && __beginTypeField="⮂" || __beginTypeField="<"


        #Keep it simple : we don't compute nothing : the center field adapts
        __rightstrWithoutEscapes="${__beginTypeField} ${__importanceMSG}${__typeField}"
        __rightStrLen=${#__rightstrWithoutEscapes}

        __rightstr="${__NN_}${__colBGcenter}${__colFGrightDelim}${__beginTypeField}${__colBGright}${__colFGright} ${__importanceMSG}${__typeField}${__NN_}"

        # --------------------------------------------------------------
        # compute fillers for zone2 : CENTER
        #
        # (obviously we do that after computing the other two)
        # --------------------------------------------------------------

        #__strlen="${#__mystring}"
        #__remainmain=$(($ncol - $__strlen))

        # how much space left do we have
        __remainmain=$ncol
        __remainmain=$(($__remainmain - $__leftStrLen - $__rightStrLen))
        __remainmain=$(( $__remainmain - $((2 * $__centerpadding)) ))

        # ..............................................................
        # compute left, right and padding fillers for CENTER zone
        # (in case message is short)
        # ..............................................................

        # generate a '$__centerpadding' long empty string
        __paddingcenter="$(head -c $__centerpadding < /dev/zero | tr '\0' ' ')"


        __msg="$__mystring"
        __strlen="${#__mystring}"

        if [ $__strlen -gt $__remainmain ]; then
        # STRING TOO LONG ?

          # TRIM IT !
          __msg="${__msg:0:$(($__remainmain - 1 - $__lenTrunc))}""$__truncatedsymbol"

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

        #TODO: REMOVEME !!!
        tput cup $(($firstL )) $(($firstC ));
        printf "%s" "${__NN_}${__leftstr}${__centerstr}${__rightstr}${__NN_}";


        __underLiner="$(head -c $ncol < /dev/zero | tr '\0' '▔')"
        printf "\n%s" "${__NN_}${__underLiner}${__NN_}";

      }
#▶▷▸▹►▻◀◁◂◃◄◅◼█⌫◢◣◤◥  ⮀ ⮂ ⮁ ⮃

      tput rc;
      #echo "stty-size=$(stty size) - nlines=$nlines ($(tput lines)) - ncol=$ncol ($(tput cols)) - firstL=$firstL - firstC=$firstC - resLength=$resLength - stripansi=$stripansi - menuBorder=["$menuBorder"]"
    fi;
    #echo "nlines=$nlines - ncol=$ncol - firstL=$firstL - firstC=$firstC - resLength=$resLength - stripansi=$stripansi - menuBorder=["$menuBorder"]"
    #stty size
  }

__infobar 10 "I'm so glad you decided to come and try my new tool, it makes me feel so good i could dance and as a matter of fact i just will, just watch. Hey what did you think ? wasn't that awesome ? no ? I think so i embrass this way of dancing i'm so cooooooooooooooooooooooooooooooooooooooool" 0 "" "GITAFUKA IS MY BERST FUCKING FRIEND" 4
sleep .5
__infobar 11 " essai 3" 0 "" "GIT THE MOTHERFUCKER" 1
sleep .5
__infobar 12 " essai 3" 0 "" "GIT" 2
sleep .5
__infobar 13 " essai 3" 0 "" "GIT" 3
sleep .5
__infobar 14 " essai 3" 0 "" "GIT" 4

