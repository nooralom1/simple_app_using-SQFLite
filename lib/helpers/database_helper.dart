import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  // Initialize the database
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  // Initialize the database
  _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_data.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        // Create jobs table
        db.execute(
          'CREATE TABLE jobs(id INTEGER PRIMARY KEY, title TEXT, companyName TEXT, salary TEXT, location TEXT, isApplied INTEGER)',
        );

        // Create users table with name, email, and password
        db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, email TEXT, password TEXT)',
        );
      },
      version: 1,
    );
  }

  // Insert or update job data (with applied status)
  Future<void> saveJob(Map<String, dynamic> jobData) async {
    final db = await database;
    await db.insert(
      'jobs',
      jobData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all saved jobs
  Future<List<Map<String, dynamic>>> getSavedJobs() async {
    final db = await database;
    return await db.query('jobs');
  }

  // Check if a job is already saved
  Future<bool> isJobSaved(int id) async {
    final db = await database;
    var result = await db.query('jobs', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty;
  }

  // Mark job as applied
  Future<void> markJobAsApplied(int id) async {
    final db = await database;
    await db.update('jobs', {'isApplied': 1}, where: 'id = ?', whereArgs: [id]);
  }

  // Check if a job is applied
  Future<bool> isJobApplied(int id) async {
    final db = await database;
    var result = await db.query('jobs', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return result.first['isApplied'] == 1;
    }
    return false;
  }

  // Save user data (name, email, and password)
  Future<void> saveUser(String name, String email, String password) async {
    final db = await database;
    await db.insert('users', {
      'name': name,
      'email': email,
      'password': password,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Get the user's name and email based on the logged-in user
  Future<Map<String, dynamic>?> getUserDataByEmail(String email) async {
    final db = await database;
    var result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null; // Return null if no data is found
  }

  // Check if a user exists by email and password (for login)
  Future<bool> isUserExists(String email, String password) async {
    final db = await database;
    var result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return result.isNotEmpty;
  }
}
