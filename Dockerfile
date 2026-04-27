FROM node:20 as build

WORKDIR /app

# ADD THIS LINE 👇
RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf

COPY . .

# Install Angular CLI
RUN npm install -g @angular/cli

# Install dependencies
RUN npm install

# Build Angular app
RUN npx ng build --configuration production

FROM nginx:alpine

COPY --from=build /app/dist/Partice-Frontend/browser/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
