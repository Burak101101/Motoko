import Map "mo:base/HashMap";
import Nat "mo:base/Nat";
import Hash "mo:base/Hash";
import Text "mo:base/Text";
import Iter "mo:base/Iter";
import Bool "mo:base/Bool";

actor Assistant {

  type ToDo = {
    desc: Text;
    completed: Bool;
  };
  
  func natHash(n: Nat) : Hash.Hash {
    Text.hash(Nat.toText(n));
  };

  var todos = Map.HashMap<Nat, ToDo>(0, Nat.equal, natHash);
  var nextID: Nat = 0;

  public query func getTodos() : async [ToDo] {
    Iter.toArray(todos.vals()); //gelen verileri array olark al
  };

  public func addtodo(desc : Text) : async Nat {
    let id = nextID;
    todos.put(id, {desc = desc; completed = false});
    nextID +=1;
    id //return id
  };

  public func completedTodo(id: Nat) : async (){
    ignore do ? { // eğer tamamlanmadıysa görmezden gel tamamlandıysa aşşası
      let desc = todos.get(id)!.desc; //! değil demek id uyumuşmuyosa geç
      todos.put(id, {desc; completed = true});
    }
  };

  public query func showTodos() : async Text {
    var output: Text = "\n_____TO-DOs_____";
    for (todo: ToDo in todos.vals()){
      output #="\n" # todo.desc; //# string demek
      if(todo.completed) {output #=" +"; };
    };
    output # "\n"
  };

  public func clearCompleted() : async (){
    todos := Map.mapFilter<Nat, ToDo, ToDo>(todos, Nat.equal, natHash,
    func(_, todo) {if (todo.completed) null else ?todo });
  };

};