import 'package:flutter/widgets.dart';

// Empty space after the last item of a screen. The bottom padding already
// covers the phone's gesture bar, and on tab screens the floating tab bar.
double endSpace(BuildContext context, {bool floatingButton = false}) =>
    MediaQuery.paddingOf(context).bottom + (floatingButton ? 104 : 48);
