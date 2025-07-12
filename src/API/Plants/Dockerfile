FROM python:3.11-slim

WORKDIR /app
COPY . /app

RUN pip install --upgrade pip && \
    pip install -r packages.txt

EXPOSE 8001
CMD ["python", "manage.py", "runserver", "0.0.0.0:8001"]
