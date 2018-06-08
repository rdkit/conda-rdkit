Dockerfile for doing RDKit linux builds and uploading the results to conda.

Note that you need to provide a conda user and conda token for this to work. Example invocation:
```
docker build -t conda-docker-build --build-arg anaconda_user=rdkit --build-arg anaconda_token="REPLACE_ME" .
```
