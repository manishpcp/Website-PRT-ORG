# Use an official Nginx image
FROM nginx:alpine

# Copy the website files to Nginx's default web directory
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
