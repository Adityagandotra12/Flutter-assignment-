class ProductDataModel{
  String? name;
  String? id;
  String? atype;

  ProductDataModel(
      {
      this.name,
      this.id,
      this.atype,
      });

  ProductDataModel.fromJson(Map<String,dynamic> json)
  {
    name =json['name'];
    id = json['id'];
    atype = json['atype'];
  }
}