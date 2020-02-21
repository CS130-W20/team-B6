from django.shortcuts import render, HttpResponse
from django.core import serializers

from backend.models import Post, User

def index(request):
    """Blank response page for root URL."""

    return HttpResponse("This is a response.")

def get_post(request, post_id):
    """GET interface for retrieving a Post based on id."""

    search_results = Post.objects.filter(id=post_id)
    if search_results:
        data = serializers.serialize('json', search_results)
        return HttpResponse(data, content_type="application/json")
    else:
        return HttpResponse("No post with given post id found.")
      
def get_user(request, user_id):
    """GET interface for retrieving a User based on id."""

    search_results = User.objects.filter(id=user_id)
    if search_results:
        data = serializers.serialize('json', search_results)
        return HttpResponse(data, content_type="application/json")
    else:
        return HttpResponse("No user with given user id found.")
