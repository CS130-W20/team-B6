from django.db import models
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver

class Post(models.Model):
    """Post model to represent a post on a news feed."""

    creation_timestamp = models.DateTimeField()
    like_count = models.IntegerField(default=0)
    news_article_url = models.URLField()

    def __str__(self):
        rep = ''
        rep += 'Id: ' + str(self.id) + '\n'
        rep += 'Creation Timestamp: ' + str(self.creation_timestamp) + '\n'
        rep += 'Like Count: ' + str(self.like_count) + '\n'
        rep += 'News Article Url: ' + str(self.news_article_url) + '\n'
        return rep

class Profile(models.Model):
    """Profile model to represent details about a single user of the app."""

    user = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True)
    first_name = models.CharField(max_length=20)
    last_name = models.CharField(max_length=20)
    email_address = models.EmailField(max_length=70)
    description = models.CharField(max_length=140)
    profile_picture_url = models.URLField()

    def __str__(self):
        rep = ''
        rep += 'id: ' + str(self.id) + '\n'
        rep += 'first_name: ' + str(self.first_name) + '\n'
        rep += 'last_name: ' + str(self.last_name) + '\n'
        rep += 'email_address: ' + str(self.email_address) + '\n'
        rep += 'description: ' + str(self.description) + '\n'
        rep += 'profile_picture_url: ' + str(self.profile_picture_url) + '\n'
        rep += 'user: ' + str(self.user) + '\n'
        return rep

@receiver(post_save, sender=User)
def create_user_profile(sender, instance, created, **kwargs):
    if created:
        Profile.objects.create(user=instance)

@receiver(post_save, sender=User)
def save_user_profile(sender, instance, **kwargs):
    instance.profile.save()

class Article(models.Model):
    """Article model to represent a single news article."""

    source_name = models.CharField(max_length=20)
    # author length should be more because sometimes
    # it includes the source name as well.
    author = models.CharField(max_length=100)
    title = models.CharField(max_length=100)
    article_url = models.URLField(unique=True)
    article_image_url = models.URLField()
    publish_date = models.DateTimeField()

    def __str__(self):
        rep = ''
        rep += 'id: ' + str(self.id) + '\n'
        rep += 'source_name: ' + str(self.source_name) + '\n'
        rep += 'author: ' + str(self.author) + '\n'
        rep += 'title: ' + str(self.title) + '\n'
        rep += 'article_url: ' + str(self.article_url) + '\n'
        rep += 'article_image_url: ' + str(self.article_image_url) + '\n'
        rep += 'publish_date: ' + str(self.publish_date) + '\n'
        return rep
