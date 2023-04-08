FROM nginx:latest

RUN apt-get update && \
    apt-get install -y git vim

RUN git clone https://github.com/nowthis/sankeymatic.git /usr/share/nginx/sankeymatic

RUN rm /etc/nginx/conf.d/default.conf

COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
