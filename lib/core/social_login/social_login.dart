
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';


class SocialLogin {
  String? name = "";
  String? lastName = "";
  String? firstName = "";
  String? social_id = "";
  String? imageUrl = "";
  String? fbEmail = "";
  AuthorizationCredentialAppleID? appleIdCredential;
  FacebookUserProfile? profile;

  Future<User?> signInWithGoogle() async {
    User? firebaseUser;
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    await _googleSignIn.signOut();
    final GoogleSignInAccount? googleSignInAccount =
    await _googleSignIn.signIn();
    if (googleSignInAccount == null) {
      return null;
    }
    social_id = googleSignInAccount.id;
    name = googleSignInAccount.displayName.toString();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    AuthCredential googleIdCredential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final userCredential =
    await FirebaseAuth.instance.signInWithCredential(googleIdCredential);
    firebaseUser = userCredential.user!;
    return firebaseUser;
  }




  Future<User?> signInWithAple() async {
    User? firebaseUser;
    var redirectURL =
        "https://SERVER_AS_PER_THE_DOCS.glitch.me/callbacks/sign_in_with_apple";
    var clientID = "AS_PER_THE_DOCS";
    appleIdCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
            clientId: clientID, redirectUri: Uri.parse(redirectURL)));

    final oAuthProvider = OAuthProvider('apple.com');
    if (appleIdCredential == null) {
      return null;
    }
    final mcredential = oAuthProvider.credential(
      idToken: appleIdCredential?.identityToken,
      accessToken: appleIdCredential?.authorizationCode,
    );

    final userCredential =
    await FirebaseAuth.instance.signInWithCredential(mcredential);
    firebaseUser = userCredential.user!;

    return firebaseUser;
  }


  Future<User?> signInWithFb() async {
    User? firebaseUser;
    final fb = FacebookLogin();
    fb.logOut();

// Log in
    //  await fb.logOut();
    final FacebookLoginResult res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

// Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:
      // Logged in

      // Send access token to server for validation and auth
        final FacebookAccessToken? accessToken = res.accessToken;
        print('Access token: ${accessToken?.token}');

        // Get profile data
        profile = await fb.getUserProfile();
        print('Hello, ${profile?.name}! You ID: ${profile?.userId}');

        // Get user profile image url
        imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');

        // Get email (since we request email permission)
        fbEmail = await fb.getUserEmail();
        // But user can decline permission
        if (fbEmail != null) print('And your email is $fbEmail');
        final AuthCredential facebookCredential =
        FacebookAuthProvider.credential(res.accessToken!.token);

        final userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookCredential);
        firebaseUser = userCredential.user!;
        break;
      case FacebookLoginStatus.cancel:
      // User cancel log in
        break;
      case FacebookLoginStatus.error:
      // Log in failed
        print('Error while log in: ${res.error}');
        break;
    }
    return firebaseUser;
  }
}