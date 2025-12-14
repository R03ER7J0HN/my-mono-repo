enum AppRoutes {
  splash('/'),
  home('/home'),
  signIn('/sign-in'),
  signUp('/sign-up'),
  forgotPassword('forgot-password'),
  profile('/profile'),
  jobs('/jobs'),
  jobEntry('/job-entry');

  const AppRoutes(this.path);

  final String path;
}
