### tailscale android builder

This repo will build the tailscale android client with a custom server url
using github actions.

### Usage:

1. Fork this repo
2. Configure secrets for github actions:

* `CR_PAT`: personal access token with read access to ghcr
* `TAILSCALE_SERVER`: FQDN of tailscale server: e.g. https://controlplane.tailscale.com

3. Build the "builder image" for the apk:

```
make docker
```

4. Push the builder image to ghcr:

```
docker tag tailscale-android-builder ghcr.io/<github_username>/tailscale-android-builder
docker push ghcr.io/<github_username>/tailscale-android-builder
```

5. Trigger a workflow run in github actions. The apk will be stored as an
   artifact of the build. Recommend deleting the artifact after downloading
   from github if it is public, as this will contain your personal control
   plane server fqdn.

### versioning:

The tailscale-android repo is a submodule. Update the submodule commit sha to
the target release and push to recreate a new apk.
