package atlas.p2m3;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

public class SpiritTipsActivity extends Activity {

    int[] images = {R.drawable.s1, R.drawable.s2, R.drawable.s3, R.drawable.s4, R.drawable.s5 };
    String[] titles = {"Do More Yoga", "Meditate Daily", "Declutter Your Life", "Focus on Your Breathing",  "Feng Shui Your Living Space"};
    String[] option = {"Yoga can relive stress and calm the mind", "Meditation Can improve focus and your mood",
            "Clutter can cause anxiety and anger", "Better breathing can lower stress and blood pressure",
            "Change the energy flow in your space"};

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_spirit_tips);

        ListView listView = (ListView) findViewById(R.id.list_view);
        SpiritAdapter spiritAdapter = new SpiritAdapter();
        listView.setAdapter(spiritAdapter);
    }

    class SpiritAdapter extends BaseAdapter {


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
