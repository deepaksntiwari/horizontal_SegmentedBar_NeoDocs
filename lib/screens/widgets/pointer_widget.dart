import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horizontal_segmentedbar_neodocs/blocs/horizontal_bar/horizontal_bar_bloc.dart';
import 'package:horizontal_segmentedbar_neodocs/blocs/horizontal_bar/horizontal_bar_state.dart';

class PointerWidget extends StatefulWidget {
  const PointerWidget({super.key});

  @override
  State<PointerWidget> createState() => _PointerWidgetState();
}

class _PointerWidgetState extends State<PointerWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;
  late Animation<int> _valueAnimation; // Animation for pointer value

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    _widthAnimation =
        Tween<double>(begin: 0.0, end: 0.0).animate(_animationController);
    _valueAnimation = IntTween(begin: 0, end: 0)
        .animate(_animationController); // Use IntTween
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HorizontalBarBloc, HorizontalBarState>(
      builder: (context, state) {
        if (state is HorizontalBarPlotBarState) {
          // Update animations based on state
          _widthAnimation = Tween<double>(
                  begin: _widthAnimation.value,
                  end: state.pointerPosition.toDouble())
              .animate(_animationController);

          // Ensure pointerValue is an integer before using in IntTween
          int pointerValue = state.pointerValue;

          _valueAnimation =
              IntTween(begin: _valueAnimation.value, end: pointerValue)
                  .animate(_animationController);

          _animationController.forward(from: 0.0); // Trigger animation

          return Row(
            children: [
              AnimatedBuilder(
                animation: _widthAnimation,
                builder: (context, child) => SizedBox(
                  width: _widthAnimation.value,
                ),
              ),
              AnimatedBuilder(
                animation: _valueAnimation,
                builder: (context, child) => Column(
                  children: [
                    const Expanded(child: SizedBox()),
                    const Icon(CupertinoIcons.triangle_fill),
                    Text(_valueAnimation.value
                        .toString()), // Display animated value
                  ],
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
      listener: (context, state) {},
    );
  }
}
