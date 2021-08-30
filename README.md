# flutter_wiki

Use the Wikipedia API  to show a list of user search results. The link contains sample API requests and an API sandbox environment to test it out. (For example, click this to see what a sample request/response looks like.)

- Parse JSON from the API response.
- Each list item should contain an image and appropriate data from the API. Show whichever fields you think are necessary.
- Clicking a list item launches the respective Wikipedia page.
- The UI specification is left to you. Use appropriate UX and UI widgets to give the best experience as you see fit.
- Cache responses to give a good offline experience.

You can add any more features you think will be good to have.

This is the Wikipedia API:
- [Search API](https://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpslimit=10&gpssearch=albert&gpsoffset=0)
- [Page Details API](https://en.wikipedia.org/w/api.php?action=query&prop=info&inprop=url&format=json&pageids=717)
- [Combined API](https://en.wikipedia.org//w/api.php?action=query&format=json&prop=extracts%7Cpageimages%7Cpageterms%7Cinfo&inprop=url&generator=prefixsearch&formatversion=2&piprop=thumbnail&pithumbsize=50&wbptterms=description&exsentences=5&exintro=1&explaintext=1&gpslimit=50&gpssearch=india)

![Splash Screen](https://raw.githubusercontent.com/loud-at-heart/flutter_wiki/master/Screenshots/1.png?token=AITHSNY5635GUQJVLO7YCKDBFR6BO | width=100 | "Splash Screen")
![Home Screen](https://raw.githubusercontent.com/loud-at-heart/flutter_wiki/master/Screenshots/2.png?token=AITHSN35WS6BU6KQZN73HMTBFR6JA "Home Screen")
![Search History Screen](https://raw.githubusercontent.com/loud-at-heart/flutter_wiki/master/Screenshots/3.png?token=AITHSN4PF4JPZPDVL3NE2N3BFR6MI "Search History Screen")
![Browsing History Screen](https://raw.githubusercontent.com/loud-at-heart/flutter_wiki/master/Screenshots/4.png?token=AITHSNYF5K4GUBE3LE7NBO3BFR6PC "Browsing History Screen")
![Search Screen](https://raw.githubusercontent.com/loud-at-heart/flutter_wiki/master/Screenshots/5.png?token=AITHSN22YOSVOTXREVBW3GDBFR6QW "Search Screen")


## Getting Started

A few resources to get you started :

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
