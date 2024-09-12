import uvicorn

from typing import Union
from time import time

from fastapi import FastAPI, Response, status
from api.logger import logger
from os import environ

app = FastAPI(
    title="API",
    summary="Canoe DevOps Tech Assessment API",
    version=environ.get('VERSION', "0.0.1")
)


@app.get("/hello_world")
def hello_world():
    """Hello World endpoint"""
    return { "message": "Hello World!" }


@app.get("/current_time")
def current_time(name: Union[str, None] = None):
    """current_time endpoint"""
    return {"timestamp": time() , "name": name}

@app.get("/healthcheck", include_in_schema=False) # hide route for swagger
def healthcheck():
    """Healthcheck endpoint"""
    return Response(status_code=status.HTTP_200_OK)

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000, log_config=None)