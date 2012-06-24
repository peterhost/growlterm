growlterm
=========

growl-like notifications for your terminal

![Growl-like notifications for your Terminal](https://github.com/peterhost/growlterm/raw/master/img/growl-terminal.png)

##Installation

Just copy the `growlterm`script somewhere and source it in your
`.bashrc` (didn't test other shells for now). It should work out of the
box.

    $ . growlterm
    $ growlterm --message "hey there, dinner's ready ! " -from "your (Girl/Boy)friend"

Customizable Theme examples can be found in the `Theme` directory, where
you can modify quite anything relating to the appearance og Growlterm's
messages

To make growlterm automatically use your `theme`, best option is to
source it prior to sourcing `grouwlterm`

    $ . mytheme
    $ . growlterm

##Usage

    $ growlterm -h

![Growlterm Documentation](https://github.com/peterhost/growlterm/raw/master/img/growlterm-help.png)

## Dependancies

the `striptansi` functionality is only functional if `Perl` is
installed on your system (and if it's not, WTF is it you're developing
on ?? ;+)

It's enabled by default.

You can disable it by passing the command-line switch

    --nostripansi

What it does is strip the message passed to growlterm of any fancy ANSI
escape sequences. In case you don't control the message's source, it can
be handy.

As we parse the string's length to display the message, the ANSI escape
sequences count as characters and bork the output and menu box. If
you're certain your `--message` does not contain any of these, you can
safely use the `--nostripansi` switch.




# Additional scripts (you could even use them!)

add 2 scripts to define TERM safe color variables : `safetermcolors8.sh`
and `safetermcolors-addit-256.sh`

##`safetermcolors-addit-256.sh`

In a fancy mood ? add custom variables for all 256 color range
(foreground and background) in a safe (*in terms of `terminfo`*) way



![Color Variable Names](https://github.com/peterhost/bash-tidbits/raw/master/color/img/256colors.png)

Access a color with the following naming convention :

>Foreground Colors

    # $__INTEGER_
    #
    # for FOREGROUNDcolor 234
    echo $__234_"my message"

>Background Colors

    #  $__BGinteger_
    #
    #  for BACKGROUND COLOR 123
    echo $__BG123_"my message"

##`safetermcolors8.sh`

safely (*in terms on `terminfo`*) defines the 001-015 color range, which
exist on any TERM which has more than 2 colors capacity, plus modifiers
(underline, reset, bold, ...) (also works on TERMS which don't by
degrading quietly and still provide modifier styles (underline & such)


###NOta Bene

sourcing this script exports the aditional variable

    export \_\_TPUT_COLORS_DEFINED="true"

so that you can check later on that it's already done


###more info

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
| :--------------------------------------- | ---------------------- | ------------------------------------: |
| MODIFIERS                                |
| Variable NAME                            | equivalent ANSI escape | Description                           |
|                                          | ATTR   FG   BG         |                                       |
| \_\_NN\_                                    | \[ 0m                  | RESET ALL attributes                  |
| STYLES                                   |
| \_\_EM\_                                    | \[ 1m                  | BEGIN DOUBLE INTENSITY (bold) mode    |
| \_\_DM\_                                    | \[ 2m                  | BEGIN HALF INTENSITY    (dim) mode    |
| \_\_UN\_                                    | \[ 4m                  | BEGIN UNDESCORE  (underlined) mode    |
| \_\_BL\_                                    | \[ 5m                  | BEGIN BLINKING                mode    |
| \_\_RV\_                                    | \[ 7m                  | BEGIN REVERSE VIDEO (reverse) mode    |
| \_\_SO\_                                    | ?\[ 7m                 | BEGIN STANDOUT      (reverse) mode    |
| \_\_IN\_                                    | \[ 8m                  | BEGIN INVISIBLE               mode    |
| \_\_DEL\_                                   |                        | MOVE cursor LEFT one space            |
| \_\_SOQ\_                                   | ?\[ 27m                | END   STANDOUT      (reverse) mode    |
| \_\_UNQ\_                                   | \[ 24m                 | END   UNDESCORE  (underlined) mode    |
| DEFAULT SYSTEM COLORS                    |
| <Foreground>                             |
| \_\_K\_                                     | \[       0m            | SET   FG color to BLACK               |
| \_\_R\_                                     | \[       1m            | SET   FG color to RED                 |
| \_\_G\_                                     | \[       2m            | SET   FG color to GREEN               |
| \_\_Y\_                                     | \[       3m            | SET   FG color to YELLOW              |
| \_\_B\_                                     | \[       4m            | SET   FG color to BLUE                |
| \_\_M\_                                     | \[       5m            | SET   FG color to MAGENTA             |
| \_\_C\_                                     | \[       6m            | SET   FG color to CYAN                |
| \_\_W\_                                     | \[       7m            | SET   FG color to WHITE               |
| <Backgound>                              |
| \_\_BGK\_                                   | \[       0m            | SET   BG color to BLACK               |
| \_\_BGR\_                                   | \[       1m            | SET   BG color to RED                 |
| \_\_BGG\_                                   | \[       2m            | SET   BG color to GREEN               |
| \_\_BGY\_                                   | \[       3m            | SET   BG color to YELLOW              |
| \_\_BGB\_                                   | \[       4m            | SET   BG color to BLUE                |
| \_\_BGM\_                                   | \[       5m            | SET   BG color to MAGENTA             |
| \_\_BGC\_                                   | \[       6m            | SET   BG color to CYAN                |
| \_\_BGW\_                                   | \[       7m            | SET   BG color to WHITE               |
| <reset>                                  |
| \_\_NF\_                                    | \[       39m           | RESET FG color to term's default      |
| \_\_NG\_                                    | \[             49m     | RESET BG color to term's default      |
| \_\_NFG\_                                   | \[       39;   49m     | RESET FG & BG color to term's default |
| PSOEUDO(BOLD) COLORS                     |
| <Foreground-bold>                        |
| \_\_EMK\_                                   | \[ 1;    20m           | SET   FG color to BOLD BLACK          |
| \_\_EMR\_                                   | \[ 1;    21m           | SET   FG color to BOLD RED            |
| \_\_EMG\_                                   | \[ 1;    22m           | SET   FG color to BOLD GREEN          |
| \_\_EMY\_                                   | \[ 1;    23m           | SET   FG color to BOLD YELLOW         |
| \_\_EMB\_                                   | \[ 1;    24m           | SET   FG color to BOLD BLUE           |
| \_\_EMM\_                                   | \[ 1;    25m           | SET   FG color to BOLD MAGENTA        |
| \_\_EMC\_                                   | \[ 1;    26m           | SET   FG color to BOLD CYAN           |
| \_\_EMW\_                                   | \[ 1;    27m           | SET   FG color to BOLD RED            |
| MISC (non color)                         |
| \_\_NL\_   most compatible NEWLINE ever     |

