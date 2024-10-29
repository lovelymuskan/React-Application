FROM node:alpine AS build
WORKDIR /opt/app
COPY package.json ./
RUN npm install -g yarn
RUN yarn install
COPY . ./
RUN yarn build

FROM node:alpine
WORKDIR /opt/app
COPY --from=build /opt/app/build ./build
# Install serve locally
RUN npm install serve
EXPOSE 3000
CMD ["npx", "serve", "-s", "build", "-l", "3000"]
