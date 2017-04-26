package atlas.labeight;


import android.app.Dialog;
import android.app.Fragment;
import android.content.Context;
import android.os.Bundle;
import android.view.ContextMenu;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;

import java.util.ArrayList;


/**
 * A simple {@link Fragment} subclass.
 */
public class ProduceDetailFragment extends Fragment implements View.OnClickListener {

    private ArrayAdapter<String> adapter;
    private long producetypeId;
    private ButtonClickListener listener;


    public ProduceDetailFragment() {
        // Required empty public constructor
    }
    public void setType(long id){
        this.producetypeId = id;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        if (savedInstanceState !=null){
            producetypeId = savedInstanceState.getLong("producetypeId");
        }


        //if the hero list is empty, load heroes
        if (Produce.produce[0].getProduceitem().size() == 0 ) {
            Produce.produce[0].loadProduce(getActivity(), 0);
        }
        if (Produce.produce[1].getProduceitem().size() == 0 ) {
            Produce.produce[1].loadProduce(getActivity(), 1);
        }

        return inflater.inflate(R.layout.fragment_produce_detail, container, false);
    }

    @Override public void onStart(){
        super.onStart();
        View view = getView();
        ListView listProduce = (ListView) view.findViewById(R.id.producelistView);

        ArrayList<String> producelist = new ArrayList<String>();

        //producelist = Produce.produce[0].getProduceitem();
        producelist = Produce.produce[(int) producetypeId].getProduceitem();
        adapter = new ArrayAdapter<String>(getActivity(), android.R.layout.simple_list_item_1, producelist);
        listProduce.setAdapter(adapter);

        Button addButton = (Button) view.findViewById(R.id.addButton);
        addButton.setOnClickListener(this);
        registerForContextMenu(listProduce);

    }

    @Override public void onSaveInstanceState(Bundle savedInstanceState){
        savedInstanceState.putLong("producetypeId", producetypeId);
    }
    interface ButtonClickListener{
        void addproduceclicked(View view);
    }

    @Override public void onAttach(Context context){
        super.onAttach(context);
        //attaches the context to the listener
        listener = (ButtonClickListener)context;
    }

    @Override public void onClick(View view){
        if (listener !=null){
            listener.addproduceclicked(view);
        }
    }
    public void addproduce(){
        final Dialog dialog = new Dialog(getActivity());
        dialog.setContentView(R.layout.dialog);
        dialog.setTitle("Add Hero");
        dialog.setCancelable(true);
        final EditText editText = (EditText) dialog.findViewById(R.id.editTextProduce);
        final EditText editText2 = (EditText) dialog.findViewById(R.id.editTextPlu);
        Button button = (Button) dialog.findViewById(R.id.addButton);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String produceName = editText.getText().toString();
                String producePlu = editText2.getText().toString();
                String produceNew = produceName + " : " + producePlu;
                Produce.produce[(int) producetypeId].getProduceitem().add(produceNew);
                ProduceDetailFragment.this.adapter.notifyDataSetChanged();
                Produce.produce[(int) producetypeId].storeProduce(getActivity(), producetypeId);
                dialog.dismiss();
            }
        });
        dialog.show();
    }

    @Override public void onCreateContextMenu(ContextMenu menu, View view, ContextMenu.ContextMenuInfo menuInfo){
        super.onCreateContextMenu(menu, view, menuInfo);
        AdapterView.AdapterContextMenuInfo adapterContextMenuInfo = (AdapterView.AdapterContextMenuInfo) menuInfo;
        String producename = adapter.getItem(adapterContextMenuInfo.position);
        menu.setHeaderTitle("Delete " + producename);
        menu.add(1, 1, 1, "Yes");
        menu.add(2, 2, 2, "No");
    }

    @Override public boolean onContextItemSelected(MenuItem item){
        int itemId = item.getItemId();
        if (itemId == 1) { //pressed
            AdapterView.AdapterContextMenuInfo info = (AdapterView.AdapterContextMenuInfo) item.getMenuInfo();
            Produce.produce[(int) producetypeId].getProduceitem().remove(info.position);
            ProduceDetailFragment.this.adapter.notifyDataSetChanged();
            Produce.produce[(int) producetypeId].storeProduce(getActivity(), producetypeId);
        }
        return true;
    }


}
