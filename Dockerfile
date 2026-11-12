FROM maven:3.9.9-eclipse-temurin-17

WORKDIR /app

# Install Google Chrome for headless Selenium tests.
RUN apt-get update     && apt-get install -y --no-install-recommends ca-certificates curl gnupg     && install -d -m 0755 /etc/apt/keyrings     && curl -fsSL https://dl.google.com/linux/linux_signing_key.pub        | gpg --dearmor -o /etc/apt/keyrings/google-chrome.gpg     && chmod a+r /etc/apt/keyrings/google-chrome.gpg     && echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main"        > /etc/apt/sources.list.d/google-chrome.list     && apt-get update     && apt-get install -y --no-install-recommends google-chrome-stable     && rm -rf /var/lib/apt/lists/*

COPY pom.xml .
COPY testng.xml .
COPY webpage ./webpage
COPY src ./src

CMD ["mvn", "--batch-mode", "clean", "test"]