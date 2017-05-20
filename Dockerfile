FROM node:6.10.0-alpine

RUN apk update && apk add --no-cache git
RUN mkdir /var/www 
WORKDIR /var/www
RUN npm install wiki.js@latest
RUN npm install

ENTRYPOINT ["node", "wiki"]

EXPOSE 3000


