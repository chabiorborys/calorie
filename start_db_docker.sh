#!/bin/sh
sudo docker run --rm --net host --name some-postgres -p5432:5432 -e POSTGRES_PASSWORD=coderslab -e POSTGRES_DB=calorie_dev postgres:13-alpine
