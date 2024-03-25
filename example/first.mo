//import
import Map "mo:base/HashMap";
import Text "mo:base/Text";

// smart contract
actor {

  //type lang = motoko

  type Name = Text;
  type Phone = Text;

  type Entry = {
    desc: Text; //özellikleri olabilir bu şekilde bunlar : ile
    phone: Phone;
  };

  //let immutable değişmez, var değişir mutable
  //Map kütüphanesinden hashmap aldık, eaqul text mi diye bakıyo, hash depoya at
  let phonebook = Map.HashMap<Name, Entry>(0, Text.equal, Text.hash); //hashmap depo burda key value burak giriyorum bana entry değerlerini veriyo

  //fonksiyon (sorgu ve update)

  public func insert(name: Name, entry: Entry) : async () { //yoksa update 2.sıra
    phonebook.put(name, entry);
  };
  public query func lookup(name: Name) : async ?Entry { //?ne olursa olsun göster entry değerlerini
    phonebook.get(name) //return phonebook.get(name) return böyle, burağın entry değerlerini döndür
  };


};