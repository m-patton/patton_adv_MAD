package atlas.labseven;
/*
*Create an app that uses lists for navigation of three levels.
* Use an array to hold the data to be used in at least one of the list views.
* Include an action bar that takes the user to an active activity from all three activities.
* The action bar should also implement up navigation.
* */

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;

public class MainActivity extends Activity {

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
        setContentView(R.layout.activity_main);

        AdapterView.OnItemClickListener itemClickListener = new AdapterView.OnItemClickListener(){
            public void onItemClick(AdapterView<?> listView, View view, int position, long id){
            String albumname = (String) listView.getItemAtPosition(position);
            Intent intent = new Intent(MainActivity.this, AlbumActivity.class);
            intent.putExtra("albumname", albumname);
            startActivity(intent);
            }
        };
        ListView listview = (ListView) findViewById(R.id.listView);
        listview.setOnItemClickListener(itemClickListener);
    }
}
