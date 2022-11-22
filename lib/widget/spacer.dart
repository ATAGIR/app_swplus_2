import 'package:flutter/widgets.dart';
import 'package:telemetria/utils/responsive.dart';

class SpacerSW extends StatelessWidget {
  const SpacerSW({Key? key, required this.space, required this.isVertical})
      : super(key: key);

  final double space;
  final bool isVertical;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return isVertical? SizedBox(
      height: responsive.hp(space),
    )
    : SizedBox(
      width: responsive.hp(space),
    )
    ;
  }
}