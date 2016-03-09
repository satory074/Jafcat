class Utility {  
  /**
   * 配列中で最大値のインデックスを返す
   *
   * @param  array     double型の配列
   * @return max_index 最大値のインデックス
   */
  public int argmax(double[] array) {
    double max = array[0];
    int max_index = 0;

    for (int i=1; i<array.length; i++) {
      if (max < array[i]) {
        max = array[i];
        max_index = i;
      }
    }

    return max_index;
  }


  /**
   * 1次元配列を2次元配列に変換する
   *
   * @param  array_1d    1次元配列
   * @param  column_size 行のサイズ
   * @param  row_size    列のサイズ
   * @return array_2d    2次元配列
   */
  public int[][] convert_array_1_to_2(int[] array_1d, int column_size, int row_size) {
    int[][] array_2d = new int[column_size][row_size];

    for (int i=0; i<column_size; i++)
      for (int j=0; j<row_size; j++)
        array_2d[i][j] = array_1d[j*row_size+i];

    return array_2d;
  }

  /**
   * 2次元配列を1次元配列に変換する
   *
   * @param  array_2d    2次元配列
   * @return array_1d    1次元配列
   */
  public int[] convert_array_2_to_1(int[][] array_2d) {
    int[] array_1d = new int[array_2d.length*array_2d[0].length];

    for (int i=0; i<array_2d.length; i++)
      for (int j=0; j<array_2d[i].length; j++)
        array_1d[j*array_2d[i].length+j] = array_2d[i][j];

    return array_1d;
  }
}