/**
* 描画する四角形のエリアを定めるクラス
* @author satori
*
*/

class Area {
  private Point left_top;
  private Point right_top;
  private Point left_bottom;
  private Point right_bottom;

  private int top;
  private int right;
  private int bottom;
  private int left;

  private int wid;
  private int hei;

  private boolean is_open;
  private float swipe_speed=0.4;


  public Area(Point p1, Point p2, Point p3, Point p4) {
    this.left_top     = p1;
    this.right_top    = p2;
    this.right_bottom = p3;
    this.left_bottom  = p4;

    this.top    = p1.get_Y();
    this.right  = p2.get_X();
    this.bottom = p3.get_Y();
    this.left   = p4.get_X();

    this.wid = p2.get_X()-p1.get_X();
    this.hei = p4.get_Y()-p1.get_Y();
  }


  public Point get_left_top() {
    return this.left_top;
  }

  public Point get_right_top() {
    return this.right_top;
  }

  public Point get_left_bottom() {
    return this.left_bottom;
  }

  public Point get_right_bottom() {
    return this.right_bottom;
  }

  public int get_top() {
    return this.top;
  }

  public int get_right() {
    return this.right;
  }

  public int get_bottom() {
    return this.bottom;
  }

  public int get_left() {
    return this.left;
  }

  public int get_width() {
    return this.wid;
  }

  public int get_height() {
    return this.hei;
  }


  public void set_top(int y) {
    this.left_top.set_Y(y);
    this.right_top.set_Y(y);
    this.top=y;
  }

  public void set_right(int x) {
    this.right_top.set_X(x);
    this.right_bottom.set_X(x);
    this.right=x;
  }

  public void set_bottom(int y) {
    this.left_bottom.set_Y(y);
    this.right_bottom.set_Y(y);
    this.bottom=y;
  }

  public void set_left(int x) {
    this.left_top.set_X(x);
    this.left_bottom.set_X(x);
    this.left=x;
  }

  public void set_is_open(boolean is_open) {
    this.is_open=is_open;
  }


  public void swipe() {
    this.set_left(
      (int)(this.left + ((
      is_open
      ? 0
      : -this.wid
      )-this.left)* swipe_speed-0.2));
    this.set_right(this.left+this.wid);

    noStroke();
    fill(#ffffff, 200);
    rect(this.left, this.top, this.wid, height);

    stroke(color(0, 0, 80));
    strokeWeight(2);
    line(this.right, 0, this.right, height);
  }
}