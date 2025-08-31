// AnimatedContainer

import 'dart:math';

import 'package:flutter/material.dart';

class TestAnimatedContainer extends StatefulWidget {
  const TestAnimatedContainer({super.key});

  @override
  State<TestAnimatedContainer> createState() => _TestAnimatedContainerState();
}

class _TestAnimatedContainerState extends State<TestAnimatedContainer> {
  bool isBig = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedContainer(
          decoration: BoxDecoration(
              color: isBig ? Colors.red : Colors.black,
              borderRadius: BorderRadius.circular(isBig ? 30 : 40)),
          height: isBig ? 400 : 200,
          width: isBig ? 400 : 200,
          curve: Curves.easeInOut,
          duration: const Duration(seconds: 1),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                isBig = !isBig;
              });
            },
            child: Text('Expand'))
      ],
    ));
  }
}

class TestTweenAnimation extends StatefulWidget {
  const TestTweenAnimation({super.key});

  @override
  State<TestTweenAnimation> createState() => _TestTweenAnimationState();
}

class _TestTweenAnimationState extends State<TestTweenAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat(); // <-- Lặp vô hạn
  }

  @override
  void dispose() {
    _controller.dispose(); // đừng quên giải phóng controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: RotationTransition(
              turns: _controller,
              child: Image.asset('assets/earth.png', width: 500),
            ),
          ),
        ],
      ),
    );
  }
}


class CustomTweenAnimation extends StatefulWidget {
  const CustomTweenAnimation({super.key});

  @override
  State<CustomTweenAnimation> createState() => _CustomTweenAnimationState();
}

class _CustomTweenAnimationState extends State<CustomTweenAnimation> {
  double beginAngle = 0;
  double endAngle = 2 * pi;
  int durationSeconds = 2;

  bool trigger = false; // để rebuild TweenAnimationBuilder mỗi lần bấm nút

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Tween Animation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Inputs
            Row(
              children: [
                const Text('Begin Angle (rad): '),
                Expanded(
                  child: Slider(
                    value: beginAngle,
                    min: 0,
                    max: 2 * pi,
                    divisions: 100,
                    label: beginAngle.toStringAsFixed(2),
                    onChanged: (value) {
                      setState(() => beginAngle = value);
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('End Angle (rad): '),
                Expanded(
                  child: Slider(
                    value: endAngle,
                    min: 0,
                    max: 4 * pi,
                    divisions: 100,
                    label: endAngle.toStringAsFixed(2),
                    onChanged: (value) {
                      setState(() => endAngle = value);
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Duration (s): '),
                Expanded(
                  child: Slider(
                    value: durationSeconds.toDouble(),
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: '$durationSeconds',
                    onChanged: (value) {
                      setState(() => durationSeconds = value.toInt());
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // trigger rebuild để restart animation
                setState(() {
                  trigger = !trigger;
                });
              },
              child: const Text('Animate!'),
            ),

            const SizedBox(height: 40),

            // Animation
            Center(
              child: TweenAnimationBuilder(
                key: ValueKey(trigger), // bắt buộc để restart animation
                tween: Tween<double>(begin: beginAngle, end: endAngle),
                duration: Duration(seconds: durationSeconds),
                builder: (_, double angle, __) {
                  return Transform.rotate(
                    angle: angle,
                    child: Image.asset('assets/earth.png', width: 200),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class CustomLogoFade extends StatefulWidget {
  const CustomLogoFade({super.key}); 

  @override
  State<CustomLogoFade> createState() => _CustomLogoFadeState();
}

class _CustomLogoFadeState extends State<CustomLogoFade> {
  double _opacity = 0; 
  void change() {
    print(_opacity);
    setState(() {
      if (_opacity == 1) {
        _opacity = 0; 
      }
      else {
        _opacity = 1; 
      }
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AnimatedOpacity(
            opacity: _opacity, duration: const Duration(seconds: 2),
            child: FlutterLogo(
              size: 300,
            ),
            ), 
          const SizedBox(height: 10,), 
          ElevatedButton(
            onPressed: () => change()
          , child: Text('OMGNICE'))
        ],
      ),
    ); 
  }
}