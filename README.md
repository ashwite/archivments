# CI Bridge

Convert a small GitHub Actions workflow into GitLab CI YAML. The included Node.js example installs dependencies, runs a test and checks the source syntax on both platforms.

## Try it

Requires Ruby with Psych. The project CI uses Ruby 3.4.

```sh
bin/ci-bridge .github/workflows/node-example.yml > converted.gitlab-ci.yml
ruby test/ci_bridge_test.rb
```

The GitLab pipeline includes [the converted example](examples/gitlab-node.yml). To refresh the checked-in example after editing the source workflow, run:

```sh
bin/ci-bridge .github/workflows/node-example.yml > examples/gitlab-node.yml
```

## Supported workflows

Use an unfiltered `push` trigger and jobs on `ubuntu-latest`. Each job starts with `actions/checkout@v4` and `actions/setup-node@v4`, with a numeric `node-version`, followed by one or more shell commands. The output uses the corresponding `node` container image on a GitLab runner configured to run container jobs. Use commands that work with POSIX shell syntax in that container.

The converter reports unsupported fields, actions and GitHub expressions. Review the output before using it in CI, especially when commands depend on the original runner environment.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for starter tasks and the [publishing guide](PUBLISHING.md) for setup on both platforms.

## Run the Node.js example locally

From the repository root, run:

```sh
npm --prefix examples/node ci
npm --prefix examples/node test
npm --prefix examples/node run build
```
