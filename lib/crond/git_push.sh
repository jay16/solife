timestamp=$(date +"%Y/%m/%d-%H:%M:%S")
date_of_today=$(date +"%Y%m%d")
db_tar_name="solife.db.bak.at.${date_of_today}.tar.gz"

#========================================================
#bak solife's db
#========================================================
cd /home/work/solife/db/db.bak

mysqldump -uroot -piamjay solife_development > solife.db.bak.sql
tar -czvf ${db_tar_name} solife.db.bak.sql
rm -f solife.db.bak.sql

#chk old bak file and del
one_month_ago=$(date -d "-1 month" +%Y%m%d)
old_tar_file="solife.db.bak.at.${one_month_ago}.tar.gz"

#bak today's db successfully and exist the old db file
#then delete it
if [ -f "${db_tar_name}" ] && [ -f "${old_tar_file}" ];
then
    rm -f ${old_tar_file}
fi

#========================================================
#push solife's code to githup 
#========================================================
cd /home/work/solife
/usr/local/bin/git init
/usr/local/bin/git add -A .
/usr/local/bin/git commit -a -m "auto commit - ${timestamp}"
/usr/local/bin/git push origin master -f
