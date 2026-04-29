FROM node:20 as build

WORKDIR /app

RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf

COPY . .

RUN npm install -g @angular/cli --registry=https://registry.npmjs.org/
RUN npm install

RUN npx ng build --configuration production

FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

COPY --from=build /app/dist/Partice-Frontend/browser/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
