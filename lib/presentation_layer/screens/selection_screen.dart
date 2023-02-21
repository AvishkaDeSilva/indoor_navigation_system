import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indoor_navigation_system/presentation_layer/screens/main_screen.dart';
import 'package:indoor_navigation_system/presentation_layer/utilities/common.dart';

import '../../logic_layer/blocs/map_bloc.dart';
import '../../logic_layer/events/map_event.dart';

class SelectionScreen extends StatefulWidget {
  static const String id = 'selection_screen';


  const SelectionScreen({super.key});

  @override
  State<SelectionScreen> createState() => _SelectionScreen();
}
class _SelectionScreen extends State<SelectionScreen> {
  late int? destination;
  late int? pathStart;
  late int? pathEnd;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Select Action')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Center(
                            child: Text(
                              'Select',
                              style:
                              TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropdownButtonFormField(
                                  hint: const Text('End'),
                                  items: dropDownList(),
                                  onChanged: (value) {
                                    setState(() {
                                      destination = value;
                                    });
                                  }),
                              const SizedBox(height: 10),
                              ElevatedButton(onPressed: (){},
                                  child: const Text("Next"))
                            ],
                          ),
                          elevation: 3,
                          scrollable: true,
                          actionsAlignment: MainAxisAlignment.center,
                        );
                      },
                    );
                  },
                  child: const Text('Direction'),
                )),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Center(
                            child: Text(
                              'Select',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropdownButtonFormField(
                                  hint: const Text('Start'),
                                  items: dropDownList(),
                                  onChanged: (value) {
                                    setState(() {
                                      pathStart = value;
                                    });
                                  }),
                              const SizedBox(height: 10),
                              DropdownButtonFormField(
                                  hint: const Text('End'),
                                  items: dropDownList(),
                                  onChanged: (value){
                                    setState(() {
                                      pathEnd= value;
                                    });
                                  }),
                              const SizedBox(height: 10),
                              ElevatedButton(onPressed: (){
                                if(pathStart != null && pathEnd != null){
                                  final bloc = context.read<MapBloc>();
                                  bloc.add(ShowDestinationPathLocationEvent(start: pathStart!,end: pathEnd!));
                                  Navigator.pushNamed(context, MainScreen.id);
                                }

                              }, child: const Text("Next"))
                            ],
                          ),
                          elevation: 3,
                          scrollable: true,
                          actionsAlignment: MainAxisAlignment.center,
                        );
                      },
                    );
                  },
                  child: const Text('Path'),
                )),
          ],
        ),
      ),
    );
  }
}
