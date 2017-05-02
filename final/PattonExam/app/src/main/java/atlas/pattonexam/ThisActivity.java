package atlas.pattonexam;

/**
 * Created by maggiepatton on 5/2/17.
 */

public class ThisActivity {
    private String name;
    private int imageResourceID;

    private ThisActivity(String newname, int newID){
        this.name = newname;
        this.imageResourceID = newID;
    }

    public static final ThisActivity[] indoor = {
            new ThisActivity("Swimming", R.drawable.in),
            new ThisActivity("Climbing", R.drawable.in),
            new ThisActivity("Basketball", R.drawable.in)
    };
    public static final ThisActivity[] outdoor = {
            new ThisActivity("Hiking", R.drawable.out),
            new ThisActivity("Cycling", R.drawable.out),
            new ThisActivity("Running", R.drawable.out)
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
