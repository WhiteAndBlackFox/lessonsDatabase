#/bin/bash

# Глобальные переменные
nameDatabase='example'
toDatabase='sample'
dirBackup=/home/backup/

if [ "$(whoami)" == "root" ] ; then
	# Проверяем существование директории для бекапов и можно ли туда писать
	if [[ ! -d $dirBackup ]]; then
		mkdir $dirBackup
	fi

	find $dirBackup -type f -name "*.sql.gz" -mtime +30 -delete

	mysqldump $nameDatabase | gzip -9 -c | cat > $dirBackup$nameDatabase_$(date +%Y-%m-%d-%H.%M.%S).sql.gz

	mysql -e "DROP DATABASE IF EXISTS $toDatabase; CREATE DATABASE $toDatabase;"
	gunzip < $dirBackup$nameDatabase_$(date +%Y-%m-%d-%H.%M.%S).sql.gz | mysql $toDatabase
else
	echo "Запустите с правами root или с правами sudo!"
fi
