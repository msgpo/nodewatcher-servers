#!yaml|gpg
docker:
  containers:
    postgresql:
      image: tozd/postgresql
      tag: "9.3"
      volumes:
        /srv/storage/postgresql:
          bind: /var/lib/postgresql/9.3/main
          user: 102
          group: 106
        /srv/log/postgresql:
          bind: /var/log/postgresql
          user: nobody
          group: nogroup
      environment:
        - postgresql
  environments:
    postgresql:
      PGSQL_ROLE_1_USERNAME: nodewatcher
      PGSQL_ROLE_1_PASSWORD: |
        -----BEGIN PGP MESSAGE-----
        Version: GnuPG v1

        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
        =rigk
        -----END PGP MESSAGE-----
      PGSQL_ROLE_1_FLAGS: LOGIN
      PGSQL_DB_1_NAME: nodewatcher
      PGSQL_DB_1_OWNER: nodewatcher
      PGSQL_DB_1_ENCODING: UNICODE
      PGSQL_DB_1_POSTGIS: true
  