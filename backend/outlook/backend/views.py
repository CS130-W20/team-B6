from django.shortcuts import render, HttpResponse
from django.core import serializers
import json
from django.contrib.auth.password_validation import validate_password
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from django.views.decorators.csrf import csrf_exempt
from rest_framework.authtoken.models import Token
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny
from rest_framework.status import (
    HTTP_400_BAD_REQUEST,
    HTTP_404_NOT_FOUND,
    HTTP_200_OK
)
from rest_framework.response import Response

from backend.models import Post, Profile

@csrf_exempt
@api_view(["GET"])
def index(request):
    """Blank response page for root URL."""

    return HttpResponse("This is a response.")

@csrf_exempt
@api_view(["POST"])
@permission_classes((AllowAny,))
def signup(request):
    required_data = [
      "username",
      "password",
      "firstname",
      "lastname"
    ]
    data = json.loads(request.body)
    for key in required_data:
        if key not in data:
            return HttpResponse("Missing data to create user.", status=401)
    if User.objects.filter(username=data["username"]):
        return HttpResponse("Username already in use.", status=409)
    try:
        validate_password(data["password"])
    except:
        return HttpResponse("Password is not strong enough.", status=400)
    new_user = User(username=data["username"])
    new_user.set_password(data["password"])
    new_user.save()
    new_profile = Profile(first_name=data["firstname"], last_name=data["lastname"])
    new_profile.user = new_user
    new_profile.save()
    return HttpResponse("User created successfully.")

@csrf_exempt
@api_view(["POST"])
@permission_classes((AllowAny,))
def login(request):
    username = request.data.get("username")
    password = request.data.get("password")
    if username is None or password is None:
        return Response({'error': 'Please provide both username and password'},
                        status=HTTP_400_BAD_REQUEST)
    user = authenticate(username=username, password=password)
    if not user:
        return Response({'error': 'Invalid Credentials'},
                        status=HTTP_404_NOT_FOUND)
    token, _ = Token.objects.get_or_create(user=user)
    return Response({'token': token.key},
                    status=HTTP_200_OK)

@csrf_exempt
@api_view(["GET"])
def get_post(request, post_id):
    """GET interface for retrieving a Post based on id."""

    search_results = Post.objects.filter(id=post_id)
    if search_results:
        data = serializers.serialize('json', search_results)
        return HttpResponse(data, content_type="application/json")
    else:
        return HttpResponse("No post with given post id found.")
      
@csrf_exempt
@api_view(["GET"])
def get_profile(request, user_id):
    """GET interface for retrieving a Profile based on user id."""

    search_results = User.objects.filter(id=user_id)
    if search_results:
        data = serializers.serialize('json', [search_results.first().profile])
        return HttpResponse(data, content_type="application/json")
    else:
        return HttpResponse("No user with given user id found.")

@csrf_exempt
@api_view(["PUT"])
def put_profile(request, user_id):
    """PUT interface for updating Profile details.
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
    search_results = User.objects.filter(id=user_id)
    if search_results:
        target_profile = search_results.first().profile
    else:
        return HttpResponse("No user found with given user id")

    data = json.loads(request.body)
    for field_name in field_names:
        if field_name in data:
            setattr(target_profile, field_name, data[field_name])
    target_profile.save()
    return HttpResponse("Update operation successful.")
