# Raspberry Pi Buildkite agent

A docker image for running a buildkite agent on a raspberry pi

# Building Agent
```
docker build -t buildkite-agent-pi .
```

Build with specified Buildkite agent verstion
```
docker build --build-arg BK_VERSION=3.23.1 -t buildkite-agent-pi .
```

# Running Agent
```
docker run -e BUILDKITE_AGENT_TOKEN="<your-agent-token>" buildkite-agent-pi
```

# References
Detailed Buildkite docs on running a docker agent can be found [here](https://buildkite.com/docs/agent/v3/docker)

Official buildkite images can be found [here](https://hub.docker.com/r/buildkite/agent/)

**At the time of building this, Buildkite doesn't offer a rpi image via dockerhub.*