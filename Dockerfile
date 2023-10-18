# Stage 1: Build React.js app
FROM node:14 AS build
WORKDIR /app
COPY ./client /app
RUN npm install && npm run build

# Stage 2: Build Node.js server
FROM node:14 AS server
WORKDIR /app
COPY ./server /app
RUN npm install

# Combine both stages
FROM node:14
WORKDIR /app
COPY --from=build /app/build ./client/build
COPY --from=server /app ./

# Expose the port your Node.js server uses
EXPOSE 5000

# Start the server
CMD ["node", "index.js"]
