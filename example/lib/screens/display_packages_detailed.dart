import 'package:flutter/material.dart';
import 'package:snooper_android/model/detailed_android_package_info.dart';

class DisplayPackagesDetailedScreen extends StatefulWidget {
  final List<DetailedAndroidPackageInfo> pkgs;

  const DisplayPackagesDetailedScreen({
    required this.pkgs,
    Key? key,
  }) : super(key: key);

  @override
  _DisplayPackagesDetailedScreenState createState() =>
      _DisplayPackagesDetailedScreenState();
}

class _DisplayPackagesDetailedScreenState
    extends State<DisplayPackagesDetailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Application Info (detailed)",
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return _buildDataTable();
  }

  Widget _buildDataTable() {
    final List<DataRow> rows = [];

    for (var pkg in widget.pkgs) {
      final List<DataCell> cells = [];

      final installDt =
          DateTime.fromMillisecondsSinceEpoch(pkg.firstInstallTime);
      final updateDt = DateTime.fromMillisecondsSinceEpoch(pkg.lastUpdateTime);

      cells.add(DataCell(Text("${pkg.uid}")));
      cells.add(DataCell(
        SizedBox(
          width: 64,
          height: 64,
          child: Image.memory(
            pkg.iconBytes!,
          ),
        ),
      ));
      cells.add(DataCell(Text(pkg.name.split(".").last)));
      cells.add(DataCell(Text(pkg.packageName!)));

      cells.add(DataCell(Text(installDt.toString())));
      cells.add(DataCell(Text(updateDt.toString())));
      cells.add(DataCell(Text("${pkg.minSdkVersion}")));

      rows.add(DataRow(
        cells: cells,
      ));
    }

    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          dataRowHeight: 100,
          columns: const [
            DataColumn(
              label: Text("uid"),
              numeric: true,
            ),
            DataColumn(
              label: Text("icon"),
            ),
            DataColumn(
              label: Text("Name"),
            ),
            DataColumn(
              label: Text("Package"),
            ),
            DataColumn(
              label: Text("Installed"),
            ),
            DataColumn(
              label: Text("Updated"),
            ),
            DataColumn(
              label: Text("minSdkVersion"),
            ),
          ],
          rows: rows,
        ),
      ),
    );
  }
}
