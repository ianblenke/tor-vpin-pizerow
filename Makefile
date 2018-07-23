all:
	docker-compose build tor-vpin-pizerow
	docker-compose up -d --force-recreate tor-vpin-pizerow
	docker exec tor-vpin-pizerow bash -c 'find /imagebuilder/build_dir/ -name "*.img" -exec cp {} tor-vpin-pizerow.img \;'
	docker cp tor-vpin-pizerow:/imagebuilder/tor-vpin-pizerow.img tor-vpin-pizerow.img
	docker-compose down
