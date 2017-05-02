package atlas.pattonexam;

import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

public class CategoryActivity extends ListActivity implements View.OnClickListener {

    private ButtonClickListener listener;

    @Override public void onClick(View view){
        if (listener !=null){
        listener.addbuttonclicked(view);
        }
    }


    /*ADD AN ACTIVITY*/

    interface ButtonClickListener{
        void addbuttonclicked(View view);
    }
/*
    public void addActivity(){
        final Dialog dialog = new Dialog(this);
        dialog.setContentView(R.layout.dialog);
        dialog.setTitle("Add Hero");
        dialog.setCancelable(true);
        final EditText editText = (EditText) dialog.findViewById(R.id.editTextHero);
        Button button = (Button) dialog.findViewById(R.id.addButton);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String activityName = editText.getText().toString();
                //
                dialog.dismiss();
            }
        });
        dialog.show();
    }
    */



    private String activityname;

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
        /*
        Button addButton = (Button)findViewById(R.id.addButton);
        addButton.setOnClickListener(this);
    */
        Intent i = getIntent();
        activityname = i.getStringExtra("activityname");
        ListView listActivities = getListView();
        ArrayAdapter<ThisActivity> listAdapter;
        switch (activityname){
            case "Indoor":
                listAdapter = new ArrayAdapter<ThisActivity>(this, android.R.layout.simple_list_item_1, ThisActivity.indoor);
                break;
            case "Outdoor":
                listAdapter = new ArrayAdapter<ThisActivity>(this, android.R.layout.simple_list_item_1, ThisActivity.outdoor);
                break;
            default: listAdapter = new ArrayAdapter<ThisActivity>(this, android.R.layout.simple_list_item_1, ThisActivity.indoor);
        }
        listActivities.setAdapter(listAdapter);
    }

    @Override
    public void onListItemClick(ListView listView, View view, int position, long id){
        Intent intent = new Intent(CategoryActivity.this, ImageActivity.class);
        intent.putExtra("activityid", (int) id);
        intent.putExtra("activityname", activityname);
        startActivity(intent);
    }




}
