# Use an official Node runtime as a parent image
FROM node:16

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (or yarn.lock) into the working directory
COPY package*.json ./
# If you are using yarn, uncomment the next line and comment out the npm install line
# COPY yarn.lock ./

# Install any needed packages specified in package.json
RUN npm install
# If you are using yarn, replace the above line with:
# RUN yarn install

# Bundle the app source inside the Docker container
COPY . .

# Build the app for production with minification
RUN npm run build
# If you are using yarn, replace the above line with:
# RUN yarn build

# Install a simple http server for serving static content
RUN npm install -g http-server
# If you are using yarn, replace the above line with:
# RUN yarn global add http-server

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Define environment variable
ENV NODE_ENV=production

# Run the app using http-server
CMD [ "http-server", "dist" ]