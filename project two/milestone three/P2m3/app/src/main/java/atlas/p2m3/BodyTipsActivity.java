package atlas.p2m3;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

public class BodyTipsActivity extends Activity {

    int[] images = {R.drawable.b1, R.drawable.b2, R.drawable.b3, R.drawable.b4, R.drawable.b5 };
    String[] titles = {"Eat Anti-inflammatory Foods", "Drink More Water", "Sleep More", "Exercise More Often",  "Juice"};
    String[] option = {"Tomatoes, Olive Oil, Green Leafy Vegetables...", "Aim for two liters a day",
            "More sleep leads to better health", "Exercise keeps you healthy and lowers disease risk", "Juice to cleanse the body of toxins"};

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_body_tips);

        ListView listView = (ListView) findViewById(R.id.list_view);
        BodyAdapter bodyAdapter = new BodyAdapter();
        listView.setAdapter(bodyAdapter);
    }

    class BodyAdapter extends BaseAdapter {


        @Override
        public int getCount() {
            return images.length;
        }

        @Override
        public Object getItem(int i) {
            return null;
        }

        @Override
        public long getItemId(int i) {
            return 0;
        }

        @Override
        public View getView(int i, View view, ViewGroup viewGroup) {
            view = getLayoutInflater().inflate(R.layout.mindlayout, null);

            ImageView imageView=(ImageView)view.findViewById(R.id.imageView2);
            TextView textView_title = (TextView)view.findViewById(R.id.textView_title);
            TextView textView_option = (TextView)view.findViewById(R.id.textView_option);

            imageView.setImageResource(images[i]);
            textView_title.setText(titles[i]);
            textView_option.setText(option[i]);

            return view;
        }
    }
}
