FROM python:3.9.16-slim
LABEL org.opencontainers.image.authors="Heeddata"

WORKDIR /usr/src/app/
ENV PYTHONPATH=/usr/src/app/

RUN pip install --upgrade pip
RUN pip install --upgrade setuptools 

COPY tools/cloud_adapter_handler tools/cloud_adapter_handler
COPY tools/heeddata_exceptions tools/heeddata_exceptions
COPY heeddata_clients/config_client heeddata_clients/config_client
COPY heeddata_clients/auth_client heeddata_clients/auth_client
COPY heeddata_clients/herald_client heeddata_clients/herald_client
COPY heeddata_clients/katara_client heeddata_clients/katara_client
COPY heeddata_clients/metroculus_client heeddata_clients/metroculus_client
COPY heeddata_clients/arcee_client heeddata_clients/arcee_client
COPY heeddata_clients/google_calendar_client heeddata_clients/google_calendar_client
COPY heeddata_clients/insider_client heeddata_clients/insider_client


COPY rest_api/requirements.txt ./rest_api/requirements.txt
RUN pip install --no-cache-dir -r /usr/src/app/rest_api/requirements.txt
# RUN pip install --index-url https://pypi.org/simple/ oci==2.96.1
# COPY live_demo.json ./
COPY rest_api/rest_api_server/alembic rest_api/rest_api_server/alembic
COPY rest_api/rest_api_server/controllers rest_api/rest_api_server/controllers
COPY rest_api/rest_api_server/handlers rest_api/rest_api_server/handlers
COPY rest_api/rest_api_server/models rest_api/rest_api_server/models
COPY rest_api/rest_api_server/*.py rest_api/rest_api_server/
COPY rest_api/rest_api_server/alembic.template rest_api/rest_api_server/alembic.template
COPY rest_api/rest_api_server/swagger rest_api/rest_api_server/swagger
COPY rest_api/rest_api_server/recommendation_cleanup_scripts rest_api/rest_api_server/recommendation_cleanup_scripts
RUN python -u rest_api/rest_api_server/write_spec.py

CMD ["python", "-u","/usr/src/app/rest_api/rest_api_server/server.py"]
EXPOSE 8999

