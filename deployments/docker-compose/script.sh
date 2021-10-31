#!/bin/bash
docker-compose -p "url-shortener" up -d
docker-compose -p "url-shortener" logs -f
docker-compose -p "url-shortener" down
docker-compose -p "url-shortener" build
docker-compose -p "url-shortener" push