import 'dart:developer';

import 'package:bankify/features/dashboard/widgets/transaction.dart';
import 'package:flutter/material.dart';
import 'package:bankify/models/transaction_model.dart';

class TransactionList extends StatefulWidget {
  final DateTimeRange? dateRangeFilter;
  final List<TransactionModel> transactions;
  final double? minAmountFilter;
  final double? maxAmountFilter;
  final bool? isSentFilter;
  final ScrollController scrollController;
  const TransactionList({
    super.key,
    this.dateRangeFilter,
    this.minAmountFilter,
    this.maxAmountFilter,
    this.isSentFilter,
    required this.transactions,
    required this.scrollController,
  });

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  List<TransactionModel> _applyFilters(
    List<TransactionModel> transactions, {
    double? minAmount,
    double? maxAmount,
    DateTimeRange? dateRange,
    bool? isSent,
  }) {
    return transactions.where((transaction) {
      final amount = transaction.amount;
      final date = transaction.date;
      final sentStatus = transaction.isSent;
      log('Filtering with minAmount: $minAmount, maxAmount: $maxAmount, dateRange: $dateRange, isSent: $isSent');

      if (minAmount != null && amount < minAmount) return false;
      if (maxAmount != null && amount > maxAmount) return false;
      if (isSent != null && isSent != sentStatus) return false;
      if (dateRange != null &&
          (date.isBefore(dateRange.start) || date.isAfter(dateRange.end))) {
        return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<TransactionModel> transactions = _applyFilters(widget.transactions,
        minAmount: widget.minAmountFilter,
        maxAmount: widget.maxAmountFilter,
        dateRange: widget.dateRangeFilter,
        isSent: widget.isSentFilter);
    log('Building TransactionList, total transactions: ${transactions.length}');
    return ListView.builder(
      controller: widget.scrollController,
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        if (index == transactions.length) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: SizedBox.shrink(),
          );
        }
        final transaction = transactions[index];
        return Transaction(transaction: transaction);
      },
    );
  }
}
