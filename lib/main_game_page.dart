import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import 'game.dart';
import 'utility/direction.dart';

class MainGamePage extends StatefulWidget {
  const MainGamePage({Key? key}) : super(key: key);

  @override
  MainGamePageState createState() => MainGamePageState();
}

class MainGamePageState extends State<MainGamePage> {
  MainGame game = MainGame();
  bool _isClear = false;

  @override
  Widget build(BuildContext context) {
    game.setCallback(_changeState);

    return Scaffold(
        body: Stack(
      children: [
        GameWidget(game: game),
        Congratulations(isClear: _isClear),
        OnScreenControls(game: game),
      ],
    ));
  }

  void _changeState(state) {
    setState(() {
      _isClear = state;
    });
  }
}

class Congratulations extends StatelessWidget {
  final bool isClear;
  const Congratulations({Key? key, required this.isClear}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, -0.6),
      child: Visibility(
        visible: isClear,
        child: Image.asset('assets/images/congratulations.png'),
      ),
    );
  }
}

class OnScreenControls extends StatelessWidget {
  final MainGame game;

  const OnScreenControls({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 600;
    final controlSize = isSmallScreen ? 140.0 : 160.0;
    final buttonSize = isSmallScreen ? 50.0 : 60.0;

    return Positioned(
      bottom: 20,
      right: 20,
      child: Container(
        width: controlSize,
        height: controlSize,
        child: Stack(
          children: [
            // Up arrow
            Positioned(
              top: 0,
              left: (controlSize - buttonSize) / 2,
              child: _buildArrowButton(
                icon: Icons.keyboard_arrow_up,
                direction: Direction.up,
                size: buttonSize,
              ),
            ),
            // Down arrow
            Positioned(
              bottom: 0,
              left: (controlSize - buttonSize) / 2,
              child: _buildArrowButton(
                icon: Icons.keyboard_arrow_down,
                direction: Direction.down,
                size: buttonSize,
              ),
            ),
            // Left arrow
            Positioned(
              top: (controlSize - buttonSize) / 2,
              left: 0,
              child: _buildArrowButton(
                icon: Icons.keyboard_arrow_left,
                direction: Direction.left,
                size: buttonSize,
              ),
            ),
            // Right arrow
            Positioned(
              top: (controlSize - buttonSize) / 2,
              right: 0,
              child: _buildArrowButton(
                icon: Icons.keyboard_arrow_right,
                direction: Direction.right,
                size: buttonSize,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArrowButton({
    required IconData icon,
    required Direction direction,
    required double size,
  }) {
    return GestureDetector(
      onTap: () => game.handleDirectionInput(direction),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(size / 2),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: size * 0.5,
        ),
      ),
    );
  }
}
