import gab.opencv.*; //<>//
import java.awt.*;
import controlP5.*;

OpenCV opencv;
ControlP5 cp5;

//                        name           id  color
Chara yui    = new Chara("櫟井唯",       0 , #d1c894);
Chara yuzuko = new Chara("野々原ゆずこ", 1 , #f3b5bb);
Chara yukari = new Chara("日向縁",       2 , #7967ac);
Chara other  = new Chara("その他",       3 , #000000);
Chara none   = new Chara("",             -1, #ffffff);

//顔分類器
FacialClassification fc = new FacialClassification(137, new int[] {100, 50, 25, 10}, 4);

//タブ
Area tab_area = new Area(
  new Point(-150, 0),                     //左上
  new Point(0,    0),                     //右上
  new Point(0,    500), //右下
  new Point(-150, 500));//左下
TabButton function_button = new TabButton( 
  tab_area,                       //エリア
  new String[] {"Learn", "Image"},//名前の配列
  color(0, 0, 255),               //色
  1);                             //タブの始点

void setup() {
  size(200, 200);

  fc.fileImport("C:/Users/太郎/Documents/GitHub/Jafcat/data/histogram.txt");
  fc.train();

  opencv = new OpenCV(this, loadImage("C:/Users/太郎/Documents/GitHub/Jafcat/data/test/test6.jpg"));
  opencv.loadCascade("lbpcascade_animeface.xml");

  surface.setSize(opencv.width, opencv.height);
  
  //function_button.generate();
}

void draw() {
  background(220);

  image(opencv.getInput(), 0, 0);

  FacialRecognition fr = new FacialRecognition(opencv.detect());
  fr.draw_facerect();
  
  //function_button.update();
  
  //swipe tab
  tab_area.swipe();
  tab_area.set_is_open(mouseX<tab_area.get_width() 
    ? true
    : false);

  noLoop();
}

public void controlEvent(ControlEvent theEvent) {
  int id=theEvent.getController().getId();
  if (id <= function_button.get_start_Y()+function_button.get_element_count()) function_button.set_selected_id(id);
}

void mouseClicked() {
}

void keyPressed() {
}