# Add ImageMagick for image processing
FROM mcr.microsoft.com/vscode/devcontainers/typescript-node:latest

# Install dependencies and ImageMagick
USER root
RUN apt-get update && \
	apt-get install -y --no-install-recommends imagemagick && \
	rm -rf /var/lib/apt/lists/*

# Switch back to non-root user
USER vscode

# Existing devcontainer settings (if any) should be merged here
# ...existing code...
