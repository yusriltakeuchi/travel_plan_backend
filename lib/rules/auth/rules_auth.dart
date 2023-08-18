/// Rules for auth
class RulesAuth {

  /// Validation for register
  static Map<String, String> get register => {
    'email': 'email|required',
    'password': 'required|string',
    'name': 'required|min:6',
  };
  
  /// Validation for login
  static Map<String, String> get login => {
    'email': 'email|required',
    'password': 'required',
  };
}
