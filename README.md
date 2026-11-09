# Karrot clone

Mobile Programming (CAU 56115), individual project: a Flutter clone of Karrot (당근마켓).

## Run

Requires Flutter 3.47 / Dart 3.13 (stable), and an Android emulator/device or an iOS simulator.

```
flutter pub get
flutter run
```

## Notes

- **Android: on first start the app opens the "All files access" settings page.
  Turn on "Allow access to manage all files" and go back.** This lets the app read
  and write `items.json` and `chat_<itemId>.json` in the Downloads folder
  (`/storage/emulated/0/Download`), including files placed there from outside.
- The Home feed shows the items from `Download/items.json`. Without that file the
  feed is empty: there are no pre-filled items.
- Source code is in `lib/` and follows the file paths and names from the spec.
