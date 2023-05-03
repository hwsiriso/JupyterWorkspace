#!/usr/bin/env sh

[ -L ./docker-compose.yml ] && rm ./docker-compose.yml

if [ -n "$(which nvidia-ctk)" ]; then
    ln -sf ./docker-compose.gpu.yml ./docker-compose.yml
else
    ln -sf ./docker-compose.nogpu.yml ./docker-compose.yml
fi

# cat docker-compose.base.yml | tr '\n' '\f' | sed -E -e "s/#__IF_NO_GPU__([^#]*)#__NOT_NO_GPU__([^#]*)#__FI_NO_GPU__/\\$NO_GPU/g" | tr '\f' '\n' > docker-compose.yml
