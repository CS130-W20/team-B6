from django.urls import path

from . import views

urlpatterns = [
        path('', views.index, name='empty_index'),
        path('posts/<int:post_id>', views.get_post, name='get_post'),
]
