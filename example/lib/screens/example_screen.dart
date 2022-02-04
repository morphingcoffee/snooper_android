import 'package:flutter/material.dart';
import 'package:snooper_android/constants/android_flags.dart';
import 'package:snooper_android/model/audio/microphone_info.dart';
import 'package:snooper_android/model/features/system_feature.dart';
import 'package:snooper_android/model/sensors/sensor_info.dart';

import 'package:snooper_android/model/simple_android_package_info.dart';
import 'package:snooper_android/model/detailed_android_package_info.dart';
import 'package:snooper_android/snooper_android.dart';
import 'package:snooper_android_example/screens/apps/display_packages_detailed.dart';
import 'package:snooper_android_example/screens/apps/display_packages_simple.dart';
import 'package:snooper_android_example/screens/features/display_system_features.dart';
import 'package:snooper_android_example/screens/sensors/display_sensors.dart';

import 'microphones/display_microphones.dart';

class ExampleScreen extends StatefulWidget {
  final String appTitle;

  const ExampleScreen(this.appTitle, {Key? key}) : super(key: key);

  @override
  _ExampleScreenState createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  List<SimpleAndroidPackageInfo>? _simplePackages;
  List<DetailedAndroidPackageInfo>? _detailedPackages;
  List<SensorInfo>? _sensors;
  List<SystemFeature>? _systemFeatures;
  List<MicrophoneInfo>? _microphones;

  @override
  void initState() {
    _reFetchAllPlatformInfo();
    super.initState();
  }

  /// SnooperAndroid API Example: fetching the available data
  ///
  /// Fetch data from different [SnooperAndroid] APIs in parallel (without
  /// individual [await]s for sequential execution) since their compute time will
  /// differ significantly
  Future<void> _reFetchAllPlatformInfo() async {
    // Reset old state
    setState(() {
      _simplePackages = null;
      _detailedPackages = null;
    });

    // Fetch Simple app info
    SnooperAndroid.simplePackageInfos.then((pkgs) {
      _simplePackages = pkgs;
      _safeSetState();
    });

    // Fetch Detailed app info
    SnooperAndroid.detailedPackageInfos.then((pkgs) {
      _detailedPackages = pkgs;
      _safeSetState();
    });

    // Fetch sensor info
    SnooperAndroid.sensorInfos.then((sensors) {
      _sensors = sensors;
      _safeSetState();
    });

    // Fetch system features info
    SnooperAndroid.systemFeatures.then((features) {
      _systemFeatures = features;
      _safeSetState();
    });

    // Fetch microphones info
    SnooperAndroid.microphones.then((microphones) {
      _microphones = microphones;
      _safeSetState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appTitle),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () => _reFetchAllPlatformInfo(),
        tooltip: 'Re-fetch all device info',
      ),
    );
  }

  void _safeSetState() {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _navInfoItem(
          icon: Icons.backpack_outlined,
          title: "All Applications",
          subtitle: "limited package info",
          hasLoaded: () => _simplePackages != null,
          navDestination: () => DisplayPackagesSimpleScreen(
            pkgs: _simplePackages!,
          ),
        ),
        _navInfoItem(
            icon: Icons.backpack,
            title: "User Applications",
            subtitle: "detailed package info",
            hasLoaded: () => _detailedPackages != null,
            navDestination: () {
              // Filter out system apps
              final pkgs = _detailedPackages!
                  .where((pkg) => !pkg.flags.has(ApplicationFlags.system))
                  .toList();
              return DisplayPackagesDetailedScreen(
                title: "User Applications (${pkgs.length})",
                pkgs: pkgs,
              );
            }),
        _navInfoItem(
            icon: Icons.backpack,
            title: "System Applications",
            subtitle: "detailed package info",
            hasLoaded: () => _detailedPackages != null,
            navDestination: () {
              // Filter out non-system apps
              final pkgs = _detailedPackages!
                  .where((pkg) => pkg.flags.has(ApplicationFlags.system))
                  .toList();
              return DisplayPackagesDetailedScreen(
                title: "System Applications (${pkgs.length})",
                pkgs: pkgs,
              );
            }),
        _navInfoItem(
            icon: Icons.sensors,
            title: "Sensors",
            subtitle: "pre-installed & dynamic device sensors",
            hasLoaded: () => _sensors != null,
            navDestination: () {
              return DisplaySensorsScreen(
                sensors: _sensors!,
              );
            }),
        _navInfoItem(
            icon: Icons.star,
            title: "System Features",
            subtitle: "hardware & software features of the device",
            hasLoaded: () => _systemFeatures != null,
            navDestination: () {
              return DisplaySystemFeaturesScreen(
                features: _systemFeatures!,
              );
            }),
        _navInfoItem(
            icon: Icons.mic,
            title: "Microphones",
            subtitle: "microphones & their metadata",
            hasLoaded: () => _microphones != null,
            navDestination: () {
              return DisplayMicrophonesScreen(
                microphones: _microphones!,
              );
            }),
      ],
    );
  }

  Widget _navInfoItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool Function() hasLoaded,
    required Widget Function() navDestination,
  }) {
    return InkWell(
      onTap: () {
        if (hasLoaded()) {
          Future.delayed(const Duration(milliseconds: 150), () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => navDestination()));
          });
        }
      },
      child: ListTile(
        leading: Icon(
          icon,
          size: 64,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: hasLoaded() ? _navIndicator() : _progressIndicator(),
      ),
    );
  }

  Widget _progressIndicator() {
    return const SizedBox(
      height: 5,
      width: 100,
      child: LinearProgressIndicator(),
    );
  }

  Widget _navIndicator() {
    return const Icon(Icons.chevron_right_rounded);
  }
}
