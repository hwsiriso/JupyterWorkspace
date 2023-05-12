#!/usr/bin/env sh

[ -L ./docker-compose.yml ] && rm ./docker-compose.yml
[ -L ./Dockerfile ] && rm ./Dockerfile

if [ -n "$(which nvidia-smi)" ]; then
  ln -sf ./docker-compose.gpu.yml ./docker-compose.yml
  ln -sf ./Dockerfile.gpu ./Dockerfile
else
  ln -sf ./docker-compose.nogpu.yml ./docker-compose.yml
  ln -sf ./Dockerfile.nogpu ./Dockerfile
fi

# cat docker-compose.base.yml | tr '\n' '\f' | sed -E -e "s/#__IF_NO_GPU__([^#]*)#__NOT_NO_GPU__([^#]*)#__FI_NO_GPU__/\\$NO_GPU/g" | tr '\f' '\n' > docker-compose.yml
