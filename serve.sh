#!/bin/bash
cd /root
git clone  https://github.com/EmbeddedAndroid/simply-posted-portal.git
cd simply-posted-portal && \
pip install -r requirements.txt
./manage.py migrate
./manage.py collectstatic --noinput
./manage.py loaddata sites
echo "from django.contrib.auth.models import User; User.objects.create_superuser('$USERNAME', '$EMAIL', '$PASSWORD')" | python manage.py shell
./manage.py sync_plans
./manage.py sync_customers
./manage.py runserver 0.0.0.0:8000
