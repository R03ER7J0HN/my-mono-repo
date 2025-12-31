enum AppRoutes {
  splash('/'),
  home('/home'),
  signIn('/sign-in'),
  signUp('/sign-up'),
  forgotPassword('forgot-password'),
  profile('/profile'),
  jobs('/jobs'),
  jobEntry('/job-entry'),
  interviews('/interviews'),
  interviewEntry('/interview-entry');

  const AppRoutes(this.path);

  final String path;
}
