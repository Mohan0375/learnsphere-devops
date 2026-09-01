FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1     PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .
COPY templates ./templates
COPY static ./static

EXPOSE 5000

HEALTHCHECK --interval=15s --timeout=5s --start-period=20s --retries=3   CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:5000/health', timeout=4)" || exit 1

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2", "--access-logfile", "-", "--error-logfile", "-", "app:app"]
