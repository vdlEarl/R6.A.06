
FROM node:14

WORKDIR /usr/src/app


RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list \
 && sed -i 's|http://security.debian.org/debian-security|http://archive.debian.org/debian-security|g' /etc/apt/sources.list \
 && sed -i '/buster-updates/d' /etc/apt/sources.list \
 && apt-get update \
 && apt-get install -y python2 python-pip \
 && rm -rf /var/lib/apt/lists/*

RUN pip install psycopg2-binary


COPY package.json package.json
COPY package-lock.json package-lock.json


RUN npm install

COPY . .

EXPOSE 5001

# Command to run the app when the container starts
CMD [ "node", "index.js" ]
