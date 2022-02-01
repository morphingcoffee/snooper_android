import 'package:flutter/material.dart';
import 'package:snooper_android/model/features/system_feature.dart';

class DisplaySystemFeaturesScreen extends StatefulWidget {
  final List<SystemFeature> features;

  const DisplaySystemFeaturesScreen({
    required this.features,
    Key? key,
  }) : super(key: key);

  @override
  _DisplaySystemFeaturesScreenState createState() =>
      _DisplaySystemFeaturesScreenState();
}

class _DisplaySystemFeaturesScreenState
    extends State<DisplaySystemFeaturesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "System Features (${widget.features.length})",
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final textTheme = Theme.of(context).textTheme;
    return ListView.separated(
      itemCount: widget.features.length,
      itemBuilder: (ctx, idx) {
        final feature = widget.features[idx];
        final splits = feature.name?.split(".") ?? [];
        String featureTitle = 'Undefined';
        String featureSubtitle = '-';

        if (feature.name == null) {
          featureTitle = 'OpenGL ES Version';
          featureSubtitle = feature.glEsVersion ?? '-';
        } else if (splits.length >= 2) {
          featureTitle = splits.removeLast();
          featureSubtitle = splits.join(".");
        } else if (splits.length == 1) {
          featureTitle = splits[0];
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: SizedBox(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    featureTitle,
                    style: textTheme.headline6,
                  ),
                ),
                Text(
                  featureSubtitle,
                  style: textTheme.bodySmall,
                ),
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
}
