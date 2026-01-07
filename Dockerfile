FROM alpine:latest

# نصب ابزارهای لازم
RUN apk add --no-cache curl unzip

# دانلود و نصب خودکار Xray (نسخه مخصوص لینوکس)
RUN curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /usr/bin && \
    chmod +x /usr/bin/xray

WORKDIR /app
COPY config.json .

# اجرای دستور جایگزینی پورت و شروع به کار
CMD sed -i "s/PORT/$PORT/g" config.json && xray run -c config.json
