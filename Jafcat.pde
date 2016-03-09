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

FacialClassification fc = new FacialClassification(137, new int[] {100, 50, 25, 10}, 4);

void settings() {
}

void setup() {

  fc.fileImport("C:/Users/太郎/Documents/GitHub/Jafcat/data/histogram.txt");
  fc.train();

  opencv = new OpenCV(this, loadImage("C:/Users/太郎/Documents/GitHub/Jafcat/data/test/test6.jpg"));
  opencv.loadCascade("lbpcascade_animeface.xml");

  surface.setSize(opencv.width, opencv.height);
}

void draw() {
  background(220);

  image(opencv.getInput(), 0, 0);

  FacialRecognition fr = new FacialRecognition(opencv.detect());
  fr.draw_facerect();

  noLoop();
}

void mouseClicked() {
}

void keyPressed() {
}