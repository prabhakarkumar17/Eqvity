/**
 * 
 *               *      1st - 1 star ---> 1*2 - 1 = 1
 *              ***     2nd - 3 star ---> 2*2 - 1 = 3
 *             *****    3rd - 5 star ---> 3*2 - 1 = 5
 *            *******   4th - 7 star ---> 4*2 - 1 = 7
 *           *********  5th - 9 star ---> 5*2 - 1 = 9
 * 
 *                      Multiply lineNo by 2 - 1
 * 
 * Space decrement by 1
 * Star increment by 2 
 */

class Pattern5{
    public static void main(String args[]){
        for(int i=1; i<=7; i++){
            for(int j=1; j<=7-i; j++){ //Space
                System.out.print(" ");
            }

            for(int k=1; k<=(2*i); k++){ //star
                System.out.print("*");
            }
            System.out.println();
        }
    }
}
