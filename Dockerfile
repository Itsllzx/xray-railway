FROM alpine:latest

RUN apk add --no-cache curl unzip

RUN curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /usr/bin && \
    chmod +x /usr/bin/xray

WORKDIR /app
COPY config.json .

# اصلاح شده: استفاده از شل برای اجرای صحیح دستورات پشت سر هم
CMD sh -c "sed -i 's/\"PORT\"/'${PORT:-8080}'/g' config.json && xray run -c config.json"
