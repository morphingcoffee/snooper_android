import 'package:flutter/material.dart';
import 'package:snooper_android/model/detailed_android_package_info.dart';

import 'individual_detailed_package.dart';

class DisplayPackagesDetailedScreen extends StatefulWidget {
  final String title;
  final List<DetailedAndroidPackageInfo> pkgs;

  const DisplayPackagesDetailedScreen({
    required this.title,
    required this.pkgs,
    Key? key,
  }) : super(key: key);

  @override
  _DisplayPackagesDetailedScreenState createState() =>
      _DisplayPackagesDetailedScreenState();
}

class _DisplayPackagesDetailedScreenState
    extends State<DisplayPackagesDetailedScreen> {
  late TextTheme _textTheme;

  @override
  void didChangeDependencies() {
    _textTheme = Theme.of(context).textTheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      color: Theme.of(context).backgroundColor.withOpacity(0.2),
      child: ListView.separated(
        itemBuilder: (context, idx) {
          return _buildListItem(widget.pkgs[idx]);
        },
        separatorBuilder: (context, idx) {
          return const Divider(
            thickness: 3.0,
            height: 1.0,
          );
        },
        itemCount: widget.pkgs.length,
      ),
    );
  }

  Widget _buildListItem(DetailedAndroidPackageInfo pkg) {
    return InkWell(
      onTap: () {
        _navToIndividualPackageDetails(pkg);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              leading: Hero(
                  tag: "${pkg.packageName}",
                  child: Image.memory(pkg.iconBytes!)),
              title: Text(pkg.name.split(".").last),
              subtitle: Text("${pkg.packageName}"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: _buildSpecificPackagePills(pkg),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecificPackagePills(DetailedAndroidPackageInfo pkg) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _pluralAwareTitleText(
                    pkg.activities?.length, "activity", "activities"),
                style: _textTheme.labelSmall,
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.deepPurpleAccent.withOpacity(0.2),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _pluralAwareTitleText(
                    pkg.services?.length, "service", "services"),
                style: _textTheme.labelSmall,
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.cyan.withOpacity(0.2),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _pluralAwareTitleText(
                    pkg.signatures?.length, "signature", "signatures"),
                style: _textTheme.labelSmall,
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.cyan.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }

  String _pluralAwareTitleText(int? howMany, String singular, String plural) {
    howMany ??= 0;
    return (howMany == 1) ? "$howMany $singular" : "$howMany $plural";
  }

  Future<void> _navToIndividualPackageDetails(
      DetailedAndroidPackageInfo pkg) async {
    final route = MaterialPageRoute(builder: (ctx) {
      return IndividualDetailedPackageScreen(pkg);
    });
    Future.delayed(const Duration(milliseconds: 150),
        () => Navigator.of(context).push(route));
  }
}
