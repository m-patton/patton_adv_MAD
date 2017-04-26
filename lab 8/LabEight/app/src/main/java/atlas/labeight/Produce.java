package atlas.labeight;

import android.content.Context;
import android.content.SharedPreferences;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by maggiepatton on 4/25/17.
 */

public class Produce {
    private String type;
    private ArrayList<String> produceitem = new ArrayList<>();


    //constructor
    private Produce(String prod, ArrayList<String> produce){ this.type = prod;
        this.produceitem = new ArrayList<String>(produce);
    }

    public static final Produce[] produce = {
            new Produce("Fruits", new ArrayList<String>()),
            new Produce("Vegetables", new ArrayList<String>())
    };
    /*
    public static final Produce[] produce = {
            new Produce("Fruits", new ArrayList<String>(Arrays.asList("Bananas : 4237", "Avocados : 4225",
                    "Fuji Apple : 4131", "Grapefruit : 4282"))),
            new Produce("Vegetables", new ArrayList<String>(Arrays.asList("Green Beans : 4066", "Bell Pepper : 4088",
                    "Broccoli : 4066", "Celery : 4583"))) };*/

    public void storeProduce(Context context, long produceId){
        SharedPreferences sharedPrefs = context.getSharedPreferences("ProduceItems", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPrefs.edit();
        Set<String> set = new HashSet<String>();
        set.addAll(produce[(int) produceId].getProduceitem());
        editor.putStringSet(produce[(int) produceId].getType(), set);
        editor.commit();
    }

    public void loadProduce(Context context, int produceId){
        SharedPreferences sharedPrefs = context.getSharedPreferences("ProduceItems", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPrefs.edit();
        Set<String> set =sharedPrefs.getStringSet(produce[produceId].getType(), null);
        if (set != null){
            Produce.produce[produceId].produceitem.addAll(set);
        }
        else {
            switch (produceId) {
                case 0:
                    Produce.produce[0].produceitem.addAll(Arrays.asList("Bananas : 4237", "Avocados : 4225",
                            "Fuji Apple : 4131", "Grapefruit : 4282"));
                    break;
                case 1:
                    Produce.produce[1].produceitem.addAll(Arrays.asList("Green Beans : 4066", "Bell Pepper : 4088",
                    "Broccoli : 4066", "Celery : 4583"));
                    break;
                default:
                    break;
            }
        }
    }

    public String getType(){ return type;
    }
    public ArrayList<String> getProduceitem(){ return produceitem;
    }
    public String toString(){ return this.type;
    }
}
