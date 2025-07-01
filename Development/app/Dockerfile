FROM python:3.12-slim

WORKDIR /app

COPY . .

RUN pip install flask

ENV PORT 8080

CMD ["python", "app.py"]