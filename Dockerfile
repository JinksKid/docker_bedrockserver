FROM ubuntu
ENV container docker

# set minecraft world name and port and apk filename
ENV WORLD='default'
ENV MCPORT=19132
ARG INSTALLERURL=https://minecraft.azureedge.net/bin-linux/bedrock-server-1.7.0.13.zip
ENV MCSERVERFOLDER=/srv/bedrockserver

EXPOSE $MCPORT

# install dependencies
RUN apt-get update
RUN apt-get install -y curl unzip

# create folders for minecraft resources
VOLUME $MCSERVERFOLDER/worlds

# install minecraft
RUN curl $INSTALLERURL --output minecraft.zip
RUN unzip minecraft.zip -d $MCSERVERFOLDER
RUN rm minecraft.zip

# copy over server properties template
COPY server.properties.template $MCSERVERFOLDER/server.properties.template

# set up startup script
COPY startup.sh /srv/bedrockserver/
RUN chmod +x /srv/bedrockserver/startup.sh
ENTRYPOINT ["/srv/bedrockserver/startup.sh"]