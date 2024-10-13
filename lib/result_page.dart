import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ResultPage extends StatefulWidget {
  final double bmiResult;

  const ResultPage({super.key, required this.bmiResult});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int _selectedViewIndex = 0;
  final List<String> _viewOptions = ['Gauge', 'Simple', 'Detailed'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your BMI Result"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Toggle buttons for view selection
            ToggleButtons(
              isSelected: List.generate(
                _viewOptions.length,
                (index) => index == _selectedViewIndex,
              ),
              onPressed: (int index) {
                setState(() {
                  _selectedViewIndex = index;
                });
              },
              children: _viewOptions
                  .map((option) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(option),
                      ))
                  .toList(),
            ),
            //const SizedBox(height: 20),
            // Display selected view
            Expanded(
              child: _buildSelectedView(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromARGB(255, 12, 161, 229), // Background color
                foregroundColor: Colors.black, // Text color
                side: const BorderSide(
                    color: Colors.grey, width: 0.2), // Border color and width
              ),
              child: const Text(
                "Back to Info",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedView() {
    switch (_selectedViewIndex) {
      case 0:
        return _buildGaugeView();
      case 1:
        return _buildSimpleView();
      case 2:
        return _buildDetailedView();
      default:
        return _buildGaugeView();
    }
  }

  Widget _buildGaugeView() {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 10,
          maximum: 40,
          ranges: <GaugeRange>[
            GaugeRange(
                startValue: 10,
                endValue: 18.5,
                color: const Color.fromARGB(255, 241, 218, 4)),
            GaugeRange(startValue: 18.5, endValue: 24.9, color: Colors.green),
            GaugeRange(startValue: 25, endValue: 29.9, color: Colors.orange),
            GaugeRange(startValue: 30, endValue: 39.9, color: Colors.red),
            GaugeRange(startValue: 40, endValue: 50, color: Colors.purple),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(value: widget.bmiResult),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Text(
                widget.bmiResult.toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 14, 86, 211),
                ),
              ),
              angle: 90,
              positionFactor: 0.5,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSimpleView() {
    return Center(
      child: Text(
        'Your BMI: ${widget.bmiResult.toStringAsFixed(2)}',
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDetailedView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Your BMI: ${widget.bmiResult.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        _buildBmiCategory(
            'Underweight', '< 18.5', const Color.fromARGB(255, 242, 218, 3)),
        _buildBmiCategory('Healthy', '18.5 - 24.9', Colors.green),
        _buildBmiCategory('Overweight', '25 - 29.9', Colors.orange),
        _buildBmiCategory('Obese', '30 - 34.9', Colors.red),
        _buildBmiCategory('Highly Obese', '35 - 39.9', Colors.redAccent),
        _buildBmiCategory('Extremely Obese', '> 40', Colors.purple),
      ],
    );
  }

  Widget _buildBmiCategory(String category, String range, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            range,
            style: TextStyle(color: color, fontSize: 16),
          ),
          Text(
            category,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
