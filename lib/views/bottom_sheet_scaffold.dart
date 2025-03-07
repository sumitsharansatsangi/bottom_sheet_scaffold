import 'package:bottom_sheet_scaffold/bottom_sheet_scaffold.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bottom_sheet_controller.dart';

class BottomSheetScaffold extends StatelessWidget {
  BottomSheetScaffold({
    super.key,
    this.body,
    this.appBar,
    this.dismissOnClick = true,
    this.draggableBody = true,
    this.barrierColor = Colors.black54,
    required this.bottomSheet,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
    this.onWillPop,
    this.oneFingerScrolling = true,
  }) {
    Get.find<BottomSheetController>().oneFingerScrolling = oneFingerScrolling;
    Get.find<BottomSheetController>().barrierColor = barrierColor;
  }
  final Color barrierColor;
  final bool dismissOnClick;
  final bool draggableBody;
  final Widget? body;
  final DraggableBottomSheet bottomSheet;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final AlignmentDirectional persistentFooterAlignment;
  final Widget? drawer;
  final DrawerCallback? onDrawerChanged;
  final Widget? endDrawer;
  final DrawerCallback? onEndDrawerChanged;
  final Color? drawerScrimColor;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final bool oneFingerScrolling;
  final String? restorationId;
  final Future<bool> Function()? onWillPop;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, __) async {
        if (didPop) {
          return; // If the system already handled the pop, no further action is needed
        }

        if (BottomSheetPanel.isOpen) {
          BottomSheetPanel.close(); // Close bottom sheet if open
          return; // Prevent navigation
        } else {
          onWillPop != null
              ? await onWillPop!()
              : null; // Call onWillPop if provided
        }
      },
      child: Scaffold(
        extendBody: extendBody,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        appBar: appBar,
        floatingActionButton: floatingActionButton,
        floatingActionButtonAnimator: floatingActionButtonAnimator,
        floatingActionButtonLocation: floatingActionButtonLocation,
        persistentFooterAlignment: persistentFooterAlignment,
        persistentFooterButtons: persistentFooterButtons,
        drawer: drawer,
        onDrawerChanged: onDrawerChanged,
        endDrawer: endDrawer,
        onEndDrawerChanged: onEndDrawerChanged,
        drawerDragStartBehavior: drawerDragStartBehavior,
        drawerEdgeDragWidth: drawerEdgeDragWidth,
        drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
        drawerScrimColor: drawerScrimColor,
        endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        restorationId: restorationId,
        primary: primary,
        backgroundColor: backgroundColor,
        bottomNavigationBar: bottomNavigationBar,
        body: Listener(
          onPointerDown: (_) => oneFingerScrolling
              ? Get.find<BottomSheetController>().addPointer()
              : null,
          onPointerUp: (_) => oneFingerScrolling
              ? Get.find<BottomSheetController>().removePointer()
              : null,
          child: Stack(
            children: [
              GestureDetector(
                onVerticalDragStart: draggableBody
                    ? Get.find<BottomSheetController>().startDrag
                    : null,
                onVerticalDragUpdate: draggableBody
                    ? Get.find<BottomSheetController>().updateDrag
                    : null,
                onVerticalDragEnd: draggableBody
                    ? Get.find<BottomSheetController>().endDrag
                    : null,
                onTap: dismissOnClick
                    ? Get.find<BottomSheetController>().close
                    : null,
                child: GetBuilder<BottomSheetController>(builder: (controller) {
                  return AnimatedContainer(
                      duration:
                          Get.find<BottomSheetController>().animationDuration,
                      width: double.infinity,
                      height: double.infinity,
                      color: BottomSheetPanel.isOpen
                          ? barrierColor.withAlpha(127)
                          : Colors.transparent,
                      child: body);
                }),
              ),
              bottomSheet
            ],
          ),
        ),
      ),
    );
  }
}
