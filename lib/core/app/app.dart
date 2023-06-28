import 'package:flutter/material.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';

class AppContainer extends StatefulWidget {
  final Widget child;

  const AppContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<AppContainer> createState() => AppState();

  static AppState of(BuildContext context) {
    return (context
                .dependOnInheritedWidgetOfExactType<_InheritedStateContainer>()
            as _InheritedStateContainer)
        .appState;
  }
}

class AppState extends State<AppContainer> {
  AppColorPalette light = lightColorPalette;
  TextTheme textTheme = lightTextTheme;

  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      appState: this,
      child: widget.child,
    );
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final AppState appState;

  const _InheritedStateContainer(
      {Key? key, required Widget child, required this.appState})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer oldWidget) => true;
}
