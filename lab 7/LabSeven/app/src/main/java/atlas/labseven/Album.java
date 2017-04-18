package atlas.labseven;

/**
 * Created by maggiepatton on 4/17/17.
 */

public class Album {
    private String name;
    private int imageResourceID;

    private Album(String newname, int newID){
        this.name = newname;
        this.imageResourceID = newID;
    }
    public static final Album[] ftops = {
            new Album("The Four Tops", R.drawable.f1),
            new Album("Second Album", R.drawable.f2),
            new Album("On Top", R.drawable.f3),
            new Album("Reach Out", R.drawable.f4),
            new Album("Still Waters Run Deep", R.drawable.f5)
    };
    public static final Album[] gaye = {
            new Album("Moods of Marvin Gaye", R.drawable.g1),
            new Album("In The Groove", R.drawable.g2),
            new Album("That’s The Way Love Is", R.drawable.g3),
            new Album("What’s Going on", R.drawable.g4),
            new Album("Let’s Get It On", R.drawable.g5)
    };
    public static final Album[] temps = {
            new Album("Meet The Temptations", R.drawable.t1),
            new Album("The Temptations Sing Smokey", R.drawable.t2),
            new Album("The Temptin' Temptations", R.drawable.t3),
            new Album("Gettin’ Ready", R.drawable.t4),
            new Album("Wish It Would Rain", R.drawable.t5)
    };
    public static final Album[] smokey = {
            new Album("Hi, We’re The Miracles", R.drawable.m1),
            new Album("Going To a Go-Go", R.drawable.m2),
            new Album("Away We a Go-Go", R.drawable.m3),
            new Album("Make it Happen", R.drawable.m4),
            new Album("Time Out For Smokey Robinson and The Miracles", R.drawable.m5)
    };
    public static final Album[] stevie = {
            new Album("My Cherie Amour", R.drawable.w1),
            new Album("Signed, Sealed and Delivered", R.drawable.w2),
            new Album("Talking Book", R.drawable.w3),
            new Album("Songs in the Key of Life", R.drawable.w4),
            new Album("Hotter Than July", R.drawable.w5)
    };
    public static final Album[] supremes = {
            new Album("Meet The Supremes", R.drawable.s1),
            new Album("Where Did Our Love Go", R.drawable.s2),
            new Album("Supremes A' Go-Go", R.drawable.s3),
            new Album("Sing Rodgers & Hart", R.drawable.s4),
            new Album("Love Child", R.drawable.s5)
    };

    public String getName(){
        return name;
    }
    public int getImageResourceID(){
        return imageResourceID;
    }

    public String toString(){
        return this.name;
    }
}
