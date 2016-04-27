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
  
        hQIMA7gdakp/SeQTAQ//elCOClhbcikgQ73WI9l1a90QjVqrQ5drtyhl5G+YAntM
        py4quKvEDKwJEiIlSOLZgYy07DJ7o00ecaKHWw2+b9BRmwhC46plimLAk889zF56
        uGpc8KD3ODofK2R8FcQw//u858szFSvYRqHj7xG5djExzFW4yDn1dOfGAx2QCgGF
        BSw7uWGKmT6rmI8N8m6uDsEc0LzjRRq8RaCo/lEpos65Ur2Lb6kleWGlb0TWe2yd
        F+HtyPoQbmXzFAHYzRm0ZnlJU8tcYoHUYPVP73jFhmG1G+/6MomM6eRmiHWkwmBJ
        3sAWqa+HKHXP3NiGLj6fRMKlBZwPmf6dno2vhU+7XdYPxNQAc6JycTdFkBoUBMGn
        IQmZ/t3SYl+25MyVbh25aeNE86kUUnRjpovUO158oYhy8SsE4M9PCDowzlXLKVHg
        ngczVJcuaJq7G/rz7LUw+ShMWngff++uFHS3zTxkcZd0Nq/pKemgCIMZU3/kCZzu
        pNAtWFI1d4U54fRRzpS+ROSYb+e5wXus2Ljo3nYPok7JmbZ6XlOotrZK8m4Zg3Ay
        4aIb+QRX4+U5/bzcOy9WChRhfEJ4NjbiFjV37orUIUlsgbHcx6rKlXM4ZYkoMW1N
        JaSslGHPUkukmdjkHM2YRd7x22kkGt37/J3AXjSmjDbjoyfWWdQovK44+UBsT3jS
        WgGtwyRnK1IWWVAR0/AUiGVcJpiG3QGfKoc4iHtiXlNEqGzVINKAFXSC/WA+YPk0
        lWG739ndAzm/5hG4MGZ7K/MdpomMbf4X2ZOEdGNr0cvE/HQPLFmzuwKRKg==
        =Ff1H
        -----END PGP MESSAGE-----
      PGSQL_ROLE_1_FLAGS: LOGIN
      PGSQL_DB_1_NAME: nodewatcher
      PGSQL_DB_1_OWNER: nodewatcher
      PGSQL_DB_1_ENCODING: UNICODE
      PGSQL_DB_1_POSTGIS: true
