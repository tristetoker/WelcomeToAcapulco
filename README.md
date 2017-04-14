# WelcomeToAcapulco
Swift 3 demo app based on OpenWeatherMap api's

# How the project was developed:
This project has been developed from scratch, using just a few adapted code snippets of mine.

# Third party components:
The project makes use of Cocoapods dependency manager, just one component has been added (Progress Hud), but it hasn’t been necessary to use it.

# Database layer:
The exercise specifies to pick up the forecast for just one, chosen city. Therefore it was possible to hardcode the city identifier, and there was no need to use a database or other forms of manually managed persistence.
If there had been a requirement to search for any city, there is a network api which takes a city name, but it has been described as not very reliable: as per OpenWeatherMap documentation, the most reliable way to use the api’s is by city id.
Therefore it would have been necessary to download the (available as a bulk) city table, and use it to pre-populate a local database (e.g. Core Data, SQLite, or Realm) where to search a city from, and then take the id to call the network api.

# Network layer:
If a third party component had to be chosen, I would have probably opted for Alamofire, which seems to be the most promising as far as Swift is concerned.
Given the example scope of the app, I decided to not use any component, and to try to provide an example of system api’s based network layer.
There are two network calls, one for the five days forecast, the other to load each cell icon representing weather condition.
The cache management has been left to protocol (http) default

# MVC
Again, given the example nature of the project, I have opted for the standard, system architecture of MVC. In my opinion, it is not always easy to keep a VC limited in size and testable. But it is not impossible either, by encapsulating the logic in dedicated components as per simple responsibility principle, and assigning them as dependencies to the VC. 
However, in a real case I might have opted for the MVVC architecture, with the support of a possible reactive framework (such as Reactive Swift).

# Model:
There are different opinions about the use of structs or classes in Swift when dealing with model objects. I have seen around both approaches. In my opinion, model objects should regarded as entities (just like Core Data does, for example), therefore I have made them all classes (and one enum). 

# Controllers:
On the other hand, all controllers have been defined as structs, with the exception of network manager, which is supposed to be a shared object, therefore this couldn’t be achieved with value semantics

# Presentation layer:
How to present information, which in this case is, how the strings are built (e.g.) has been in some cases defined within the model objects, in terms of computed properties. This allow as to use a consistent style across (possible) different view controllers. With more time available, I would have probably moved this logic to a dedicated controller type.

# Use of icons:
A more native app approach might imply to have the weather condition icons in the bundle. Anyway, given the default use of network protocol cache, a lot of calls get resolved without actual network access.

# Use of protocols and dependency injection:
Most controller types are backed by declared custom protocols. This implies more files and more verbosity, but protocols should be used as a starting point for design. Apparently Swift is supposed to be used this way.
The view controllers (one) encapsulate logic in dedicated components, clearly expose them as dependencies and have an injectDependencies configuration method which is supposed to complete the initialization (with navigation based on storyboard this the best approach I have been able to find so far).
Dependencies are expressed in terms of protocols instead of actual type. This make our view controllers much more testable. 

# Testing:
A couple of test targets have been defined, just to provide evidence of some testing. One target is for all those tests which don’t need any host app (logic tests). The other one is a duplicate of the real app, with a different app delegate.
The test have been realized without support of any framework (in Objective-C I use intensively OCMock). A few mock objects have been defined taking benefit of protocol-defined dependencies.
The example provided is about networking, were the calls and their asynchronous result has been mocked.

# What I would have done (to begin with) having more time:
- Some visual feedback about failed data network fetch.
- Manage somehow the possible time difference between the chosen city and local device time.
- Localize strings.
- Rearrange consistently the functions order, placing more MARK delimiters, and removing empty implementations.
- User markup notations to document api’s.
- Manage types, functions and properties access level, which in most cases has been left untouched (internal).
- Extend Swift error throwing pattern to all applicable cases.
- Browse Swift standard library and see if some of the used custom protocols can be made conforming to any system provided protocol, in order to have them more standardized and possibly to get some behavior for free.
- Provide more testing coverage. In a less time constrained case, I wouldn’t have left it last, and I would have probably tried to follow a TDD approach.



