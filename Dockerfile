FROM node:22-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY ..
RUN npm run build

FROM nginx:stable-alpine
RUN rm -rf /usr/share/ngix/html/*
COPY --from=builder /app/dist /usr/ashre/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
ENTRYPOINT ["nginx","-g", "daemon off:"]


