package atlas.labeight;


import android.app.Fragment;
import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;


/**
 * A simple {@link Fragment} subclass.
 */
public class TypeListFragment extends Fragment implements AdapterView.OnItemClickListener {

    interface TypeListListener{
        void itemClicked(long id);
    }
    private TypeListListener listener;

    public TypeListFragment() {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_type_list, container, false);
    }

    @Override
    public void onStart(){
        super.onStart();
        View view = getView();
        if (view != null){
            ListView listUniverse = (ListView) view.findViewById(R.id.listView);
            ArrayAdapter<Produce> listAdapter = new ArrayAdapter<Produce>(getActivity(), android.R.layout.simple_list_item_1, Produce.produce);
            listUniverse.setAdapter(listAdapter);
            listUniverse.setOnItemClickListener(this);
        }
    }

    @Override public void onAttach(Context context){
        super.onAttach(context);
        listener = (TypeListListener) context;
    }

    @Override public void onItemClick(AdapterView<?> parent, View view, int position, long id){
        if (listener != null){
            listener.itemClicked(id);
        }
    }



}
