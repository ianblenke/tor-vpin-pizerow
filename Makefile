all: files/etc/dropbear/authorized_keys
	./paged_execute.sh docker build --tag sofwerx/tor-dfpk-pizerow:latest --cache-from sofwerx/tor-dfpk-pizerow:latest .
	docker-compose up -d --force-recreate tor-dfpk-pizerow
	( docker exec tor-dfpk-pizerow find /imagebuilder/ -name '*.img' ; \
	  docker exec tor-dfpk-pizerow find /imagebuilder/ -name '*.img.gz' ) | while read line ; do \
		docker cp tor-dfpk-pizerow:$$line . ; \
	done
	docker-compose down || true

files/etc/dropbear/authorized_keys:
	mkdir -p `dirname $@`
	for githubuser in ianblenke tabinfl ahernmikej camswx Shad0wSt4R ; do \
		curl -sL https://github.com/$${githubuser}.keys ; \
	done > $@
	chmod 600 $@
