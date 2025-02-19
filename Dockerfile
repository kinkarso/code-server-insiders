# Start from the code-server base image (Insiders/latest version)
FROM codercom/code-server:latest

# (Optional) Switch to the coder user (already created in the base image)
USER coder

# (Optional) Copy in any VS Code settings or config files
# COPY settings.json /home/coder/.local/share/code-server/User/settings.json

# Ensure the container uses bash (optional, since base uses Debian)
ENV SHELL=/bin/bash

# (Optional) Install additional tools, e.g., Node.js, git, etc.
# RUN sudo apt-get update && sudo apt-get install -y nodejs

# Expose the default code-server port
EXPOSE 8080

# Use the default entrypoint provided by code-server image
# (The base image’s entrypoint already runs code-server on 0.0.0.0:8080)
