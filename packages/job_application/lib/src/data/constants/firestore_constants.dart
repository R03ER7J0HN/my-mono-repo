class FirestoreCollections {
  const FirestoreCollections._();

  static const String jobApplications = 'job_applications';
  static const String users = 'users';
  static const String interviews = 'interviews';
}

class JobFields {
  const JobFields._();

  static const String dateApplied = 'dateApplied';
  static const String status = 'status';
  static const String companyName = 'companyName';
}

class InterviewFields {
  const InterviewFields._();

  static const String startTime = 'startTime';
  static const String userId = 'userId';
  static const String jobApplicationId = 'jobApplicationId';
}
