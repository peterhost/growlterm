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

    #UPDATE HOMEBREW
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

## Additional scripts (you could even use them!)

add 2 scripts to define TERM safe color variables : `safetermcolors8.sh`
and `safetermcolors-addit-256.sh`

Source them before yout `theme`file and use fancy variable names for
colors

    . safetermcolors8.sh
    . safetermcolors-addit-256.sh
    . myTheme
    . growlterm

Then you can define colors in your theme with :


    # FOREGROUND color for OPTIONNAL UNDERLINE BAR : ONE COLOR per level of IMPORTANCE
    NO256__COLOR_FG_UNDERLINE_IMPORT_0=$__7_
    NO256__COLOR_FG_UNDERLINE_IMPORT_1=$__7_
    NO256__COLOR_FG_UNDERLINE_IMPORT_2=$__7_
    NO256__COLOR_FG_UNDERLINE_IMPORT_3=$__7_
    NO256__COLOR_FG_UNDERLINE_IMPORT_4=$__7_

         __COLOR_FG_UNDERLINE_IMPORT_0=$__58_
         __COLOR_FG_UNDERLINE_IMPORT_1=$__236_
         __COLOR_FG_UNDERLINE_IMPORT_2=$__60_
         __COLOR_FG_UNDERLINE_IMPORT_3=$__58_
         __COLOR_FG_UNDERLINE_IMPORT_4=$__124_

Instead of :

    # FOREGROUND color for OPTIONNAL UNDERLINE BAR : ONE COLOR per level of IMPORTANCE
    NO256__COLOR_FG_UNDERLINE_IMPORT_0=$( tput setf 7   || tput setaf 7   || : 2>/dev/null )      ;
    NO256__COLOR_FG_UNDERLINE_IMPORT_1=$( tput setf 7   || tput setaf 7   || : 2>/dev/null )      ;
    NO256__COLOR_FG_UNDERLINE_IMPORT_2=$( tput setf 7   || tput setaf 7   || : 2>/dev/null )      ;
    NO256__COLOR_FG_UNDERLINE_IMPORT_3=$( tput setf 7   || tput setaf 7   || : 2>/dev/null )      ;
    NO256__COLOR_FG_UNDERLINE_IMPORT_4=$( tput setf 7   || tput setaf 7   || : 2>/dev/null )      ;

         __COLOR_FG_UNDERLINE_IMPORT_0=$( tput setf 58  || tput setaf 58  || : 2>/dev/null )      ;
         __COLOR_FG_UNDERLINE_IMPORT_1=$( tput setf 236 || tput setaf 236 || : 2>/dev/null )      ;
         __COLOR_FG_UNDERLINE_IMPORT_2=$( tput setf 60  || tput setaf 60  || : 2>/dev/null )      ;
         __COLOR_FG_UNDERLINE_IMPORT_3=$( tput setf 58  || tput setaf 58  || : 2>/dev/null )      ;
         __COLOR_FG_UNDERLINE_IMPORT_4=$( tput setf 124 || tput setaf 124 || : 2>/dev/null )      ;

###`safetermcolors-addit-256.sh`

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

###`safetermcolors8.sh`

safely (*in terms on `terminfo`*) defines the 001-015 color range, which
exist on any TERM which has more than 2 colors capacity, plus modifiers
(underline, reset, bold, ...) (also works on TERMS which don't by
degrading quietly and still provide modifier styles (underline & such)


####NOta Bene

sourcing this script exports the aditional variable

    export __TPUT_COLORS_DEFINED="true"

so that you can check later on that it's already done


####Variable List

#####RESETS
| Variable NAME | tput                  | equivalent ANSI escape | Description                           |
| ------------- | --------------------- | ---------------------- | ------------------------------------- |
|               |                       | ATTR     FG    BG      |                                       |
| \_\_NN\_      | tput sgr0             | \[ 0m                  | RESET ALL attributes                  |
| \_\_NF\_      | tput setf 9 / setaf 9 | \[       39m           | RESET FG color to term's default      |
| \_\_NG\_      | tput setb 9 / setab 9 | \[       ;     49m     | RESET BG color to term's default      |
| \_\_NFG\_     | last 2 combined       | \[       39;   49m     | RESET FG & BG color to term's default |

#####STYLES

| Variable NAME | tput           | equivalent ANSI escape | Description                                                   |
| ------------- | -------------- | ---------------------- | ------------------------------------------------------------- |
|               |                | ATTR   FG   BG         |                                                               |
| \_\_EM\_      | tput bold      | \[ 1m                  | BEGIN DOUBLE INTENSITY (bold) mode                            |
| \_\_DM\_      | tput dim       | \[ 2m                  | BEGIN HALF INTENSITY    (dim) mode                            |
| \_\_UN\_      | tput smul      | \[ 4m                  | BEGIN UNDESCORE  (underlined) mode                            |
| \_\_BL\_      | tput blink     | \[ 5m                  | BEGIN BLINKING                mode                            |
| \_\_RV\_      | tput rev       | \[ 7m                  | BEGIN REVERSE VIDEO (reverse) mode                            |
| \_\_SO\_      | tput smso      | ?\[ 7m                 | BEGIN STANDOUT      (reverse) mode                            |
| \_\_IN\_      | tput invis     | \[ 8m                  | BEGIN INVISIBLE               mode                            |
| \_\_DEL\_     | tput cub1      |                        | MOVE cursor LEFT one space                                    |
| \_\_SOQ\_     | tput rmso      | ?\[ 27m                | END   STANDOUT      (reverse) & DOUBLE INTENSITY (bold) modes |
| \_\_UNQ\_     | tput rmul      | \[ 24m                 | END   UNDESCORE  (underlined) mode                            |

#####DEFAULT SYSTEM COLORS : FOREGROUND

| Variable NAME | tput                | equivalent ANSI escape | Description                |
| ------------- | ------------------- | ---------------------- | -------------------------- |
|               |                     | ATTR     FG   BG       |                            |
| \_\_K\_       | tput (setf/setaf) 0 | \[       0m            | SET   FG color to BLACK    |
| \_\_R\_       | tput (setf/setaf) 1 | \[       1m            | SET   FG color to RED      |
| \_\_G\_       | tput (setf/setaf) 2 | \[       2m            | SET   FG color to GREEN    |
| \_\_Y\_       | tput (setf/setaf) 3 | \[       3m            | SET   FG color to YELLOW   |
| \_\_B\_       | tput (setf/setaf) 4 | \[       4m            | SET   FG color to BLUE     |
| \_\_M\_       | tput (setf/setaf) 5 | \[       5m            | SET   FG color to MAGENTA  |
| \_\_C\_       | tput (setf/setaf) 6 | \[       6m            | SET   FG color to CYAN     |
| \_\_W\_       | tput (setf/setaf) 7 | \[       7m            | SET   FG color to WHITE    |

#####DEFAULT SYSTEM COLORS : FOREGROUND

| Variable NAME  | tput                 | equivalent ANSI escape | Description                           |
| -------------- | -------------------- | ---------------------- | ------------------------------------- |
|                |                      | ATTR     FG   BG       |                                       |
| \_\_BGK\_      | tput  (setb/setab) 0 | \[       ;    0m       | SET   BG color to BLACK               |
| \_\_BGR\_      | tput  (setb/setab) 1 | \[       ;    1m       | SET   BG color to RED                 |
| \_\_BGG\_      | tput  (setb/setab) 2 | \[       ;    2m       | SET   BG color to GREEN               |
| \_\_BGY\_      | tput  (setb/setab) 3 | \[       ;    3m       | SET   BG color to YELLOW              |
| \_\_BGB\_      | tput  (setb/setab) 4 | \[       ;    4m       | SET   BG color to BLUE                |
| \_\_BGM\_      | tput  (setb/setab) 5 | \[       ;    5m       | SET   BG color to MAGENTA             |
| \_\_BGC\_      | tput  (setb/setab) 6 | \[       ;    6m       | SET   BG color to CYAN                |
| \_\_BGW\_      | tput  (setb/setab) 7 | \[       ;    7m       | SET   BG color to WHITE               |

#####PSEUDO BOLD FOREGROUND COLORS

| Variable NAME  | tput               | equivalent ANSI escape | Description                           |
| -------------- | ------------------ | ---------------------- | ------------------------------------- |
|                | tput bold; tput... | ATTR     FG    BG      |                                       |
| \_\_EMK\_      | ...                | \[ 1;    20m           | set   fg color to BOLD BLACK          |
| \_\_EMR\_      | ...                | \[ 1;    21m           | set   fg color to BOLD RED            |
| \_\_EMG\_      | ...                | \[ 1;    22m           | set   fg color to BOLD GREEN          |
| \_\_EMY\_      | ...                | \[ 1;    23m           | set   fg color to BOLD YELLOW         |
| \_\_EMB\_      | ...                | \[ 1;    24m           | set   fg color to BOLD BLUE           |
| \_\_EMM\_      | ...                | \[ 1;    25m           | set   fg color to BOLD MAGENTA        |
| \_\_EMC\_      | ...                | \[ 1;    26m           | set   fg color to BOLD CYAN           |
| \_\_EMW\_      | ...                | \[ 1;    27m           | set   fg color to BOLD RED            |

#####NEWLINE

| Variable NAME  | tput           | Description                           |
| -------------- | -------------- | ------------------------------------- |
| \_\_NL\_       | tput           | most compatible NEWLINE ever          |
