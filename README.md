This sets up a Prometheus monitoring stack for the Kaizen OpenStack environment.

## Containers

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

## Exposed ports

This compose stack provides services on the following ports:

- `3000` -- Grafana
- `9090` -- The `prom_main` prometheus instance
- `9191` -- The `prom_archive` prometheus instance
- `19192` -- The Thanos query instance

## Configuring

- Provide admin OpenStack credentials in `openstack/clouds.yaml`
- Set `POSTGRES_PASSWORD` in `.env`.
- Set `OS_CLOUD` in `.env` to match a cloud name from `openstack/clouds.yaml`
- Provide object store credentials in `thanos/bucket_config.yml`
