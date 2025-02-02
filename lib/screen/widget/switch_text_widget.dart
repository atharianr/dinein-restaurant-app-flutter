import 'package:flutter/material.dart';

import '../../style/typography/dine_in_text_styles.dart';

class SwitchTextWidget extends StatelessWidget {
  final String title;
  final String description;
  final bool state;
  final Function(bool) onChanged;

  const SwitchTextWidget({
    super.key,
    required this.title,
    required this.description,
    required this.state,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: DineInTextStyles.labelLargeBold,
              ),
              Text(
                description,
                style: DineInTextStyles.labelMedium,
              ),
            ],
          ),
        ),
        Switch(
          value: state,
          activeTrackColor: Colors.orange,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
