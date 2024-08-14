import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  final DateTimeRange? dateRange;
  final double? minAmount;
  final double? maxAmount;
  final bool? isSent;

  const FilterDialog({
    super.key,
    this.dateRange,
    this.minAmount,
    this.maxAmount,
    this.isSent,
  });

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  DateTimeRange? _dateRange;
  double? _minAmount;
  double? _maxAmount;
  bool? _isSent;

  @override
  void initState() {
    super.initState();
    _dateRange = widget.dateRange;
    _minAmount = widget.minAmount;
    _maxAmount = widget.maxAmount;
    _isSent = widget.isSent;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Filter Transactions',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Date Range'),
            subtitle: Text(
              _dateRange == null
                  ? 'No range selected'
                  : '${_dateRange!.start.toLocal()} - ${_dateRange!.end.toLocal()}',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            trailing:
                Icon(Icons.date_range, color: Theme.of(context).primaryColor),
            onTap: () async {
              _dateRange = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
                initialDateRange: _dateRange,
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary: Theme.of(context).primaryColor,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              setState(() {});
            },
          ),
          TextFormField(
            initialValue: _minAmount?.toString(),
            decoration: InputDecoration(
              labelText: 'Min Amount',
              labelStyle: TextStyle(color: Theme.of(context).primaryColor),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).primaryColorLight),
              ),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              _minAmount = double.tryParse(value);
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            initialValue: _maxAmount?.toString(),
            decoration: InputDecoration(
              labelText: 'Max Amount',
              labelStyle: TextStyle(color: Theme.of(context).primaryColor),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).primaryColorLight),
              ),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              _maxAmount = double.tryParse(value);
            },
          ),
          const SizedBox(height: 10),
          SwitchListTile(
            title: Text(
              'Credit/Debit',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            value: _isSent ?? false,
            onChanged: (value) {
              _isSent = value;
              setState(() {});
            },
            subtitle: Text(
              _isSent == null
                  ? 'No filter'
                  : _isSent!
                      ? 'Debit'
                      : 'Credit',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            activeColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop({
              'dateRange': null,
              'minAmount': null,
              'maxAmount': null,
              'isSent': null,
            });
          },
          child: Text(
            'Clear',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop({
              'dateRange': _dateRange,
              'minAmount': _minAmount,
              'maxAmount': _maxAmount,
              'isSent': _isSent,
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
          ),
          child: const Text('Apply', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
