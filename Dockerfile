FROM node:14.3.0

WORKDIR /app

COPY ./package.json .
COPY ./yarn.lock .
RUN yarn
COPY ./tests .

ENTRYPOINT [ "yarn" ]