enum JobPlatform {
  linkedIn,
  indeed,
  glassdoor,
  jobstreet,
  weworkremotely,
  upwork,
  other
  ;

  String get displayName {
    switch (this) {
      case JobPlatform.linkedIn:
        return 'LinkedIn';
      case JobPlatform.indeed:
        return 'Indeed';
      case JobPlatform.glassdoor:
        return 'Glassdoor';
      case JobPlatform.jobstreet:
        return 'JobStreet';
      case JobPlatform.weworkremotely:
        return 'We Work Remotely';
      case JobPlatform.upwork:
        return 'Upwork';
      case JobPlatform.other:
        return 'Other';
    }
  }

  static JobPlatform fromUrl(String url) {
    if (url.isEmpty) return JobPlatform.other;

    final uri = Uri.tryParse(url);

    if (uri == null) return JobPlatform.other;

    final host = uri.host.toLowerCase();
    if (host.contains('linkedin')) return JobPlatform.linkedIn;
    if (host.contains('indeed')) return JobPlatform.indeed;
    if (host.contains('glassdoor')) return JobPlatform.glassdoor;
    if (host.contains('jobstreet')) return JobPlatform.jobstreet;
    if (host.contains('weworkremotely')) return JobPlatform.weworkremotely;
    if (host.contains('upwork')) return JobPlatform.upwork;

    return JobPlatform.other;
  }
}

enum WorkSetup {
  remote,
  onsite,
  hybrid,
}

enum EmploymentType {
  fullTime,
  partTime,
  contract,
  internship,
  freelance,
}

enum JobStatus {
  applied,
  interviewing,
  offer,
  rejected,
  ghosted, // For when they never reply :(
}
