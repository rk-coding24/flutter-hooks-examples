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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:developer' as devtools show log;

extension CompactMap<T> on Iterable<T?> {
  Iterable<T> compactMap<E>([E? Function(T?)? transform]) => map(
        transform ?? (e) => e,
      ).where((e) => e != null).cast();
}

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

// const url = 'https://picsum.photos/500/500';
const url =
    'https://images.unsplash.com/photo-1485529910432-783b455774fa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final future = useMemoized(() => NetworkAssetBundle(Uri.parse(url))
        .load(url)
        .then((data) => data.buffer.asUint8List())
        .then((data) => Image.memory(data)));

    final snapshot = useFuture(future);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: Column(
          children: [snapshot.data].compactMap().toList(),
        ));
  }
}
