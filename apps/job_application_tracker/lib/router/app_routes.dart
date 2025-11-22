enum AppRoutes {
  splash('/'),
  home('/home'),
  signIn('/sign-in'),
  signUp('/sign-up');

  const AppRoutes(this.path);

  final String path;
}
