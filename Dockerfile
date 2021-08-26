FROM node:alpine as build

WORKDIR /usr/app

COPY ./package.json ./

RUN npm install --legacy-peer-deps && \
    npm install -g @angular/cli
    
COPY . .


RUN ng build --prod
FROM nginx:1.17.1-alpine
EXPOSE 80
COPY --from=build /usr/app/dist/my-app /usr/share/nginx/html

