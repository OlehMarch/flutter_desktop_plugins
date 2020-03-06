import 'package:flinq/flinq.dart';
import 'package:file_chooser/file_chooser.dart';

import '../file.dart';
import '../file_selector_interface.dart';

class FileSelectorWindows extends FileSelectorInterface {
  FileTypeFilterGroup _toFileChooserFileType(FileType type) {
    // TODO
    return FileTypeFilterGroup(
      label: type.type,
      fileExtensions: type.fileExtensions != null ? [type.fileExtensions] : [],
    );
  }

  @override
  Future<File> pickFile({
    FileType type = FileType.any,
    String confirmButtonText,
  }) async {
    assert(() {
      if (type == null) {
        throw ArgumentError.notNull('types');
      }

      return true;
    }());
    final result = await showOpenPanel(
      canSelectDirectories: false,
      allowsMultipleSelection: false,
      confirmButtonText: confirmButtonText,
      allowedFileTypes: [_toFileChooserFileType(type)],
    );

    if (result?.canceled != false || result?.paths?.isNotEmpty != true) {
      return null;
    }

    return File(
      name: result.paths[0].split(r'\').last,
      path: result.paths[0],
    );
  }

  @override
  Future<List<File>> pickMultipleFiles({
    List<FileType> types = const [FileType.any],
    String confirmButtonText,
  }) async {
    assert(() {
      if (types == null) {
        throw ArgumentError.notNull('types');
      }

      return true;
    }());

    final result = await showOpenPanel(
      canSelectDirectories: false,
      allowsMultipleSelection: false,
      confirmButtonText: confirmButtonText,
      allowedFileTypes: types.mapList((type) => _toFileChooserFileType(type)),
    );

    if (result?.canceled != false || result?.paths?.isNotEmpty != true) {
      return null;
    }

    return result.paths.mapList(
      (path) => File(
        name: path.split('/').last,
        path: path,
      ),
    );
  }
}
