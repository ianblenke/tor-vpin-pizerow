all: files/etc/dropbear/authorized_keys
	./paged_execute.sh docker-compose build tor-vpin-pizerow
	docker-compose up -d --force-recreate tor-vpin-pizerow
	( docker exec tor-vpin-pizerow find /imagebuilder/ -name '*.img' ; \
	  docker exec tor-vpin-pizerow find /imagebuilder/ -name '*.img.gz' ) | while read line ; do \
		docker cp tor-vpin-pizerow:$$line . ; \
	done
	docker-compose down || true

files/etc/dropbear/authorized_keys:
	mkdir -p `dirname $@`
	for githubuser in ianblenke tabinfl ahernmikej camswx Shad0wSt4R ; do \
		curl -sL https://github.com/$${githubuser}.keys ; \
	done > $@
	chmod 600 $@
