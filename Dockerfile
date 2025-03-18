FROM nvidia/cuda:11.7.1-cudnn8-runtime-ubuntu20.04

RUN apt update
RUN apt install -y wget

RUN wget -qO- https://astral.sh/uv/install.sh | sh

RUN echo '. "$HOME/.local/bin/env"' >> $HOME/.bashrc

RUN . $HOME/.local/bin/env && uvx -p 3.11 whisperx --help

RUN apt install -y ffmpeg

RUN echo "#!/bin/bash\n. "$HOME/.local/bin/env"\nuvx -p 3.11 whisperx \"\$@\"" > /entrypoint.sh && chmod +x /entrypoint.sh

VOLUME [ "/root/.cache/whisper" ]

WORKDIR /whisperX
ENTRYPOINT [ "/entrypoint.sh" ]