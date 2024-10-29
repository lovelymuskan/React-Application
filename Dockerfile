# Stage 1: Build the application
FROM node:alpine AS build
WORKDIR /opt/app

# Copy package.json and package-lock.json for dependency installation
COPY package*.json ./

# Install dependencies only
RUN npm install --production

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Stage 2: Serve the application
FROM node:alpine

# Install 'serve' globally
RUN npm install -g serve

# Set working directory
WORKDIR /opt/app

# Copy built application from the previous stage
COPY --from=build /opt/app/build ./build

# Expose port 3000 for the application
EXPOSE 3000

# Command to run the application
CMD ["serve", "-s", "build", "-l", "3000"]
