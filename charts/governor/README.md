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
| api | object | `{"adminGroups":"governor-admins","db":{"connections":{"max_idle":20,"max_lifetime":0,"max_open":20},"secrets":{"crdbCrt":null,"enabled":false,"uri":null},"uri":{"existingSecret":"db-uri"}},"debug":false,"enabled":true,"image":{"pullPolicy":"IfNotPresent","repository":"ghcr.io/metal-toolbox/governor-api","tag":"243-dec3db14"},"ingress":{"host":"api.governor.example.com","prefix":"api.governor"},"nats":{"credsPath":"/nats","secrets":{"clientCreds":null,"enabled":false},"subjectPrefix":"governor.events","url":null},"oidc":[{"audience":"","enabled":true,"issuer":"","jwksuri":"","rolesClaim":"","userClaim":""}],"readinessProbe":{"failureThreshold":3,"periodSeconds":20,"successThreshold":1,"timeoutSeconds":3},"replicaCount":2,"resources":{"limits":{"cpu":"500m","memory":"1Gi"},"requests":{"cpu":"100m","memory":"128Mi"}},"tracing":{"enabled":true,"secrets":{"enabled":false,"honeycombKey":null}}}` | governor-api settings |
| api.adminGroups | string | `"governor-admins"` | admin group for highest level permissions in the governor-api |
| api.db | object | `{"connections":{"max_idle":20,"max_lifetime":0,"max_open":20},"secrets":{"crdbCrt":null,"enabled":false,"uri":null},"uri":{"existingSecret":"db-uri"}}` | settings for the backend db |
| api.db.secrets | object | `{"crdbCrt":null,"enabled":false,"uri":null}` | db secrets, set to `true` if you want to set the value directly in the chart (not recommended) |
| api.debug | bool | `false` | set to true to turn on debug logging |
| api.image | object | `{"pullPolicy":"IfNotPresent","repository":"ghcr.io/metal-toolbox/governor-api","tag":"243-dec3db14"}` | image for the governor-api |
| api.ingress | object | `{"host":"api.governor.example.com","prefix":"api.governor"}` | ingress settings for the governor-api |
| api.nats | object | `{"credsPath":"/nats","secrets":{"clientCreds":null,"enabled":false},"subjectPrefix":"governor.events","url":null}` | nats settings for the governor-api |
| api.oidc | list | `[{"audience":"","enabled":true,"issuer":"","jwksuri":"","rolesClaim":"","userClaim":""}]` | oidc settings, currently startup will fail without a valid oidc config |
| api.replicaCount | int | `2` | replicas of the governor-api |
| api.resources | object | `{"limits":{"cpu":"500m","memory":"1Gi"},"requests":{"cpu":"100m","memory":"128Mi"}}` | resource settings for the governor-api |
| api.tracing | object | `{"enabled":true,"secrets":{"enabled":false,"honeycombKey":null}}` | tracing settings |
| api.tracing.secrets | object | `{"enabled":false,"honeycombKey":null}` | tracing secrets, set to `true` if you want to set the value directly in the chart (not recommended) |
| audit | object | `{"auditImage":{"pullPolicy":"IfNotPresent","repository":"ghcr.io/metal-toolbox/audittail","tag":"v0.7.0"},"enabled":true,"initContainer":{"resources":{"limits":{"cpu":"100m","memory":"20Mi"},"requests":{"cpu":"100m","memory":"20Mi"}}},"resources":{"limits":{"cpu":"500m","memory":"1Gi"},"requests":{"cpu":"100m","memory":"128Mi"}},"securityContext":{"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true,"runAsNonRoot":true,"runAsUser":1000}}` | audit sidecar settings |
| k8s-otel-collector | object | `{"include_otel_attributes":false}` | settings for the otel collector sub-chart ref https://github.com/equinixmetal-helm/k8s-otel-collector |
| slackAddon | object | `{"api":{"audience":"https://api.governor.example.com","clientId":"gov-slack-addon-governor","url":"https://api.governor.example.com"},"autoscaling":{"enabled":false},"debug":false,"dryrun":false,"enabled":true,"hydra":{"url":"https://hydra.example.com/oauth2/token"},"image":{"pullPolicy":"IfNotPresent","repository":"ghcr.io/metal-toolbox/governor-slack-addon","tag":"46-c41b0158"},"nats":{"credsPath":"/nats","subjectPrefix":"equinixmetal.governor.events","url":"tls://nats.governor.hollow-a.sv15.metalkube.net:4222,tls://nats.governor.hollow-a.dc10.metalkube.net:4222,tls://nats.governor.hollow-a.ch3.metalkube.net:4222"},"nodeSelector":null,"pretty":false,"reconciler":{"interval":"1h","locking":true},"replicas":1,"resources":{"limits":{"cpu":"500m","memory":"500Mi"},"requests":{"cpu":"250m","memory":"500Mi"}},"securityContext":{"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true,"runAsNonRoot":true,"runAsUser":1000},"service":{"port":80},"tolerations":null}` | slack-addon settings |
| slackAddon.api | object | `{"audience":"https://api.governor.example.com","clientId":"gov-slack-addon-governor","url":"https://api.governor.example.com"}` | governor-api settings to retrieve required information by the slack addon |
| slackAddon.debug | bool | `false` | set to true to turn on debug logging |
| slackAddon.dryrun | bool | `false` | dryrun on the reconcile loop |
| slackAddon.enabled | bool | `true` | set to false to disable this addon completely |
| slackAddon.hydra | object | `{"url":"https://hydra.example.com/oauth2/token"}` | hydra settings for communication with the governor-api |
| slackAddon.image | object | `{"pullPolicy":"IfNotPresent","repository":"ghcr.io/metal-toolbox/governor-slack-addon","tag":"46-c41b0158"}` | image settings for the slack addon |
| slackAddon.nats | object | `{"credsPath":"/nats","subjectPrefix":"equinixmetal.governor.events","url":"tls://nats.governor.hollow-a.sv15.metalkube.net:4222,tls://nats.governor.hollow-a.dc10.metalkube.net:4222,tls://nats.governor.hollow-a.ch3.metalkube.net:4222"}` | nats setup for the slack addon |
| slackAddon.pretty | bool | `false` | set to true for human readable logging |
| slackAddon.resources | dict | `{"limits":{"cpu":"500m","memory":"500Mi"},"requests":{"cpu":"250m","memory":"500Mi"}}` | resource limits & requests ref: https://kubernetes.io/docs/user-guide/compute-resources/ |
| slackAddon.securityContext | object | `{"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true,"runAsNonRoot":true,"runAsUser":1000}` | Security context to be added to the deployment |

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
