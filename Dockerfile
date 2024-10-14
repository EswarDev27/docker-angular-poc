# Use the latest Node.js image as the build environment
FROM node:latest AS build

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Build the Angular app for production
RUN npm run build --prod

# Use the official Nginx image to serve the Angular app
FROM nginx:alpine

# Copy the build output from the 'build' stage to Nginx's default location
COPY --from=build /app/dist/anguler-docker-demo /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
