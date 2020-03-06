import 'package:flinq/flinq.dart';
import 'package:file_picker/file_picker.dart' hide FileType;
import 'package:file_picker/file_picker.dart' as fp show FileType;

import '../file.dart';
import '../file_selector_interface.dart';

class FileSelectorMobile extends FileSelectorInterface {
  fp.FileType _toFilePickerFileType(FileType type) {
    switch (type) {
      case FileType.img:
        return fp.FileType.IMAGE;
      case FileType.pdf:
        return fp.FileType.CUSTOM;

      case FileType.any:
      default:
        return fp.FileType.ANY;
    }
  }

  @override
  Future<File> pickFile({
    FileType type = FileType.any,
    String confirmButtonText,
  }) async {
    final path = await FilePicker.getFilePath(
      type: _toFilePickerFileType(type),
      fileExtension: type.fileExtensions,
    );

    if (path == null) return null;

    return File(
      name: path.split('/').last,
      path: path,
    );
  }

  @override
  Future<List<File>> pickMultipleFiles({
    List<FileType> types = const [FileType.any],
    String confirmButtonText,
  }) async {
    final type = types[0]; // TODO

    final paths = await FilePicker.getMultiFilePath(
      type: _toFilePickerFileType(type),
      fileExtension: type.fileExtensions,
    );

    if (paths == null) return null;

    return paths.entries.mapList(
      (entry) => File(
        name: entry.key,
        path: entry.value,
      ),
    );
  }
}
