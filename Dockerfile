FROM mysql:8.0.19
MAINTAINER Vova Tkach <vladimirok5959@gmail.com>

COPY --chown=root:root ./docker /

RUN echo "" >> /root/.profile && \
	echo "TIME_ZONE=\$(cat /etc/timezone)" >> /root/.profile && \
	echo "export TZ=\"\${TIME_ZONE}\"" >> /root/.profile && \
	echo "" >> /root/.bashrc && \
	echo "TIME_ZONE=\$(cat /etc/timezone)" >> /root/.bashrc && \
	echo "export TZ=\"\${TIME_ZONE}\"" >> /root/.bashrc && \
	echo "#!/bin/bash" > /usr/local/bin/tmp && \
	echo "" >> /usr/local/bin/tmp && \
	echo "# Set timezone" >> /usr/local/bin/tmp && \
	echo "TIME_ZONE=\$(cat /etc/timezone)" >> /usr/local/bin/tmp && \
	echo "export TZ=\"\${TIME_ZONE}\"" >> /usr/local/bin/tmp && \
	echo "" >> /usr/local/bin/tmp && \
	cat /usr/local/bin/docker-entrypoint.sh | tail -n +2 >> /usr/local/bin/tmp && \
	cat /usr/local/bin/tmp > /usr/local/bin/docker-entrypoint.sh && \
	rm /usr/local/bin/tmp
