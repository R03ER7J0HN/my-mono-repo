enum AppRoutes {
  splash('/'),
  home('/home'),
  signIn('/sign-in'),
  signUp('/sign-up'),
  forgotPassword('forgot-password'),
  profile('/profile');

  const AppRoutes(this.path);

  final String path;
}
