from django.urls import path

from . import views

urlpatterns = [
        path('', views.index, name='empty_index'),
        path('posts/<int:post_id>', views.get_post, name='get_post'),
        path('users/<int:user_id>', views.get_profile, name="get_profile"),
        path('users/put/<int:user_id>', views.put_profile, name="put_profile"),
        path('login/', views.login, name="login"),
        path('signup/', views.signup, name="signup"),
]
