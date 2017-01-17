#!/bin/bash
mkdir -p /webapps
cd /webapps
git clone  https://github.com/EmbeddedAndroid/simply-posted-portal.git
cd simply-posted-portal && \
groupadd --system webapps
useradd --system --gid webapps --shell /bin/bash --home /webapps/simply-posted-portal simplyposted
pip install -r requirements.txt
./manage.py migrate
./manage.py collectstatic --noinput
./manage.py loaddata sites
echo "from django.contrib.auth.models import User; User.objects.create_superuser('$USERNAME', '$EMAIL', '$PASSWORD')" | python manage.py shell
./manage.py sync_plans
./manage.py sync_customers
chown -Rv simplyposted /webapps/simply-posted-portal/
if [ "$DEPLOYMENT" = "production" ];
then
	gunicorn simply_posted_portal.wsgi:application --user=simplyposted --group=webapps --workers=5 --log-level=debug --bind=0.0.0.0:8000
else
	./manage.py runserver 0.0.0.0:8000
fi
