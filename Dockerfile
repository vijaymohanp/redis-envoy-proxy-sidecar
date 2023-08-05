# Use the specific version of the Envoy image you need
FROM envoyproxy/envoy:v1.26-latest


# Copy the Envoy configuration file into the container
COPY envoy.yaml /etc/envoy/envoy.yaml


# Set appropriate permissions for the configuration file
RUN chmod go+r /etc/envoy/envoy.yaml


# Update the package repository and install Redis tools
RUN apt-get update && \
    apt-get install -y redis-tools


# Copy the health check script into the container
COPY checkHealth.sh /usr/local/bin/


# Set executable permissions for the health check script
RUN chmod +x /usr/local/bin/checkHealth.sh
