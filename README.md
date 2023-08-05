# redis-envoy-proxy-sidecar
This is a public repository that's for anyone can use to understand up how the envoy proxy configuration looks for a sidecar container to propagate redis replication into multi regional cluster 

# Envoy Proxy Configuration

Replace templated section (example: `address: <US CENTRAL REDIS CLUSTER IP>` ) with actual ip address of your regional redis cluster envoy-proxy yaml 

# Listener Configuration

`
- name: redis_listener
  address:
    socket_address:
      address: 0.0.0.0
      port_value: 6379
  filter_chains:
  - filters:
    - name: envoy.filters.network.redis_proxy
      typed_config:
        "@type": type.googleapis.com/envoy.extensions.filters.network.redis_proxy.v3.RedisProxy
        stat_prefix: redis_proxy
        settings:
          op_timeout: 10s
          enable_redirection: false
        prefix_routes:
          catch_all_route:
            cluster: us_central1
            request_mirror_policy:
              cluster: us_east1_local
              exclude_read_commands: true
  `
