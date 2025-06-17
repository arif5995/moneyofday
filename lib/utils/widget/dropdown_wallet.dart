import 'package:flutter/material.dart';
import 'package:monday/datasource/model/wallet_bank_model.dart';
import 'package:monday/utils/gen/colors.gen.dart';

class DropdownWallet extends StatefulWidget {
  final List<WalletBankModel> listWallet;
  const DropdownWallet({super.key, required this.listWallet});

  @override
  State<DropdownWallet> createState() => _DropdownWalletState();
}

class _DropdownWalletState extends State<DropdownWallet> {
  String currentCategory = "";
  @override
  void initState() {
    super.initState();
    currentCategory = widget.listWallet.first.nameBank;
  }
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      // key: widget.bankFormKey,
      dropdownColor: Colors.white,
      items: widget.listWallet.map((WalletBankModel category) {
        return DropdownMenuItem(value: category, child: Text(category.nameBank));
      }).toList(),
      onChanged: (newValue) {
        setState(() => currentCategory = newValue as String);
      },
      value: currentCategory,
      validator: (val) {
        if (val == currentCategory[0]) {
          return 'Please select account type';
        }
        return null;
      },
      decoration: InputDecoration(
        // Set border for enabled state (default)
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: ColorName.textGrey),
          borderRadius: BorderRadius.circular(15),
        ),
        // Set border for focused state
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: ColorName.textGrey),
          borderRadius: BorderRadius.circular(15),
        ),
        // errorText: errorSnapshot.data == 0 ? Localization.of(context).categoryEmpty : null
      ),
    );
  }
}
