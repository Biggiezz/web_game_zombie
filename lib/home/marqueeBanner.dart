import 'dart:async';
import 'package:flutter/material.dart';

class MarqueeBanner extends StatefulWidget {
  const MarqueeBanner({super.key});

  @override
  State<MarqueeBanner> createState() => _MarqueeBannerState();
}

class _MarqueeBannerState extends State<MarqueeBanner> {
  late ScrollController _scrollController;
  final GlobalKey _contentKey = GlobalKey();
  double _contentWidth = 0.0;
  Timer? _scrollTimer;

  final double _scrollSpeed = 1.0;
  final Duration _scrollFrequency = const Duration(milliseconds: 16);

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureContentAndStartScroll();
    });
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _measureContentAndStartScroll() {
    final BuildContext? context = _contentKey.currentContext;
    if (context != null) {
      setState(() {
        _contentWidth = context.size!.width;
      });
      _startScrollLoop();
    }
  }

  void _startScrollLoop() {
    _scrollTimer = Timer.periodic(_scrollFrequency, (timer) {
      if (!_scrollController.hasClients || _contentWidth == 0.0) {
        return;
      }

      double currentPosition = _scrollController.position.pixels;

      if (currentPosition >= _contentWidth) {
        _scrollController.jumpTo(currentPosition - _contentWidth);
      } else {
        _scrollController.jumpTo(currentPosition + _scrollSpeed);
      }
    });
  }

  Widget _buildBannerContent({Key? key}) {
    return Container(
      key: key,
      height: 60,
      alignment: Alignment.center,
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconTextItem(
            icon: Icons.local_shipping,
            text: "MIỄN PHÍ VẬN CHUYỂN TOÀN QUỐC",
          ),
          SizedBox(width: 40),
          IconTextItem(icon: Icons.percent, text: "GIẢM GIÁ 50% MÙA HÈ"),
          SizedBox(width: 40),
          IconTextItem(icon: Icons.star, text: "HÀNG CHÍNH HÃNG 100%"),
          SizedBox(width: 40),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          Container(
            height: 60,
            color: Color(0xFFF3BA2F),
            child: ClipRect(
              child: IgnorePointer(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      _buildBannerContent(key: _contentKey),
                      _buildBannerContent(),
                      _buildBannerContent(),
                      _buildBannerContent(),
                      _buildBannerContent(),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: Container(
              color: Color(0xFFF3BA2F),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Copyright © 2025 REMIX',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.facebook, color: Colors.black, size: 20),
                      const SizedBox(width: 16),
                      const Icon(Icons.discord, color: Colors.black, size: 20),
                      const SizedBox(width: 16),
                      const Icon(Icons.email, color: Colors.black, size: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IconTextItem extends StatelessWidget {
  final IconData icon;
  final String text;
  const IconTextItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.black, size: 20),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
