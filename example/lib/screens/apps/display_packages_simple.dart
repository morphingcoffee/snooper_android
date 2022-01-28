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
        title: Text(
          "Application List (${widget.pkgs.length})",
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final textTheme = Theme.of(context).textTheme;
    return ListView.separated(
      itemCount: widget.pkgs.length,
      itemBuilder: (ctx, idx) {
        final pkg = widget.pkgs[idx];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: SizedBox(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    pkg.name.split(".").last,
                    style: textTheme.headline6,
                  ),
                ),
                Text(
                  "${pkg.uid}",
                  style: textTheme.bodySmall,
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "${pkg.packageName}",
                    style: textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (ctx, idx) {
        return const Divider();
      },
    );
  }
}
