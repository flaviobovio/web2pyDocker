# Use Ubuntu 18.04 which has Python 2.7
FROM ubuntu:18.04

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV DEBIAN_FRONTEND=noninteractive

# Install Python 2.7 and dependencies (configure as needed)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    locales \
    python2.7 \
    python-pip \
    mc \
    git \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Locale
RUN echo "es_AR.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen es_AR.UTF-8

# Set the locale environment variable
ENV LANG=es_AR.UTF-8
ENV LANGUAGE=es_AR:es
ENV LC_ALL=es_AR.UTF-8

# Create symlink for python command (remove existing first)
RUN rm -f /usr/bin/python && ln -s /usr/bin/python2.7 /usr/bin/python

# Create web2py directory
WORKDIR /opt

#Copy certificate, key requirenments to container
COPY *.crt /opt
COPY *.key /opt
COPY requirements.txt /opt

# Upgrade pip and install the requests library
RUN pip install --upgrade pip
RUN pip install setuptools

# Application requirements
RUN pip install -r /opt/requirements.txt

# Download and install web2py from official site
#RUN git clone --recursive --branch R-2.18.5 https://github.com/web2py/web2py.git web2py
RUN git clone --recursive --branch v2.19.1 https://github.com/web2py/web2py.git web2py

# Set working directory to web2py
WORKDIR /opt/web2py

# Expose port 8000
EXPOSE 8000

# Create startup script for HTTPS
RUN echo '#!/bin/bash\n\
cd /opt/web2py\n\
python web2py.py -a 1 -i 0.0.0.0 -p 8000 -k /opt/server.key -c /opt/server.crt --nogui\n\
' > /opt/start_web2py.sh && chmod +x /opt/start_web2py.sh

# Start web2py
CMD ["/opt/start_web2py.sh"]

