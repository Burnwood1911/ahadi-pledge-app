# Ahadi Pledge Documentation

This is the documentation for the setup and building of the ahadi pledge mobile app.

## Getting Started

### Prerequisites

- Ensure you have Flutter and Dart SDK's setup and added to PATH.

### Installation

- clone the repository in your local machine

- open a terminal the root directory of the project and run the following command

```shell
flutter clean
flutter pub get
```

- To setup firebase on ANDROID add the `google-services.json` you obtained from the firebase console inside the directory `android/app/`

- To setup firebase on IOS drag the `google-services.plist` you obtained from the firebase console and drop it inside `Runner` in xcode of the left menu


###  Run

- To run App open a terminal in the root directory of the project and run the following command

```js
flutter run

```

###  Build Google Play store Release

- Ensure that the correct path to `upload-keystore.jks` is added in the file `key.properties` located in the `/android` directory in the projcect

- to build release app bundle run the following commands
```js
flutter clean
flutter build appbundle

```


## Adding or Updating Translations

- the transalion files can be found in the `/assets/translations` directory inside the project where you will find the `json` files for each language eg `en.json`. 

- You will use these file to add or make changes to the translations to the app

- after making changes to these files you must run the following commands to generate the Localkeys for the translations

```js

flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations"


flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations" -o "locale_keys.g.dart" -f keys

```

## Credits

- [Alex Paul Rossi]

## License

This project is licensed under the [MIT](LICENSE.md) License.