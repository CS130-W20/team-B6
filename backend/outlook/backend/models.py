from django.db import models
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver

class Comment(models.Model):
    """Comment model to represent all the data about a comment."""
    
    claim = models.CharField(max_length=140)
    argument = models.CharField(max_length=140)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    is_agreement = models.BooleanField(default=True)
    parent_comment = models.ForeignKey('self', on_delete=models.CASCADE, null=True, blank=True)
    parent_post = models.ForeignKey('Post', on_delete=models.CASCADE)

    def __str__(self):
        rep = ''
        rep += 'id: ' + str(self.id) + '\n'
        rep += 'claim: ' + str(self.claim) + '\n'
        rep += 'argument: ' + str(self.argument) + '\n'
        rep += 'user: ' + str(self.user) + '\n'
        rep += 'is_agreement: ' + str(self.is_agreement) + '\n'
        rep += 'parent_comment: ' + str(self.parent_comment) + '\n'
        rep += 'parent_post: ' + str(self.parent_post) + '\n'
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

    source_name = models.CharField(max_length=2000)
    # author length should be more because sometimes
    # it includes the source name as well.
    author = models.CharField(max_length=2000, null=True, blank=True)
    title = models.CharField(max_length=2000)
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

class Post(models.Model):
    """Post model to represent a post on a news feed."""

    article = models.OneToOneField(Article, on_delete=models.CASCADE)
    creation_timestamp = models.DateTimeField(auto_now_add=True)
    like_count = models.IntegerField(default=0)

    def __str__(self):
        rep = ''
        rep += 'Id: ' + str(self.id) + '\n'
        rep += 'Creation Timestamp: ' + str(self.creation_timestamp) + '\n'
        rep += 'Like Count: ' + str(self.like_count) + '\n'
        return rep
