docker:
  containers:
    tunneldigger-vpn0:
      image: wlanslovenija/tunneldigger-client
      host_kernel_modules:
        - l2tp_core
        - l2tp_eth
        - l2tp_netlink
      capabilities:
        - NET_ADMIN
      environment:
        TUNNELDIGGER_UUID: d26b98f4-3567-4b2f-b0c4-25515d1a8618
        TUNNELDIGGER_BROKERS: 104.236.181.226:8942
        TUNNELDIGGER_BRIDGE: td-vpn0
      networks:
        - id: td-vpn0
      volumes:
        /srv/log/tunneldigger/vpn0:
          bind: /var/log/tunneldigger
          user: nobody
          group: nogroup
