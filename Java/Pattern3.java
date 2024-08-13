/**
 * 
 *                      *****
 *                       ****
 *                        ***
 *                         **
 *                          *
 * 
 */
class Pattern3{
    public static void main(String args[]){

        for(int i=5; i>=1; i--){ //for line change
            for(int j=1; j<=5-i; j++){ //for space printing
                System.out.print(" ");
            }

            for(int k=1; k<=i; k++){ //for star print
                System.out.print("*");
            }
            System.out.println();
        }
    }
}