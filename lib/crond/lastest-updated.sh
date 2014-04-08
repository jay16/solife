#!/bin/bash
#说明:
#查看mvc最近文件修改时间


solife=/home/work/solife
tmp=${solife}/tmp/lastest-updated.txt
current_year=$(date +%Y)

true > ${tmp}
types=(model view controller)
for type in "${types[@]}"
do
    app="${solife}/app/${type}s"
    lastest=$(ls -ltR ${app} | grep .rb |  head -n 1 | awk '{print $6 " " $7 }')
    lastest="${current_year}-${lastest}"
    echo "${type}: ${lastest}" && echo ${lastest} >> ${tmp}
done

