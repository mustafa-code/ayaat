import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:aes_crypt/aes_crypt.dart';
import 'package:crypto/crypto.dart';

class EncryptData {
  static Future<String> generateFileHash(File file) async{
    var imageBytes =  file.readAsBytesSync().toString();
    var bytes = utf8.encode(imageBytes); // data being hashed
    String digest = sha256.convert(bytes).toString();
    print("This is image Digest :  $digest");
    return  digest;
  }

  static String encryptFile(String path, String password) {
    AesCrypt crypt = AesCrypt(password);
    crypt.aesSetMode(AesMode.cbc);
    crypt.setOverwriteMode(AesCryptOwMode.on);
    String encFilepath = "";
    try {
      encFilepath = crypt.encryptFileSync(path);
      log('The encryption has been completed successfully.');
      log('Encrypted file: $encFilepath');
    } on AesCryptException catch (e) {
      if (e.type == AesCryptExceptionType.destFileExists) {
        log('The encryption has been completed unsuccessfully.');
        log(e.message);
      } else{
        return 'ERROR';
      }
    }
    return encFilepath;
  }

  static String? decryptFile(String path, String password) {
    AesCrypt crypt = AesCrypt(password);
    crypt.aesSetMode(AesMode.cbc);
    crypt.setOverwriteMode(AesCryptOwMode.on);
    String decFilepath = "";
    try {
      decFilepath = crypt.decryptFileSync(path);
      log('The decryption has been completed successfully.');
      log('Decrypted file 1: $decFilepath');
      log('File content: ' + File(decFilepath).path);
      return decFilepath;
    } on AesCryptException catch (e) {
      if (e.type == AesCryptExceptionType.destFileExists) {
        log('The decryption has been completed unsuccessfully.');
        log(e.message);
      }
    }
    return null;
  }
}