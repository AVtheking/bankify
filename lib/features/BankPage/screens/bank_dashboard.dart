import 'dart:developer';

import 'package:bankify/features/BankPage/controller/services_controller.dart';
import 'package:bankify/features/BankPage/controller/transactions_generator.dart';
import 'package:bankify/features/BankPage/widgets/filter_dialog.dart';
import 'package:bankify/features/BankPage/widgets/transactions_list.dart';
import 'package:bankify/models/transaction_model.dart';
import 'package:flutter/material.dart';

class BankDashboard extends StatefulWidget {
  const BankDashboard({super.key});

  @override
  State<BankDashboard> createState() => _BankDashboardState();
}

class _BankDashboardState extends State<BankDashboard> {
  DateTimeRange? _dateRangeFilter;
  double? _minAmountFilter;
  double? _maxAmountFilter;
  bool? _isSentFilter;
  final ScrollController scrollController = ScrollController();

  List<TransactionModel> transactions = [];
  int currentPage = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoading) {
      _fetchTransactions();
    }
  }

  Future<void> _fetchTransactions() async {
    setState(() {
      isLoading = true;
    });

    List<TransactionModel> newTransactions =
        await TransactionsGenerator.generateRandomTransactions(
            transactions.length, 10);
    //api call
    // List<TransactionModel>? newTransactions = await ServicesController.getTransactions();
    setState(() {
      transactions.addAll(newTransactions);
      currentPage++;
      isLoading = false;
    });
  }

  void _applyFilters(Map<String, dynamic> filters) {
    _dateRangeFilter = filters['dateRange'];
    _minAmountFilter = filters['minAmount'];
    _maxAmountFilter = filters['maxAmount'];
    _isSentFilter = filters['isSent'];
    _resetTransactions();
  }

  void _resetTransactions() {
    setState(() {
      transactions.clear();
      currentPage = 1;
    });
    _fetchTransactions();
  }

  void _openFilterDialog() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => FilterDialog(
        dateRange: _dateRangeFilter,
        minAmount: _minAmountFilter,
        maxAmount: _maxAmountFilter,
        isSent: _isSentFilter,
      ),
    );
    log("applying filters $result");
    if (result != null) {
      _applyFilters(result);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All transactions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _openFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: TransactionList(
              dateRangeFilter: _dateRangeFilter,
              minAmountFilter: _minAmountFilter,
              maxAmountFilter: _maxAmountFilter,
              scrollController: scrollController,
              isSentFilter: _isSentFilter,
              transactions: transactions,
            ),
          ),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
