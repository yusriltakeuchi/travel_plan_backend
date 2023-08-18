// ignore_for_file: inference_failure_on_function_return_type, lines_longer_than_80_chars, prefer_constructors_over_static_methods, use_setters_to_change_properties

import 'package:intl/intl.dart';

/// Validation class
class Validations {

  /// Constructor
  Validations(this._requestData, this._rules);
  final Map<String, dynamic> _requestData;
  final Map<String, List<Function(dynamic)>> _rules;

  static final Map<String, String> _localizedMessages = {
    'required': 'Field :field is required.',
    'string': ':field must be a string.',
    'int': ':field must be an integer.',
    'email': 'Invalid email format for :field.',
    'min': ':field must be at least :value.',
    'double': ':field must be a double.',
    'boolean': ':field must be a boolean.',
    'list': ':field must be a list.',
    'max': ':field must be less than or equal to :value.',
    'date': 'Invalid date format for :field. Expected format: yyyy-MM-dd.',
    // ... add more localized messages as needed ...
  };
  
  /// get Messages from localized
  static String _getMessage(String ruleName, String fieldName, String? value) {
    var message = _localizedMessages[ruleName] ?? 'Invalid rule: $ruleName for field: :field';
    message = message.replaceAll(':field', fieldName);
    if (value != null) {
      message = message.replaceAll(':value', value);
    }
    return message;
  }

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
        errors.add(_getMessage('required', field, null));
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
    'required': (field, value, _) => value != null ? null : _getMessage('required', field, null),
    'string': (field, value, _) => value is String ? null : _getMessage('string', field, null),
    'int': (field, value, _) => value is int ? null : _getMessage('int', field, null),
    'number': (field, value, _) => value is num ? null : _getMessage('number', field, null),
    'email': (field, value, _) {
      final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',);
      return emailRegex.hasMatch(value.toString()) ? null : _getMessage('email', field, null);
    },
    'min': (field, value, min) {
      if (value is String && value.length >= int.parse(min!)) {
        return null;
      }
      if (value is int && value >= int.parse(min!)) {
        return null;
      }
      return _getMessage('min', field, min);
    },
    'double': (field, value, _) => value is double ? null : _getMessage('double', field, null),
    'boolean': (field, value, _) => value is bool ? null : _getMessage('boolean', field, null),
    'list': (field, value, _) => value is List ? null : _getMessage('list', field, null),
    'max': (field, value, max) {
      if (value is num && value <= double.parse(max!)) {
        return null;
      }
      if (value is String && value.length <= int.parse(max!)) {
        return null;
      }
      if (value is List && value.length <= int.parse(max!)) {
        return null;
      }
      return _getMessage('max', field, max);
    },
    'date': (field, value, _) {
      final dateFormat = DateFormat('yyyy-MM-dd');
      try {
        final dynamic parseValue = dateFormat.format(DateTime.parse(value.toString()));
        if (value is String && parseValue != null) {
          return null;
        }
        return _getMessage('date', field, null);
      } catch(e) {
        return _getMessage('date', field, null);
      }
    },
  };
}
