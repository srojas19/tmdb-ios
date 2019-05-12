# TMDb Catalogue for iOS
**By Santiago Rojas Herrera**

Showcase iOS app of some API services offered by The Movie Database.

## Building Instructions
Open in Xcode or clone the project

````
git clone https://github.com/srojas19/tmdb-ios.git
cd tmdb-ios
````
Install cocoa pods
```
pod install
```
Open `TMDb.xcworkspace`, build the project and run.

**Note:** Project is set-up with Swift 5 and Xcode 10.2.1, thus, you need an up-to-date Xcode to test the project



## Features
- Consumes the Movies and TV Shows APIs of [TMDb](https://developers.themoviedb.org/3/).
- Shows Movies and TV Shows in 3 different categories: Popular, Top Rated and Upcoming.
- Detailed View of Movies and TV Shows.
- Allows the search of Movies and TV Shows by category.
- Stores the results of lists and detailed media in a Realm database, that is accessed whenever the device is offline.
- Implements a MVVM architectural pattern.
- Uses RxSwift to handle state changes reactively.

## Application Layers

### Model
Since this application doesn't require the editing or creation of new data, and the communication with TMDb's servers are only to request data, the model of the application is comprised with the entities required to decode the data requested into instances with defined properties. These entities inherit from Realm's Object class, which allows them to be persisted on the device.

* **TMDbCategory**: Enum that defines the 3 possible categories of the list of movies of TV shows: Upcoming, Top Rated and Popular. Used to request and display the expected list of such category, by the services layer and MediaTableViewController.
* **TMDbMediaType**: Enum that defines the 2 different types of media: Movie or TV Show. It's used by the Services and Controller layers' methods to create the correct Media instances used by the MediaDetailViewController to display data, and to request the correct media list depending on the category.
* **MediaListResult**: Instance of one result of the list requests. It can represent both movies and TV shows. It's assigned to a MediaCell displayed in the MediaTableViewController.
* **Media**: Protocol that defines the base properties, common to Movie and TV Show instances. It's used by the Services layer and MediaDetailViewController to allow polymorphism of the methods to request and display the Media instances.
* **Movie**: Conforms to Media. It has the specific properties to Movies, as defined by TMDb's API.
* **TV Show**: Conforms to Media. It has the specific properties to TV Shows, as defined by TMDb's API.

Other structures that are used by Media instances
* Creator
* Episode
* Genre
* ProductionCompany
* ProductionCountry
* Season
* SpokenLanguage
* TMDBCollection


### View
As per common with iOS projects, most views are defined in the Main storyboard of the project. The application functions with a Tab Bar view that separates it in two branches, one dedicated to movies and other for TV shows.

* **MoviesView** and **TVShowsView**: Has a ContainerView that embeds a MediaTableView that does the bulk of the visualization. Contains the search bar and search button.
* **MediaTableView**: Embeded by MoviesView or TVShowsView. Contains a toolbar with a segmented control that allows the user to switch between categories, and a table that displays MediaCell instances with the results of the Services requests.
* **MediaCell**: Displays an instance of one result of a list request. It shows an image of the media (Movie or TV Show), its title or name, average score and a description if available. If the request hasn't loaded yet, the MediaCell is empty.
* **MediaDetailView**: Displays the details of a Media instance. Shows the title or name of the media, its image (poster), a backdrop image, its year or status, main production company, language, average score, number of votes, runtime (or average runtime if it is a TV show), number of seasons and episodes if it is a tv show, and a expandable description.

### ViewModel
* **MediaTableViewModel**: Fetches the media lists by category from the services layer. Handles the state related to the lists of Movies and TV Shows. Handles the search logic, using a RxSwift Observable to allow MediaTableViewController to track the search text when available.
* **MediaDetailViewModel**: Fetches the detailed media instance from the services layer. After fetching it, its binded by MediaDetailViewController to MediaDetailView.

### Controller
As per common with iOS projects, the view controllers are connected to its views via the Main storyboard of the project. Consequently the segues, Navigation controllers and Tab Bar controller are visible there.

* **MoviesViewController** and **MediaTableViewController**: Prepare the embeded MediaTableViewController with the expected media type to request and display (by changing a TMDBType property). Also, focuses the search bar if the search button in the navigation bar is pressed.
* **MediaTableViewController**:  It is the tableView's delegate, the tableView's data source, the searchController's delegate, and the searchBar's delegate. As such, it implements the methods to return the number of rows in the table, the cell that should be loaded in a row, the prefetching method for the data in the rows (by using pagination). It segues to a MediaDetailView when a cell in the tableView is selected.
* **MediaDetailViewController**: Subscribes to a change in the detailed media object in the ViewModel, to then bind the state properties to MediaDetailView subviews. Additionally, it contains a method to expand or collapse the description.


### Services / Network

* **Reachability**: Small library implemented by [Ashley Mills](https://github.com/ashleymills/Reachability.swift) to check network status. Inteded to be used to load cached responses when there is no internet connection. *It was decided to manually insert it into the project, to avoid nedlessly using CocoaPods or Carthage to import the library.*
* **TMDbServices**: Singleton accessed via a shared instance in the same class. Implements the methods to fetch the page of a list category for movies or TV shows, and to get the detailed Media instance, from the TMDb's servers, via HTTP requests. In both methods, the response's data is decoded from JSON to the Model structures, and then it is sent as a parameter in a completion closure, which is used by the View Controllers to access the information.

## Questions

**1. What is the single responsability principle? What is its purpose?**

The single responsability principle states that every module, class or function in a software system should encapsulate a single responsablity over the functionality of the software. According to Robert C. Martin, the single responsability principle consists of the fact that "A class should only have one reason to change", with that reason being that its responsability must be acommodated to fit the needs of the actor it is serving it to.

Its purpose is to promote a cohesive domain of modules and classes, that are more robust when other parts of the domain change. Therefore, the testing and implementation process becomes more fluid, as there would be a clearer direction and repercusions to a change.

**2. What characteristics, in your opinion, make *good* or clean code?**

There's multiple characteristics to good code, some with more importance than others. I'll note the most important characteristics to me.

* Legible: The code is easily understandable, by using correct indentation, syntax and guidelines according to the language, expressive statements over *clever* ones.
* Fast: The code should aim to be as fast as possible, attempting to optimize where possible. For instance, avoiding variable generation, decreasing the complexity of a method, by reducing cycles, etc.
* Testable: The code should be written in a way that it allows it to be easily testable and debbugable. The expressiveness of the statements can allow to identify possible testing cases, while it can also show the cause of a bug.
* Organized: The code should be contained in an organized folder structure, with correct naming conventions for methods, classes, properties, ...; so that it is easy to identify the position of a feature, or something that needs to be worked on.

