FROM python:3.11-slim

WORKDIR /app/

COPY requirements.txt /app/
RUN pip install --no-cache-dir -r /app/requirements.txt

RUN mkdir -p /app/logs && chmod -R 777 /app/logs

COPY . /app/

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]