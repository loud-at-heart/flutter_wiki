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

## Getting Started

A few resources to get you started :

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
