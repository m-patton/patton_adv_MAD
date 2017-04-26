package atlas.labeight;

/*
*Lab 8: Create an app that uses fragments and displays them differently on phones and tablets.
* The user should be able to add and delete data.
* The data should be persistent.
* */


import android.app.Activity;
import android.app.FragmentTransaction;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;

public class MainActivity extends Activity implements TypeListFragment.TypeListListener, ProduceDetailFragment.ButtonClickListener {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    @Override public void onBackPressed() {
        if (getFragmentManager().getBackStackEntryCount() > 0 ){
        getFragmentManager().popBackStack();
        } else {
        super.onBackPressed();
        }
    }
    @Override public void itemClicked(long id){
        View fragmentContainer = findViewById(R.id.fragment_container);
        if (fragmentContainer != null) {
            ProduceDetailFragment frag = new ProduceDetailFragment();
            FragmentTransaction ft = getFragmentManager().beginTransaction();
            frag.setType(id);
            ft.replace(R.id.fragment_container, frag);
            ft.addToBackStack(null);
            ft.setTransition(FragmentTransaction.TRANSIT_FRAGMENT_FADE);
            ft.commit();
        }else{
            Intent intent = new Intent(this, DetailActivity.class);
            intent.putExtra("id", (int) id);
            startActivity(intent);
        }
    }


    @Override public void addproduceclicked(View view){
        ProduceDetailFragment fragment = (ProduceDetailFragment)getFragmentManager().findFragmentById(R.id.fragment_container);
        fragment.addproduce();
    }
}
