import java.util.Arrays;

public class Chess {
    static String[] bishopPositions = {"a1", "h1", "a5", "g1", "e7", "e7", "e3", "a1", "a1",  "h1"}; //тест как в таблице
    static String[] pawnPositions = {"c3", "h3", "c3", "f3", "d6", "a3", "a7", "h8", "h7",  "a8"}; //аналогично
    static int[][] chessBoard = new int[8][8]; // массив шахматной доски

    static Integer bishopX;// координаты офицера по X
    static Integer bishopY; // координаты офицера по Y

    static Integer pawnX; // аналогично для пешки
    static Integer pawnY;


    public static void main(String[] args) {
        for (int i = 0; i < bishopPositions.length; i++) {
            System.out.println(isBeat(bishopPositions[i], pawnPositions[i])); //заводим в метод isBeat() попарно значения из теста
            fillArray(0); // после теста сбрасываем все значения с шахматной доски
        }
    }

    public static boolean isBeat(String bishop, String pawn){
        findFiguresCoordinates(bishop, pawn); //превращаем координаты из String в int (например, А1 в понятную [0][7])
        setBishopXYtoChessBoard(); //помещаем координаты офицера на шахматную доску
        setPossiblePositionsToChessBoard(); //помещаем на шахматную доску всевозможные варианты

        return chessBoard[pawnX][pawnY] == 2;
    }

    private static void findFiguresCoordinates(String bishop, String pawn){
        char[] bishopCoordinates = bishop.toCharArray(); //превращаем String в массив char
        char[] pawnCoordinates = pawn.toCharArray(); //аналогично для пешки

        bishopY = convertPositionToInteger(bishopCoordinates[0]);
        bishopX = 8 - Integer.parseInt(String.valueOf(bishopCoordinates[1]));

        pawnY = convertPositionToInteger(pawnCoordinates[0]);
        pawnX = 8 - Integer.parseInt(String.valueOf(pawnCoordinates[1]));

    }

    private static void setBishopXYtoChessBoard(){
        //все просто, присваиваем значение 1 координате офицера
        chessBoard[bishopX][bishopY] = 1;
    }

    private static void setPossiblePositionsToChessBoard(){
        int x = bishopX + 1;
        int y = bishopY + 1;
        for (int i = x; i < chessBoard.length; i++) {
            if(y >= 8){
                break;
            }
            chessBoard[i][y] = 2;
            y++;
        }
        x = bishopX + 1;
        y = bishopY - 1;
        for (int i = x; i < chessBoard.length ; i++) {
            if(y < 0){
                break;
            }
            chessBoard[i][y] = 2;
            y--;
        }
        x = bishopX - 1;
        y = bishopY + 1;
        for(int i = x; i >= 0; i--){
            if(y >= 8){
                break;
            }
            chessBoard[i][y] = 2;
            y++;
        }
        x = bishopX - 1;
        y = bishopY - 1;

        for (int i = x; i >= 0 ; i--) {
            if(y < 0){
                break;
            }
            chessBoard[i][y] = 2;
            y--;
        }
    }
    public static void fillArray(int value){
        //тут все просто, пробегаем по массиву, заполняем нулями
        for (int i = 0; i < chessBoard.length; i++) {
            for (int j = 0; j < chessBoard[i].length; j++) {
                chessBoard[i][j] = value;
            }
        }
    }

    private static int convertPositionToInteger(Character charPosition){
        String position = String.valueOf(charPosition); //конвертация char в String
        switch (position) {
            case "a":
                return 0;
            case "b":
                return 1;
            case "c":
                return 2;
            case "d":
                return 3;
            case "e":
                return 4;
            case "f":
                return 5;
            case "g":
                return 6;
            case "h":
                return 7;
            default:
                System.out.println("Ошибка!");
                return -1;
        }
    }
}

