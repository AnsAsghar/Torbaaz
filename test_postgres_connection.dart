import 'dart:io';

void main() async {
  // Connection string from MCP config
  final connectionString =
      'postgresql://postgres.xfvbgpybpjumgdvfuidk:AnsAsghar777@aws-0-ap-south-1.pooler.supabase.com:5432/postgres';

  // Use dart:io to run a command to test the connection
  try {
    final result = await Process.run('dart', [
      'run',
      'postgres',
      'query',
      '--connection-string=$connectionString',
      'SELECT table_name FROM information_schema.tables WHERE table_schema = \'public\''
    ]);

    print('Exit code: ${result.exitCode}');
    print('Output: ${result.stdout}');
    print('Error: ${result.stderr}');
  } catch (e) {
    print('Error: $e');
  }
}
