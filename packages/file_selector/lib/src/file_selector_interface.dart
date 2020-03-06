import 'dart:io';

import 'package:flutter/foundation.dart';

import 'file.dart';
import 'web/file_selector_web.dart';
import 'mobile/file_selector_mobile.dart';
import 'windows/file_selector_windows.dart';

class FileSelector implements FileSelectorInterface {
  const FileSelector._();

  factory FileSelector() => _instance;

  static FileSelector _instance = FileSelector._();
  static FileSelectorInterface _interface;

  FileSelectorInterface _fileSelectorFactory() {
    if (_interface != null) {
      return _interface;
    }

    if (Platform.isAndroid || Platform.isIOS) {
      return FileSelectorMobile();
    } else if (Platform.isWindows) {
      return FileSelectorWindows();
    } else if (kIsWeb) {
      return FileSelectorWeb();
    }

    return null;
  }

  @override
  Future<File> pickFile({
    FileType type = FileType.any,
    String confirmButtonText,
  }) =>
      _fileSelectorFactory()?.pickFile(
        type: type,
        confirmButtonText: confirmButtonText,
      );

  @override
  Future<List<File>> pickMultipleFiles({
    List<FileType> types = const [FileType.any],
    String confirmButtonText,
  }) =>
      _fileSelectorFactory()?.pickMultipleFiles(
        types: types,
        confirmButtonText: confirmButtonText,
      );
}

abstract class FileSelectorInterface {
  Future<File> pickFile({
    FileType type = FileType.any,
    String confirmButtonText,
  });

  Future<List<File>> pickMultipleFiles({
    List<FileType> types = const [FileType.any],
    String confirmButtonText,
  });
}
