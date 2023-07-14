# pulumi-yaml-image-update-issue

Following error shows up on every change for in build context, Dockerfile, or `Pulumi.yaml`:

```
Diagnostics:
  docker:index:Container (container):
    error: docker:index/container:Container resource 'container' has a problem: Missing required argument. The argument "image" is required, but no definition was found.. Examine values at 'container.image'.
```

A workaround I've tried:

```sh
pulumi destroy -y && pulumi up -y
```

Which is wipes out all resources and re-creates them from scratch.
