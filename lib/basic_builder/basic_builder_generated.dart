import 'package:bloc_cubit_template/basic_builder/counter_bloc.dart';
import 'package:bloc_cubit_template/basic_builder/other_page_generated.dart';
import 'package:bloc_cubit_template/basic_builder/theme_bloc.dart';
import 'package:bloc_cubit_template/basic_builder/user_cubit.dart';
import 'package:bloc_cubit_template/global/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BasicBuilderGenerated extends StatelessWidget {
  BasicBuilderGenerated({super.key});

  static const routeName = '/basic_builder/basic_builder_generated';

  // final GlobalKey<ScaffoldState> _providerKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // BISA MENGGUNAKAN .watch TAPI SEMUA DIDALAM BUILD AKAN DIREBUILD, BLOCBUILDER LEBIH RINGAN
    // final Counter myCounter = context.watch<Counter>();
    // CARA LAIN BISA TARUH WATCH DI DALAM BUILDER TAPI SAMA AJA DENGAN BLOCBUILDER
    final Counter myCounter = context.read<Counter>();
    final ThemeBloc myTheme = context.read<ThemeBloc>();
    // final UserCubit myUser = context.read<UserCubit>();
    // BISA JUGA MENGGUNAKAN WATCH SELECTOR KONSEPNYA SAMA
    // final String myUser = context.select<UserCubit, String>((value) => value.state['Name']);
    // BISA LANGSUNG DIMASUKKAN KE <> UNTUK MENENTUKAN TIPE BLOC DAN STATE

    // SUMMARY
    // .read BIASANYA DIPANGGIL UNTUK NGAMBIL FUNGSI ATAU DILEMPAR KE BUILDER
    // .watch DAN .select BISA DIPAKAI UNTUK WIDGET YANG SIMPEL
    // SELAIN ITU LEBIH BAIK DENGAN BUILDER2 DARI BLOC

    return BlocBuilder<ThemeBloc, bool>(
      bloc: myTheme,
      builder: (context, state) {
        return CupertinoPageScaffold(
          backgroundColor: state ? Colors.grey : Colors.white,
          navigationBar: CupertinoNavigationBar(
            middle: Text('Basic Builder GENERATED'),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                BlocListener(
                  bloc: myCounter,
                  listener: (context, state) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('is 5 listener')));
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
                          ' FROM LISTENER',
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
                        ' FROM BUILDER',
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
                        ' FROM CONSUMER',
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
                Row(
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
                ),
                CupertinoButton(
                    child: Text('OTHER PAGE'),
                    onPressed: () {
                      Navigator.pushNamed(navigatorKey.currentContext!,
                          OtherPageGenerated.routeName);
                    }),
                CupertinoButton(
                  color: Colors.blue,
                  child: const Text('Switch bg Color'),
                  onPressed: () {
                    context.read<ThemeBloc>().switchTheme();
                  },
                ),
                SizedBox(height: 20),
                UserData(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class UserData extends StatefulWidget {
  const UserData({
    Key? key,
  }) : super(key: key);

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // BLOCSELECTOR HANYA BUILD PARAM SPESIFIK DARI STATE
  @override
  Widget build(BuildContext context) {
    UserCubit userCubit = context.read<UserCubit>();

    return Column(
      children: [
        BlocSelector<UserCubit, Map<String, dynamic>, String>(
          selector: (state) {
            return state['Name'];
          },
          builder: (context, state) {
            return Text(
              'Name : $state',
              style: TextStyle(fontSize: 20),
            );
          },
        ),
        SizedBox(height: 10),
        BlocSelector<UserCubit, Map<String, dynamic>, int>(
          selector: (state) {
            return state['Age'];
          },
          builder: (context, state) {
            return Text('Age : $state', style: TextStyle(fontSize: 20));
          },
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: CupertinoTextField(
                  controller: _nameController,
                ),
              ),
              CupertinoButton(
                  onPressed: () {
                    userCubit.setName(_nameController.text);
                  },
                  child: const Icon(Icons.check)),
            ],
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoButton(
                onPressed: () {
                  userCubit.setAge(userCubit.state['Age'] + 1);
                },
                child: const Icon(Icons.add)),
            CupertinoButton(
                onPressed: () {
                  userCubit.setAge(userCubit.state['Age'] - 1);
                },
                child: const Icon(Icons.remove))
          ],
        ),
      ],
    );
    ;
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
