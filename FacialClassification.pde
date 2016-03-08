import java.util.*;
import java.io.*;
import org.deeplearning4j.nnpractice.*;

/**
 *
 * @author Matsudate
 */

class FacialClassification {
  private int nInput;//64;
  private int nHidden[];// = {100, 50, 25, 10};
  private int nOutput;// = 4;
  private Random rng;// = new Random(123);
  private int epoch;// = 1000;
  private double corruptionLevel;// = 0.1;
  private double alpha;// = 0.1;
  private double decayRate;// = 1E-2;
  private StackedAutoEncoder sAE;


  public FacialClassification(int nInput, int nHidden[], int nOut) {
    this.nInput = nInput;
    this.nHidden = nHidden;
    this.nOutput = nOut;
    this.epoch = 500;
    this.corruptionLevel = 0.1;
    this.alpha = 0.1;
    this.decayRate = 1E-2;
    this.rng = new Random(123);

    //build DNN
    this.sAE = new StackedAutoEncoder(nInput, nHidden, nOutput, nInput, rng, "ReLU");
  }

  public void fileImport(int input[][], int teach[][], String adress) {

    /* adress = 読み込みたいテキストファイルがある場所。
     */

    //配列[ノード番号][ノードの要素]の配列を準備
    input = new int[nInput][64];
    teach = new int[nInput][4];

    //ファイルの読み込み
    try {
      //ファイルのアドレスよりbrにファイルの情報を格納
      FileReader filereader = new FileReader(adress);
      BufferedReader br = new BufferedReader(filereader);

      //一行ずつ読み込んで
      String str = br.readLine();
      int count = 0;

      while (str != null) {
        //strlist.add(str.split(","));
        //一行の内容を','で分割してそれぞれを[count=ノード番号]の２次元目の配列の要素として格納
        input[count] = parseInts(str.split(","), teach[count]);
        //次の行を読み込み
        str = br.readLine();
        count++;
      }

      br.close();

      for (int i=0; i<nInput; i++) {
        for (int j=0; j<nOutput; j++) {
          print(teach[i][j]);
        }
        println();
      }
    }
    catch(FileNotFoundException e) {
      System.out.println(e);
    }
    catch(IOException e) {
      System.out.println(e);
    }
  }
  public int[] parseInts(String[] s, int teach[]) {

    /* s[] = intに変換したいストリングを収めた配列
     */

    int[] x = new int[s.length];
    for (int i = 0; i < s.length; i++) {
      if (i == 0) {
        switch(s[i]) {
        case "0":
          teach[3] = 1;
          break;
        case "1":
          teach[0] = 1;
          break;
        case "2":
          teach[1] = 1;
          break;
        case "3":
          teach[2] = 1;
          break;
        }
      } else {
        //x[i] = Integer.parseInt(s[i]);
        x[i-1] = int(s[i]);
      }
    }
    return x;
  }

  public void train(int input[][], int teachData[][]) {
    //pre-training
    sAE.preTraining(input, alpha, epoch, corruptionLevel);
    //fine-tuning
    sAE.fineTuning(input, teachData, alpha, epoch, decayRate);
  }

  public int classification(int testData[], double testOut[]) {
    //classification
    sAE.reconstruct(testData, testOut);

    int maxIndex = 0;
    double maxValue = testOut[0], value;
    for (int index = 1; index < testOut.length; index++) {
      value = testOut[index];
      if (value > maxValue) {
        maxValue = value;
        maxIndex = index;
      }
    }
    return maxIndex;
  }
}