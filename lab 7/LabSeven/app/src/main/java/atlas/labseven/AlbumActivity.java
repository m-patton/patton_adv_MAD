package atlas.labseven;

import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

public class AlbumActivity extends ListActivity {

    private String albumname;

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

        Intent i = getIntent();
        albumname = i.getStringExtra("albumname");
        ListView listAlbums = getListView();
        ArrayAdapter<Album> listAdapter;
        switch (albumname){
            case "The Four Tops":
                listAdapter = new ArrayAdapter<Album>(this, android.R.layout.simple_list_item_1, Album.ftops);
                //this.listnum = 1
                break;
            case "Marvin Gaye":
                listAdapter = new ArrayAdapter<Album>(this, android.R.layout.simple_list_item_1, Album.gaye);
                break;
            case "The Temptations":
                listAdapter = new ArrayAdapter<Album>(this, android.R.layout.simple_list_item_1, Album.temps);
                break;
            case "Smokey Robinson and The Miracles":
                listAdapter = new ArrayAdapter<Album>(this, android.R.layout.simple_list_item_1, Album.smokey);
                break;
            case "Stevie Wonder":
                listAdapter = new ArrayAdapter<Album>(this, android.R.layout.simple_list_item_1, Album.stevie);
                break;
            case "The Supremes":
                listAdapter = new ArrayAdapter<Album>(this, android.R.layout.simple_list_item_1, Album.supremes);
                break;
            default: listAdapter = new ArrayAdapter<Album>(this, android.R.layout.simple_list_item_1, Album.ftops);
        }
        listAlbums.setAdapter(listAdapter);
    }

    @Override
    public void onListItemClick(ListView listView, View view, int position, long id){
        Intent intent = new Intent(AlbumActivity.this, AlbumImgActivity.class);
        intent.putExtra("albumid", (int) id);
        intent.putExtra("albumname", albumname);
        startActivity(intent);
    }
}
