import 'package:flutter/material.dart';
import 'package:snooper_android/constants/android_flags.dart';
import 'package:snooper_android/model/android_activity_info.dart';
import 'package:snooper_android/model/android_service_info.dart';
import 'package:snooper_android/model/detailed_android_package_info.dart';
import 'package:snooper_android/model/x509_signature_info.dart';

class IndividualDetailedPackageScreen extends StatefulWidget {
  const IndividualDetailedPackageScreen(this.pkg, {Key? key}) : super(key: key);

  final DetailedAndroidPackageInfo pkg;

  @override
  _IndividualDetailedPackageState createState() =>
      _IndividualDetailedPackageState();
}

class _IndividualDetailedPackageState
    extends State<IndividualDetailedPackageScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  static const List<Tab> _tabs = <Tab>[
    Tab(text: 'General Info'),
    Tab(text: 'Activities'),
    Tab(text: 'Services'),
    Tab(text: 'Signatures'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    final pkg = widget.pkg;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 36,
              height: 36,
              child: Hero(
                tag: "${pkg.packageName}",
                child: Image.memory(pkg.iconBytes!),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(pkg.name.split(".").last),
              ),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _tabs,
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final pkg = widget.pkg;
    return TabBarView(
      children: [
        _buildGeneralInfoContent(pkg),
        _buildActivitiesContent(pkg.activities),
        _buildServicesContent(pkg.services),
        _buildSignaturesContent(pkg.signatures),
      ],
      controller: _tabController,
    );
  }

  Widget _buildGeneralInfoContent(DetailedAndroidPackageInfo pkg) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          _buildSectionTitle("General Info"),
          ..._buildGeneralInfoItems(pkg),
        ]),
      ),
    );
  }

  Widget _buildActivitiesContent(List<AndroidActivityInfo>? activities) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 2 + (activities?.length ?? 0),
          itemBuilder: (context, idx) {
            if (idx == 0) {
              return _buildSectionTitle("Activities");
            } else if (idx == 1) {
              return Center(
                child: Text(
                  "(${activities?.length ?? 0})",
                  style: textTheme.labelSmall,
                ),
              );
            }

            final activity = activities![idx - 2];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "${activity.name?.split('.').last}",
                        style: textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "${activity.name?.substring(0, activity.name!.lastIndexOf("."))}",
                        style: textTheme.labelSmall,
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildEnabledChip(activity.enabled),
                          _buildExportedChip(activity.exported),
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
            );
          }),
    );
  }

  List<Widget> _buildGeneralInfoItems(DetailedAndroidPackageInfo pkg) {
    final installDt = DateTime.fromMillisecondsSinceEpoch(pkg.firstInstallTime);
    final updateDt = DateTime.fromMillisecondsSinceEpoch(pkg.lastUpdateTime);
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildGeneralInfoWidget(
              title: "Package", subtitle: pkg.packageName ?? 'none'),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: (pkg.description == null)
            ? []
            : [
                _buildGeneralInfoWidget(
                    title: "Description",
                    subtitle: pkg.description!,
                    maxWidthFraction: 1 / 2),
              ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildGeneralInfoWidget(
              title: "System App",
              subtitle: pkg.flags.has(ApplicationFlags.system) ? 'yes' : 'no',
              maxWidthFraction: 1 / 5),
          _buildGeneralInfoWidget(
              title: "Debuggable",
              subtitle:
                  pkg.flags.has(ApplicationFlags.debuggable) ? 'yes' : 'no',
              maxWidthFraction: 1 / 4),
          _buildGeneralInfoWidget(
              title: "Min SDK",
              subtitle: pkg.minSdkVersion.toString(),
              maxWidthFraction: 1 / 5),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildGeneralInfoWidget(
              title: "Cloud Backup",
              subtitle: pkg.flags.has(ApplicationFlags.allowBackup)
                  ? 'enabled'
                  : 'disabled',
              maxWidthFraction: 1 / 3),
          _buildGeneralInfoWidget(
              title: "Uses Cleartext Traffic",
              subtitle: pkg.flags.has(ApplicationFlags.usesCleartextTraffic)
                  ? 'yes'
                  : 'no',
              maxWidthFraction: 1 / 3),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildGeneralInfoWidget(
              title: "Installed",
              subtitle:
                  pkg.flags.has(ApplicationFlags.installed) ? 'yes' : 'no',
              maxWidthFraction: 1 / 3),
          _buildGeneralInfoWidget(
              title: "Stopped",
              subtitle: pkg.flags.has(ApplicationFlags.stopped) ? 'yes' : 'no',
              maxWidthFraction: 1 / 3),
          _buildGeneralInfoWidget(
              title: "Suspended",
              subtitle:
                  pkg.flags.has(ApplicationFlags.suspended) ? 'yes' : 'no',
              maxWidthFraction: 1 / 3),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildGeneralInfoWidget(
              title: "Data-only",
              subtitle:
                  pkg.flags.has(ApplicationFlags.isDataOnly) ? 'yes' : 'no',
              maxWidthFraction: 1 / 4),
          _buildGeneralInfoWidget(
            title: "Kernel User ID",
            subtitle: pkg.uid.toString(),
            maxWidthFraction: 2 / 4,
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildGeneralInfoWidget(
              title: "Storage UUID",
              subtitle: pkg.storageUuid ?? 'none',
              maxWidthFraction: 1),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildGeneralInfoWidget(
              title: "Installed On",
              subtitle: installDt.toString(),
              maxWidthFraction: 1 / 3),
          _buildGeneralInfoWidget(
              title: "Updated On",
              subtitle: updateDt.toString(),
              maxWidthFraction: 1 / 3),
        ],
      )
    ];
  }

  Widget _buildGeneralInfoWidget(
      {required String title, required String subtitle, maxWidthFraction = 1}) {
    assert(maxWidthFraction <= 1.0);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ConstrainedBox(
            constraints: BoxConstraints.loose(Size(
                maxWidthFraction * MediaQuery.of(context).size.width,
                double.infinity)),
            child: Column(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.labelSmall,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                ),
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(),
        ),
      ),
    );
  }

  Widget _buildServicesContent(List<AndroidServiceInfo>? services) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 2 + (services?.length ?? 0),
        itemBuilder: (context, idx) {
          if (idx == 0) {
            return _buildSectionTitle("Services");
          } else if (idx == 1) {
            return Center(
              child: Text(
                "(${services?.length ?? 0})",
                style: textTheme.labelSmall,
              ),
            );
          }

          final service = services![idx - 2];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "${service.name?.split('.').last}",
                      style: textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "${service.name?.substring(0, service.name!.lastIndexOf("."))}",
                      style: textTheme.labelSmall,
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildEnabledChip(service.enabled),
                        _buildExportedChip(service.exported),
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
          );
        },
      ),
    );
  }

  Widget _buildSignaturesContent(List<X509SignatureInfo>? signatures) {
    final textTheme = Theme.of(context).textTheme;
    final List<Widget> widgets = [_buildSectionTitle("Signatures")];

    signatures?.forEach((signature) {
      final notBefore =
          DateTime.fromMillisecondsSinceEpoch(signature.notBefore);
      final notAfter = DateTime.fromMillisecondsSinceEpoch(signature.notAfter);

      widgets.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "Not Before",
                  style: textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                Text(
                  notBefore.toString(),
                  style: textTheme.labelSmall,
                  textAlign: TextAlign.center,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
                Text(
                  "Not After",
                  style: textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                Text(
                  notAfter.toString(),
                  style: textTheme.labelSmall,
                  textAlign: TextAlign.center,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
                Text(
                  "Signature Algorithm",
                  style: textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "${signature.sigAlgName}",
                  style: textTheme.labelSmall,
                  textAlign: TextAlign.center,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
                Text(
                  "Issuer DN",
                  style: textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "${signature.issuerDN}",
                  style: textTheme.labelSmall,
                  textAlign: TextAlign.center,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
                Text(
                  "Serial Number",
                  style: textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "${signature.serialNumber}",
                  style: textTheme.labelSmall,
                  textAlign: TextAlign.center,
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: widgets,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }

  Widget _buildEnabledChip(bool isEnabled) {
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

  Widget _buildExportedChip(bool isExported) {
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
