import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:utils/sign_in.dart' as utils;
import 'package:os_detect/os_detect.dart' as platform;

class AccountLinkingSettings extends StatefulWidget {
  const AccountLinkingSettings({super.key});

  @override
  State<AccountLinkingSettings> createState() => _AccountLinkingSettingsState();
}

class _AccountLinkingSettingsState extends State<AccountLinkingSettings> {
  bool _linkingGoogle = false;
  bool _linkingApple = false;

  User? get _user => FirebaseAuth.instance.currentUser;

  bool get _hasGoogleProvider => _user?.providerData.any((p) => p.providerId == 'google.com') ?? false;
  bool get _hasAppleProvider => _user?.providerData.any((p) => p.providerId == 'apple.com') ?? false;

  Future<void> _linkGoogle() async {
    setState(() => _linkingGoogle = true);
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();
      final GoogleSignInAuthentication gsa = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: gsa.idToken,
        accessToken: gsa.idToken,
      );

      await FirebaseAuth.instance.currentUser!.linkWithCredential(credential);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google account linked')),
      );
      setState(() {});
    } on FirebaseAuthException catch (e) {
      String msg = 'Failed to link Google: ${e.code}';
      if (e.code == 'provider-already-linked') {
        msg = 'Google is already linked to this account';
      } else if (e.code == 'credential-already-in-use') {
        msg = 'This Google account is already linked to another user';
      } else if (e.code == 'requires-recent-login') {
        msg = 'Please sign out and sign in again before linking Google';
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Google linking was canceled')),
        );
      }
    } finally {
      if (mounted) setState(() => _linkingGoogle = false);
    }
  }

  Future<void> _linkApple() async {
    setState(() => _linkingApple = true);
    try {
      final rawNonce = utils.generateNonce();
      final nonce = utils.sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      await FirebaseAuth.instance.currentUser!.linkWithCredential(oauthCredential);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Apple account linked')),
      );
      setState(() {});
    } on FirebaseAuthException catch (e) {
      String msg = 'Failed to link Apple: ${e.code}';
      if (e.code == 'provider-already-linked') {
        msg = 'Apple is already linked to this account';
      } else if (e.code == 'credential-already-in-use') {
        msg = 'This Apple account is already linked to another user';
      } else if (e.code == 'requires-recent-login') {
        msg = 'Please sign out and sign in again before linking Apple';
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Apple linking was canceled')),
        );
      }
    } finally {
      if (mounted) setState(() => _linkingApple = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAnon = _user?.isAnonymous ?? true;
    final canLinkGoogle = !_hasGoogleProvider;
    final canLinkApple = !_hasAppleProvider && platform.isIOS;

    if (_user == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isAnon)
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                'You are signed in anonymously. Link your account to back up your data.',
                textAlign: TextAlign.center,
              ),
            ),
          if (canLinkGoogle)
            ElevatedButton(
              onPressed: _linkingGoogle ? null : _linkGoogle,
              child: _linkingGoogle
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.link),
                        SizedBox(width: 8),
                        Text('Link Google account'),
                      ],
                    ),
            ),
          if (canLinkGoogle) const SizedBox(height: 12),
          if (canLinkApple)
            ElevatedButton(
              onPressed: _linkingApple ? null : _linkApple,
              child: _linkingApple
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.apple),
                        SizedBox(width: 8),
                        Text('Link Apple account'),
                      ],
                    ),
            ),
          if (!canLinkGoogle && (!platform.isIOS || !canLinkApple))
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                'Your account is linked.',
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
