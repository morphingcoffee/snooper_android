import 'dart:math' as math;

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:snooper_android/model/audio/freq_response.dart';
import 'package:snooper_android/model/audio/microphone_info.dart';

class DisplayMicrophonesScreen extends StatefulWidget {
  final List<MicrophoneInfo> microphones;

  const DisplayMicrophonesScreen({
    required this.microphones,
    Key? key,
  }) : super(key: key);

  @override
  _DisplayMicrophonesScreenState createState() =>
      _DisplayMicrophonesScreenState();
}

class _DisplayMicrophonesScreenState extends State<DisplayMicrophonesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Microphones (${widget.microphones.length})"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      color: Theme.of(context).backgroundColor.withOpacity(0.5),
      child: ListView.separated(
        itemCount: widget.microphones.length,
        itemBuilder: (ctx, idx) {
          final mic = widget.microphones[idx];
          String title = mic.address;
          if (mic.description != null) {
            title += " (${mic.description})";
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(title, style: textTheme.headline6),
                const Padding(padding: EdgeInsets.only(bottom: 8.0)),
                Text(_getPolarPatternString(mic), style: textTheme.bodySmall),
                const Padding(padding: EdgeInsets.only(bottom: 8.0)),
                _buildFrequencyResponseChartOrNothing(mic),
              ],
            ),
          );
        },
        separatorBuilder: (ctx, idx) {
          return const Divider(thickness: 5.0);
        },
      ),
    );
  }

  Widget _buildFrequencyResponseChartOrNothing(MicrophoneInfo mic) {
    if ((mic.frequencyResponse?.length ?? 0) == 0) {
      // Skip chart building when no frequency response data available
      return Container();
    } else {
      return _buildFrequencyResponseChart(mic);
    }
  }

  /// Frequency-response charts are usually displayed with
  /// frequency axis using logarithmic scale.
  /// Hence, log(x) is used for plotting & exp(log(x)) is used for displaying
  /// original x frequency value for the user.
  Widget _buildFrequencyResponseChart(MicrophoneInfo mic) {
    final data = mic.frequencyResponse!;
    final series = <charts.Series<dynamic, num>>[
      charts.Series<FreqResponse, double>(
        id: 'FreqResponse',
        colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault.darker,
        domainFn: (FreqResponse freqResp, _) {
          // use log scale for frequency
          return math.log(freqResp.frequency);
        },
        measureFn: (FreqResponse freqResp, _) => freqResp.response,
        data: data,
      ),
    ];

    // Choose arbitrary frequency (x-axis) ticks
    final staticTicks = <charts.TickSpec<double>>[
      charts.TickSpec(math.log(250)),
      charts.TickSpec(math.log(500)),
      charts.TickSpec(math.log(1000)),
      charts.TickSpec(math.log(2500)),
      charts.TickSpec(math.log(5000)),
      charts.TickSpec(math.log(1000)),
      charts.TickSpec(math.log(10000)),
      charts.TickSpec(math.log(20000)),
    ];

    final size = MediaQuery.of(context).size;
    const horizontalPadding = 20.0;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Theme.of(context).backgroundColor.withOpacity(0.7),
      ),
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 8.0)),
          Text(
            'Frequency Response Chart',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 16.0,
                left: horizontalPadding,
                right: horizontalPadding,
                bottom: 8.0),
            child: SizedBox(
              width: size.width - (2 * horizontalPadding),
              height: 250,
              child: charts.LineChart(
                series,
                defaultRenderer:
                    charts.LineRendererConfig(includePoints: false),
                domainAxis: charts.NumericAxisSpec(
                  tickProviderSpec:
                      charts.StaticNumericTickProviderSpec(staticTicks),
                  tickFormatterSpec:
                      charts.BasicNumericTickFormatterSpec((xValue) {
                    final originalFreq = math.exp(xValue!).round();
                    if (originalFreq < 1000) {
                      return originalFreq.toString();
                    } else {
                      final label = (originalFreq / 1000).toStringAsFixed(0);
                      return '${label}k';
                    }
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getPolarPatternString(MicrophoneInfo mic) {
    String directionalityStr;
    switch (mic.directionality) {
      case 1:
        directionalityStr = 'omnidirectional';
        break;
      case 2:
        directionalityStr = 'bi-directional';
        break;
      case 3:
        directionalityStr = 'cardioid';
        break;
      case 4:
        directionalityStr = 'hyper cardioid';
        break;
      case 5:
        directionalityStr = 'super cardioid';
        break;
      default:
        directionalityStr = 'unknown polar pattern';
        break;
    }
    return directionalityStr;
  }
}
