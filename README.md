
# Building a simple iOS movies application

## The first build

The project requires Xcode 13 and several tools to appropriate compiling:
- [SwiftLint](https://github.com/realm/SwiftLint) — to check code style
- [Swiftgen](https://github.com/SwiftGen/SwiftGen) — to achieve compile-guaranteed access to the resources
- [Sourcery](https://github.com/krzysztofzablocki/Sourcery) — to generate boilerplate code (primary used for the DI context building)

You can install it manually or using the script `install_tools.sh`. This script will check Homebrew installation and install described dependencies via Homebrew.

## The stack

RxSwift is used for MVVM bindings.

SnapKit for the convenient autolayout interface.

SDWebImage for image caching.

Alamofire for networking.

SwiftGen for generation of resources.

SwiftLint is used to check the code-style.

## The app architecture

The application is designed with MVVM+Coordinators architecture pattern.

RxSwift framework is used for MVVM bindings.

Models are presented as immutable structures.

The movies in the list are loaded by pages. The user interface controls the demand for new page. Once the last item in the list is sown the view requests viewmodel for the next page. 

## User interface

The UI is written in UIKit + autolayout(SnapKit) for app screens.

The table cell in the list of movies is based on XIB.

## Possible TODOs

Here is the list of possible futher improvements:
1. Create tests for services and view model.
2. Whilst creating models, also extract protosols herever needed for mocks.
3. Improve the look of UI.
4. Add images loading cancellation, so image loading is cancelled for images that are not loaded yet and that already has gone from the screens.
5. Improve preloading of movies in the list of movies for smoother scroll.

## Task :

Create an IOS application that displays the list of trending movies, when we select one movie it shows more details about it.

As a data provider, use the following REST API endpoints:

List of trending movies
```
https://api.themoviedb.org/3/discover/movie https://developers.themoviedb.org/ 3 /discov
er/movie-discover
```
Details of a movie
```
https://developers.themoviedb.org/3/movies/{movie_id} https://developers.themoviedb.org/ 3 /movie
s/get-movie-details
```


```
● Follow this documentation to get the full poster image path of a movie :
https://developers.themoviedb.org/3/getting-started/images
```
You can use the image below as a reference for implementing the UI but you are not required to follow it exactly. You can
unleash your creativity.

# Remarks:

```
● Even if it’s a simple project, Implement the app in the best way that represents your understanding of high quality
software. It will be your best way to share your knowledge with us.
● The application code should be pushed to a public github repository, and share the repository link with us.
● The application will be compiled and run under the latest iOS SDK with the latest production Xcode.
● The application is expected to be written in Swift and UIKit.
```
