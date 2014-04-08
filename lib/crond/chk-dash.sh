#!/bin/bash
#清理临时文件

root_path=/home/work/solife

for dash in $(ls -AR ${root_path} | grep -E ".*~|.*.swp")
do
  echo ${dash}
  dash_path=$(find ${root_path} -name ${dash} | head -n 1)
  echo ${dash_path}
  rm ${dash_path}
done
