import requests

# checking this in to git as it just does GET requests
# on public sources, so it is not a security risk.
API_KEY = "06b29a383ab7424fb93a9d7fa418db6f"

def config_for_external_scripts():
    import os, sys, django
    sys.path.append('/Users/rishabhjain/Documents/team-B6/backend/outlook')
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "outlook.settings")
    django.setup()

def retrieve_top_articles():
    params = {
        "apiKey": API_KEY,
        "country": "us",
    }

    url = "http://newsapi.org/v2/top-headlines"
    data = requests.get(url=url, params=params).json()
    if not data["articles"]:
        raise Exception("Empty return for top headlines from API")
    return data["articles"]

def save_article_data(article):
    from backend.models import Article
    # Check if article already exists in the DB.
    # Primary key should be the article URL.

    # If article does not already exist, save it now.
    new_article = Article()
    new_article.source_name = article["source"]["name"]
    new_article.title = article["title"]
    new_article.author = article["author"]
    new_article.publish_date = article["publishedAt"]
    new_article.save()
    return 1

def generate_news_feed():
    top_articles = retrieve_top_articles()
    for article in top_articles:
        save_article_data(article)
    # make this list of top articles easily accessible through endpoint