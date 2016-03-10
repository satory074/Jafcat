/**
 * キャラクターの情報
 * @author satori
 *
 */

class Chara {
  private String name;
  private int id;
  private color col;


  Chara(String name, int id, color col) {
    this.name=name;
    this.id=id;
    this.col=col;
  }
  

  public String get_name() {
    return this.name;
  }

  public int get_id() {
    return this.id;
  }

  public color get_color() {
    return this.col;
  }
}