import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTaransaction extends StatefulWidget {

  NewTaransaction(this.addNewTransaction);
  final Function addNewTransaction;

  @override
  _NewTaransactionState createState() => _NewTaransactionState();
}

class _NewTaransactionState extends State<NewTaransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData(){

    if(_titleController.text == null){
      return;
    }

    final enterTitle = _titleController.text;
    final enterAmount = double.parse(_amountController.text);

    if(enterTitle.isEmpty || enterAmount<=0 || _selectedDate == null){
      return;
    }

    widget.addNewTransaction(enterTitle, enterAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDayPicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate){
      if(pickedDate == null){
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  // onChanged: (val) => titleInput = val,
                  controller: _titleController,
                  onSubmitted: (_) => _submitData(),
                  ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  // onChanged: (val) => amonutInput = val,
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  onSubmitted: (_) => _submitData(),                  //_ get an argument but not usedddd....
                  ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          _selectedDate == null ? "No Date Chosen" : 
                          "Picked Date: ${DateFormat.yMd().format(_selectedDate)}"
                        ),
                      ),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text("Choose date", style: TextStyle(fontWeight: FontWeight.bold,),),
                        onPressed: _presentDayPicker,  
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  child: Text('Add Transaction'),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  onPressed: _submitData
                )
              ],
            ),
          ),
            elevation: 5,
          );
  }
}