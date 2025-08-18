import 'package:hive/hive.dart';
import '../../../features/auth/data/models/log_in_model.dart';

class LogInModelAdapter extends TypeAdapter<LogInModel> {
  @override
  final int typeId = 2; // Choose a unique ID for your model

  @override
  LogInModel read(BinaryReader reader) {
    return LogInModel(
      id: reader.read(),
      username: reader.read(),
      email: reader.read(),
      firstName: reader.read(),
      lastName: reader.read(),
      gender: reader.read(),
      image: reader.read(),
      accessToken: reader.read(),
      refreshToken: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, LogInModel obj) {
    writer.write(obj.id);
    writer.write(obj.username);
    writer.write(obj.email);
    writer.write(obj.firstName);
    writer.write(obj.lastName);
    writer.write(obj.gender);
    writer.write(obj.image);
    writer.write(obj.accessToken);
    writer.write(obj.refreshToken);
  }
}