"""Script to generate a newsfeed and save it to DB.

Use the driver function generate_news_feed() to get a 
list of top headlines from all news sources from newsapi.org,
and then save each article to the DB while avoiding duplicates.
In case using a cron job to run this script outside of the
Django app, use config_for_external_scripts() to get access 
to the Django models.
"""

# checking this in to git as it just does GET requests
# on public sources, so it is not a security risk.
API_KEY = "06b29a383ab7424fb93a9d7fa418db6f"

def config_for_external_scripts():
    """Config to access Django models directly.

    We need to run this function in order to gain access
    for storing new articles into the DB.
    Only need to call this function in case an external 
    cron job wants to generate a new newsfeed.
    """

    import os, sys, django
    sys.path.append('../')
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "outlook.settings")
    django.setup()

def retrieve_top_articles(source=None, category=None):
    """Retrieve the headlines from all news sources.

    Queries newsapi.org to get the top headlines for all
    news sources in the United States. Raises an exception 
    in case it receives an empty response.
    """

    import requests
    params = {
        "apiKey": API_KEY,
        "country": "us",
    }
    if source:
        params["sources"] = source
        del params["country"]
    if category:
        params["category"] = category

    url = "http://newsapi.org/v2/top-headlines"
    data = requests.get(url=url, params=params).json()
    if "articles" not in data or not data["articles"]:
        raise Exception("Empty return for top headlines from API")
    return data["articles"]

def save_article_data(article):
    """Save an individual article.

    Parses an article from the newsapi.org format to the 
    required model, and also avoids duplicates.
    """

    from backend.models import Article
    # Check if article already exists in the DB.
    # Primary key should be the article URL.
    search_results = Article.objects.filter(article_url=article["url"])
    if search_results:
        return search_results.first()

    # Chuck out unrealistically long article fields.
    if len(article["source"]["name"]) > 2000 or len(article["author"]) > 2000 or len(article["title"]) > 2000:
        return None

    # If article does not already exist, save it now.
    new_article = Article()
    new_article.source_name = article["source"]["name"]
    new_article.author = article["author"]
    if not new_article.author:
        new_article.author = "Unknown Author"
    new_article.title = article["title"]
    new_article.article_url = article["url"]
    new_article.article_image_url = article["urlToImage"]
    if not new_article.article_image_url:
        new_article.article_image_url = "https://southpasadenan.com/wp-content/uploads/south-pasadena-news-08-21-18-mid-century-modern-home-at-83-patrician-way-sits-high-atop-LA-01.jpg"
    new_article.publish_date = article["publishedAt"]
    new_article.save()
    return new_article

def generate_news_feed(source=None, category=None):
    """Driver function to generate news feed.

    Get the top headlines from newsapi.org and save the 
    corresponding articles into the DB in the correct format.
    """

    top_articles = retrieve_top_articles(source, category)
    saved_articles = []
    for article in top_articles:
        new_article = save_article_data(article)
        if new_article:
            saved_articles.append(new_article)
    return saved_articles
