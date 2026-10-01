# Start with the official Open WebUI Computer image to keep the WebUI/Dashboard
FROM ghcr.io/open-webui/computer:latest

USER root

# 1. Install Chromium and all required Linux dependencies for a headed browser
RUN apt-get update && apt-get install -y \
    chromium \
    chromium-driver \
    xvfb \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    && rm -rf /var/lib/apt/lists/*

# 2. Install the Python libraries for Scraping and Office Files
# We use the system python or the venv if the image uses one
RUN pip install --no-cache-dir \
    playwright \
    beautifulsoup4 \
    requests \
    pandas \
    openpyxl \
    python-pptx \
    python-docx \
    pdfplumber

# 3. Install Playwright's specific browser binaries
RUN playwright install chromium
RUN playwright install-deps

# Switch back to the default user provided by the image
USER computer
