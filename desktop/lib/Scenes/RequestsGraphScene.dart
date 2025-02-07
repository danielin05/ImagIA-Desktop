import 'package:desktop/Providers/RequestsProvider.dart';
import 'package:flutter/material.dart';
import 'package:desktop/Widgets/VerticalBarGraph.dart';
import 'package:provider/provider.dart';

class RequestsGraphScene extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final requestsProvider = Provider.of<RequestsProvider>(context, listen: false);
    requestsProvider.getRequests();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Peticiones esta hora"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center( 
            child: constraints.maxHeight > 50 ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Let the graph take up all remaining space
              if (constraints.maxHeight > 200) 
                Consumer<RequestsProvider>(
                  builder: (context, requestsProvider, child) {
                    if (requestsProvider.barGetData == null) {
                      return const CircularProgressIndicator();
                    }
                    return Expanded(child: VerticalBarGraph(
                      data: requestsProvider.barGetData!,
                      xAxisName: "Peticiones esta hora",
                      yAxisName: "Numero de peticiones",
                    ));
                  },
                ),
            ],
          ):null);
        },
      ),
    );
  }
}

