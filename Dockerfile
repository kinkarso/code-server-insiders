# Start from code-server base image
FROM codercom/code-server:latest

# Switch to coder user
USER coder
ENV SHELL=/bin/bash

# Copy your Remote-SSH VSIX into the container
COPY remote-ssh.vsix /tmp/remote-ssh.vsix

# Expose the default code-server port
EXPOSE 8080

# 1) Install the Remote-SSH extension
# 2) Patch its manifest to run in workspace mode
RUN code-server --install-extension /tmp/remote-ssh.vsix && \
    for d in /home/coder/.local/share/code-server/extensions/ms-vscode-remote.remote-ssh-*; do \
      if [ -d "$d" ]; then \
        echo "Patching $d/package.json"; \
        sed -i 's/"extensionKind": *\["ui"\]/"extensionKind": ["workspace"]/g' "$d/package.json"; \
      else \
        echo "No Remote-SSH extension folder found at build time."; \
      fi \
    done

# Launch code-server with no auth (for testing)
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none"]
