import 'package:flutter/material.dart';
import 'package:snooper_android/model/android_activity_info.dart';
import 'package:snooper_android/model/android_service_info.dart';
import 'package:snooper_android/model/detailed_android_package_info.dart';

class IndividualDetailedPackageScreen extends StatefulWidget {
  const IndividualDetailedPackageScreen(this.pkg, {Key? key}) : super(key: key);

  final DetailedAndroidPackageInfo pkg;

  @override
  _IndividualDetailedPackageState createState() =>
      _IndividualDetailedPackageState();
}

class _IndividualDetailedPackageState
    extends State<IndividualDetailedPackageScreen> {
  @override
  Widget build(BuildContext context) {
    final pkg = widget.pkg;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              width: 36,
              height: 36,
              child: Hero(
                tag: "${pkg.packageName}",
                child: Image.memory(pkg.iconBytes!),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(pkg.name.split(".").last),
            ),
          ],
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final pkg = widget.pkg;
    final textTheme = Theme.of(context).textTheme;
    final installDt = DateTime.fromMillisecondsSinceEpoch(pkg.firstInstallTime);
    final updateDt = DateTime.fromMillisecondsSinceEpoch(pkg.lastUpdateTime);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "General Info",
                style: textTheme.headline4,
              ),
            ),
            Text(
              "uid: ${pkg.uid}",
              style: textTheme.bodyText1,
            ),
            Text(
              "Package: ${pkg.packageName}",
              style: textTheme.bodyText1,
            ),
            Text(
              "Description: ${pkg.description}",
              style: textTheme.bodyText1,
            ),
            Text(
              "Min SDK Version: ${pkg.minSdkVersion}",
              style: textTheme.bodyText1,
            ),
            Text(
              "Installed on: ${installDt.toString()}",
              style: textTheme.bodyText1,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Center(
                child: Text(
                  "Activities",
                  style: textTheme.headline4,
                ),
              ),
            ),
            Center(
              child: Text(
                "(${pkg.activities?.length ?? 0})",
                style: textTheme.labelSmall,
              ),
            ),
            ..._buildActivities(pkg.activities),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Center(
                child: Text(
                  "Services",
                  style: textTheme.headline4,
                ),
              ),
            ),
            Center(
              child: Text(
                "(${pkg.services?.length ?? 0})",
                style: textTheme.labelSmall,
              ),
            ),
            ..._buildServices(pkg.services),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildActivities(List<AndroidActivityInfo>? activities) {
    final textStyle = Theme.of(context).textTheme;
    final List<Widget> widgets = [];

    activities?.forEach((activity) {
      widgets.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "${activity.name?.split('.').last}",
                  style: textStyle.titleMedium,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "${activity.name?.substring(0, activity.name!.lastIndexOf("."))}",
                  style: textStyle.labelSmall,
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildEnabledWidget(activity.enabled),
                    _buildExportedWidget(activity.exported),
                  ],
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(),
          ),
        ),
      ));
    });

    return widgets;
  }

  List<Widget> _buildServices(List<AndroidServiceInfo>? services) {
    final textStyle = Theme.of(context).textTheme;
    final List<Widget> widgets = [];

    services?.forEach((service) {
      widgets.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "${service.name?.split('.').last}",
                  style: textStyle.titleMedium,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "${service.name?.substring(0, service.name!.lastIndexOf("."))}",
                  style: textStyle.labelSmall,
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildEnabledWidget(service.enabled),
                    _buildExportedWidget(service.exported),
                  ],
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(),
          ),
        ),
      ));
    });

    return widgets;
  }

  Widget _buildEnabledWidget(bool isEnabled) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: isEnabled
            ? Colors.greenAccent.withOpacity(0.5)
            : Colors.grey.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
        child: Text(isEnabled ? 'enabled' : 'disabled'),
      ),
    );
  }

  Widget _buildExportedWidget(bool isExported) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: isExported
              ? Colors.redAccent.withOpacity(0.5)
              : Colors.grey.withOpacity(0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
          child: Text(isExported ? 'exported' : 'non-exported'),
        ),
      ),
    );
  }
}
