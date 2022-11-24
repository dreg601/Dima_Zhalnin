import java.util.Scanner;

public class Plant {
    private static final int upSpeed = 7;
    private static final int downSpeed = 3;

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int desiredHeight = scanner.nextInt();
        int countDays = getDaysCount(desiredHeight);
    }
    public static int getDaysCount(int desiredHeight){
        int currentHeight = 0;
        int days = 0;
        while (true){
            days++;
            currentHeight += upSpeed;
            if(desiredHeight <= currentHeight){
                System.out.println("Требуемое количество дней: " + days);
                return days;
            }
            currentHeight -= downSpeed;
        }
    }
}
