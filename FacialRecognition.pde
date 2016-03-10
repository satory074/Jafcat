/**
 * 顔認識をする
 * @author satori
 *
 */

class FacialRecognition {
  private Utility util = new Utility();

  private Rectangle[] faces;
  private int[][] histogram;

  private int gradient = 4;//減色時の階調
  private PFont font = createFont("MS-PGothic-14.vlw", 14, true);

  FacialRecognition(Rectangle[] faces) {
    this.faces = faces;

    this.histogram = new int[faces.length][(int)pow(this.gradient, 3)];
  }

  public int[][] get_histogram() {
    return this.histogram;
  }

  public int[] get_histogram(int n) {
    return this.histogram[n];
  }


  /**
   * 検出された画像を囲う
   *
   * @param  なし
   * @return なし
   *
   */
  public void draw_facerect() {
    noFill();
    strokeWeight(3);
    textFont(font);

    calc_histogram();

    for (int i=0; i<faces.length; i++) {      
      double[] testOut = new double[4];
      int max_index = fc.classification(this.histogram[i], testOut);
      color col = character_instance(max_index).get_color();

      noFill();
      stroke(col);
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);

      draw_rectlabel(col, max_index, faces[i]);
    }
  }

  /**
   * 検出された顔全てのヒストグラムの計算
   *
   * @param  col  キャラのパーソナルカラー
   * @return なし
   *
   */
  public void draw_rectlabel(color col, int max_index, Rectangle faces) {
    String name = character_instance(max_index).get_name();
    int text_width = (int)(textWidth(name));

    noStroke();
    fill(col);
    textAlign(LEFT, CENTER);
    rect(faces.x, faces.y, textWidth(name)+30, 15);

    fill(#000000);
    text(name, faces.x+5, faces.y+5);
    text(max_index, faces.x+text_width+15, faces.y+5);
  }


  /**
   * 検出された顔全てのヒストグラムの計算
   *
   * @param  なし
   * @return なし
   *
   */

  //TODO : max_indexではなく、％をtext()表示する

  public void calc_histogram() {
    loadPixels(); //<>//
    
    //pixels[]を16進数->10進数とする
    int[] pixels_1d = new int[pixels.length];
    for(int i=0; i<pixels_1d.length; i++)
      pixels_1d[i] = unhex(hex(pixels[i], 6));
    
    int[][] pixels_2d = util.convert_array_1_to_2(pixels_1d, height, width); //<>//

    for (int face_id=0; face_id<faces.length; face_id++) {
      int[][] face_pixels_2d = new int[faces[face_id].height][faces[face_id].width]; //<>//

      //顔の範囲のピクセルデータを格納
      for (int wid=0; wid<faces[face_id].width; wid++) {
        for (int hei=0; hei<faces[face_id].height; hei++) {
          face_pixels_2d[hei][wid] = unhex(hex(pixels_2d[hei][wid], 6)); //<>//
        }
      }

      //ヒストグラムの計算
      int[] face_pixels_1d = invert_pixels(face_pixels_2d);
      for (int i=0; i<face_pixels_1d.length; i++) {
        this.histogram[face_id][face_pixels_1d[i]]++; //<>//
      }
    }
  }


  /**
   * 整数からキャラクターの色を取得する
   *
   * @param  id      キャラ番号
   * @return (Chara) Charaインスタンス
   */
  private Chara character_instance(int id) {
    switch(id) {
    case 0:  
      return yui;
    case 1:  
      return yuzuko;
    case 2:  
      return yukari;
    case 3:  
      return other;
    default: 
      return none;
    }
  }

  /**
   * ピクセルの1次元配列から減色した1次元配列を返す
   *
   * @param  array ある範囲のpixels[]の1次元配列
   * @return reduct_array 256階調をgradient階調に減色した1次元配列
   */
  private int[] invert_pixels(int[] array) {
    int[] reduct_array = new int[array.length];

    for (int i=0; i<array.length; i++)
      reduct_array[i] = array[i]/(int)(pow(256, 3)/pow(this.gradient, 3));

    return reduct_array;
  }

  /**
   * ピクセルの2次元配列から減色した1次元配列を返す
   *
   * @param  array        ある範囲のpixels[]の2次元配列
   * @return reduct_array 256階調をgradient階調に減色した1次元配列
   */
  private int[] invert_pixels(int[][] origin_array) {
    Utility util = new Utility();
    int[] origin_array_1d = util.convert_array_2_to_1(origin_array);
    int[] reduct_array = new int[origin_array.length];

    for (int i=0; i<origin_array.length; i++)
      reduct_array[i] = origin_array_1d[i]/(int)(pow(256, 3)/pow(this.gradient, 3));

    return reduct_array;
  }
}