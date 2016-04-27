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
  
        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
        J1OM+oenWtQ5VYtF4Bw=
        =ZxC5
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
