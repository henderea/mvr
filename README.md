# Mvr

a Ruby script that allows you to rename a group of files via regular expression

## Installation

Install it yourself as:

    $ gem install mvr

## Usage

###required parameters:
* match pattern
* replacement pattern (use `\1` for first match, `\2` for second match, and so on)
* filenames

###optional parameters:
* `-e` or `--exclude-extension` to exclude the extension of the file from the pattern matching/replacement
* `-v` or `--override-colors` to override the colors with the ones configured by the [colorconfig][colorconfig] script

###displays:
prints a color-coded list of file names and their replacement names; also asks for confirmation

#####Color Coding:
grey background for no change, red background for conflict

###action:
if you type `y` or `yes` (case insensitive), it will rename the files; anything else will cause it to cancel the operation