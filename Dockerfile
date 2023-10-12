FROM node:18.18.0
ADD http://worldtimeapi.org/api/ip /time.tmp
RUN apt-get update
RUN apt-get install -y nginx 
RUN apt-get install -y openssh-client
RUN  mkdir -m 700 /root/.ssh

# Save ssh key
ARG SSH_PRIVATE_KEY
RUN echo "$SSH_PRIVATE_KEY" | base64 -d > /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa
RUN cat /root/.ssh/id_rsa
RUN touch -m 600 /root/.ssh/known_hosts
RUN echo "Host *\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

# No cache
WORKDIR /app
RUN --mount=type=ssh git clone ssh://.git ./
#RUN rm -rf /root/.ssh/

#RUN cp ./nginx/nginx.conf /etc/nginx/conf.d/nginx.conf
#COPY . .
#RUN cd server && npm install
#RUN npm install
#RUN npm run build-offline
#COPY . /var/www

CMD ["tail", "-f", "/dev/null"]