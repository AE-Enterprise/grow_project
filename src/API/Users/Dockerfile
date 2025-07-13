FROM python:3.11-slim

WORKDIR /app
# Copy only required files
COPY manage.py /app/
COPY users_service/*.py /app/users_service/
# Do not copy .env

RUN pip install --upgrade pip && \
    pip install django djangorestframework gunicorn

EXPOSE 8001
CMD ["gunicorn", "users_service.wsgi:application", "--bind", "0.0.0.0:8001"]
