from django.db import models

# Create your models here.

class Post(models.Model):
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

class User(models.Model):
    user_name = models.CharField(unique=True, max_length=20)
    first_name = models.CharField(max_length=20)
    last_name = models.CharField(max_length=20)
    email_address = models.EmailField(max_length=70)
    description = models.CharField(max_length=140)
    profile_picture_url = models.URLField()

    def __str__(self):
        rep = ''
        rep += 'id: ' + str(self.id) + '\n'
        rep += 'user_name: ' + str(self.user_name) + '\n'
        rep += 'first_name: ' + str(self.first_name) + '\n'
        rep += 'last_name: ' + str(self.last_name) + '\n'
        rep += 'email_address: ' + str(self.email_address) + '\n'
        rep += 'description: ' + str(self.description) + '\n'
        rep += 'profile_picture_url: ' + str(self.profile_picture_url) + '\n'
        return rep
