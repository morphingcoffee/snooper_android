import 'package:flutter/material.dart';
import 'package:snooper_android/model/sensors/sensor_info.dart';

class DisplaySensorsScreen extends StatefulWidget {
  final List<SensorInfo> sensors;

  const DisplaySensorsScreen({
    required this.sensors,
    Key? key,
  }) : super(key: key);

  @override
  _DisplaySensorsScreenState createState() => _DisplaySensorsScreenState();
}

class _DisplaySensorsScreenState extends State<DisplaySensorsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sensors (${widget.sensors.length})",
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final textTheme = Theme.of(context).textTheme;
    return ListView.separated(
      itemCount: widget.sensors.length,
      itemBuilder: (ctx, idx) {
        final sensor = widget.sensors[idx];
        final powerString = (sensor.power >= 1.0)
            ? sensor.power.toStringAsFixed(1)
            : sensor.power.toStringAsPrecision(1);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: SizedBox(
            height: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    sensor.name ?? 'No Name',
                    style: textTheme.headline6,
                  ),
                ),
                Text(
                  "${sensor.stringType}",
                  style: textTheme.bodySmall,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSensorProperty(
                      icon: Icons.store,
                      title: "${sensor.vendor}",
                      tooltip: "Vendor: ${sensor.vendor}",
                      bgColor: Colors.orange.withOpacity(0.2),
                    ),
                    _buildSensorProperty(
                      icon: Icons.battery_std_outlined,
                      title: "$powerString mA",
                      tooltip: "Power consumption: $powerString milliamperes",
                      bgColor: Colors.green.withOpacity(0.2),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (ctx, idx) {
        return const Divider(
          thickness: 5.0,
        );
      },
    );
  }

  Widget _buildSensorProperty(
      {required IconData icon,
      required String title,
      required String tooltip,
      required Color bgColor}) {
    return Tooltip(
      message: tooltip,
      showDuration: const Duration(milliseconds: 2000),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: bgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(icon),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
