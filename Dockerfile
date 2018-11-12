FROM debian:stretch

# Install common system tools
RUN apt-get update \
    && apt-get install -y \
        ca-certificates \
        gnupg \
        curl \
        wget \
        rsync \
        sudo \
        git \
        bzip2 \
        unzip \
    && rm -rf /var/lib/apt/lists/*

# Install nodejs to compile the frontend
RUN curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*
# Allow npm scripts to run as root user
ENV npm_config_unsafe_perm 1
# Upgrade npm
RUN npm i npm@6.4.1 -g

# Add dependencies for FE build
RUN apt-get update \
    && apt-get install -y \
        libfreetype6 \
        libfontconfig \
    && rm -rf /var/lib/apt/lists/*

RUN npm install --global node-sass
RUN npm install --global gulp-cli
RUN npm install --global requirejs
RUN npm install --global phantomjs-prebuilt

WORKDIR /

ENTRYPOINT ["gulp"]
CMD ["--version"]
