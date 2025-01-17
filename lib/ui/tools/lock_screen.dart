

import 'package:ente_auth/ui/common/gradient_button.dart';
import 'package:ente_auth/ui/tools/app_lock.dart';
import 'package:ente_auth/utils/auth_util.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({Key? key}) : super(key: key);

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final _logger = Logger("LockScreen");

  @override
  void initState() {
    _showLockScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: 0.3,
                  child: Image.asset('assets/loading_photos_background.png'),
                ),
                SizedBox(
                  width: 142,
                  child: GradientButton(
                    text: "Unlock",
                    iconData: Icons.lock_open_outlined,
                    onTap: () async {
                      _showLockScreen();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showLockScreen() async {
    _logger.info("Showing lockscreen");
    try {
      final result = await requestAuthentication(
        "Please authenticate to view your secrets",
      );
      if (result) {
        AppLock.of(context)!.didUnlock();
      }
    } catch (e, s) {
      _logger.severe(e, s);
    }
  }
}
