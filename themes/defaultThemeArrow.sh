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
export __customGrowltermThemeSet="TRUE"
