FROM node:20 as build

WORKDIR /app

COPY . .

RUN npm install -g @angular/cli
RUN npm install

RUN npx ng build --configuration production

FROM nginx:alpine

# 🔥 CLEAN OLD FILES
RUN rm -rf /usr/share/nginx/html/*

# 🔥 COPY ONLY BROWSER BUILD
COPY --from=build /app/dist/Partice-Frontend/browser/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
