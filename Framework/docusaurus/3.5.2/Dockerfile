FROM ghcr.io/labring-actions/devbox/node.js-20:219d11

USER root
RUN cd /home/devbox/project && \
rm -rf ./*
 
COPY /Framework/docusaurus/3.5.2/project /home/devbox/project
RUN chown -R devbox:devbox /home/devbox/project && \
chmod -R u+rw /home/devbox/project && \
chmod -R +x /home/devbox/project/entrypoint.sh

USER devbox
RUN cd /home/devbox/project && \
npm install && \
npx docusaurus build
 
RUN mkdir -p /home/devbox/.devbox