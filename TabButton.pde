/**
 * 描画する四角形のエリアを定める
 * @author satori
 *
 */
class TabButton {
  private Area area;
  private String[] element_name;
  private color col;
  private int start_Y;

  private int selected_id;
  private int HEIGHT=35;
  
  private controlP5.Button[] button;


  TabButton(Area area, String[] element_name, color col, int start_Y) {
    this.area=area;
    this.start_Y=start_Y;
    this.element_name=element_name;
    this.col=col;
    
    this.selected_id=start_Y;
    button = new controlP5.Button[this.element_name.length];
  }


  public int get_start_Y() {
    return this.start_Y;
  }

  public int get_height() {
    return this.HEIGHT;
  }

  public int get_selected_id() {
    return this.selected_id;
  }

  public int get_element_count() {
    return this.element_name.length;
  }

  public String get_element_name(int n) {
    return this.element_name[n-this.start_Y];
  }


  public void set_selected_id(int n) {
    this.selected_id=n;
  }

  public void generate() {
    PFont font = createFont("Arial", 20);

    for (int i=0; i<this.element_name.length; i++) {
      this.button[i] = cp5.addButton("tabButtonValue:"+str(col)+", "+nf(i, 2))
        .setPosition(this.area.get_left(), this.start_Y+(this.HEIGHT+1)*i)
        .setSize(this.area.get_width(), this.HEIGHT)
        .setColorBackground(color(constrain(red(col), 0, 80), constrain(green(col), 0, 80), constrain(blue(col), 0, 80)))//ボタンの背景色
        .setColorForeground(color(constrain(red(col), 100, 255), constrain(green(col), 100, 255), constrain(blue(col), 100, 255)))//マウスオーバーの色
        .setColorActive(color(constrain(red(col), 128, 255), constrain(green(col), 128, 255), constrain(blue(col), 128, 255)))//押した時の色
        .setColorLabel(color(255))//文字色
        .setId(this.start_Y+i);

      this.button[i].getCaptionLabel()
        .setFont(font)
        .setSize(20)
        .toUpperCase(false)
        .setText(this.element_name[i]);
      //.setText(str(this.button[i].getId()));
    }
  }

  public void update() {
    noStroke();
    for (int i =0; i<this.element_name.length; i++) {
      this.button[i].setPosition(this.area.get_left(), start_Y+(HEIGHT+1)*i);

      if (this.selected_id-this.start_Y==i) this.button[i].setColorBackground(color(constrain(red(this.col), 100, 255), constrain(green(this.col), 100, 255), constrain(blue(this.col), 100, 255)));//ボタンの背景色
      else this.button[i].setColorBackground(color(constrain(red(this.col), 0, 80), constrain(green(this.col), 0, 80), constrain(blue(this.col), 0, 80)));//ボタンの背景色
    }
  }
}