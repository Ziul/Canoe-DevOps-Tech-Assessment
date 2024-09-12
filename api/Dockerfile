# Step 1: Build dependencies using python base image
FROM python:3.11.2-slim-buster as builder

WORKDIR /app

# Install dependencies
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code
COPY api ./api

# Create user 1001 and turn him the owner of the /app folder
RUN groupadd -g 1001 appgroup && \
    useradd -u 1001 -g appgroup -m appuser
RUN chown -R appuser:appgroup /app
USER appuser

ENTRYPOINT ["python", "-m", "api"]

# Step 2: Distroless image for runtime
# actually using 3.11.2. Needs to keep it sync with builder image
FROM gcr.io/distroless/python3:nonroot

WORKDIR /app

# Copy source code and dependencies from builder step
COPY --from=builder /app /app
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
ENV PYTHONPATH=/usr/local/lib/python3.11/site-packages

# Ensure rootless image
USER 1001:1001

# Define entrypoint
ENTRYPOINT ["python", "-m", "api"]
