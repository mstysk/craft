TARGET=info

.PHONY: composer
composer:
	docker run \
		-v ${PWD}:/var/html/www \
		-v ${PWD}/.data:/tmp \
		-e COMPOSER_CACHE_DIR=/tmp \
		-w /var/html/www/app \
		composer:latest \
		${TARGET}

.PHONY: install
install:
	make composer -e TARGET=install

.PHONY: dump-autoload
dump-autoload:
	make composer -e TARGET=dump-autoload

.PHONY: update
update:
	make composer -e TARGET=update

.PHONY: clean
clean:
	sudo rm -rf app/

.PHONY: create
create:
	make composer -e TARGET="create-project craftcms/craft ./"

.PHOMY: setup
setup:
	make clean
	make create
	docker-compose up -d
	docker-compose exec craft php craft setup
