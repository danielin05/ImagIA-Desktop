  import 'package:desktop/Providers/LogsProvider.dart';
  import 'package:desktop/Widgets/LogListItem.dart';
  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';

  class LogSearchScene extends StatefulWidget {
    @override
    _LogSearchSceneState createState() => _LogSearchSceneState();
  }

  class _LogSearchSceneState extends State<LogSearchScene> {
    TextEditingController messageController = TextEditingController();
    TextEditingController tagController = TextEditingController();

    @override
    void initState() {
      super.initState();
      Provider.of<LogsProvider>(context, listen: false).loadLogs();

      // Listen for changes to the message and tag filters
      messageController.addListener(_updateLogs);
      tagController.addListener(_updateLogs);
    }

    void _updateLogs() {
      final logsProvider = Provider.of<LogsProvider>(context, listen: false);
      logsProvider
        ..messageFilter = messageController.text
        ..tagFilter = tagController.text
        ..loadLogs();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Search Logs"),
        ),
        body: SingleChildScrollView(child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Wrap(
                spacing: 8.0, 
                runSpacing: 8.0,
                alignment: WrapAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        labelText: "Search by Message",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: tagController,
                      decoration: const InputDecoration(
                        labelText: "Search by Tag",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      _updateLogs();
                    },
                  ),
                ],
              ),
            ),
            Consumer<LogsProvider>(
              builder: (context, logsProvider, child) {
                if (logsProvider.logs.isEmpty) {
                  return const Center(child: Text("No logs found"));
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: logsProvider.logs.length,
                    itemBuilder: (context, index) {
                      final log = logsProvider.logs[index];
                      return LogListItem(
                        message: log.message,
                        tag: log.tag,
                        time: log.time,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        )),
      );
    }
  }
