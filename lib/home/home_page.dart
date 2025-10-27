import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../provider/game_providers.dart';
import 'package:web_game_zombie/assets/image.dart';
import '../model/game_list.dart';
import 'hint_animation_page.dart';
import 'marqueeBanner.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final bool isDesktop = screenSize.width > 800;
    final double titleFontSize = isDesktop ? 48 : 28;
    final double subtitleFontSize = isDesktop ? 18 : 14;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.track_changes_sharp, color: Color(0xFFF3BA2F), size: 28),
            SizedBox(width: 8),
            Text(
              'REMIX',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                letterSpacing: 1.5,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          _buildAppBar(
            title: 'Log In',
            backgroundColor: Colors.black,
            textColor: Colors.white,
          ),
          SizedBox(width: 8),
          _buildAppBar(
            title: 'Get Started',
            backgroundColor: Color(0xFFF3BA2F),
            textColor: Colors.black,
          ),
          SizedBox(width: isDesktop ? 24 : 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1100),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: isDesktop ? 100 : 60,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "What game would you like to create?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 24),

                  AnimatedHintTextField(
                    fontSize: subtitleFontSize,
                    onUploadPressed: (String gameName) {
                      if (gameName.isNotEmpty) {
                        ref.read(gameListProvider.notifier).addGame(gameName);
                      }
                    },
                  ),
                  SizedBox(height: 16),

                  _buildRichText(),
                  SizedBox(height: 16),

                  SvgPicture.asset(
                    ImageAssets.logo_appstore,
                    width: isDesktop ? 60 : 28,
                    height: isDesktop ? 60 : 28,
                  ),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Text(
                        "Featured Games",
                        style: TextStyle(
                          fontSize: isDesktop ? 24 : 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  GameListView(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const MarqueeBanner(),
    );
  }

  Widget _buildAppBar({
    String? title,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return InkWell(
      onTap: () {
        print('$title clicked');
      },
      borderRadius: BorderRadius.circular(8),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: backgroundColor == Colors.black
                    ? Colors.grey[700]!
                    : Colors.transparent,
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                title ?? '',
                style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildRichText() {
    return RichText(
      text: TextSpan(
        text: 'Tiktok ',
        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w800),
        children: [
          TextSpan(
            text: 'for Games. Endless Feed. Instantly Playable',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
