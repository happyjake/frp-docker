# Stage 1: Download and extract frps
FROM alpine as builder
ARG VERSION=0.52.3
RUN apk add --no-cache wget tar
RUN wget https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_linux_amd64.tar.gz
RUN tar -xzf frp_${VERSION}_darwin_arm64.tar.gz

# Stage 2: Copy frps binary to a new image
FROM alpine
COPY --from=builder /frp_${VERSION}_linux_amd64/frps /usr/local/bin/frps
RUN chmod +x /usr/local/bin/frps

# Create a volume for the configuration file
VOLUME /frp

# Expose necessary port
EXPOSE 7000

# Run frps with configuration file
CMD ["frps", "-c", "/frp/frps.ini"]