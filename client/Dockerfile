# Use Node.js to build the Angular app

FROM node:20 AS build
WORKDIR /app
COPY . .
RUN npm install --legacy-peer-deps && npm run build -- --configuration=production

# Use Nginx to serve the built app
FROM nginx:alpine
COPY --from=build /app/dist/client/browser/. /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
