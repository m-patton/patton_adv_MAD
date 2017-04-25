package atlas.p2m3;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

public class MindTipsActivity extends Activity {

    int[] images = {R.drawable.m1, R.drawable.m2, R.drawable.m3, R.drawable.m4, R.drawable.m5 };
    String[] titles = {"Read A Book", "Try Calming Herbs", "Keep a Journal", "Listen to Binaural Beats",  "Challenge Yourself"};
    String[] option = {"Read lots of books!", "Chamomile, Passionflower, Lavender... ", "Write out your thoughts", "to relax and meditate", "Try a puzzle or brain teaser"};

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mind_tips);

        ListView listView = (ListView) findViewById(R.id.list_view);
        MindAdapter mindAdapter = new MindAdapter();
        listView.setAdapter(mindAdapter);
    }

    class MindAdapter extends BaseAdapter {


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
