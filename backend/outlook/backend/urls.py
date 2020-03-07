from django.urls import path

from . import views

urlpatterns = [
        path('', views.index, name='empty_index'),
        path('posts/<int:post_id>', views.get_post, name='get_post'),
        path('users/<int:user_id>', views.get_user, name="get_user"),
        path('users/put/<int:user_id>', views.put_user, name="put_user"),
]
