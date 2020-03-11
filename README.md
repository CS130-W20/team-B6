# Outlook
“FAKE NEWS!” is an expression that has caught a lot of traction since the past year or two. This term was mostly popularized by social media platforms like Facebook and Instagram, which handle a huge portion of internet traffic in today’s time. Most of the news articles that we see are unsolicited rumors targeting certain groups of people, often maliciously. 

The application is for all people as long as they have opinions! By allowing people from diverse backgrounds and age groups to enable discussions on verified articles, we believe this application would provide the right balance between social media and debating platforms. The application does not intend to better social media apps like Facebook or Instagram. On the other hand, it attempts to provide a dedicated platform for more scholastic discussions under a no-nonsense roof.

<img src="https://user-images.githubusercontent.com/23279139/76458116-4827c980-6397-11ea-8f5a-e8bc891db847.png" width="200"> <img src="https://user-images.githubusercontent.com/23279139/76458122-4a8a2380-6397-11ea-8c9e-efe5038a8888.png" width="200"> <img src="https://user-images.githubusercontent.com/23279139/76458125-4b22ba00-6397-11ea-9590-2d38f15b242c.png" width="200">


## Directory Structure
The app's frontend and backend is split into their respective folders.
### Frontend
The frontend runs on Dart/Flutter and is intended to be a cross-platform mobile application. The android and ios folders are mostly auto-generated (with some configuration), and the source code is found in the lib folder. Each page is then separated by a folder, with a common entry point `main.dart`.
### Backend
The backend runs on Python Django and a SQL database. The directory structure of the backend follows the typical Django structure, with the app's general settings found in the `outlook` folder. The more specific configurations like API endpoints, database querying, and database schema declaration are found in the `backend` folder.

## Installation/Run instructions
Without doing anything, the frontend should just be infinitely loading. To get to the app itself, make sure to follow these steps.
1. Start the backend server.
2. Download and install [ngrok](https://dashboard.ngrok.com/get-started), which will create an HTTP tunnel to help extend localhost so that your phone can reach the server. (I don't think you need this if you're using the emulator).
3. Open ngrok and type in the command `ngrok http localhost:8000`. You should see that it maps some address like `http://4b75b70e.ngrok.io ` to localhost.
4. Go to `frontend/lib/managers/api_manager.dart` and set the `DOMAIN` with  `$NGROK_ADDRESS`.
5. In `backend/.../outlook/settings.py`, add your ngrok address to the list of allowed hosts. If the list has '*' in it, that should be fine also.
6. Run the app, sign up and log in with an account and it should work.

## Relevant Links 
- Documentation link
- Working URL (if any)
- anything else


