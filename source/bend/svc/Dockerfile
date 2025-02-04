FROM python:3.11-slim

WORKDIR /svc/

COPY requirements.txt /svc/
RUN pip install --no-cache-dir -r /svc/requirements.txt

COPY . /svc/

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]