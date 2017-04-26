package atlas.labeight;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;

public class DetailActivity extends Activity implements ProduceDetailFragment.ButtonClickListener {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);

        ProduceDetailFragment produceDetailFragment = (ProduceDetailFragment) getFragmentManager().findFragmentById(R.id.fragment_container);
        int produceId = (int) getIntent().getExtras().get("id");
        produceDetailFragment.setType(produceId);
    }

    @Override public void addproduceclicked(View view){
        ProduceDetailFragment fragment = (ProduceDetailFragment)getFragmentManager().findFragmentById(R.id.fragment_container);
        fragment.addproduce();
    }
}
