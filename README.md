# Outlook
“FAKE NEWS!” is an expression that has caught a lot of traction since the past year or two. This term was mostly popularized by social media platforms like Facebook and Instagram, which handle a huge portion of internet traffic in today’s time. Most of the news articles that we see are unsolicited rumors targeting certain groups of people, often maliciously. 

The application is for all people as long as they have opinions! By allowing people from diverse backgrounds and age groups to enable discussions on verified articles, we believe this application would provide the right balance between social media and debating platforms. The application does not intend to better social media apps like Facebook or Instagram. On the other hand, it attempts to provide a dedicated platform for more scholastic discussions under a no-nonsense roof.

## Directory Structure
The app's frontend and backend is split into their respective folders.
### Frontend
The frontend runs on Dart/Flutter and is intended to be a cross-platform mobile application. The android and ios folders are mostly auto-generated (with some configuration), and the source code is found in the lib folder. Each page is then separated by a folder, and the entry point is `main.dart`.
### Backend
The backend runs on Python Django and a SQL database. The directory structure of the backend follows the typical Django structure, with the app's general settings found in the `outlook` folder. The more specific configurations like API endpoints, database querying, and database schema declaration are found in the `backend` folder.

## Installation/Run instructions
When starting up the app without modifying anything, the frontend should just be infinitely loading. To get to the app itself, make sure to follow these steps.

1. In backend/.../db.sqlite3, add an entry in backend_users with id 1.
2. Start the backend server.
3. Download and install ngrok, which will create an HTTP tunnel to help extend localhost so that your phone can reach the server.
4. Open ngrok and type in the command ngrok http localhost:8000. You should see that it maps some address like http://4b75b70e.ngrok.io to localhost.
5. Go to frontend/.../main.dart and replace the BACKEND API URL HERE with [ngrok_address]/users/1.
6. In backend/.../outlook/settings.py, add your ngrok address to the list of allowed hosts.
7. Run the app and it should work.

## Relevant Links 
- Documentation link
- Working URL (if any)
- anything else


