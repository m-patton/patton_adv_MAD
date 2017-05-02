package atlas.pattonexam;

/**
 * Created by maggiepatton on 5/2/17.
 */

public class Activity {
    private String name;
    private int imageResourceID;

    private Activity(String newname, int newID){
        this.name = newname;
        this.imageResourceID = newID;
    }

    public static final Activity[] indoor = {
            new Activity("Swimming", R.drawable.in),
            new Activity("Climbing", R.drawable.in),
            new Activity("Basketball", R.drawable.in)
    };
    public static final Activity[] outdoor = {
            new Activity("Hiking", R.drawable.out),
            new Activity("Cycling", R.drawable.out),
            new Activity("Running", R.drawable.out)
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
