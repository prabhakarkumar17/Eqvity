/**
 * Class ----> Variable + Methods(function) declare
 * Object
 * Ex - Scanner sc = new Scanner(System.in)
 * 
 * Oops - Object Oriented Programming Language
 * 
 * Types of OOPS 
 *  1. EnCAPSULation - class which contain variable and function is known as encapsulation 
 *  2. Inheritance - One class can use properties of another class. 
 *  3. Polymorphism - Poly --> many   morphism --> type  Two or more func having same name but different parameters
 *  4. Abstraction - Display of imp info only.
 */

class Student{
    int roll;
    String name;
    float marks;

    private
    int contact;

    void setDetail(int r, String n, float m){
        roll = r;
        name = n;
        marks = m;
    }

    void displayDetail(){
        System.out.println("Name of student is - "+name);
        System.out.println("Roll No of student is - "+roll);
        System.out.println("Marks of student is - "+marks);
    }
}

/**
 * To use another class's variable and methods we have to create 
 * object of that particular class.
 * 
 * Whenever we will create any objet of a class then a new instance(xerox copy)
 * of that particular class will be created
 */

class Oops{
    public static void main(String args[]){
        Student std1 = new Student(); //std1 - Object of Student class
        Student std2 = new Student();
        Student std3 = new Student();
        Student std4 = new Student();

        std1.setDetail(10, "Sachin Tendulkar", 77.5f);
        std2.setDetail(7, "Mahendra Singh Dhoni", 80.5f);
        std3.setDetail(18, "Virat Kohli", 65.8f);
        std4.setDetail(45, "Rohit Sharma", 70.0f);

        std1.displayDetail();
        System.out.println();

        std2.displayDetail();
        System.out.println();

        std3.displayDetail();
        System.out.println();

        std4.displayDetail();
        System.out.println();
    }
}