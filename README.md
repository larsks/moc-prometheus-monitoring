This sets up a Prometheus monitoring stack for the Kaizen OpenStack environment.

## Containers

- `frontend`

  This is a [Traefik][] frontend proxy. It is responsible for routing
  requests to appropriate containers based on the request hostname,
  and it manages requesting and renewing SSL certificates from
  LetsEncrypt.

  [traefik]: https://containo.us/traefik/

- `prom_main`

  This is the main Prometheus instance. All scraping jobs are run from here.

- `prom_host_discovery`

  This is a utility container that gets the address of the docker host
  and writes it to a file so that Prometheus is able to query the
  local node exporter.

- `grafana`

  Visualization.

- `cinder_exporter`

  Exports information about Cinder volumes for consumption by Prometheus.

- `keystone_exporter`

  Exports information about Keystone projects and users for consumption by
  Prometheus.

- `thanos_sidecar`

  Ships Prometheus metrics to a remote object store, and provide Thanos with
  access to local Prometheus data store.

- `thanos_store`

  Provides Thanos with read access to remote object store.

- `thanos_query`

  Allows PromQL queries against multiple sources (specificaly, the `prom_main`
  container and the `thanos_store` container).

- `thanos_compactor`

  Downsamples data for better performance with long time ranges.

## Exposed services

This compose stack provides the following services:

- <https://grafana.promtest.massopen.cloud>

  This is the Grafana UI. The password for the `admin` user is in
  Bitwarden.

- <https://thanos.promtest.massopen.cloud>

  This is the Thanos query UI. It's a good place to experiment with
  PromQL queries.

- <https://prom.promtest.massopen.cloud>

  This is the actual Prometheus instance from the `prom_main`
  container.

## Configuring

- Provide admin OpenStack credentials in `openstack/clouds.yaml`
- Set `POSTGRES_PASSWORD` in `.env`.
- Set `OS_CLOUD` in `.env` to match a cloud name from `openstack/clouds.yaml`
- Provide object store credentials in `thanos/bucket_config.yml`
