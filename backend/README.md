Backend, using Django 3.0

To use, source the virtualenv 'django-env' using:
`source django-env/bin/activate`

After activating the virtualenv, to run the server on 127.0.0.1:8000, navigate to the outlook folder and run:

`python manage.py runserver`

In case it says migrations are pending, run:
`python manage.py migrate`  
&nbsp;
&nbsp;

In order to view documentation for Django application,

First create admin credentials using:

`python manage.py createsuperuser`

Then, run the server and navigate to:
http://127.0.0.1:8000/admin/doc/

&nbsp;

Additional docs at:
`pydoc outlook/backend/news.py`
