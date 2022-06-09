import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../utility/shared/utils/common_widget.dart';


class DBProvider {
  static var tblExample = 'fromTbl';
  static var keyTblExample = 'keyFromTbl';
  static var tblExample2 = "tblExample2";
  static var tblExample3 = "tblExample3";

  HiveInterface dbLocal = Hive;

  var encryptionKey;

  init() async {
    return await dbLocal
      ..initFlutter();
      // ..registerAdapter(RoomChatAdapter());
  }

  Future<Uint8List?> getEncryptionKey() async {
    const secureStorage = FlutterSecureStorage();
    // if key not exists return null
    final encryprionKey = await secureStorage.read(key: 'key');
    if (encryprionKey == null) {
      final key = Hive.generateSecureKey();
      await secureStorage.write(
        key: 'key',
        value: base64UrlEncode(key),
      );
    }
    final key = await secureStorage.read(key: 'key');
    final encryptionKey = base64Url.decode(key!);
    print('Encryption key: $encryptionKey');
    return encryptionKey;
  }

  pickBox({required String name}) async {
    encryptionKey = encryptionKey ?? await getEncryptionKey();
    if (!dbLocal.isBoxOpen(name) && encryptionKey != null) {
      await dbLocal.openBox(name,
          encryptionCipher: HiveAesCipher(encryptionKey));
    }

    final encryptedBox = await dbLocal.openBox('vaultBox', encryptionCipher: HiveAesCipher(encryptionKey));
    encryptedBox.put('secret', 'Hive is cool');
    await encryptedBox.close();
    final unEncryptedBox = await dbLocal.openBox('vaultBox', encryptionCipher: HiveAesCipher(encryptionKey));
    print(unEncryptedBox.get('secret'));

    return dbLocal.box(name);
  }

  Future<dynamic> read({required String from, required String key}) async {
    if (!dbLocal.isBoxOpen(from)) {
      await dbLocal.openBox(from);
    }
    return await dbLocal.box(from).get(key);
  }

  Future<dynamic> readAt({required String from, required int index}) async {
    if (!dbLocal.isBoxOpen(from)) {
      await dbLocal.openBox(from);
    }
    return await dbLocal.box(from).getAt(index);
  }

  Future<dynamic> readWithDefault(
      {required String from,
      required String key,
      required dynamic defaultValue}) async {
    if (!dbLocal.isBoxOpen(from)) {
      await dbLocal.openBox(from);
    }
    return await dbLocal.box(from).get(key, defaultValue: defaultValue);
  }

  Future<int> insert({required String to, required dynamic data}) async {
    if (!dbLocal.isBoxOpen(to)) {
      await dbLocal.openBox(to);
    }
    return await dbLocal.box(to).add(data);
  }

  Future<Iterable<int>> insertAll(
      {required String to, required List<dynamic> datas}) async {
    if (!dbLocal.isBoxOpen(to)) {
      await dbLocal.openBox(to);
    }
    return await dbLocal.box(to).addAll(datas);
  }

  Future<void> update(
      {required String to, required String key, required dynamic data}) async {
    if (!dbLocal.isBoxOpen(to)) {
      await dbLocal.openBox(to);
    }
    return await dbLocal.box(to).put(key, data);
  }

  Future<void> updateAll(
      {required String to, required Map<dynamic, dynamic> data}) async {
    if (!dbLocal.isBoxOpen(to)) {
      await dbLocal.openBox(to);
    }
    return await dbLocal.box(to).putAll(data);
  }

  Future<void> delete({required String from, required String key}) async {
    if (!dbLocal.isBoxOpen(from)) {
      await dbLocal.openBox(from);
    }

    if (!dbLocal.box(from).containsKey(key)) {
      CommonWidget.toast('sorry key not exist');
      return;
    } else {
      return await dbLocal.box(from).delete(key);
    }
  }

  Future<void> deleteAt({required String from, required int index}) async {
    if (!dbLocal.isBoxOpen(from)) {
      await dbLocal.openBox(from);
    }

    if (!dbLocal.box(from).containsKey(index)) {
      CommonWidget.toast('sorry index not exist');
      return;
    } else {
      return await dbLocal.box(from).deleteAt(index);
    }
  }

  Future<void> deleteAll(
      {required String from, required List<dynamic> keys}) async {
    if (!dbLocal.isBoxOpen(from)) {
      await dbLocal.openBox(from);
    }
    return await dbLocal.box(from).deleteAll(keys);
  }
}
