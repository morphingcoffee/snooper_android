Flutter platform package for Android which provides concrete implementations for various device info
lookups.

By using `SnooperAndroid` you can retrieve the following information:

- Simple Device Applications List
- Detailed Device Applications List
    - App icons
    - Activities
    - Services
    - APK Signatures
    - Other Metadata

### APIs provided by [SnooperAndroid.dart](./lib/snooper_android.dart):
[Simple Package Info](./lib/model/simple_android_package_info.dart):
```dart
List<SimpleAndroidPackageInfo> simplePackageInfos = await SnooperAndroid.simplePackageInfos;
```

[Detailed Package Info](./lib/model/detailed_android_package_info.dart):
```dart
List<DetailedAndroidPackageInfo> detailedPackageInfos = await SnooperAndroid.detailedPackageInfos;
```


### Example App
Available at [./example/lib/](./example/lib/)  

<p float="left">
  <img src="docs/media/sample-home.png" width="250">
  <img src="docs/media/sample-packages-simple.png" width="250">
  <img src="docs/media/sample-packages-detailed.png" width="250">
  <img src="docs/media/sample-packages-detailed-dashboard.png" width="250">
</p>