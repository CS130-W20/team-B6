from django.db import models

# Create your models here.

class Post(models.Model):
    creation_date = models.DateTimeField()
    like_count = models.IntegerField(default=0)

    def __str__(self):
        rep = ''
        rep += 'Creation Date: ' + str(self.creation_date) + '\n'
        rep += 'Like Count: ' + str(self.like_count) + '\n'
        return rep
