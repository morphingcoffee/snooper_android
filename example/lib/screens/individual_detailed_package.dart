import 'package:flutter/material.dart';
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
            Text(
              "General Info",
              style: textTheme.headline4,
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
            Text(
              "Activities",
              style: textTheme.headline4,
            ),
            Text(
              "Services",
              style: textTheme.headline4,
            ),
            ..._buildServices(pkg.services),
            Text(
              "Other",
              style: textTheme.headline4,
            ),
            Text(
              "Installed initiated by: ${pkg.installInitiatingPackageName}",
              style: textTheme.bodyText1,
            ),
            Text(
              "Last updated on: ${updateDt.toString()}",
              style: textTheme.bodyText1,
            ),
            Text(
              "Last updated on: ${updateDt.toString()}",
              style: textTheme.bodyText1,
            ),
            Text(
              "Backup Agent Name: ${pkg.backupAgentName ?? 'none'}",
              style: textTheme.bodyText1,
            ),
            Text(
              "Native Library Dir: ${pkg.nativeLibraryDir}",
              style: textTheme.bodyText1,
            ),
            Text(
              "Process Name: ${pkg.processName}",
              style: textTheme.bodyText1,
            ),
            Text(
              "Device Protected Data Dir: ${pkg.deviceProtectedDataDir}",
              style: textTheme.bodyText1,
            ),
            const Divider(
              height: 10.0,
            ),
            const Divider(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
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
                    _buildEnabledServiceWidget(service),
                    _buildExportedServiceWidget(service),
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

  Widget _buildEnabledServiceWidget(AndroidServiceInfo service) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: service.enabled
            ? Colors.greenAccent.withOpacity(0.5)
            : Colors.grey.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
        child: Text(service.enabled ? 'enabled' : 'disabled'),
      ),
    );
  }

  Widget _buildExportedServiceWidget(AndroidServiceInfo service) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: service.exported
              ? Colors.redAccent.withOpacity(0.5)
              : Colors.grey.withOpacity(0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
          child: Text(service.exported ? 'exported' : 'non-exported'),
        ),
      ),
    );
  }
}
