#!/usr/bin/env ruby

timestamp = Time.now.strftime("%Y/%m/%d-%H:%M:%S")

shell_content =<<SHELL
  git_path=$(which git)
  cd /home/work/solife
  ${git_path} init
  ${git_path} add -A .
  ${git_path} commit -a -m "auto commit - #{timestamp}"
  ${git_path} push origin master -f
SHELL

system(shell_content)
