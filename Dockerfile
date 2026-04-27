FROM node:20 as build

WORKDIR /app

COPY . .

# Install Angular CLI
RUN npm install -g @angular/cli

# Install dependencies
RUN npm install

# Build Angular app
RUN npx ng build --configuration production

FROM nginx:alpine

COPY --from=build /app/dist/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
