```shell
docker build . -t bmwilson74/rlcraft-server
docker run -v $(pwd)/data:/data -ti bmwilson74/rlcraft-server
docker push bmwilson74/rlcraft-server:1.12.2
```