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

def put_user(request, user_id):
    """PUT interface for updating User details.
    The request body (json) will be checked for the parameters in
    the field_names list.
    """

    field_names = [
        "first_name",
        "last_name",
        "email_address",
        "description",
        # profile_picture TODO: Need to implement an image upload service.
    ]
    if request.method != 'PUT':
        return HttpResponse("Need to use PUT method for this interface.")
    target_user = get_user(None, user_id)
    for field_name in field_names:
        if field_name in request.body:
            setattr(target_user, field_name, request.body[field_name])
    target_user.save()
    return HttpResponse("Update operation successful.")
