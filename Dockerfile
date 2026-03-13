# CI Dockerfile for xgbse - used by GitHub Actions
FROM python:3.12-slim

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
	git \
	build-essential \
	&& rm -rf /var/lib/apt/lists/*

# Clone xgbse repository
RUN git clone https://github.com/loft-br/xgboost-survival-embeddings.git /xgbse

WORKDIR /xgbse

# Checkout to specific commit (replace with desired commit hash)
ARG COMMIT_HASH=HEAD
RUN git checkout ${COMMIT_HASH}

# Install dependencies with pinned versions
RUN pip install --no-cache-dir \
	"xgboost==2.1.0" \
	"numpy==1.26.4" \
	"scikit-learn==1.5.0" \
	"pandas==2.2.0" \
	"joblib==1.4.2" \
	"lifelines==0.29.0" \
	"pytest==8.2.2" \
	"pytest-cov==5.0.0" \
	"ruff==0.5.0" \
	"black==24.3.0" \
	"flake8==7.0.0"

# Install the package
RUN pip install --no-cache-dir --no-deps -e .

# Run tests
RUN pytest --cov-report term-missing --cov=xgbse tests/
