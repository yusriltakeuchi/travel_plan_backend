import 'package:mysql_client/mysql_client.dart';

/// Database client
class DBClient {

  /// Constructor
  factory DBClient() {
    return _inst;
  }
  DBClient._internal() {
    _connect();
  }
  static final DBClient _inst = DBClient._internal();

  /// Connection to database
  MySQLConnection? _connection;

  /// Initialize connection
  Future<void> _connect() async {
    _connection = await MySQLConnection.createConnection(
      host: '127.0.0.1',
      port: 3306,
      userName: 'root',
      password: '123456',
      secure: false,
      databaseName: 'travel',
    );
    await _connection?.connect();
  }

  /// Check connection before execute query
  Future<IResultSet> execute(
    String query, {
    Map<String, dynamic>? params,
    bool iterable = false,
  }) async {
    if (_connection == null || _connection?.connected == false) {
      await _connect();
    }
    if (_connection?.connected == false) {
      throw Exception('Could not connect to the database');
    }
    return _connection!.execute(query, params, iterable);
  }
}
