FROM alpine:3.14

RUN apk add --no-cache postgresql postgresql-contrib

USER postgres

RUN mkdir -p /var/lib/postgresql/data && \
    chmod 700 /var/lib/postgresql/data

RUN initdb -D /var/lib/postgresql/data

COPY postgresql.conf /var/lib/postgresql/data/
COPY setup.sh /docker-entrypoint-initdb.d/

RUN echo "host all all 0.0.0.0/0 md5" >> /var/lib/postgresql/data/pg_hba.conf

USER root
RUN chmod +x /docker-entrypoint-initdb.d/setup.sh

USER postgres

EXPOSE 5432

VOLUME ["/var/lib/postgresql/data"]

CMD ["postgres", "-D", "/var/lib/postgresql/data"]