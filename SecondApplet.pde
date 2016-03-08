class SecondApplet extends PApplet { //<>//
  PApplet parent;

  SecondApplet(PApplet _parent) {
    super();
    // set parent
    this.parent = _parent;
    //// init window
    try {
      java.lang.reflect.Method handleSettingsMethod =
        this.getClass().getSuperclass().getDeclaredMethod("handleSettings", null);
      handleSettingsMethod.setAccessible(true);
      handleSettingsMethod.invoke(this, null);
    } 
    catch (Exception ex) {
      ex.printStackTrace();
    }

    PSurface surface = super.initSurface();
    surface.placeWindow(new int[]{0, 0}, new int[]{0, 0});

    this.showSurface();
    this.startSurface();
  }

  void settings() {
    size(100, 100);
  }

  void setup() {
  }

  void draw() {
    noFill();
    stroke(0, 255, 0);

    try {      
      PImage newimg = img.get(faces[0].x, faces[0].y, faces[0].width, faces[0].height);

      surface.setSize(newimg.width, newimg.height);
      image(newimg, 0, 0);

      loadPixels();

      int[] histgram = new int[64];
      for (int j=0; j<pixels.length; j++)
        histgram[(int)unhex(hex(pixels[j], 6))/262144]++;

      double[] test_result=new double[4];
      maxindex = fc.classification(histgram, test_result);
<<<<<<< HEAD:Jafcat/SecondApplet.pde
=======
      println(test_result[0]);
      noLoop();
      //      String[] hist=new String[64];
      //      for (int j=0; j<histgram.length; j++)
      //        hist[j]=str(histgram[j]);

      //saveStrings("C:/Users/太郎/Documents/GitHub/ImageProcessing/FacialRecognition/data/histogram/"+str(index)+".txt", hist);

      //for (int j=0; j<pixels.length; j++)
      //set(j, j/width, (255/pixels.length)*pixels[j]);

      //updatePixels();
>>>>>>> parent of 2769e7e... 色とれたらしい:FacialRecognition/SecondApplet.pde

      //stroke(255, 0, 0);
      //for (int j=0; j<histgram.length; j++)
      //  line(map(j, 0, histgram.length, 0, width), 0, map(j, 0, histgram.length, 0, width), map(histgram[j], 0, max(histgram), 0, height));

      println(faces.length);
    }
    catch(NullPointerException e) {
    }
    catch(ArrayIndexOutOfBoundsException e) {
    }
  }
}