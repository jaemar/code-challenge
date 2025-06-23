FROM node:20

WORKDIR /amenitiz_frontend

COPY ./frontend/package*.json ./
RUN npm install

COPY ./frontend .

EXPOSE 3000