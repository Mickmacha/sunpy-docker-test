FROM python:3.12-slim

# Install system dependencies needed from source and install git incase its not present in the container

RUN apt-get update && apt-get install -y --no-install-recommends \

	git \
	
	build-essential \

	&& rm -rf /var/lib/apt/lists/*



# clone sunpy and checkout to the issued commit

RUN git clone https://github.com/sunpy/sunpy.git /sunpy

WORKDIR /sunpy

RUN git checkout a1a081a



# Install sunpy from source not a precompiled version so instead of pip install sunpy, pip install -e

# Install sunpy deps from the pyproject.toml file in the repo

RUN pip install --no-cache-dir \

	"astropy>=6.1.0" \

	"fsspec>=2023.6.0" \

	"numpy>=1.26.0" \

	"packaging>=23.2" \

	"parfive[ftp]>=2.1.0" \

	"pyerfa>=2.0.1.1" \

	"requests>=2.32.1" \  

	"pytest>=7.4.0" \

	"pytest-astropy>=0.11.0" \

	"pytest-mpl>=0.18.0" \
	
	"pytest-xdist" \

	"hvpy>=1.1.0" \

	"jplephem>=2.19" \

	"psutil>=6.0.0"



RUN pip install --no-cache-dir --no-deps -e .
