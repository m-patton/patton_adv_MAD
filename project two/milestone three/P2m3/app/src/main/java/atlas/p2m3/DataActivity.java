package atlas.p2m3;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

import java.util.ArrayList;

public class DataActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_data);
        ListView listview = (ListView) findViewById(R.id.list_view);
        ArrayList<Object> list = new ArrayList<>();
        list.add(new String("Mind"));
        list.add(new ListItem("Happy", "0", R.drawable.mood_button));
        list.add(new ListItem("Fine", "0", R.drawable.mood_button));
        list.add(new ListItem("Fabulous", "0", R.drawable.mood_button));
        list.add(new ListItem("Stressed", "0", R.drawable.mood_button));
        list.add(new ListItem("Sad", "0", R.drawable.mood_button));
        list.add(new ListItem("Nervous", "0", R.drawable.mood_button));
        list.add(new ListItem("Blah", "0", R.drawable.mood_button));
        list.add(new ListItem("Angry", "0", R.drawable.mood_button));
        list.add(new ListItem("Irritable", "0", R.drawable.mood_button));
        list.add(new String("Body"));
        list.add(new ListItem("Ate healthy", "0", R.drawable.body_button));
        list.add(new ListItem("Ate junk", "0", R.drawable.body_button));
        list.add(new ListItem("Had a headache", "0", R.drawable.body_button));
        list.add(new ListItem("Slept well", "0", R.drawable.body_button));
        list.add(new ListItem("Slept poorly", "0", R.drawable.body_button));
        list.add(new ListItem("Felt fatigued", "0", R.drawable.body_button));
        list.add(new ListItem("Exercised", "0", R.drawable.body_button));
        list.add(new ListItem("Lounged", "0", R.drawable.body_button));
        list.add(new ListItem("Felt sick", "0", R.drawable.body_button));
        list.add(new String("Spirit"));
        list.add(new ListItem("Yoga", "0", R.drawable.spirit_button));
        list.add(new ListItem("Meditation", "0", R.drawable.spirit_button));
        list.add(new ListItem("Deep Breathing", "0", R.drawable.spirit_button));
        list.add(new ListItem("Light Exercise", "0", R.drawable.spirit_button));
        list.add(new ListItem("Positive Thoughts", "0", R.drawable.spirit_button));
        list.add(new ListItem("Negative Thoughts", "0", R.drawable.spirit_button));
        list.add(new ListItem("Spent time Outside", "0", R.drawable.spirit_button));
        list.add(new ListItem("Relaxed", "0", R.drawable.spirit_button));
        list.add(new ListItem("Felt Uncluttered", "0", R.drawable.spirit_button));

        listview.setAdapter(new CustomAdapter(this, list));
    }

    class CustomAdapter extends BaseAdapter {

        ArrayList<Object> list;
        private static final int mood_item = 0;
        private static final int header = 1;
        private LayoutInflater inflater;

        public CustomAdapter(Context context, ArrayList<Object> list) {
            this.list = list;
            inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        }

        @Override
        public int getItemViewType(int position) {
            if(list.get(position) instanceof ListItem){
                return mood_item;
            }
            else {
                return header;
            }
        }

        @Override
        public int getViewTypeCount() {
            return 2;
        }

        @Override
        public int getCount() {
            return list.size();
        }

        @Override
        public Object getItem(int i) {
            return list.get(i);
        }

        @Override
        public long getItemId(int i) {
            return i;
        }

        @Override
        public View getView(int i, View view, ViewGroup viewGroup) {
            if(view == null) {
                switch(getItemViewType(i)) {
                    case mood_item:
                        view = inflater.inflate(R.layout.customlayout, null);
                        break;

                    case header:
                        view = inflater.inflate(R.layout.customheader, null);
                        break;
                }
            }
            switch(getItemViewType(i)) {
                case mood_item:
                    ImageView image = (ImageView) view.findViewById(R.id.imageView);
                    TextView name = (TextView) view.findViewById(R.id.textView_item);
                    TextView count = (TextView) view.findViewById(R.id.textView_count);

                    image.setImageResource(((ListItem)list.get(i)).getImage());
                    name.setText(((ListItem)list.get(i)).getName());
                    count.setText(((ListItem)list.get(i)).getCount());
                    break;

                case header:
                    TextView title = (TextView) view.findViewById(R.id.listHeader);
                    title.setText(((String)list.get(i)));
                    break;
            }
            return view;
        }
    }
}
