# paperless

![Version: 0.3.1](https://img.shields.io/badge/Version-0.3.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.11.6](https://img.shields.io/badge/AppVersion-2.11.6-informational?style=flat-square)

Helm Chart to install paperless-ngx along with Tika and Gotenberg

Please note that this chart is still relatively new and not all features/values have been tested.
If you encounter any issues/bugs, feel free to file an issue/PR!

**Homepage:** <https://github.com/spacebird-dev/charts>

## Installation

To install this chart directly, use:

`helm install --repo https://charts.spacebird.dev/ my-paperless paperless`

Alternatively, you can also add the repository like so:

`helm repo add spacebird https://charts.spacebird.dev`

And then install the chart from the repository reference:

`helm install spacebird/my-paperless paperless`

## Source Code

* <https://github.com/paperless-ngx/paperless-ngx>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| db.external.database.existingSecret | object | `{}` |  |
| db.external.database.name | string | `""` | Remote DB databse |
| db.external.host.existingSecret | object | `{}` |  |
| db.external.host.name | string | `""` | Remote DB hostname |
| db.external.password.existingSecret | object | `{}` |  |
| db.external.password.value | string | `""` | Remote DB password |
| db.external.port.existingSecret | object | `{}` |  |
| db.external.port.value | int | `5432` | Remote DB port |
| db.external.sslClientCert.certificate | string | `""` | Remote DB client TLS certificate |
| db.external.sslClientCert.existingSecret | object | `{}` |  |
| db.external.sslClientKey.existingSecret | object | `{}` |  |
| db.external.sslClientKey.key | string | `""` | Remote DB client TLS key |
| db.external.sslMode | string | `""` | Remote DB SSL/TLS connection mode. See https://docs.paperless-ngx.com/configuration/#PAPERLESS_DBSSLMODE |
| db.external.sslRootCert.certificate | string | `""` | Remote DB server TLS certificate |
| db.external.sslRootCert.existingSecret | object | `{}` |  |
| db.external.type | string | `""` | If not empty, will skip db installation and use an external database instead. Accepted values are "" (managed install), "mariadb" and "postgresql" |
| db.external.user.existingSecret | object | `{}` |  |
| db.external.user.name | string | `""` | Remote DB username |
| db.mariadb.enabled | bool | `false` | Install a bundled mariadb database instead of SQLite. If enabled, you must not use another bundled/external DB |
| db.postgres.enabled | bool | `false` | Install a bundled postgresql database instead of SQLite. If enabled, you must not use another bundled/external DB |
| db.sqlite.enabled | bool | `true` | Use the integrated sqlite database, enabled by default The database is stored in the data PVC If disabled, you must use another bundled/external DB |
| fullnameOverride | string | `""` |  |
| gotenberg.bundled.enabled | bool | `true` | Use the bundled gotenberg install. Ignored if `external.endpoint` is set |
| gotenberg.external.endpoint | string | `""` | Gotenberg URL as expected by paperless, e.g: http://localhost:3000 |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"paperless-ngx.example.com"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.tls | list | `[]` |  |
| mariadb | object | `{"auth":{"database":"paperless","password":"paperless","username":"paperless"},"primary":{"service":{"ports":{"mysql":3306}}}}` | Default credentials for the bundled mariadb DB |
| nameOverride | string | `""` |  |
| paperless.admin.email.address | string | `"admin@exmaple.com"` | Email of the admin user |
| paperless.admin.email.existingSecret | object | `{}` |  |
| paperless.admin.enabled | bool | `false` | Whether to install a default admin user with the provided credentials. |
| paperless.admin.password.existingSecret | object | `{}` |  |
| paperless.admin.password.value | string | `""` | Password of the admin user |
| paperless.admin.user.existingSecret | object | `{}` |  |
| paperless.admin.user.name | string | `"admin"` | Name of the admin user |
| paperless.affinity | object | `{}` |  |
| paperless.appTitle | string | `"Paperless-ngx"` | Override the default app title shown in the frontend |
| paperless.extraConfig | object | `{}` | Additional Configuration parameters to pass to paperless. Expects key-value pairs of config options and values. See https://docs.paperless-ngx.com/configuration |
| paperless.extraVolumeMounts | list | `[]` |  |
| paperless.extraVolumes | list | `[]` |  |
| paperless.image.pullPolicy | string | `"IfNotPresent"` |  |
| paperless.image.repository | string | `"ghcr.io/paperless-ngx/paperless-ngx"` |  |
| paperless.image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion. |
| paperless.imagePullSecrets | list | `[]` |  |
| paperless.livenessProbe.httpGet.path | string | `"/"` |  |
| paperless.livenessProbe.httpGet.port | string | `"http"` |  |
| paperless.nodeSelector | object | `{}` |  |
| paperless.ocr.defaultLanguage | string | `"eng"` | OCR default language. See https://packages.debian.org/search?keywords=tesseract-ocr-&searchon=names&suite=buster |
| paperless.ocr.extraLanguages | string | `"deu fra"` | OCR extra languages. |
| paperless.pathPrefix | string | `""` | Set if accessing paperless via a domain subpath e.g. https://domain.com/PATHPREFIX and using a reverse-proxy like traefik or nginx. Expects a prefix like "/prefix-path" |
| paperless.podAnnotations | object | `{}` |  |
| paperless.podLabels | object | `{}` |  |
| paperless.podSecurityContext.fsGroup | int | `1000` |  |
| paperless.readinessProbe.httpGet.path | string | `"/"` |  |
| paperless.readinessProbe.httpGet.port | string | `"http"` |  |
| paperless.replicaCount | int | `1` | Number of deployment replicas. Note that the paperless container is not ready for multi-replica deployments |
| paperless.resources | object | `{}` |  |
| paperless.secretKey.existingSecret | object | `{}` |  |
| paperless.secretKey.value | string | `""` | Paperless server secret for tokens/etc. This should be a long random string |
| paperless.securityContext | object | `{}` |  |
| paperless.smtp.encryption | string | `""` | Whether to enable SMTP encryption or not. Valid options are false/"", "ssl", "tls" |
| paperless.smtp.from.address | string | `"no-reply-paperless@exmaple.com"` | SMTP FROM email address |
| paperless.smtp.from.existingSecret | object | `{}` |  |
| paperless.smtp.host.existingSecret | object | `{}` |  |
| paperless.smtp.host.name | string | `"localhost"` | SMTP host to relay Emails to |
| paperless.smtp.password.existingSecret | object | `{}` |  |
| paperless.smtp.password.value | string | `""` | SMTP login password |
| paperless.smtp.port.existingSecret | object | `{}` |  |
| paperless.smtp.port.value | int | `25` | Port of the SMTP host |
| paperless.smtp.user.existingSecret | object | `{}` |  |
| paperless.smtp.user.name | string | `""` | SMTP login user |
| paperless.tolerations | list | `[]` |  |
| paperless.tz | string | `"UTC"` | Paperless server Timezone |
| paperless.url | string | `"https://paperless-ngx.example.com"` |  |
| paperless.volumes.consumption.mountPath | string | `"/usr/src/paperless/consume"` |  |
| paperless.volumes.consumption.persistence.accessMode | string | `"ReadWriteOnce"` |  |
| paperless.volumes.consumption.persistence.enabled | bool | `true` | Enable PV/PVC creation for the consumption directory containing incoming documents. If disabled, the consumption directory will not be exposed, so uploads will only be possible via the API/WebUI |
| paperless.volumes.consumption.persistence.size | string | `"5Gi"` |  |
| paperless.volumes.consumption.persistence.storageClass | string | `""` |  |
| paperless.volumes.consumption.persistence.volumeName | string | `""` | - Optionally specify an existing PV to bind to, instead of creating a new one on install. |
| paperless.volumes.data.mountPath | string | `"/usr/src/paperless/data"` |  |
| paperless.volumes.data.persistence.accessMode | string | `"ReadWriteOnce"` |  |
| paperless.volumes.data.persistence.enabled | bool | `true` | Enable persistence for the data directory containing paperless application data. Disable for an ephemeral install. |
| paperless.volumes.data.persistence.size | string | `"5Gi"` |  |
| paperless.volumes.data.persistence.storageClass | string | `""` |  |
| paperless.volumes.data.persistence.volumeName | string | `""` | - Optionally specify an existing PV to bind to, instead of creating a new one on install |
| paperless.volumes.export.mountPath | string | `"/usr/src/paperless/export"` |  |
| paperless.volumes.export.persistence.accessMode | string | `"ReadWriteOnce"` |  |
| paperless.volumes.export.persistence.enabled | bool | `true` | Enable PV/PVC creation for the export directory containing exported data. If disabled, there will be no exposed export directory |
| paperless.volumes.export.persistence.size | string | `"5Gi"` |  |
| paperless.volumes.export.persistence.storageClass | string | `""` |  |
| paperless.volumes.export.persistence.volumeName | string | `""` | - Optionally specify an existing PV to bind to, instead of creating a new one on install. |
| paperless.volumes.media.mountPath | string | `"/usr/src/paperless/media"` |  |
| paperless.volumes.media.persistence.accessMode | string | `"ReadWriteOnce"` |  |
| paperless.volumes.media.persistence.enabled | bool | `true` | Enable persistence for the media directory containing processed documents. Disable for an ephemeral install. |
| paperless.volumes.media.persistence.size | string | `"5Gi"` |  |
| paperless.volumes.media.persistence.storageClass | string | `""` |  |
| paperless.volumes.media.persistence.volumeName | string | `""` | - Optionally specify an existing PV to bind to, instead of creating a new one on install |
| postgresql | object | `{"auth":{"database":"paperless","password":"paperless","username":"paperless"},"primary":{"service":{"ports":{"postgresql":5432}}}}` | Default credentials for the bundled postgres DB |
| redis.architecture | string | `"standalone"` | Architecture of the managed redis instance. Defaults to single-node master operation. Note that changing this value is untested and may have undesirable results. |
| redis.auth.enabled | bool | `true` |  |
| redis.auth.password | string | `"paperless"` | Password for the bundled redis service |
| redis.bundled.enabled | bool | `true` | Install a managed redis instance. Ignored if an external redis server is defined below |
| redis.external.existingSecret | string | `nil` |  |
| redis.external.url | string | `""` | Use an external redis server through its url starting with redis:// |
| redis.master.persistence.enabled | bool | `false` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` | How to expose paperless to the k8s cluster. If you want to configure external access, use the `ingress` configuration instead. |
| tika.bundled.enabled | bool | `true` | Use the bundled tika install for document processing. Ignored if `external.endpoint` is set |
| tika.external.endpoint | string | `""` | External Tika URL as expected by paperless, e.g: http://localhost:9998 |

### Note on `existingSecret`

Many of the values in the chart can also be sourced from existing secrets.
Check `values.yaml`, if a key has an `existingSecret` sibling, you can uncomment the `existingSecret` definition and it will take precedence over the directly supplied value.

Example:

```yaml
paperless:
  secretKey:
    # -- Paperless server secret for tokens/etc. This should be a long random string
    value: ""
    existingSecret: {}
    # 👇 Uncomment this, remove the empty braces and supply a secret to use the value form said secret instead of `value`.
    #  name: ""
    #  key: ""
```

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
