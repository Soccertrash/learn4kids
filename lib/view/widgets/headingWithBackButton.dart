import 'package:flutter/cupertino.dart';
import 'package:learn4kids/view/styles/text.dart' as TextStyle;
import 'package:learn4kids/view/widgets/appBackButton.dart';

class HeadingWithBackButton extends StatelessWidget {
  final String heading;

  const HeadingWithBackButton(this.heading);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: Align(
          alignment: Alignment.topLeft,
          child: AppBackButton(),
        )),
        Expanded(
            child: Align(
                alignment: Alignment.center,
                child: Text(heading, style: TextStyle.heading))),
        Expanded(child: Container())
      ],
    ));
  }
}
