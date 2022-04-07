.PHONY: today yesterday history

URL=https://arquivos.b3.com.br/apinegocios/tickercsv

DATA=data

TODAY=$(shell date '+%Y-%m-%d')
YESTERDAY=$(shell date --date 'yesterday' '+%Y-%m-%d')


today:
	curl -L $(URL)/$(TODAY) -o $(DATA)/$(TODAY).zip


yesterday:
	curl -L $(URL)/$(YESTERDAY) -o $(DATA)/$(YESTERDAY).zip


history:
	seq 0 14 \
		| xargs -I@ date --date '@ days ago' '+%Y-%m-%d' \
		| xargs -I@ -t -P8 curl -Ls $(URL)/@ -o $(DATA)/@.zip
	find $(DATA) -type f -size 0 -delete
