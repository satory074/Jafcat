import gab.opencv.*;  //<>// //<>//
import java.awt.*;
import controlP5.*;

OpenCV opencv;
Rectangle[] faces;

ControlP5 cp5;

FacialClassification fc = new FacialClassification(137, new int[] {100, 50, 25, 10}, 4);

void settings() {
}

void setup() {

  fc.fileImport("C:/Users/太郎/Documents/GitHub/ImageProcessing/Jafcat/data/histogram.txt");
  fc.train();

  opencv = new OpenCV(this, loadImage("C:/Users/太郎/Documents/GitHub/ImageProcessing/Jafcat/data/test/test6.jpg"));
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