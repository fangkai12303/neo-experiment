FROM node:17-alpine as build
LABEL name="marvelous"

WORKDIR /app
COPY ./package.json ./package-lock.json ./
RUN npm i
COPY . .
RUN npm run build
COPY ./build/ build/
RUN echo "build finished"

FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
