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

    for (int i=0; i<faces.length; i++) {
      double[] percent = fc.classification(this.histogram[i]);
      color col = character_instance(util.argmax(percent)).get_color();
      
      noFill();
      stroke(col);
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
      
      draw_rectlabel(col);
      
    }
  }
  
 /**
   * 検出された顔全てのヒストグラムの計算
   *
   * @param  col  キャラのパーソナルカラー
   * @return なし
   *
   */
  public void draw_rectlabel(color col){
    noStroke();
    fill(col);
  }


  /**
   * 検出された顔全てのヒストグラムの計算
   *
   * @param  なし
   * @return なし
   *
   */
  public void calc_histogram() {
    loadPixels();

    int[][] pixels_2d = util.convert_array_1_to_2(pixels, height, width);

    for (int face_id=0; face_id<faces.length; face_id++) {
      int[][] face_pixels_2d = new int[faces[face_id].height][faces[face_id].width];

      //顔の範囲のピクセルデータを格納
      for (int wid=0; wid<faces[face_id].height; wid++) {
        for (int hei=0; hei<faces[face_id].width; hei++) {
          face_pixels_2d[hei][wid] = pixels_2d[hei][wid];
        }
      }

      //ヒストグラムの計算
      int[] face_pixels_1d = invert_pixels(face_pixels_2d);
      for (int i=0; i<face_pixels_1d.length; i++) {
        this.histogram[face_id][face_pixels_1d[i]]++;
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
      reduct_array[i] = array[i]/(int)(pow(256, 3)/pow(gradient, 3));

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
      reduct_array[i] = origin_array_1d[i]/(int)(pow(256, 3)/pow(gradient, 3));

    return reduct_array;
  }
}