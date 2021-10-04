FROM node:12 AS build
WORKDIR /src
ADD . ./
RUN npm install &&\
    npm run build

FROM nginx:1.21
WORKDIR /app
COPY --from=build /src/build/ ./
RUN chmod 775 -R ./
ADD nginx.conf /etc/nginx/nginx.conf

ENV DB_HOST db
ENV DB_PORT 3306
ENV DB_NAME urlshortener
ENV DB_USER urlshortener
ENV DB_PASS urlshortener
