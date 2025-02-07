class BarGraphData {
  final List<double> values;
  final List<String> labels;
  final double maxValue;

  const BarGraphData({
    required this.values,
    required this.labels,
    required this.maxValue,
  });

  BarGraphData.fromJson(Map<String, dynamic> json)
    : values = json['values'],
      labels = json['labels'],
      maxValue = json['values'].reduce((a, b) => a > b ? a : b);
}
