// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'dart:developer' as devtools show log;

// void main() {
//   runApp(
//     MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const HomePage(),
//     ),
//   );
// }

// const url = 'https://picsum.photos/500/500';
// // const url = 'https://unsplash.com/photos/dQjNHYposdY';

// class HomePage extends HookWidget {
//   const HomePage({Key? key}) : super(key: key);

//   Future<Image> loadImage() async {
//     final data = await NetworkAssetBundle(Uri.parse(url)).load(url);
//     final imageData = await data.buffer.asUint8List();
//     final image = Image.memory(imageData);
//     return image;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final imageFuture = useMemoized(loadImage);
//     // devtools.log('image value is ${imageFuture.data}');
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home Page'),
//       ),
//       body: FutureBuilder<Image>(
//         future: imageFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else if (snapshot.hasData) {
//             return snapshot.data!;
//           } else {
//             return Text('No image data');
//           }
//         },
//       ),
//     );
//   }
// }

//----
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    ),
  );
}

class CountDown extends ValueNotifier<int> {
  late StreamSubscription sub;
  CountDown({required int from}) : super(from) {
    sub = Stream.periodic(
      const Duration(seconds: 1),
      (v) => from - v,
    ).takeWhile((value) => value >= 0).listen((value) {
      this.value = value;
    });
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }
}

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final countDown = useMemoized(() => CountDown(from: 20));
    final notifier = useListenable(countDown);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Text(notifier.value.toString()),
    );
  }
}
