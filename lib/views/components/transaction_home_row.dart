import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionsHomeRow extends StatelessWidget {
  final Map transaccion;
  final VoidCallback onPressed;
  const TransactionsHomeRow(
      {super.key, required this.transaccion, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
          onTap: onPressed,
          child: Container(
            height: 64,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black87.withOpacity(0.5)),
              color: const Color.fromARGB(188, 192, 213, 195),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            alignment: Alignment.center,
            child: Row(
              children: [
                const SizedBox(width: 10,),

                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: transaccion['colorCategoria'],
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: SvgPicture.asset('assets/icon/${transaccion['icono']}.svg'), 
                ),
                
      
                const SizedBox(height: 8,width: 10,),
      
                Expanded(
                  child: Text(
                    transaccion['categoria'],
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
      
                const SizedBox(width: 10,),
                
                Text(
                    "\$"+transaccion['monto'],
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),

                const SizedBox(width: 10,),
              ],
            ),
          )),
    );
  }
}
