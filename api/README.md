# Canoe DevOps Tech Assessment API

### About it

This API have as goal demonstrate familiarity with Docker containers and some software development skills. It uses [FastAPI](https://fastapi.tiangolo.com/) Framework to expose four endpoints:

- **`GET /hello_world`**
    Should returns a 200 status code with `{ "message": "Hello World!" }` JSON response.
- **`GET /current_time?name=some_name`**
    Should returns a 200 status code with `{ "timestamp": 1700000000, "message": "Hello some_name" }`
- **`GET /healthcheck`**
    Should returns a 200 status code to indicate that the service is healthy
- **`GET /docs`**
    This is a standard route created by FastAPI to expose the API' Swagger.

### Running locally

Using a virtual envioriments, install the dependencies with:

```bash
pip install -r requirements.txt
```

Then, run the application with:

```bash
fastapi dev api
```

This should make the application available, by default, on port 8000. Use the flag `--help` for more options.

### Building Docker images

#### Staging image

The staging image has the objective to run in a safe envioriment. It still keep some commands thatmay represents some issue security, but are welcome for debuging.

Create it with:

```bash
docker build . -t api:staging --target builder
```

Than run it with:

```bash
docker run --rm -p 8000:8000 api:staging
```

#### Production image

The production image adds a layer of security over the staging, as this image is [distroless](https://github.com/GoogleContainerTools/distroless). To keep it available, is required to keep the python image from the `builder` target with the same version from the distroless.

Create it with:

```bash
docker build . -t api:production
```

Than run it with:

```bash
docker run --rm -p 8000:8000 api:production
```

### Pushing the image

Docker images shouldn't being pushed to remotes manually, but if you desire to push an image to a private remote, as ECR for example, you should follow the [AWS userguide](https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-push-ecr-image.html). Pushing images to any private remote usually  have the following steps:

1. **Authenticate**
    This step usually envolves the `docker login` command to get yourself authenticated. For AWS ECR it should be something like:
    ```bash
    aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.region.amazonaws.com
    ```
2. **Create and/or locate the target image**
    When you creates the image with the flag `-t`, you sets the name:tag of the image. In the examples or creating the image, it creates the images `api:production` and `api:staging`. To push images for ECR, it requires to have the following patter name: `${AWS_ACCOUNT_ID}.dkr.ecr.region.amazonaws.com/${APPLICATION_NAME}:${TAG_OR_VERSION}`. For us, would be something like: `${AWS_ACCOUNT_ID}.dkr.ecr.region.amazonaws.com/api:production-0.0.1`.

3. **Pushing the image**
    After authenticated, the pushing step should be very similar to any other remote:
    ```bash
    docker push ${AWS_ACCOUNT_ID}.dkr.ecr.region.amazonaws.com/api:production-0.0.1
    ```