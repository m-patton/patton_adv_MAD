package atlas.labseven;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ImageView;
import android.widget.TextView;

public class AlbumImgActivity extends Activity {

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
        setContentView(R.layout.activity_album_img);

        int albumnum = (Integer)getIntent().getExtras().get("albumid");
        String album = (String)getIntent().getExtras().get("albumname");
        //albumname = i.getStringExtra("albumname");
        Album artist1 = Album.ftops[albumnum];
        Album artist2 = Album.gaye[albumnum];
        Album artist3 = Album.temps[albumnum];
        Album artist4 = Album.smokey[albumnum];
        Album artist5 = Album.stevie[albumnum];
        Album artist6 = Album.supremes[albumnum];



        ImageView albumImage = (ImageView)findViewById(R.id.albumImageView);
        TextView albumName = (TextView)findViewById(R.id.album_name);
        switch (album) {
            case "The Four Tops":
                albumImage.setImageResource(artist1.getImageResourceID());
                albumName.setText(artist1.getName());
                break;
            case "Marvin Gaye":
                albumImage.setImageResource(artist2.getImageResourceID());
                albumName.setText(artist2.getName());
                break;
            case "The Temptations":
                albumImage.setImageResource(artist3.getImageResourceID());
                albumName.setText(artist3.getName());
                break;
            case "Smokey Robinson and The Miracles":
                albumImage.setImageResource(artist4.getImageResourceID());
                albumName.setText(artist4.getName());
                break;
            case "Stevie Wonder":
                albumImage.setImageResource(artist5.getImageResourceID());
                albumName.setText(artist5.getName());
                break;
            case "The Supremes":
                albumImage.setImageResource(artist6.getImageResourceID());
                albumName.setText(artist6.getName());
                break;
        }

    }
}
