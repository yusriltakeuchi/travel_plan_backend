/// Rules for travel
class RulesTravel {

  /// Validation for create travel
  static Map<String, String> get create => {
    'title': 'required|string',
    'description': 'required|string',
    'latitude': 'required',
    'longitude': 'required',
    'plan_date': 'required|string',
    'budget': 'required|int',
  };
}
