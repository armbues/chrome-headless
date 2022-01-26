# Base image
FROM amd64/ubuntu:latest

# Update & upgrade system
RUN apt-get update && \
	apt-get upgrade -yq

# Define image locale & timezone
ENV TZ=Universal
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages
RUN apt-get install -yq wget ca-certificates gnupg

# Install Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
	sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
	apt-get update && \
	apt-get install -yq google-chrome-stable

# Install international fonts
RUN apt-get install -yq --no-install-recommends \
	fontconfig \
	fonts-arphic-ukai \
	fonts-arphic-uming \
	fonts-ipafont-mincho \
	fonts-unfonts-core  \
	fonts-ipafont-gothic \
	fonts-wqy-zenhei \
	fonts-thai-tlwg \
	fonts-kacst \
	fonts-symbola \
	fonts-noto \
	fonts-freefont-ttf

# Installation cleanup
RUN apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create directories
RUN mkdir /data && \
	mkdir /profile
WORKDIR /data

# Add chrome user
RUN addgroup chrome && \
	useradd -m -g chrome chrome
USER chrome

# Expose Chrome remote debugging port
EXPOSE 9222

ENTRYPOINT ["google-chrome", "--headless", "--disable-gpu", "--profile-directory=/profile"]