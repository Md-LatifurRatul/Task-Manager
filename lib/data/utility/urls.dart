class Urls {
  static const String _baseUrl = 'http://152.42.163.176:2006/api/v1';
  static String registrationUrl = '$_baseUrl/Registration';
  static String loginUrl = '$_baseUrl/Login';
  static String createTask = '$_baseUrl/createTask';
  static String taskStatusCount = '$_baseUrl/taskStatusCount';
  static String newlistTaskByStatus = '$_baseUrl/listTaskByStatus/New';
  static String completedTaskList = '$_baseUrl/listTaskByStatus/Completed';
  static String deleteTaskById(String id) => '$_baseUrl/deleteTask/$id';
  static String updateTaskStatus(String id, String status) =>
      '$_baseUrl//updateTaskStatus/$id/$status';
  static String progressTaskList = '$_baseUrl/listTaskByStatus/Progress';
  static String cancellTaskList = '$_baseUrl/listTaskByStatus/Cancelled';
  static String updateProfileUrl = '$_baseUrl/ProfileUpdate';

  static String verifyEmail(String email) =>
      '$_baseUrl/RecoverVerifyEmail/$email';
  static String verifyOtp(String email, otp) =>
      '$_baseUrl/RecoverVerifyOtp/$email/$otp';

  static String recoverResetPassword = '$_baseUrl/RecoverResetPassword';
}
