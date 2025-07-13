FROM python:3.11-slim

WORKDIR /app
# Copy only required files
COPY manage.py /app/
COPY auth_service/*.py /app/auth_service/
# Do not copy .env

RUN pip install --upgrade pip && \
    pip install django djangorestframework gunicorn

EXPOSE 8001
CMD ["gunicorn", "auth_service.wsgi:application", "--bind", "0.0.0.0:8001"]
