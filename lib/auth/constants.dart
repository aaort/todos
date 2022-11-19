final authExceptions = <String>[
  'wrong-password',
  'weak-password',
  'email-already-in-use',
  'user-not-found',
];

final Map errorMessages = <String, String>{
  authExceptions[0]: 'Provided password is incorrect',
  authExceptions[1]: 'Provided password is too weak',
  authExceptions[2]: 'Provided email is already in use',
  authExceptions[3]: "There is no user found with provided credentials",
};
