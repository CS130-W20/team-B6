from django.shortcuts import render, HttpResponse
from django.core import serializers

from backend.models import User

# Create your views here.
def index(request):
    return HttpResponse("This is a response.")

def get_user(request, user_id):
    search_results = User.objects.filter(id=user_id)
    if search_results:
        data = serializers.serialize('json', search_results)
        return HttpResponse(data, content_type="application/json")
    else:
        return HttpResponse("No user with given user id found.")
