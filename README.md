# Quay.io image tag verification [![wercker status](https://app.wercker.com/status/65b620ad1f4ca8c0a15484ebaa0e0757/s/master "wercker status")](https://app.wercker.com/project/bykey/65b620ad1f4ca8c0a15484ebaa0e0757)

Using this step, you can verify the existence of an image tag on Quay.io. The
step will fail if the image tag does not exist, possibly preventing you from
deploying an image that does not exist.

## Example

```yml
deploy:
  steps:
  - blendle/verify-quay-tag:
    repository: blendle/true    # required, org/repo format
    tag: other                  # optional, defaults to "$WERCKER_GIT_COMMIT" or "latest"
    token: hello-world          # optional, for private repositories
    message: 4-oh-4!            # optional, printed failure message
    debug: true                 # optional, print debug information
```

## License

The step is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
