# Nova Weather

A small app to show forecasts for current weather and the next few days. This app is made with Flutter and should run on both iOS (requires apple license) and Android. To install the Flutter SDK, please view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference. 



## Design 

The design for this was inspired by a dribbble user Chris Iwan. It's a simple and effective design which takes advantage of the the screen space on displays of all sizes. Have a look at the [concept design](https://dribbble.com/shots/7106462-Weather-App) for comparison

## Technical

This app uses the MVP (Model/View/Presenter) architectural pattern. Currently it only has one presenter for the entire weather forecast app. There are many views which pass down the model from the presenter (on successful calls of the api). Error handling happens at the presenter layer. It notifies the view if there has been an error which will in turn, show a placeholder informing the user that an issue occured. 

The project has two unit tests, one for the provider used to call the endpoints and another for the presenter. To make sure each component is testable, dependency injection needed to be implemented so that those dependencies could be mocked (such as the http clients). A plugin named [Mockito](https://flutter.dev/docs/cookbook/testing/unit/mocking) allows for the mocking of these dependencies to be used in testing so that the components can be tested in isolation. 