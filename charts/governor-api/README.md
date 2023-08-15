# Governor

## Description

A repo holding the Kubernetes deployment manifests for the governor ecosystem

[Governor API](https://github.com/metal-toolbox/governor-api)

## Installation

* Add the Equinix Metal helm repository

```bash
helm repo add equinixmetal https://helm.equinixmetal.com
```

* Install the helm chart using default values

```bash
helm install governor-api equinixmetal/governor-api
```

> If you are using your own chart, reference the following to your chart's dependencies:
> ```yaml
> dependencies:
>   - name: governor-api
>     version: v0.0.1
>     repository: "https://helm.equinixmetal.com"
> ```

## Usage

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| api.enabled | bool | `true` |  |
| api.ingress.prefix | string | `"api.governor"` |  |
| api.oidc[0].audience | string | `""` |  |
| api.oidc[0].enabled | bool | `true` |  |
| api.oidc[0].issuer | string | `""` |  |
| api.oidc[0].jwksuri | string | `""` |  |
| api.oidc[0].rolesClaim | string | `""` |  |
| api.oidc[0].userClaim | string | `""` |  |
| api.readinessProbe.failureThreshold | int | `3` |  |
| api.readinessProbe.periodSeconds | int | `20` |  |
| api.readinessProbe.successThreshold | int | `1` |  |
| api.readinessProbe.timeoutSeconds | int | `3` |  |
| api.replicaCount | int | `2` |  |
| api.resources.limits.cpu | string | `"500m"` |  |
| api.resources.limits.memory | string | `"1Gi"` |  |
| api.resources.requests.cpu | string | `"100m"` |  |
| api.resources.requests.memory | string | `"128Mi"` |  |
| audit.auditImage.pullPolicy | string | `"IfNotPresent"` |  |
| audit.auditImage.repository | string | `"ghcr.io/metal-toolbox/audittail"` |  |
| audit.auditImage.tag | string | `"v0.7.0"` |  |
| audit.initContainer.resources.limits.cpu | string | `"100m"` |  |
| audit.initContainer.resources.limits.memory | string | `"20Mi"` |  |
| audit.initContainer.resources.requests.cpu | string | `"100m"` |  |
| audit.initContainer.resources.requests.memory | string | `"20Mi"` |  |
| audit.resources.limits.cpu | string | `"500m"` |  |
| audit.resources.limits.memory | string | `"1Gi"` |  |
| audit.resources.requests.cpu | string | `"100m"` |  |
| audit.resources.requests.memory | string | `"128Mi"` |  |
| db.connections.max_idle | int | `20` |  |
| db.connections.max_lifetime | int | `0` |  |
| db.connections.max_open | int | `20` |  |
| db.secrets.crdbCrt | string | `nil` |  |
| db.secrets.enabled | bool | `false` |  |
| db.secrets.uri | string | `nil` |  |
| dbURI.existingSecret | string | `"db-uri"` |  |
| governor.adminGroups | string | `"governor-admins"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/metal-toolbox/governor-api"` |  |
| image.tag | string | `"243-dec3db14"` |  |
| ingress.domains | list | `[]` |  |
| ingress.enabled | bool | `true` |  |
| k8s-otel-collector.include_otel_attributes | bool | `false` |  |
| nats.credsPath | string | `"/nats"` |  |
| nats.secrets.clientCreds | string | `nil` |  |
| nats.secrets.enabled | bool | `false` |  |
| nats.subjectPrefix | string | `"governor.events"` |  |
| nats.url | string | `nil` |  |
| resources.limits.cpu | string | `"500m"` |  |
| resources.limits.memory | string | `"1Gi"` |  |
| resources.requests.cpu | string | `"100m"` |  |
| resources.requests.memory | string | `"128Mi"` |  |
| tracing.enabled | bool | `true` |  |
| tracing.secrets.enabled | bool | `false` |  |
| tracing.secrets.honeycombKey | string | `nil` |  |

## Development

### Prerequisites

- [helm](https://helm.sh/docs/intro/install/)
- [helm-docs](https://github.com/norwoodj/helm-docs)

### Testing

Ensure that the documentation is up to date before pushing a pull request:

```bash
helm-docs
```

### Releasing

There is a useful Makefile target that's useful to cut a release. So, simply do:

```bash
TAG=$RELEASE_VERSION make release
```

And the release will happen.

Note that this project follows the [Semantic Versioning scheme](https://semver.org/), so
make sure to follow it when cutting releases.

The `TAG` Makefile variable takes a release version without the `v` prefix. For example,
if you want to cut a release with version `v1.2.3`, you'd do:

```bash
TAG=1.2.3 make release
```
