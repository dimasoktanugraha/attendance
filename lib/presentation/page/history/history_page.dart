import 'package:attendance/presentation/page/history/bloc/history/history_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  @override
  void initState() {
    context.read<HistoryBloc>().add(const HistoryEvent.getHistory());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            return state.maybeWhen(
                orElse: () => SizedBox.shrink(),
                loading: () => CircularProgressIndicator(),
                loaded: (history) {
                  if(history.isNotEmpty){
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: history.length,
                      separatorBuilder: (context, index) => Divider(),
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.blue,
                                  ),
                                  child: Text(
                                    history[index].type,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  DateFormat.yMd().format(history[index].createdAt),
                                  style: TextStyle(
                                    fontSize: 14
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: (history[index].status == "Approved") ? Colors.green : Colors.red,
                                  ),
                                  child: Text(
                                    history[index].status,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  DateFormat.Hms().format(history[index].createdAt),
                                  style: TextStyle(
                                    fontSize: 14
                                  ),
                                ),
                              ],
                            )
                          ]
                        ),
                      ),
                    );
                  }else{
                    return Center(child: Text('No History'));
                  }
                },
                error: (message) => Center(child: Text('Error : $message'))
              );
            },
          ),
      ),
    );
  }
}
