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

# Patch the Remote SSH extension manifest to force it to run in workspace mode
RUN for d in /home/coder/.local/share/code-server/extensions/ms-vscode-remote.remote-ssh-*; do \
      echo "Patching $d/package.json"; \
      sed -i 's/"extensionKind": *\["ui"\]/"extensionKind": ["workspace"]/g' "$d/package.json"; \
    done

# Use the default entrypoint provided by code-server image, with auth disabled
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none"]
