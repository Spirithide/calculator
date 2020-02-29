class CalculationResult {

  String number;

  CalculationResult(this.number);

  Map<String, dynamic> toMap() => {
    'number': number
  };

  CalculationResult.fromMapObject(Map<String, dynamic> map)
      : number = map['number'];

}