# pulumi-yaml-image-update-issue

This repo demonstrates an error when attempting `pulumi up -y` in YAML runtime on any change

### Reproduction

1. Clone this repository.
2. Log in to your pulumi account from command line.
3. Run `pulumi up -y` in project's root for the first time. It will set up resources. This command will succeed.
  3.1. Optionally, you can open [`http://localhost:3000`](http://localhost:3000) in your browser to verify that the app is up and running (you'll see the default Astro page)
4. Change something within build context, `Dockerfile`, or `Pulumi.yaml` config (you may just uncomment [line 32](https://github.com/octet-stream/pulumi-yaml-image-update-issue/blob/fdb795e6dd17f67598b6ddbf3d5c342cb1df7924/Dockerfile#L32))
5. Run `pulumi up -y` again and you'll see an error.

This error shows up on every change within build context, `Dockerfile`, or `Pulumi.yaml`:

```
Diagnostics:
  docker:index:Container (container):
    error: docker:index/container:Container resource 'container' has a problem: Missing required argument. The argument "image" is required, but no definition was found.. Examine values at 'container.image'.
```

### A workaround I've tried:

```sh
pulumi destroy -y && pulumi up -y
```

Which is wipes out all resources and re-creates them from scratch, which is far from ideal.

### Expected behaviour

When something is changed within build context, `Dockerfile` or `Pulumi.yaml` config the `pulumi up` command succeeds with no error.
