growlterm
=========

growl-like notifications for your terminal

![Growl-like notifications for your Terminal](https://github.com/peterhost/growlterm/raw/master/img/growl-terminal.png)
![Growl-like notifications for your Terminal](https://github.com/peterhost/growlterm/raw/master/img/growlterm-info.png)
![Growl-like notifications for your Terminal](https://github.com/peterhost/growlterm/raw/master/img/growlterm-warning.png)
![Growl-like notifications for your Terminal](https://github.com/peterhost/growlterm/raw/master/img/growlterm-error.png)


##Idea

* Is not a new one.
* Graphic design of top statusbar shamelessly duplicates (or attempts to) 
  copy **Kim Silkebækken**'s awesome [Vim-Powerline](https://github.com/Lokaltog/vim-powerline) 
  plugin for `Vim`.
* Is something I've used for 2 years on my `GIT for bash prompt` plugin (called
  [bash-tartify](https://github.com/peterhost/bash-tartify), go check it out, it's showing
  in the screen captures below) :
     * keep some infos in the prompt
     * display parts of the prompt somewhere else on the screen (prefered by 
       yours truly being "right edge of terminal, same line as prompt)
     * by so doing, never Fuck your Prompt up
     * adapt to 2liners or 3liners prompts
* I've externalised that part from the [bash-tartify](https://github.com/peterhost/bash-tartify)
  Plugin, did a lot of reworking and added
  my clone for Bash of `Vim-Powerline`, as a Handy notification
  statusbar.

##Installation

Just copy the `growlterm`script somewhere and source it in your
`.bashrc` (didn't test other shells for now). It should work out of the
box.,bv

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


##Examples

###Background Job inside your BASHRC

####1. Old Way
> Notify me on job end (usefull at shell-loading time)

> Note the >/dev/null 2>&1, a poor man's attempt to quiet down the
background job on error. Result is, some time later...

    . mytheme
    . growlterm

    # (...)

    # UPDATE RUBYGEMS IN THE BACKGROUND, USUAL WAY
    $ rvm rubygems current >/dev/null 2>&1 &
    [1] 65272
    $ ls
    README.md colorscripts growlterm.sh img themes
    #
    # Some Time Later
    # 
    $ ls
    [1]+ Done rvm rubygems current > /dev/null 2>&1
    README.md colorscripts growlterm.sh img themes

* It does only quiet down STDIN/STDOUT output for background job
* You still get these notifications amidst your prompt when job
terminates

####2. Entomb/Burry it all

    . mytheme
    . growlterm

    # (...)

    # UPDATE RUBYGEMS IN THE BACKGROUND, FUCK-OFF WAY
    $ (rvm rubygems current &) >/dev/null 2>&1
    $ ls
    README.md colorscripts growlterm.sh img themes
    #
    # Some Time Later
    # 
    $ ls
    README.md colorscripts growlterm.sh img themes

* No notification at all AT ALL

####3. New Way


    . mytheme
    . growlterm

    # (...)

    #UPDATE RUBYGEMS
    (
      # Bail if another process is already updationg HOMEBREW
      [ -z "$(ps auxw | grep -v grep | grep -i 'brew update')" ] && {

        brew update >/dev/null 2>&1  && { 
          growlterm -i 1 -m "homebrew updated" -f "HOMEBREW" -u
        } || {
          growlterm -i 3 -m "error updating homebrew (maybe not installed ?)" -f  "HOMEBREW" -u
        } &

      } || growlterm -i 2 -m "homebrew already being updated by another process... Aborting" -f  "HOMEBREW" -u
    )


* you still get notified
* but not under your cursor
* It's so Geeky it almost makes you cry

###Inception : subshell inside a subshell inside a ...

> If you wish to use `growlterm` for background Job notifications inside your
> own scripts, either `source` growlterm inside your script, or in your
> `.bashrc`, replace :

    . mytheme
    . growlterm

    # (...)

with

    . mytheme
    . growlterm
    export -f __growltermUsage; export -f __growltermHelpmsg;
    export -f __growltermShortUsage; export -f __growltermVersion
    export -f __growltermParseOpts; export -f __growltermAdditLines
    export -f __growltermDefaultTheme; # or yours
    export -f growlterm

    # (...)


## Drawbacks

Major drawback is that these messages pollute your screen. They override
whatever was under them before they popped out. If you wish to minimize
this effect, you can use growlterm with option :

    --position 1 (or2 or 3)
    --position 0

I didn't find any satisfying solution for this problem :

>1) it's easy enough to save the TERMINAL window's state, print something
  somewhere, then erase it by restoring the TERMINAL window's state

    tput sc; # Save current cursor position
    # do things
    tput rc; # Restore to saved state

>2) Only this affects the whole screen, and if you wish to leave
  the message on screen long enough for the user to read it,then erase
  it, then the TERMINAL window's state most probably has changed
  (or you hit enter) and the `tput rc` fucks up. Terminals are not
  `POST PC ERA` devices ^^

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


##TODO

* make it ZSH compliant (be my guest !)

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


###Variable List

####RESETS
| Variable NAME                            | equivalent ANSI escape | Description                           |
|                                          | ATTR   FG   BG         |                                       |
| :--------------------------------------- | ---------------------- | ------------------------------------: |
| \_\_NN\_                                 | \[ 0m                  | RESET ALL attributes                  |
| \_\_NF\_                                 | \[       39m           | RESET FG color to term's default      |
| \_\_NG\_                                 | \[             49m     | RESET BG color to term's default      |
| \_\_NFG\_                                | \[       39;   49m     | RESET FG & BG color to term's default |

####STYLES

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

####DEFAULT SYSTEM COLORS : FOREGROUND

| Variable NAME                            | equivalent ANSI escape | Description                           |
|                                          | ATTR   FG   BG         |                                       |
| :--------------------------------------- | ---------------------- | ------------------------------------: |
| \_\_K\_                                  | \[       0m            | SET   FG color to BLACK               |
| \_\_R\_                                  | \[       1m            | SET   FG color to RED                 |
| \_\_G\_                                  | \[       2m            | SET   FG color to GREEN               |
| \_\_Y\_                                  | \[       3m            | SET   FG color to YELLOW              |
| \_\_B\_                                  | \[       4m            | SET   FG color to BLUE                |
| \_\_M\_                                  | \[       5m            | SET   FG color to MAGENTA             |
| \_\_C\_                                  | \[       6m            | SET   FG color to CYAN                |
| \_\_W\_                                  | \[       7m            | SET   FG color to WHITE               |

####DEFAULT SYSTEM COLORS : FOREGROUND

| Variable NAME                            | equivalent ANSI escape | Description                           |
|                                          | ATTR   FG   BG         |                                       |
| :--------------------------------------- | ---------------------- | ------------------------------------: |
| \_\_BGK\_                                | \[       0m            | SET   BG color to BLACK               |
| \_\_BGR\_                                | \[       1m            | SET   BG color to RED                 |
| \_\_BGG\_                                | \[       2m            | SET   BG color to GREEN               |
| \_\_BGY\_                                | \[       3m            | SET   BG color to YELLOW              |
| \_\_BGB\_                                | \[       4m            | SET   BG color to BLUE                |
| \_\_BGM\_                                | \[       5m            | SET   BG color to MAGENTA             |
| \_\_BGC\_                                | \[       6m            | SET   BG color to CYAN                |
| \_\_BGW\_                                | \[       7m            | SET   BG color to WHITE               |

####PSEUDO BOLD FOREGROUND COLORS

| Variable NAME                            | equivalent ANSI escape | Description                           |
|                                          | ATTR   FG   BG         |                                       |
| :--------------------------------------- | ---------------------- | ------------------------------------: |
| \_\_EMK\_                                | \[ 1;    20m           | SET   FG color to BOLD BLACK          |
| \_\_EMR\_                                | \[ 1;    21m           | SET   FG color to BOLD RED            |
| \_\_EMG\_                                | \[ 1;    22m           | SET   FG color to BOLD GREEN          |
| \_\_EMY\_                                | \[ 1;    23m           | SET   FG color to BOLD YELLOW         |
| \_\_EMB\_                                | \[ 1;    24m           | SET   FG color to BOLD BLUE           |
| \_\_EMM\_                                | \[ 1;    25m           | SET   FG color to BOLD MAGENTA        |
| \_\_EMC\_                                | \[ 1;    26m           | SET   FG color to BOLD CYAN           |
| \_\_EMW\_                                | \[ 1;    27m           | SET   FG color to BOLD RED            |

####NEWLINE

| Variable NAME                            | Description                           |
|                                          |                                       |
| :--------------------------------------- | ------------------------------------: |
| \_\_NL\_                                 | most compatible NEWLINE ever          |

