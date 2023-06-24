import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sentinel_guard_app/src/api/user_api_service.dart';
import 'package:sentinel_guard_app/src/models/message.dart';

class CryptoService {
  static Future<SimpleKeyPairData> getKeyPair() async {
    const storage = FlutterSecureStorage();
    final privateKey =
        await storage.read(key: 'sentinel-guard-private-key') ?? '';
    final publicKey =
        await storage.read(key: 'sentinel-guard-public-key') ?? '';
    if (privateKey == '') {
      throw Exception('Private key not found');
    }
    // if (publicKey == '') {
    //   throw Exception('Private key not found');
    // }

    final privateKeyBytes = base64Decode(privateKey);
    final publicKeyBytes = base64Decode(publicKey);
    final simplePublicKey =
        SimplePublicKey(publicKeyBytes, type: KeyPairType.x25519);
    
    // print(simplePublicKey);
    return SimpleKeyPairData(privateKeyBytes,
        publicKey: simplePublicKey, type: KeyPairType.x25519);
  }

  // Generates and saves a private key into Flutter Secure Storage
  static Future saveKeyPair() async {
    try {
      // If the key pair exists, do not generate a new one
      await getKeyPair();
    } catch (e) {
      // If the key pair doesn't exist, generate a new one
      print("error");
      const storage = FlutterSecureStorage();

      final algorithm = X25519();
      final keyPair = await algorithm.newKeyPair();

      final privateKeyBytes = await keyPair.extractPrivateKeyBytes();
      final privateKey = base64Encode(privateKeyBytes);

      final publicKeyObject = await keyPair.extractPublicKey();
      final publicKeyBytes = publicKeyObject.bytes;
      final publicKey = base64Encode(publicKeyBytes);

      await storage.write(key: 'sentinel-guard-private-key', value: privateKey);
      await storage.write(key: 'sentinel-guard-public-key', value: publicKey);

      await UserApiService.updatePublicKey(publicKey);
    }
  }

  static Future removeKeyPair() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'sentinel-guard-private-key');
    await storage.delete(key: 'sentinel-guard-public-key');
  }

  static Future<String> decryptMessage(
      Message encryptedMessage, String bankPublicKey) async {
    final keyPair = await getKeyPair();
    final algorithm = X25519();
    print("encryptedMessage");
    print(encryptedMessage.content);
    print("bankPublicKey");
    print(bankPublicKey);
    final sharedSecret = await algorithm.sharedSecretKey(
      keyPair: keyPair,
      remotePublicKey: SimplePublicKey(base64Decode(bankPublicKey),
          type: KeyPairType.x25519),
    );

    final encryptionAlgorithm = AesCtr.with256bits(
      macAlgorithm: Hmac.sha256(),
    );

    final secretBox = SecretBox(
      base64.decode(encryptedMessage.content),
      nonce: base64.decode(encryptedMessage.nonce),
      mac: Mac(base64.decode(encryptedMessage.mac)),
    );

    final decryptedMessage =
        await encryptionAlgorithm.decrypt(secretBox, secretKey: sharedSecret);

    return utf8.decode(decryptedMessage);
  }
}
