from django.urls import path

from . import views

urlpatterns = [
        path('', views.index, name='empty_index'),
        path('users/<int:user_id>', views.get_user, name="get_user"),
]
