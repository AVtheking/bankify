import 'package:bankify/features/BankPage/screens/bank_dashboard.dart';
import 'package:bankify/utils/const/images/images.dart';
import 'package:flutter/material.dart';

class BankCards extends StatelessWidget {
  const BankCards({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      width: MediaQuery.of(context).size.width,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const BankDashboard()));
            },
            child: Stack(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 7,
                                  blurRadius: 5,
                                ),
                              ]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Positioned(
                              child: Image.asset(
                                MyImages.card1,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                    )),
                const Positioned(
                    top: 75,
                    left: 200,
                    child: Text(
                      " Balance: \$2000",
                      style: TextStyle(color: Colors.green),
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}
