# Use the insiders build image from code-server
FROM codercom/code-server:insiders

# (Optional) Install additional dependencies if needed (e.g., Python, Node)
RUN sudo apt-get update && \
    sudo apt-get install -y python3 python3-pip nodejs

# Expose the default port that code-server listens on
EXPOSE 8080

# Set environment variables for code-server login (optional)
# If Railway asks for these, you'll set them in Railway's settings.
ENV PASSWORD=linan45445

# Run code-server on port 8080 without authentication (if you prefer; otherwise, use the PASSWORD)
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "password"]
