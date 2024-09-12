# Canoe DevOps Tech Assessment API

### About it

This API demonstrates familiarity with Docker containers and basic software development skills. It uses the [FastAPI](https://fastapi.tiangolo.com/) framework to expose four endpoints:

- **`GET /hello_world`**
    Returns a 200 status code with a JSON response: `{ "message": "Hello World!" }`.
- **`GET /current_time?name=some_name`**
    Returns a 200 status code with a JSON response: `{ "timestamp": 1700000000, "message": "Hello some_name" }`
- **`GET /healthcheck`**
    Returns a 200 status code to indicate that the service is healthy.
- **`GET /docs`**
    This is a standard route created by FastAPI to expose the API's Swagger documentation.

### Running locally

To run the API locally using a virtual environment, first install the dependencies:

```bash
pip install -r requirements.txt
```

Then, start the application with:

```bash
fastapi dev api
```

By default, the application will be available on port 8000. Use the `--help` flag for more options.

##### Disclaimer

*While running the application locally with the default fastapi-cli command, the logs will remain in the standard output. To get structured JSON log output, run the application using:*

```bash
python -m api
```

### Building Docker images

#### Staging image

The staging image is intended for use in a safe environment. It retains some commands that may pose security risks but are useful for debugging.

Create it with:
```bash
docker build . -t api:staging --target builder
```

Then, run it with:
```bash
docker run --rm -p 8000:8000 api:staging
```

#### Production image

The production image adds an extra layer of security over the staging image by using a [distroless](https://github.com/GoogleContainerTools/distroless). base. Ensure that the Python version in the `builder` target matches the distroless image.

Create it with:
```bash
docker build . -t api:production
```

Then, run it with:
```bash
docker run --rm -p 8000:8000 api:production
```

### Pushing the image

While Docker images are usually pushed to remotes automatically in CI/CD pipelines, if you want to push an image manually to a private remote, such as AWS ECR, follow the [AWS user guide](https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-push-ecr-image.html). 

Here are the typical steps for pushing images to a private remote:

1. **Authenticate**
    This step involves using the `docker login` command. For AWS ECR, the command would look like this:
    ```bash
    aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.region.amazonaws.com
    ```
2. **Create and/or locate the target image**
    When creating the image with the -t flag, you specify the image name and tag. For ECR, the image name should follow this pattern:
    `${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${APPLICATION_NAME}:${TAG_OR_VERSION}`
    For example:
    `${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/api:production-0.0.1`

3. **Pushing the image**
    Once authenticated, push the image to the remote registry:
    ```bash
    docker push ${AWS_ACCOUNT_ID}.dkr.ecr.region.amazonaws.com/api:production-0.0.1
    ```