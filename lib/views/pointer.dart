import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Represents the state of the animated cursor.
class AnimatedCursorState {
  const AnimatedCursorState({
    this.offset = Offset.zero,
    this.size = kDefaultSize,
    this.decoration = kDefaultDecoration,
  });

  // Default size for the cursor.
  static const Size kDefaultSize = Size(40, 40);
  static const Size kSmallSize = Size(10, 10); // Shrinked size when idle.

  // Default decoration for the cursor.
  static const BoxDecoration kDefaultDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(90)),
    color: Colors.black12,
  );

  final BoxDecoration decoration;
  final Offset offset;
  final Size size;
}

// Provides functionality for updating the state of the animated cursor.
class AnimatedCursorProvider extends ChangeNotifier {
  AnimatedCursorProvider();

  AnimatedCursorState state = const AnimatedCursorState();
  Timer? _cursorTimer;

  // Updates the position of the cursor.
  void updateCursorPosition(Offset pos) {
    state = AnimatedCursorState(
        offset: pos, size: AnimatedCursorState.kDefaultSize);
    notifyListeners();

    // Reset previous timer and start a new one to detect inactivity.
    _cursorTimer?.cancel();
    _cursorTimer = Timer(const Duration(milliseconds: 1000), _shrinkCursor);
  }

  // Shrinks the cursor when inactive.
  void _shrinkCursor() {
    state = AnimatedCursorState(
        offset: state.offset, size: AnimatedCursorState.kSmallSize);
    notifyListeners();
  }
}

// Represents a web pointer widget with an animated cursor.
class WebPointer extends StatelessWidget {
  const WebPointer({
    super.key,
    this.circleColor = Colors.black,
    this.roundColor = Colors.black,
    this.roundDuration = 100,
    this.circleDuration = 350,
    this.child,
  });

  final Color? circleColor;
  final Color? roundColor;
  final int? roundDuration;
  final int? circleDuration;
  final Widget? child;

  void _onCursorUpdate(PointerEvent event, BuildContext context) {
    context.read<AnimatedCursorProvider>().updateCursorPosition(event.position);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AnimatedCursorProvider(),
      child: Consumer<AnimatedCursorProvider>(
        child: child ?? const SizedBox(),
        builder: (context, provider, child) {
          final state = provider.state;
          return Directionality(
            textDirection: TextDirection.ltr,
            child: Stack(
              children: [
                if (child != null) child,
                Positioned.fill(
                  child: MouseRegion(
                    opaque: false,
                    cursor: SystemMouseCursors.basic,
                    onHover: (e) => _onCursorUpdate(e, context),
                  ),
                ),
                Visibility(
                  visible: state.offset != Offset.zero,
                  child: AnimatedPositioned(
                    left: state.offset.dx - state.size.width / 1.8,
                    top: state.offset.dy - state.size.height / 1.8,
                    width: state.size.width,
                    height: state.size.height,
                    duration: Duration(milliseconds: roundDuration!),
                    child: IgnorePointer(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 1200),
                        curve: Curves.easeIn,
                        width: state.size.width,
                        height: state.size.height,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: roundColor!,
                            width: 1.5,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: state.offset != Offset.zero,
                  child: AnimatedPositioned(
                    left: state.offset.dx - state.size.width / 7,
                    top: state.offset.dy - state.size.height / 7.2,
                    width: 7,
                    height: 7,
                    duration: Duration(milliseconds: circleDuration!),
                    child: IgnorePointer(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 0),
                        curve: Curves.easeIn,
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: circleColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
