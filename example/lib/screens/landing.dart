import 'package:flutter/material.dart';

import 'package:snooper_android/model/simple_android_package_info.dart';
import 'package:snooper_android/model/detailed_android_package_info.dart';
import 'package:snooper_android/snooper_android.dart';
import 'package:snooper_android_example/screens/display_packages_detailed.dart';
import 'package:snooper_android_example/screens/display_packages_simple.dart';

class LandingScreen extends StatefulWidget {
  final String appTitle;

  const LandingScreen(this.appTitle, {Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  List<SimpleAndroidPackageInfo>? _simplePackages;
  List<DetailedAndroidPackageInfo>? _detailedPackages;

  @override
  void initState() {
    _reFetchAllPlatformInfo();
    super.initState();
  }

  /// Fetch data from different [SnooperAndroid] APIs in parallel (without
  /// individual [await]s for sequential execution) since their compute time will
  /// differ significantly
  Future<void> _reFetchAllPlatformInfo() async {
    // Reset old state
    setState(() {
      _simplePackages = null;
      _detailedPackages = null;
    });

    // Fetch Simple info
    SnooperAndroid.simplePackageInfos.then((pkgs) {
      _simplePackages = pkgs;
      _safeSetState();
    });

    // Fetch Detailed info
    SnooperAndroid.detailedPackageInfos.then((pkgs) {
      _detailedPackages = pkgs;
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
          title: "Application List",
          subtitle: "limited info",
          hasLoaded: () => _simplePackages != null,
          navDestination: () => DisplayPackagesSimpleScreen(
            pkgs: _simplePackages!,
          ),
        ),
        _navInfoItem(
          icon: Icons.backpack,
          title: "Application Data Table",
          subtitle: "detailed info",
          hasLoaded: () => _detailedPackages != null,
          navDestination: () => DisplayPackagesDetailedScreen(
            pkgs: _detailedPackages!,
          ),
        ),
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
