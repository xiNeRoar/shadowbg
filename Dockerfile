# ------------------------------------------------------------------------------
# Build shadowbg-frontend
FROM arm64v8/node:20-bullseye AS buildfe
RUN git clone https://github.com/xav1erenc/shadowbg-frontend && \
    cd shadowbg-frontend && npm install && npm run build && mv out /fe

# ------------------------------------------------------------------------------
# Build go binary
FROM arm64v8/ubuntu:jammy AS buildgo
ADD . /src
WORKDIR /src
RUN apt-get update && \
    apt-get install -y build-essential git golang-go && \
    go build -o shadow.bg main.go && \
    strip shadow.bg

# ------------------------------------------------------------------------------
# Pull base image
FROM arm64v8/ubuntu:jammy

# ------------------------------------------------------------------------------
# Copy files to final stage
COPY --from=buildgo /src/shadow.bg /app/shadow.bg
COPY --from=buildgo /src/app.sh /app/
COPY --from=buildfe /fe /app/frontend/

# ------------------------------------------------------------------------------
# Identify Volumes
VOLUME /data

# ------------------------------------------------------------------------------
# Expose ports
EXPOSE 80

# ------------------------------------------------------------------------------
# Define default command
CMD ["/app/app.sh"]
