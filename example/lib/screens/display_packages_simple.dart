import 'package:flutter/material.dart';

import 'package:snooper_android/model/simple_android_package_info.dart';

class DisplayPackagesSimpleScreen extends StatefulWidget {
  final List<SimpleAndroidPackageInfo> pkgs;

  const DisplayPackagesSimpleScreen({
    required this.pkgs,
    Key? key,
  }) : super(key: key);

  @override
  _DisplayPackagesSimpleScreenState createState() =>
      _DisplayPackagesSimpleScreenState();
}

class _DisplayPackagesSimpleScreenState
    extends State<DisplayPackagesSimpleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Application Info (limited)",
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ListView.builder(itemBuilder: (ctx, idx) {
      final pkg = widget.pkgs[idx];

      return ListTile(
        title: Text("${pkg.name} (${pkg.uid})"),
        subtitle: Text("${pkg.packageName}"),
      );
    });
  }
}
