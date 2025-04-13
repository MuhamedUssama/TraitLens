import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trait_lens/core/utils/app_assets.dart';

class CustomMicButton extends StatefulWidget {
  final bool isRecording;
  final Function onTap;

  const CustomMicButton({
    super.key,
    required this.isRecording,
    required this.onTap,
  });

  @override
  State<CustomMicButton> createState() => _CustomMicButtonState();
}

class _CustomMicButtonState extends State<CustomMicButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: false);

    final curved = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _animation1 = Tween<double>(begin: 90, end: 160).animate(
      CurvedAnimation(parent: curved, curve: const Interval(0.0, 1.0)),
    );

    _animation2 = Tween<double>(begin: 80, end: 130).animate(
      CurvedAnimation(parent: curved, curve: const Interval(0.2, 1.0)),
    );

    _animation3 = Tween<double>(begin: 70, end: 100).animate(
      CurvedAnimation(parent: curved, curve: const Interval(0.4, 1.0)),
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 180,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              if (widget.isRecording) ...[
                _buildCircle(_animation1.value, 0.25),
                _buildCircle(_animation2.value, 0.35),
                _buildCircle(_animation3.value, 0.45),
              ],
              _buildMic(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCircle(double size, double alpha) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xff3AAEF8).withValues(alpha: alpha),
          width: 1.5,
        ),
      ),
    );
  }

  Widget _buildMic() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000),
          gradient: const LinearGradient(
            colors: [
              Color(0xff3AAEF8),
              Color(0xff1F41BB),
            ],
          ),
        ),
        child: Center(
          child: SvgPicture.asset(AppSvg.mic),
        ),
      ),
    );
  }
}
