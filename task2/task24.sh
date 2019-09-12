#!/bin/bash

nameDatabase='mysql'
nameTable='help_keyword'
limit=100

mysqldump $nameDatabase --tables $nameTable -w '1 ORDER BY help_keyword_id ASC limit '$limit | gzip -9 -c | cat > $nameDatabase_$nameTable_$(date +%Y-%m-%d-%H.%M.%S).sql.gz
