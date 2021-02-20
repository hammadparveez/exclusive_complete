import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';

class CustomScrollLoader extends StatelessWidget {
  final bool isLoading;

  const CustomScrollLoader({Key key, this.isLoading = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if(isLoading)
    return Center(
      child:  Material(
        type: MaterialType.transparency,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SpinKitThreeBounce(color: ColorResources.WEB_PRIMARY_COLOR, size: 20),
            const SizedBox(height: 4),
            Text("Loading more...", style: titilliumSemiBold),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
    else
      return const SizedBox.shrink();
  }
}



class CustomLoader extends StatelessWidget {
  final bool isLoading;
  final Widget elseWidget;
  final bool isExpanded;
  const CustomLoader({Key key, this.isLoading = false, this.elseWidget, this.isExpanded = true}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if(isLoading)
      return isExpanded ? Expanded(
        child: Center(
          child:  Material(
            type: MaterialType.transparency,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SpinKitThreeBounce(color: ColorResources.WEB_PRIMARY_COLOR, size: 40),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ),
      )
          : Center(
        child:  Material(
          type: MaterialType.transparency,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SpinKitThreeBounce(color: ColorResources.WEB_PRIMARY_COLOR, size: 40),
              const SizedBox(height: 4),
            ],
          ),
        ),
      );
    else
      return elseWidget ?? const SizedBox.shrink();
  }
}
