FROM debian:stable-slim
ARG USER
#ARG PATH_CODE # will use these only when starting the container
#ARG PATH_CONF

RUN apt-get update
RUN apt dist-upgrade -y
# need gpg to install ppa key, curl to fetch keys/yolo-scripts. vim and sensible-utils are just common decency
RUN apt install -y gpg dialog vim sensible-utils curl

# apt-get install -y curl

# Set working directory
WORKDIR /workspace

# Install the Antigravity
#RUN curl -fsSL https://antigravity.google.com/install.sh | bash
#lol. gone are the days of single-use supply-chain attack. now it's persistent:
# RUN mkdir -p /etc/apt/keyrings
# RUN curl -fsSL https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg | gpg --dearmor --yes -o /etc/apt/keyrings/antigravity-repo-key.gpg
# RUN echo "deb [signed-by=/etc/apt/keyrings/antigravity-repo-key.gpg] https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main" > /etc/apt/sources.list.d/antigravity.list
# RUN apt update
# RUN apt install -y antigravity libterm-readline-gnu-perl #low-memory-monitor libarchive13t64 libbpf1 libdw1t64 libqrencode4 libsub-name-perl libbusiness-isbn-perl libmime-base32-perl make debhelper


# set up user and it's home
RUN useradd gcb
RUN mkdir ~gcb
COPY user-home/.[a-zA-Z]* /home/gcb/
RUN chown -R gcb ~gcb

# setup the shared .gemini volume dir, so you keep login/etc between runs
RUN mkdir ~gcb/.gemini; chown -R gcb:root ~gcb/.gemini
VOLUME ["/home/gcb/.gemini"]

# Install the Antigravity CLI
USER gcb
RUN curl -fsSL https://antigravity.google/cli/install.sh | bash
RUN echo 'export PATH="/home/gcb/.local/bin:$PATH"' >> ~/.bashrc
USER root


# clean up
RUN rm -rf /var/lib/apt/lists/*

# entry as user
USER gcb
WORKDIR /home/gcb
CMD ["bash", "--login"]
