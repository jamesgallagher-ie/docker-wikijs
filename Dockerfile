FROM node:6.10.0-alpine

# Need git for the npm installations below
RUN apk update && apk add --no-cache git

RUN mkdir /var/www 
WORKDIR /var/www
RUN touch .first-run
RUN npm install wiki.js@latest
RUN npm install
# pm2 will be used to run the configured Wiki.js 
RUN npm install -g pm2

# Can't think of an alternative way of offering first run configuration and then normal running other than 
# using this shell script to alternate between running 'node wiki configure' and a pm 2 command
# Learned a valuable lesson about Docker containers when I tried to do 'node wiki start' - it starts the 
# server in the background and exits ... which causes the container to terminate 

RUN echo -e "#!/bin/sh\nif [ -f /var/www/.first-run ]\nthen\n  node wiki configure\nelse\n  echo 'something else'\nfi \n" > /var/www/start.sh
RUN chmod +x /var/www/start.sh

CMD ["/var/www/start.sh"]

EXPOSE 3000


