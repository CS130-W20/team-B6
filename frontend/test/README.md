## Testing

### Splash screen tests
These are just to ensure that the splash screen renders at appropriate times and that it is not
being interrupted by other widgets that could have incorrectly appeared also. The most simple
scenario is when the app is opened, the splash screen automatically appears while the app loads data.
Then, there should not be anything other components, like the news feed, profile page, or bottom nav bar
appearing (they appear after data is loaded and the user is signed in).