# Use an official Node.js runtime as a parent image
FROM node:12-alpine

# Set the working directory to /app
WORKDIR /app

# Copy the package.json and package-lock.json files to /app
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application code to /app
COPY . .

# Build the production version of the app
RUN npm run build

# Use an official Nginx image as a parent image
FROM nginx:alpine

# Copy the built app from the previous stage to the nginx public directory
COPY --from=0 /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx when the container is started
CMD ["nginx", "-g", "daemon off;"]

