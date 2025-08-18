import 'package:hive/hive.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoAdapter extends TypeAdapter<PackageInfo> {
  @override
  final int typeId = 3; // Use a different typeId than your LocaleAdapter

  @override
  PackageInfo read(BinaryReader reader) {
    return PackageInfo(
      appName: reader.readString(),
      packageName: reader.readString(),
      version: reader.readString(),
      buildNumber: reader.readString(),
      buildSignature: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, PackageInfo obj) {
    writer.writeString(obj.appName);
    writer.writeString(obj.packageName);
    writer.writeString(obj.version);
    writer.writeString(obj.buildNumber);
    writer.writeString(obj.buildSignature);
  }
}