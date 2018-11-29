##
## Slides
## ------
##

slides: yarn.lock ## Démarrer la présentation, avec make slides s=slides/*.md (remplacer * par le nom du fichier)
	cp $(s) slides.md && yarn start

update_slides: yarn.lock ## mets à jour la présentation (à partir de slides.md modifié), avec make slides s=slides/*.md (remplacer * par le nom du fichier)
	cp slides.md $(s)

.PHONY: slides update_slides

yarn.lock: package.json
	yarn

.DEFAULT_GOAL := help
help:
	@grep -E '(^[0-9a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'
.PHONY: help