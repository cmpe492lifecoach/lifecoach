class Notes {
  int id; // her not'a kolayca ulaşmak adına bir id,
  String title; // her not için bir başlık,
  String description; //her not için bir açıklama tanımladık.
  String date;
  String startTime;
  String endTime;
  Notes(this.title, this.description,this.date,this.startTime,this.endTime); // Constructor'ımızı oluşturduk.
  //Ekleme işlemlerinde direkt olarak id atadığı için id kullanmadık.
  Notes.withID(this.id, this.title, this.description,this.date,this.startTime,this.endTime);
  // Silme ve güncelleme gibi işlemler için ise id'li bir constructor oluşturduk.

//Sqlite'da devamlı "map"ler ile çalışacağımız için yardımcı methodlarımızı hazırlayalım.
//Verilerimizi okurken de map olarak okuyacağız, nesnemizi yazdırırkende map'e çevireceğiz.

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>(); //Geçici bir map nesnesi
    map["id"] = id;
    map["title"] = title;
    map["description"] = description;
    map["date"]=date;
    map["startTime"]=startTime;
    map["endTime"]=endTime;
    return map; //Bu mapimizi döndürüyoruz.
  }

  Notes.fromMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.title = map["title"];
    this.description = map["description"];
    this.date=map["date"];
    this.startTime=map["startTime"];
    this.endTime= map["endTime"];
  }
}
