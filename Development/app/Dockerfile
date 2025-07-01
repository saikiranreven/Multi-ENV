FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt requirements.txt

# Clear pip cache and install fresh versions
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["gunicorn", "--bind", "0.0.0.0:8080", "app:app"]