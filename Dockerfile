ARG PYTHON_VERSION=3.12-slim


FROM python:${PYTHON_VERSION}


ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1


WORKDIR /app


RUN apt update -y \
    && apt install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    wait-for-it \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*
   
COPY requirements.txt /app/


RUN set -ex && \
    pip install -U pip && \
    pip install --no-cache-dir -r requirements.txt


COPY . /app/


EXPOSE 8000


CMD [“sh”, “-c”, “python manage.py migrate && python manage.py runserver 0.0.0.0:8000”]