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
| api | object | `{"adminGroups":"governor-admins","db":{"connections":{"max_idle":20,"max_lifetime":0,"max_open":20},"secrets":{"crdbCrt":null,"enabled":false,"uri":null},"uri":{"existingSecret":"db-uri"}},"debug":false,"enabled":true,"image":{"pullPolicy":"IfNotPresent","repository":"ghcr.io/metal-toolbox/governor-api","tag":"v0.3.0"},"ingress":{"host":"api.governor.example.com","prefix":"api.governor"},"labels":{"app.kubernetes.io/component":"api","app.kubernetes.io/instance":"governor","app.kubernetes.io/managed-by":"Helm","app.kubernetes.io/name":"governor"},"matchLabels":{"app.kubernetes.io/instance":"governor","app.kubernetes.io/name":"governor"},"nats":{"credsPath":"/nats","secrets":{"clientCreds":null,"enabled":false},"subjectPrefix":"governor.events","url":null},"oidc":[{"audience":"","enabled":true,"issuer":"","jwksuri":"","rolesClaim":"","userClaim":""}],"readinessProbe":{"failureThreshold":3,"periodSeconds":20,"successThreshold":1,"timeoutSeconds":3},"replicaCount":2,"resources":{"limits":{"cpu":"500m","memory":"1Gi"},"requests":{"cpu":"100m","memory":"128Mi"}},"tracing":{"enabled":true,"secrets":{"enabled":false,"honeycombKey":null}}}` | governor-api settings |
| api.adminGroups | string | `"governor-admins"` | admin group for highest level permissions in the governor-api |
| api.db | object | `{"connections":{"max_idle":20,"max_lifetime":0,"max_open":20},"secrets":{"crdbCrt":null,"enabled":false,"uri":null},"uri":{"existingSecret":"db-uri"}}` | settings for the backend db |
| api.db.secrets | object | `{"crdbCrt":null,"enabled":false,"uri":null}` | db secrets, set to `true` if you want to set the value directly in the chart (not recommended) |
| api.debug | bool | `false` | set to true to turn on debug logging |
| api.enabled | bool | `true` | enable the governor-api components |
| api.image | object | `{"pullPolicy":"IfNotPresent","repository":"ghcr.io/metal-toolbox/governor-api","tag":"v0.3.0"}` | image for the governor-api |
| api.image.pullPolicy | string | `"IfNotPresent"` | image pull policy for the governor-api container |
| api.image.repository | string | `"ghcr.io/metal-toolbox/governor-api"` | container image repository for the governor-api image |
| api.image.tag | string | `"v0.3.0"` | image tag version |
| api.ingress | object | `{"host":"api.governor.example.com","prefix":"api.governor"}` | ingress settings for the governor-api |
| api.ingress.host | string | `"api.governor.example.com"` | host definition for the api ingress |
| api.ingress.prefix | string | `"api.governor"` | prefix use for the governor api ingress |
| api.labels | object | `{"app.kubernetes.io/component":"api","app.kubernetes.io/instance":"governor","app.kubernetes.io/managed-by":"Helm","app.kubernetes.io/name":"governor"}` | set of additional labels for the application  |
| api.matchLabels | object | `{"app.kubernetes.io/instance":"governor","app.kubernetes.io/name":"governor"}` | set of additional match labels for the application  |
| api.nats | object | `{"credsPath":"/nats","secrets":{"clientCreds":null,"enabled":false},"subjectPrefix":"governor.events","url":null}` | nats settings for the governor-api |
| api.nats.credsPath | string | `"/nats"` | mount path for the nats creds file |
| api.nats.secrets | object | `{"clientCreds":null,"enabled":false}` | nats secrets definitions |
| api.nats.secrets.clientCreds | string | `nil` | client credentials secrets |
| api.nats.secrets.enabled | bool | `false` | enable helm secrets, set to `true` if you want to set the value directly in the chart (not recommended) |
| api.nats.subjectPrefix | string | `"governor.events"` | subject prefix used for the nats events |
| api.nats.url | string | `nil` | url to connection to nats |
| api.oidc | list | `[{"audience":"","enabled":true,"issuer":"","jwksuri":"","rolesClaim":"","userClaim":""}]` | oidc settings, currently startup will fail without a valid oidc config |
| api.oidc[0] | object | `{"audience":"","enabled":true,"issuer":"","jwksuri":"","rolesClaim":"","userClaim":""}` | a unique identifier for your app that is issued to you when you register your app with the IdP |
| api.readinessProbe | object | `{"failureThreshold":3,"periodSeconds":20,"successThreshold":1,"timeoutSeconds":3}` | readiness probe definitions for the governor-api pod |
| api.readinessProbe.failureThreshold | int | `3` | minimum consecutive failures for the probe to be considered unhealthy |
| api.readinessProbe.periodSeconds | int | `20` | interval to run the readiness probe |
| api.readinessProbe.successThreshold | int | `1` | minimum consecutive successes for probe to be considered successful |
| api.readinessProbe.timeoutSeconds | int | `3` | number of seconds to wait for the probe to timeout |
| api.replicaCount | int | `2` | replicas of the governor-api |
| api.resources | object | `{"limits":{"cpu":"500m","memory":"1Gi"},"requests":{"cpu":"100m","memory":"128Mi"}}` | resource settings for the governor-api |
| api.tracing | object | `{"enabled":true,"secrets":{"enabled":false,"honeycombKey":null}}` | tracing settings |
| api.tracing.secrets | object | `{"enabled":false,"honeycombKey":null}` | tracing secrets, set to `true` if you want to set the value directly in the chart (not recommended) |
| audit | object | `{"auditImage":{"pullPolicy":"IfNotPresent","repository":"ghcr.io/metal-toolbox/audittail","tag":"v0.8.0"},"enabled":true,"initContainer":{"resources":{"limits":{"cpu":"100m","memory":"20Mi"},"requests":{"cpu":"100m","memory":"20Mi"}}},"resources":{"limits":{"cpu":"500m","memory":"1Gi"},"requests":{"cpu":"100m","memory":"128Mi"}},"securityContext":{"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true,"runAsNonRoot":true,"runAsUser":1000}}` | audit sidecar settings |
| slackAddon | object | `{"api":{"audience":"https://api.governor.example.com","clientId":"gov-slack-addon-governor","url":"https://api.governor.example.com"},"autoscaling":{"enabled":false},"debug":false,"dryrun":false,"enabled":true,"hydra":{"url":"https://hydra.example.com/oauth2/token"},"image":{"pullPolicy":"IfNotPresent","repository":"ghcr.io/metal-toolbox/governor-slack-addon","tag":"46-c41b0158"},"labels":{"app.kubernetes.io/instance":"gov-slack-addon","app.kubernetes.io/managed-by":"Helm","app.kubernetes.io/name":"gov-slack-addon"},"matchLabels":{"app.kubernetes.io/instance":"gov-slack-addon","app.kubernetes.io/name":"gov-slack-addon"},"nats":{"credsPath":"/nats","subjectPrefix":"governor.events","url":"tls://nats.governor.example.com:4222,"},"nodeSelector":null,"ports":[{"containerPort":8000,"name":"http"}],"pretty":false,"reconciler":{"interval":"1h","locking":true},"replicas":1,"resources":{"limits":{"cpu":"500m","memory":"500Mi"},"requests":{"cpu":"250m","memory":"500Mi"}},"securityContext":{"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true,"runAsNonRoot":true,"runAsUser":1000},"service":{"port":80},"tolerations":null}` | slack-addon settings |
| slackAddon.api | object | `{"audience":"https://api.governor.example.com","clientId":"gov-slack-addon-governor","url":"https://api.governor.example.com"}` | governor-api settings to retrieve required information by the slack addon |
| slackAddon.debug | bool | `false` | set to true to turn on debug logging |
| slackAddon.dryrun | bool | `false` | dryrun on the reconcile loop |
| slackAddon.enabled | bool | `true` | set to false to disable this addon completely |
| slackAddon.hydra | object | `{"url":"https://hydra.example.com/oauth2/token"}` | hydra settings for communication with the governor-api |
| slackAddon.image | object | `{"pullPolicy":"IfNotPresent","repository":"ghcr.io/metal-toolbox/governor-slack-addon","tag":"46-c41b0158"}` | image settings for the slack addon |
| slackAddon.labels | object | `{"app.kubernetes.io/instance":"gov-slack-addon","app.kubernetes.io/managed-by":"Helm","app.kubernetes.io/name":"gov-slack-addon"}` | set of labels for the application  |
| slackAddon.matchLabels | object | `{"app.kubernetes.io/instance":"gov-slack-addon","app.kubernetes.io/name":"gov-slack-addon"}` | set of match labels for the application  |
| slackAddon.nats | object | `{"credsPath":"/nats","subjectPrefix":"governor.events","url":"tls://nats.governor.example.com:4222,"}` | nats setup for the slack addon |
| slackAddon.ports | list | `[{"containerPort":8000,"name":"http"}]` | ports for the slack addon container |
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
