from django.urls import path

from . import views

urlpatterns = [
        path('', views.index, name='empty_index'),
        path('posts/<int:post_id>', views.get_post, name='get_post'),
        path('users/<int:user_id>', views.get_profile, name="get_profile"),
        path('users/put/<int:user_id>', views.put_profile, name="put_profile"),
        path('users/<int:user_id>/comments', views.get_comments_by_user_id, name="get_comments_by_user_id"),
        path('login', views.login, name="login"),
        path('signup', views.signup, name="signup"),
        path('comments/<int:post_id>', views.get_comments_for_post, name="get_comments_for_post"),
        path('comments/add/<int:post_id>', views.add_comment_to_post, name="add_comment_to_post"),
        path('newsfeed', views.get_newsfeed_posts, name="get_newsfeed_posts"),
        path('newsfeed/source/<str:source>', views.get_newsfeed_posts_from_source, name='get_newsfeed_posts_from_source'),
        path('newsfeed/category/<str:category>', views.get_newsfeed_posts_from_category, name='get_newsfeed_posts_from_category'),
        path('posts/increment_like/<int:post_id>', views.increment_like, name='increment_like'),
        path('comments/get_replies/<int:comment_id>', views.get_replies_for_comment, name='get_replies_for_comment'),
        path('users/<int:user_id>/followers', views.get_followers, name="get_followers")
]
