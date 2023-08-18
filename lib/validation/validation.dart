// ignore_for_file: inference_failure_on_function_return_type, lines_longer_than_80_chars, prefer_constructors_over_static_methods

/// Validation class
class Validations {

  /// Constructor
  Validations(this._requestData, this._rules);
  final Map<String, dynamic> _requestData;
  final Map<String, List<Function(dynamic)>> _rules;

  /// Validate request data
  List<String> validate() {
    final errors = <String>[];

    _rules.forEach((field, rules) {
      if (_requestData.containsKey(field)) {
        final fieldValue = _requestData[field];
        for (final rule in rules) {
          final error = rule(fieldValue);
          if (error != null) {
            errors.add(error.toString());
          }
        }
      } else {
        errors.add("Field '$field' is required.");
      }
    });

    return errors;
  }

  /// Create validator
  static Validations setRules(Map<String, dynamic> requestData, Map<String, String> validationRules,) {
     final rules = <String, List<Function(dynamic)>>{};

    validationRules.forEach((field, ruleString) {
      final ruleList = ruleString.split('|');
      final fieldValidators = <Function(dynamic)>[];

      for (final rule in ruleList) {
        final parts = rule.split(':');
        final ruleName = parts[0];
        final validator = _validators[ruleName];
        if (validator != null) {
          if (parts.length > 1) {
            final ruleValue = parts[1];
            fieldValidators.add((value) => validator(field, value, ruleValue));
          } else {
            fieldValidators.add((value) =>validator(field, value, null));
          }
        } else {
          fieldValidators.add((_) => 'Invalid rule: $ruleName for field: $field');
        }
      }
      rules[field] = fieldValidators;
    });

    return Validations(requestData, rules);
  }

  static final Map<String, Function(String, dynamic, String?)> _validators = {
    'required': (field, value, _) => value != null ? null : '$field is required.',
    'string': (field, value, _) =>
        value is String ? null : '$field must be a string.',
    'int': (field, value, _) =>
        value is int ? null : '$field must be an integer.',
    'number': (field, value, _) =>
        value is num ? null : '$field must be a number.',
    'email': (field, value, _) {
      final emailRegex = RegExp(
          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',);
      return emailRegex.hasMatch(value.toString()) ? null : 'Invalid email format for $field.';
    },
    'min': (field, value, min) {
      if (value is String && value.length >= int.parse(min!)) {
        return null;
      }
      if (value is int && value >= int.parse(min!)) {
        return null;
      }
      return '$field must be at least $min.';
    },
  };
}
