
# Building a simple iOS movies application

## Task :

Create an IOS application that displays the list of trending movies, when we select one movie it shows more details about it.

As a data provider, use the following REST API endpoints:

```
Api name Api link Api documentation
```
```
List of trending
movies
```
```
https://api.themoviedb.org/3/discover/movie https://developers.themoviedb.org/ 3 /discov
er/movie-discover
```
```
Details of a movie https://developers.themoviedb.org/3/movies/{movie_id} https://developers.themoviedb.org/ 3 /movie
s/get-movie-details
```
Notes :
● You can use the following api key to authenticate your requests : **c9856d0cb57c3f14bf75bdc6c063b8f**

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


## The first build

The project requires Xcode 13 and several tools to appropriate compiling:
- [SwiftLint](https://github.com/realm/SwiftLint) — to check code style
- [Swiftgen](https://github.com/SwiftGen/SwiftGen) — to achieve compile-guaranteed access to the resources
- [Sourcery](https://github.com/krzysztofzablocki/Sourcery) — to generate boilerplate code (primary used for the DI context building)

You can install it manually or using the script `install_tools.sh`. This script will check Homebrew installation and install described dependencies via Homebrew.

## The stack

## The app architecture

## User interface

## Possible TODOs

