FROM node:20

WORKDIR /amenitiz_frontend

COPY ./frontend/package*.json ./
RUN npm install
RUN npm install -g serve

COPY ./frontend .

EXPOSE 3000

CMD ["serve", "-s", "build", "-l", "3000"]