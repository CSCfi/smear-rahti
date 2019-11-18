FROM python:3

RUN apt-get update && apt-get install -y wget unzip

RUN python3 -m pip install robotframework
RUN python3 -m pip install robotframework-seleniumlibrary

# Install Chrome
RUN wget -q https://dl-ssl.google.com/linux/linux_signing_key.pub && apt-key add linux_signing_key.pub && rm linux_signing_key.pub
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN apt-get update && apt-get install -y google-chrome-stable

# Disable the SUID sandbox
RUN dpkg-divert --add --rename --divert /opt/google/chrome/google-chrome.real /opt/google/chrome/google-chrome
RUN echo "#!/bin/bash\nexec /opt/google/chrome/google-chrome.real --no-sandbox --disable-setuid-sandbox \"\$@\"" > /opt/google/chrome/google-chrome
RUN chmod 755 /opt/google/chrome/google-chrome

# Install Chromedriver
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/
RUN chmod +x /usr/local/bin/chromedriver

RUN git clone https://github.com/CSCfi/smear-rahti.git && cd smear-rahti/ && git checkout dev

ADD /scripts/run_smoke_test.sh /usr/local/bin
RUN chmod a+x /usr/local/bin/run_smoke_test.sh

CMD ["run_smoke_test.sh"]
