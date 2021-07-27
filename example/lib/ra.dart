import 'package:app_security_kit/app_security_kit.dart';
import 'package:flutter/material.dart';

class RADemo extends StatefulWidget {
  @override
  _RADemoState createState() => _RADemoState();
}

class _RADemoState extends State<RADemo> {
  final TextEditingController privateKyTc = TextEditingController();
  final TextEditingController raEncryptedTc = TextEditingController();
  final TextEditingController resultTc = TextEditingController();

  @override
  void initState() {
    privateKyTc.text =
        'MIICXAIBAAKBgQDusPc9qEGYrkE/eYAKuuR3q4FFQGnQ6ubIPAnzil6H/FTlU6AaNH+Rz9xis5SNQq7t+YtaG7O2mUNg6zOZnUg+/9jmOJjvFo7TWz+yGH5EeLuVsZiCUOWrtwtZgyvuPfGzWagVnmcDY1yqLik03w8MDHOZNLaGi693yHZRz9qIkQIDAQABAoGAMl657hMBtLyhHEoBkUIbUH2qy/hp3CKWDQ9Ockxy4nOHXtWk5aLKgPTCZznKUX0O+T0+AQfzhscVBvDbdMFSK0Dx71B8LdnmLkvyUGu9nVTTuGgelTF0WQCf86Rd6LknGwZQAK6RNzeQZEq6XG/yJOuHWIPFsy9YHY2+yNyQkVkCQQD3IsLc7OmsfuB/UvKXsUsCoajhqOG7poh3tAY+YJMlWyToDGOXw1JSCTph6XbzYmnk/kRyhioxY78r2R5IatZ3AkEA90CqcJkiXP5JOgVSvAiYa9O14EfvXOjCYfAklFLekyru5OjUJhJ2YACykB1m4O1w7BvZwRMFvci5bca6QqlzNwJAI45fxNNdJ1E10XvIpWR/q0hA+P6IQ6xJFBfVkiHo6cX8QFqP9aTHckAbozyovYmaPLUMegGtjl+QgKmDPt4ILwJACdPzMmiT2hhtdrXxdPHuhRK0Pwb897d0yonOGms016q0Njse+6huNiCw+FOC3Fvzyh7NSARmjQWmgTuN+cpcfwJBAM58p/u2zv1KDezdD4ynn+GGvhPEvbdW7b0uXnQIZYRaTUzPVLMyteTW8NskqS97mAw4uD7RpDeUH6i0qzY2zxc=';
    raEncryptedTc.text =
        'rLoBALejPtLDGAfSpRx/Lzj1IDYnuEiqRRULAahJAZ5Opuz87u4YKbFmKxPlbWTft+b/FdDPKzGif6bgZU5Z4femjaOlQSoICR9ecXzQpWx15Oq11vnIlms57Dr72zFCSgtns9Pj3iXlUHTDjzd2Y+RL/wfgS6F5etnJJrFxqbKKKX5kj2ByCFSbEdlKFuGzIHqXNnIa0vjpZH2cVcVOnWCzsxo=';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Decode RA Format',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              textAlign: TextAlign.start,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text("Private Key"),
                ),
                Expanded(
                  flex: 3,
                  child: TextField(
                    maxLines: 4,
                    controller: privateKyTc,
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text("RA Format Encrypted text"),
                ),
                Expanded(
                  flex: 3,
                  child: TextField(
                    maxLines: 4,
                    controller: raEncryptedTc,
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed:
                  privateKyTc.text.length > 0 && raEncryptedTc.text.length > 0
                      ? () {
                          final decode =
                              DecryptionHelper(privateKey: privateKyTc.text);
                          String finalDecoded =
                              decode.decryptRAEncryption(raEncryptedTc.text);

                          resultTc.text = finalDecoded;
                        }
                      : null,
              child: Text("Decrypte text"),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text("Decrypted Text"),
                ),
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: resultTc,
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
