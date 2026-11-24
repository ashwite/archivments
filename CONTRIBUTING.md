# Contributing

Pick one change per pull request. Include a sample workflow and a test when adding support for a new field. Run `ruby test/ci_bridge_test.rb` before opening the PR.

Good first contributions:

- Add support for `working-directory` on individual run steps.
- Add support for static job-level environment variables.
- Add a Python example once Python setup is supported.
- Document how to select a GitLab runner that supports container images.

Use GitHub Discussions in the Q&A category for migration questions once it is enabled. For a bug report, include the smallest workflow that reproduces the problem. Remove credentials and private repository details from examples.

For work done together, record both authors with a `Co-authored-by: Name <email>` trailer in the commit. Use an email address associated with the contributor's GitHub account and keep the trailer in the merged commit.
