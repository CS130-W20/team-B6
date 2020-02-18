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
