import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:utils/sign_in.dart';

class AccountLink extends StatefulWidget {
  final void Function(User user)? onSignedIn;
  final bool showAppleIfAvailable;

  const AccountLink({super.key, this.onSignedIn, this.showAppleIfAvailable = true});

  @override
  State<AccountLink> createState() => _AccountLinkState();
}

class _AccountLinkState extends State<AccountLink> {
  bool _working = false;

  bool get _isAnonymous => FirebaseAuth.instance.currentUser?.isAnonymous ?? true;

  Future<void> _handleSignInWithGoogle() async {
    setState(() => _working = true);
    try {
      final user = await signInWithGoogle();
      if (user != null) {
        widget.onSignedIn?.call(user);
      }
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  Future<void> _handleSignInWithApple() async {
    setState(() => _working = true);
    try {
      final user = await signInWithApple();
      if (user != null) {
        widget.onSignedIn?.call(user);
      }
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAnonymous) {
      // Already linked/signed in with a provider; nothing to show.
      return const SizedBox.shrink();
    }

    final isIOS = defaultTargetPlatform == TargetPlatform.iOS;

    if (_working) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FilledButton(
          onPressed: _handleSignInWithGoogle,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.login),
              SizedBox(width: 8),
              Text('Sign in with Google'),
            ],
          ),
        ),
        if (widget.showAppleIfAvailable && isIOS) ...[
          const SizedBox(height: 12),
          FilledButton(
            onPressed: _handleSignInWithApple,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.apple),
                SizedBox(width: 8),
                Text('Sign in with Apple'),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
