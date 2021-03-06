#!/bin/bash

apt-get update
apt-get install -y build-essential \
  libssl-dev \
  libffi-dev \
  python3-dev \
  python3-pip \
  python3-venv \
  libsasl2-dev \
  libldap2-dev \
  openjdk-8-jdk
apt-get install -y postgresql libpq-dev

su postgres <<'EOF'
  createuser -s -w superset
  createdb superset -O superset
  psql -c "ALTER USER "superset" WITH PASSWORD 'superset';"
EOF

# Superset installation and initialization
# https://github.com/apache/incubator-superset/blob/master/docs/installation.rst#superset-installation-and-initialization

su ubuntu <<'EOF'
  echo 'export PYTHONPATH=/vagrant/.superset:$PYTHONPATH' >> /home/ubuntu/.bash_profile
  source /home/ubuntu/.bash_profile

  python3 -m venv venv
  source venv/bin/activate
  pip install superset "PyAthenaJDBC>1.0.9" psycopg2
  fabmanager create-admin --app superset --username admin --firstname Admin --lastname Superset --email admin@admin.com --password 12345
  superset db upgrade
  superset load_examples
  superset init
EOF

# Start the web server on port 8088, use -p to bind to another port
# superset runserver
