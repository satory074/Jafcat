/**
 * ポイントのX座標とY座標を定める
 * @editor satori
 *
 */

class Point {

  private int x;
  private int y;

  public Point(int x, int y) {
    this.x = x;
    this.y = y;
  }

  public int get_X() {
    return this.x;
  }

  public int get_Y() {
    return this.y;
  }

  public void set_X(int x) {
    this.x = x;
  }

  public void set_Y(int y) {
    this.y = y;
  }

  public void set_point(int x, int y) {
    this.x = x;
    this.y = y;
  }
}