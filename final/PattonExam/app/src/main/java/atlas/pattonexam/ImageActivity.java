package atlas.pattonexam;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ImageView;
import android.widget.TextView;

public class ImageActivity extends Activity {
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()){
            case R.id.create_order:
                Intent intent = new Intent(this, OrderActivity.class);
                startActivity(intent);
                return true;
            default:
                return super.onOptionsItemSelected(item); }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_image);

        //get bulb data from the intent
        int activitynum = (Integer)getIntent().getExtras().get("activityid");
        String type = (String)getIntent().getExtras().get("activityname");
        ThisActivity activity1 = ThisActivity.indoor[activitynum];
        ThisActivity activity2 = ThisActivity.outdoor[activitynum];

        ImageView albumImage = (ImageView)findViewById(R.id.bulbImageView);
        TextView albumName = (TextView)findViewById(R.id.bulb_name);
        switch (type) {
            case "Indoor":
                albumImage.setImageResource(activity1.getImageResourceID());
                albumName.setText(activity1.getName());
                break;
            case "Outdoor":
                albumImage.setImageResource(activity2.getImageResourceID());
                albumName.setText(activity2.getName());
                break;
        }
    }
}
