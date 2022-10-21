import 'package:bloc_cubit_template/basic_builder/counter_bloc.dart';
import 'package:bloc_cubit_template/global/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasicBuilderPage extends StatelessWidget {
  BasicBuilderPage({super.key});

  static const routeName = '/basic_builder/basic_builder_page';

  final Counter myCounter = Counter(init: 0);

  // final GlobalKey<ScaffoldState> _providerKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Basic Builder'),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocListener(
            bloc: myCounter,
            listener: (context, state) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('is 5 listener')));
              print(state);
            },
            listenWhen: (previous, current) {
              if (current == 5)
                return true;
              else
                return false;
            },
            // child: Text(
            //   '${myCounter.state} FROM LISTENER',
            //   style: const TextStyle(fontSize: 30),
            // )
            child: BlocBuilder(
                bloc: myCounter,
                builder: (context, state) {
                  return Text(
                    '$state FROM LISTENER',
                    style: const TextStyle(fontSize: 30),
                  );
                }),
          ),
          const SizedBox(
            height: 30,
          ),
          // BLOC LISTENER OPTIONAL
          // BLOC LISTENER UNTUK MEMANGGIL FUNGSI PADA KONDISI TERTENTU
          // SEDANGKAN BUILDER MENENTUKAN KAPAN DI EMIT DAN KAPAN TIDAK EMIT
          BlocBuilder(
              bloc: myCounter,
              buildWhen: (previous, current) {
                // conditional setstate
                return true;
              },
              builder: (context, state) {
                return Text(
                  '$state FROM BUILDER',
                  style: const TextStyle(fontSize: 30),
                );
              }),
          const SizedBox(
            height: 30,
          ),
          // GABUNGAN LISTENER DAN BUILDER
          BlocConsumer(
              bloc: myCounter,
              builder: (context, state) {
                return Text(
                  '$state FROM CONSUMER',
                  style: const TextStyle(fontSize: 30),
                );
              },
              listener: (context, state) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('is 6 consumer')));
                print(state);
              },
              listenWhen: (previous, current) {
                if (current == 6)
                  return true;
                else
                  return false;
              }),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton(
                  onPressed: () {
                    myCounter.increment();
                  },
                  child: const Icon(Icons.add)),
              CupertinoButton(
                  onPressed: () {
                    myCounter.dencrement();
                  },
                  child: const Icon(Icons.remove))
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'PROVIDER',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          BlocProvider(
              create: (context) {
                return Counter(init: 0);
              },
              // MANGGIL BlocProvider.of<Counter>(context) HARUS 2 BUILD DIBAWAHNYA
              // ATAU BISA PANGGIL BlocProvider.value DAN LEMPAR BLOCNYA LEWAT PARAM
              // TIDAK DISARANKAN MULTIPLE BlocProvider.of UNTUK BLOC SAMA, GUNAKAN .value
              // SEPERTI CARA BIASA DI RESTAURANT APP
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const DecrementButton(),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 200,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SeparatedBlocBuilder(),
                        // BlocProvider.value(
                        //   value: context.read<Counter>(),
                        //   child: Text(
                        //     '${context.read<Counter>().state}',
                        //     style: const TextStyle(
                        //         fontSize: 20,
                        //         color: Colors.white,
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const IncrementButton(),
                ],
              ))
        ],
      ),
    );
  }
}

class IncrementButton extends StatelessWidget {
  const IncrementButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      color: Colors.blue,
      child: InkWell(
        onTap: () {
          // BlocProvider.of<Counter>(context).increment();
          context.read<Counter>().increment();
        },
        child: const SizedBox(
          height: 100,
          width: 50,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}

class DecrementButton extends StatelessWidget {
  const DecrementButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      color: Colors.blue,
      child: InkWell(
        onTap: () {
          // BlocProvider.of<Counter>(context).dencrement();
          context.read<Counter>().dencrement();
        },
        child: const SizedBox(
          height: 100,
          width: 50,
          child: Icon(
            Icons.remove,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}

class SeparatedBlocBuilder extends StatelessWidget {
  const SeparatedBlocBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: BlocBuilder(
            bloc: context.read<Counter>(),
            builder: (context, state) {
              return Text(
                '$state',
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              );
            }));
  }
}
