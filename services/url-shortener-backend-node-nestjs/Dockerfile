FROM node:12
WORKDIR /src
ADD . ./
RUN npm install &&\
    npm run build
ENTRYPOINT node dist/main.js

ENV DB_HOST db
ENV DB_PORT 3306
ENV DB_NAME urlshortener
ENV DB_USER urlshortener
ENV DB_PASS urlshortener
