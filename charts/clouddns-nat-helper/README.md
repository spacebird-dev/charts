# clouddns-nat-helper

![Version: 0.2.16](https://img.shields.io/badge/Version-0.2.16-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.2.14](https://img.shields.io/badge/AppVersion-0.2.14-informational?style=flat-square)

A utility to automatically generate Ipv4 A DNS records for hosts based on existing AAAA records in a DNS zone.

**Homepage:** <https://github.com/spacebird-dev/charts>

## Installation

To install this chart directly, use:

`helm install --repo https://charts.spacebird.dev/ my-clouddns-nat-helper clouddns-nat-helper`

Alternatively, you can also add the repository like so:

`helm repo add spacebird https://charts.spacebird.dev`

And then install the chart from the repository reference:

`helm install spacebird/my-clouddns-nat-helper clouddns-nat-helper`

## Source Code

* <https://github.com/spacebird-dev/clouddns-nat-helper>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| cloudflare.apiToken | string | `""` | Cloudflare API Token to authenticate with |
| cloudflare.proxied | bool | `false` | Set to enable proxying for the generated A records in Cloudflare |
| fixed.address | string | `""` | Use this address for all IPv4 records |
| fullnameOverride | string | `""` |  |
| hostname.dnsServers | list | `[]` | Optional list of DNS servers to query when resolving `hostname.name`. Will use the applications default servers if not set. |
| hostname.name | string | `""` | Resolve this hostname to get the Ipv4 address to put into a records. |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"quay.io/spacebird-dev/clouddns-nat-helper"` |  |
| image.tag | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| interval | int | `0` | Time to wait between update operations in seconds. 0 results in the app default being used |
| ipv4Source | string | `"hostname"` | Set the source to use for determining the A records IPv4 address. Can be either `hostname` or `fixed` |
| loglevel | string | `"info"` | Can be any of error,warn,info,debug,trace |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| policy | string | `"sync"` | What A record actions are permitted. createonly: create, upsert: create,update, sync: create,update,delete |
| provider | string | `"cloudflare"` | DNS provider to use. Currently supported: `cloudflare` |
| registry.tenant | string | `"helm-nat-helper"` | Unique identifier (tenant) that will be used to identify this instance of nat-helper in DNS records |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| tolerations | list | `[]` |  |
| ttl | int | `0` | Optionally set a TTL for newly created records. Will use the provider default if no specified |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Max Hösel | <github@maxhoesel.de> |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
