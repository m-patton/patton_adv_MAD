package atlas.p2m3;

/**
 * Created by maggiepatton on 4/24/17.
 */

public class ListItem {
    private String name;
    private String count;
    private int image;

    public ListItem(String name, String count, int image) {
        this.name = name;
        this.count = count;
        this.image = image;

    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCount() {
        return count;
    }
    public void setCount(String count){
        this.count = count;
    }
    public int getImage() {
        return image;
    }
    public void setImage(int image){
        this.image = image;
    }
}

