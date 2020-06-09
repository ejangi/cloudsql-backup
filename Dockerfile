FROM google/cloud-sdk:alpine

ENV PORT 8080
EXPOSE $PORT
ENV _SQL_INSTANCE_NAME "mysql"
ENV _SQL_DATABASES "db1 db2"
ENV _GS_BUCKET_NAME "mybucket"
ENV _GS_GZ_PATH "/backups"

RUN pip3 install Flask gunicorn
RUN mkdir -p /usr/src/app

COPY Docker/backup.sh /usr/bin/backup.sh
COPY Docker/app.py /usr/src/app/app.py
COPY Docker/templates /usr/src/app/templates
COPY Docker/service-account.json /usr/src/app/service-account.json
COPY Docker/docker-entrypoint.sh /usr/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 app:app