from django.shortcuts import render, HttpResponse
from django.core import serializers

from backend.models import Post

# Create your views here.
def index(request):
    return HttpResponse("This is a response.")

def get_post(request, post_id):
    search_results = Post.objects.filter(id=post_id)
    if search_results:
        data = serializers.serialize('json', search_results)
        return HttpResponse(data, content_type="application/json")
    else:
        return HttpResponse("No post with given post id found.")
