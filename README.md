# Sky Sight - Weather App

Sky Sight is an intuitive and elegantly designed weather application built using Flutter. It utilizes the `flutter_bloc` library to implement the BLoC (Business Logic Component) design pattern, ensuring a clean separation between the app's business logic and presentation layers. The app provides real-time weather updates for any specified city using the OpenWeatherMap API.

## Features

- **Real-time Weather**: Fetches and displays the current weather information using the OpenWeatherMap API's free plan.
- **Geolocation and Geocoding**: Determines the user's current location to provide local weather data.
- **Bloc Design Pattern**: Implemented using the flutter_bloc package to manage app state and event handling in a predictable way.
- **Dio for HTTP**: Uses Dio, a powerful HTTP client for Dart, to perform network requests.
- **Loading Indicator**: Shows a loading spinner while fetching data to provide immediate feedback to the user.
- **Weather List**: Displays a list of weather conditions with the day of the week abbreviation and condition image.
- **Pull to Refresh**: Allows users to refresh weather information with a simple pull-to-refresh gesture.
- **Error Handling**: Presents an error screen with a retry option if data fetching fails.
- **Adaptive Layouts**: Supports both horizontal and vertical orientations for enhanced user experience.
- **Temperature Unit Toggle**: Users can switch between Celsius and Fahrenheit temperature units.

## Getting Started

Follow these instructions to set up the project locally.

### Prerequisites

- Flutter SDK
- Android/iOS emulator or device
- Active internet connection

### Installation

1. Clone the repository
2. Navigate to the project directory
3. Install dependencies
4. Run the app

## Usage

Launch Sky Sight on your emulator or device. The app will automatically request your current location and display the corresponding weather information. Explore the app's features such as viewing detailed weather, refreshing data, and toggling temperature units.
