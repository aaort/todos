final Set authExceptions = <String>{
  'wrong-password',
  'weak-password',
  'email-already-in-use',
  'user-not-found',
};

final Map errorMessages = <String, String>{
  authExceptions.elementAt(0): 'Provided password is incorrect',
  authExceptions.elementAt(1): 'Provided password is too weak',
  authExceptions.elementAt(2): 'Provided email is already in use',
  authExceptions.elementAt(3):
      "There is no user found with provided credentials",
};
