all: dbuild docker

# specify same name as in paper/Makefile
FILE=pfors

## build locally
local:
	-cd Paper && make pdf sup1 sup2 clean
	-mv Paper/*.pdf ./

## build docker image (requires root access for docker)
dbuild: Dockerfile
	docker build \
    -t $(FILE) .

## run docker image that produces pdf from within docker
docker: dbuild
	docker run \
    --rm \
	--env pdfdocker="true" \
	--env FILE=$(FILE) \
	--volume $(CURDIR):/output \
	$(FILE)
	# mv $(FILE).pdf paper/$(FILE).pdf
