FROM node:16 as builder

# RUN apk add chromium

# # Installs latest Chromium package
# RUN apk update && apk upgrade && \
#     echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
#     echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
#     apk add --no-cache bash chromium@edge nss@edge

# # This line is to tell karma-chrome-launcher where
# # chromium was downloaded and installed to.
# ENV CHROME_BIN /usr/bin/chromium-browser

# # Tell Puppeteer to skip installing Chrome.
# # We'll be using the installed package instead.
# ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

# Install Chrome WebDriver
# RUN CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
#     mkdir -p /opt/chromedriver-$CHROMEDRIVER_VERSION && \
#     curl -sS -o /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
#     unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver-$CHROMEDRIVER_VERSION && \
#     rm /tmp/chromedriver_linux64.zip && \
#     chmod +x /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver && \
#     ln -fs /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver /usr/local/bin/chromedriver

# # Install Google Chrome
# RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
#     echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
#     apt-get -yqq update && \
#     apt-get -yqq install google-chrome-stable && \
#     rm -rf /var/lib/apt/lists/*

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get update
RUN apt --fix-broken install
RUN apt-get install google-chrome-stable -y

WORKDIR /app

ENV CHROME_BIN /usr/bin/chromium-browser

COPY . .

# RUN npm install --global cross-env

# RUN npm install cross-env

# RUN "dev": "cross-env NODE_OPTIONS='--openssl-legacy-provider' next dev"

# RUN npm run dev

RUN npm install

# RUN SET NODE_OPTIONS=--openssl-legacy-provider

RUN npm run test