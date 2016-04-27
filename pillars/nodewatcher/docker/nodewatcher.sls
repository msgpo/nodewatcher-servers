#!yaml|gpg
docker:
  containers:
    nodewatcher-frontend:
      image: wlanslovenija/nodewatcher-frontend
      environment:
        # We use a different virtual host for pushing monitoring data as we configure
        # TLS client authentication there.
        - VIRTUAL_HOST: nodewatcher.sudomesh.org
          VIRTUAL_URL: /
        - nodewatcher
        - postgresql
      config:
        nodewatcher: /code/nodewatcher/settings_production.py
      volumes:
        /srv/storage/nodewatcher/media:
          bind: /media
          user: www-data
          group: www-data
          mode: 755
        /srv/storage/nodewatcher/static:
          bind: /static
        /srv/log/nodewatcher/uwsgi:
          bind: /var/log/uwsgi
          user: nobody
          group: nogroup
    nodewatcher-monitor:
      image: wlanslovenija/nodewatcher-monitor
      network_mode:
        type: container
        container: mesh-network
      environment:
        - nodewatcher
        - postgresql
      config:
        nodewatcher: /code/nodewatcher/settings_production.py
      volumes:
        /srv/storage/nodewatcher/media:
          bind: /media
          user: www-data
          group: www-data
          mode: 755
        /srv/log/nodewatcher/monitor:
          bind: /var/log/monitor
          user: nobody
          group: nogroup
    nodewatcher-monitorq:
      image: wlanslovenija/nodewatcher-monitorq
      network_mode:
        type: container
        container: mesh-network
      environment:
        - nodewatcher
        - postgresql
      config:
        nodewatcher: /code/nodewatcher/settings_production.py
      volumes:
        /srv/storage/nodewatcher/media:
          bind: /media
          user: www-data
          group: www-data
          mode: 755
        /srv/log/nodewatcher/monitorq:
          bind: /var/log/celery
          user: nobody
          group: nogroup
  environments:
    nodewatcher:
      DJANGO_SETTINGS_MODULE: nodewatcher.settings_production
      SECRET_KEY: |
        -----BEGIN PGP MESSAGE-----
        Version: GnuPG v1
  
        hQIMA7gdakp/SeQTAQ//QnQExItiuPxOQ2cCYlm0SLIPA1n33XK0LrPLpFE3zw+3
        E1VaXaUFe3sMurWnyGT0wKmDRSVCl5N8asB0B5KscPQvkDN/f4vHuX26xm48tS5E
        zd7rHEdzNm+126I4YaqEplL9IAuUQu9q4AEPeSa6wbHuRyOUrgtSzKY1kHP92omy
        qMKk78Q61EmBFovBGO/z01qKoq11EYRXxzkV64boMxg4flEedpK42PoxnDLwbc8o
        yA5HFho6bsZQvpt6mj60NhF7tE+cwe4OfaDA0EGfZ4h8RK6FdxMbtCOQ20kpkiAC
        rNgzo2CRcStgAsUnvGqB4rdASRzX6tizSEBjrW1ZJs9M2VHORk5LPoEyLsEwmUOE
        gy3spEue7e5j+sf3/xa3ozujIuqxCLZuNFa8i1DkpZSL8tbNS20X9g14p9m8ve+E
        NSWIwAnVExnXqCHYd5PXfypqrjZauMOxTS1uqqIdfXMSqOqLaRv2WSMvomWU0rrt
        x3lyAhqFh8gmLJsqn33xSIOLnVH39UJPXtiM3lCVHMmMeho57wn9xoESPuFidrYH
        t85x1uOo3l33QmUlmgG96mTyGK5+v1UZGKUNuiOvrFtLDQDUTNl+ctNzbS/7jwZv
        3zSx2nTAqVgRAo5oedc/fDN+11bYX+aF9qN51/ByoBRW83kvyyGtOycsHlXJgc3S
        fQF0YqA4o5bFYrrbzap/6IQPdm0hqCHzZr4pUC3lj38pjnDW5cM32aecrdvrvG2n
        0WsTgdUvtTtozNjVWBvqzdyruWmnaLSupT5HnkO+pcWzsHh1/KL1pEokilRoY7F1
        gsmtIbU6oLakcVJpPsa2c3lLisQT3nsAMo0WyW2O
        =7QbG
        -----END PGP MESSAGE-----

  configs:
    nodewatcher: |
      from .settings import *

      DEBUG = False
      TEMPLATE_DEBUG = DEBUG
      TEMPLATE_URL_RESOLVERS_DEBUG = DEBUG

      SECRET_KEY = os.environ.get('SECRET_KEY')

      ADMINS = (
        ('Marc Juul', 'marc@juul.io')
      )

      MANAGERS = ADMINS

      DATABASES = {
          'default': {
              'ENGINE': 'django.contrib.gis.db.backends.postgis',
              'NAME': 'nodewatcher',
              'USER': 'nodewatcher',
              'PASSWORD': os.environ.get('PGSQL_ROLE_1_PASSWORD', ''),
              'HOST': 'postgresql',
              'PORT': '5432',
          }
      }

      TIME_ZONE = 'US/Pacific'

      MEDIA_ROOT = '/media'
      STATIC_ROOT = '/static'

      EMAIL_HOST = 'localhost'
      EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'

      BROKER_URL = 'redis://redis:6379/0'
      CELERY_RESULT_BACKEND = BROKER_URL

      DATASTREAM_BACKEND = 'datastream.backends.mongodb.Backend'
      DATASTREAM_BACKEND_SETTINGS = {
        'database_name': 'nodewatcher_ds',
        'host': 'tokumx',
        'port': 27017,
        'tz_aware': USE_TZ,
      }

      MEASUREMENT_SOURCE_NODE = '5dcf6dae-9246-47ec-8ba5-f864d8f88778'

      USE_HTTPS = True
      CSRF_COOKIE_SECURE = USE_HTTPS
      SESSION_COOKIE_SECURE = USE_HTTPS
      SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')

      NETWORK.update({
        'NAME': "People's Open Network",
        'HOME': 'http://peoplesopen.net',
        'CONTACT': 'info@peoplesopen.net',
        'CONTACT_PAGE': 'http://peoplesopen.net',
        'DESCRIPTION': 'A community mesh network in the SF East Bay'
      })

      EMAIL_SUBJECT_PREFIX = '[' + NETWORK['NAME'] + '] '
      DEFAULT_FROM_EMAIL = NETWORK['CONTACT']
      SERVER_EMAIL = DEFAULT_FROM_EMAIL

      ALLOWED_HOSTS = os.environ.get('VIRTUAL_HOST', '127.0.0.1').split(',')
