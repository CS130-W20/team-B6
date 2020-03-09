# Outlook Frontend

## Run the app
Without doing anything, the frontend should just be infinitely loading. To get to the app itself, make sure to follow these steps.
1. Start the backend server.
2. Download and install [ngrok](https://dashboard.ngrok.com/get-started), which will create an HTTP tunnel to help extend localhost so that your phone can reach the server. (I don't think you need this if you're using the emulator).
3. Open ngrok and type in the command `ngrok http localhost:8000`. You should see that it maps some address like `http://4b75b70e.ngrok.io ` to localhost.
4. Go to `frontend/lib/managers/api_manager.dart` and replace the `BACKEND API URL HERE` with  `$NGROK_ADDRESS`.
5. In `backend/.../outlook/settings.py`, add your ngrok address to the list of allowed hosts. If the list has '*' in it, that should be fine also.
6. Run the app, sign up and log in with an account and it should work.

## Extra info (troubleshooting)
- [Postman](https://www.postman.com/downloads/) is recommend to make direct API requests to the backend.
- To directly make an account, go to `$NGROK_ADDRESS/signup` in Postman and select POST. Go to Body tab, click "raw", and put in
```
{
  "username": "$YOURUSERNAME",
  "password": "$YOURPASSWORD",
  "firstname": "$YOURFIRSTNAME",
  "lastname": "$YOURLASTNAME"
}
```
Clicking Send should sign you up as a user in the DB. Check that this is true.
- In `main.dart`, you can try to change the line of code with `ApiManager.login(...)` to `ApiManager.login($YOURUSERNAME, $YOURPASSWORD)`.
- To reset the data that Hive saves in its storage, you can uncomment out the two lines in `main()` inside `main.dart`. If data is blank, just manually add `UserState.setUserName(username)` and `AuthState.setPassword(password)` in `main()`, which should help retrieve the corresponding user data (assuming you signed up).
