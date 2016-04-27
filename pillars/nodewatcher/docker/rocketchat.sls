#!yaml|gpg
docker:
  containers:
    rocket-chat:
      image: rocketchat/rocket.chat
      environment:
        - VIRTUAL_HOST: chat.wlan-si.net
          VIRTUAL_URL: /
          MONGO_URL: mongodb://rocket-chat-db/rocketchat
          ROOT_URL: https://chat.wlan-si.net
          MAIL_URL: smtp://mail.tnode.com/
    rocket-chat-db:
      image: mongo
      volumes:
        /srv/storage/rocket-chat:
          bind: /data/db
          user: 999
          group: root
