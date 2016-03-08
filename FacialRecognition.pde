/**
 *顔認識するクラス
 *@author satori
 *
 */

class FacialRecognition {
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
   *検出された画像を囲う
   *
   *@param  なし
   *@return なし
   *
   */
  public void draw_facerect() {
    noFill();
    strokeWeight(3);

    for (int i=0; i<faces.length; i++) {
      double[] percent = new double[4];
      stroke(character_color(fc.classification(this.histogram[i], percent)));
      
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    }
  }

  /**
   *検出された顔全てのヒストグラムの計算
   *
   *@param  なし
   *@return なし
   *
   */
  public void calc_histogram() {
    loadPixels();

    for (int face_id=0; face_id<faces.length; face_id++) {
      int[][] pixels_2d = convert_array_1_to_2(pixels, height, width);
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
   *整数からキャラクターの色を取得する
   *
   *@param  n       整数
   *@return (color) カラーコード
   */
  private color character_color(int n) {
    switch(n) {
    case 0:  return #ffff00;//櫟井唯
    case 1:  return #ff0000;//野々原ゆずこ
    case 2:  return #0000ff;//日向縁
    case 3:  return #000000;//その他
    default: return #ffffff;
    }
  }
  
  /**
   *ピクセルの1次元配列から減色した1次元配列を返す
   *
   *@param  array ある範囲のpixels[]の1次元配列
   *@return reduct_array 256階調をgradient階調に減色した1次元配列
   */
  private int[] invert_pixels(int[] array) {
    int[] reduct_array = new int[array.length];

    for (int i=0; i<array.length; i++)
      reduct_array[i] = array[i]/(int)(pow(256, 3)/pow(gradient, 3));

    return reduct_array;
  }

  /**
   *ピクセルの2次元配列から減色した1次元配列を返す
   *
   *@param  array        ある範囲のpixels[]の2次元配列
   *@return reduct_array 256階調をgradient階調に減色した1次元配列
   */
  private int[] invert_pixels(int[][] origin_array) {
    int[] origin_array_1d = convert_array_2_to_1(origin_array);
    int[] reduct_array = new int[origin_array.length];


    for (int i=0; i<origin_array.length; i++)
      reduct_array[i] = origin_array_1d[i]/(int)(pow(256, 3)/pow(gradient, 3));

    return reduct_array;
  }

  /**
   *1次元配列を2次元配列に変換する
   *
   *@param  array_1d    1次元配列
   *@param  column_size 行のサイズ
   *@param  row_size    列のサイズ
   *@return array_2d    2次元配列
   */
  private int[][] convert_array_1_to_2(int[] array_1d, int column_size, int row_size) {
    int[][] array_2d = new int[column_size][row_size];

    for (int i=0; i<column_size; i++)
      for (int j=0; j<row_size; j++)
        array_2d[i][j] = array_1d[j*row_size+i];

    return array_2d;
  }

  /**
   *2次元配列を1次元配列に変換する
   *
   *@param  array_2d    2次元配列
   *@return array_1d    1次元配列
   */
  private int[] convert_array_2_to_1(int[][] array_2d) {
    int[] array_1d = new int[array_2d.length*array_2d[0].length];

    for (int i=0; i<array_2d.length; i++)
      for (int j=0; j<array_2d[i].length; j++)
        array_1d[j*array_2d[i].length+j] = array_2d[i][j];

    return array_1d;
  }
}