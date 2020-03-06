import '../file.dart';
import '../file_selector_interface.dart';

class FileSelectorWeb extends FileSelectorInterface {
  @override
  Future<File> pickFile({
    FileType type = FileType.any,
    String confirmButtonText,
  }) =>
      throw UnimplementedError();

  @override
  Future<List<File>> pickMultipleFiles({
    List<FileType> types = const [FileType.any],
    String confirmButtonText,
  }) =>
      throw UnimplementedError();
}
