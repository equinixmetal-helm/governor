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
