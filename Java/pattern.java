/**
 *                  *
 *                  **
 *                  ***
 *                  ****
 *                  *****
 *                  ****
 *                  ***
 *                  **
 *                  *
 * right angle triangle + inverse rt angle triangle 
 */

class pattern{
    public static void main(String args[]){

        //Right angle triangle
        for(int i=1; i<=5; i++){
            for(int j=1; j<=i; j++){
                System.out.print("*");
            }
            System.out.println();
        }

        for(int i=5; i>=1; i--){
            for(int j=1;j<=i; j++){
                System.out.print("*");
            }
            System.out.println();
        }
    }
}