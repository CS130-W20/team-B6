# Outlook Frontend

Without doing anything, the frontend should just be infinitely loading. To get to the app itself, make sure to follow these steps.
1. In `backend/.../db.sqlite3`, add an entry in `backend_users` with id 1.
2. Start the backend server.
3. Download and install [ngrok](https://dashboard.ngrok.com/get-started), which will create an HTTP tunnel to help extend localhost so that your phone can reach the server. (I don't think you need this if you're using the emulator).
4. Open ngrok and type in the command `ngrok http localhost:8000`. You should see that it maps some address like `http://4b75b70e.ngrok.io ` to localhost.
5. Go to `frontend/.../main.dart` and replace the `BACKEND API URL HERE` with  `[ngrok_address]/users/1`.
6. Run the app and it should work.
