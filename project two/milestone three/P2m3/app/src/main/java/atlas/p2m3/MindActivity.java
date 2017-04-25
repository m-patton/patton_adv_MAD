package atlas.p2m3;

import android.app.Activity;
import android.content.Intent;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ToggleButton;

public class MindActivity extends Activity {
    ToggleButton btn1;ToggleButton btn2;ToggleButton btn3;ToggleButton btn4;
    ToggleButton btn5;ToggleButton btn6;ToggleButton btn7;ToggleButton btn8;ToggleButton btn9;
    int c1 = 0;int c2 = 0;int c3 = 0;int c4 = 0;
    int c5 = 0;int c6 = 0;int c7 = 0;int c8 = 0;int c9 = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mind);

        btn1 = (ToggleButton) findViewById(R.id.tmb1);btn2 = (ToggleButton) findViewById(R.id.tmb2);
        btn3 = (ToggleButton) findViewById(R.id.tmb3);btn4 = (ToggleButton) findViewById(R.id.tmb4);
        btn5 = (ToggleButton) findViewById(R.id.tmb5);btn6 = (ToggleButton) findViewById(R.id.tmb6);
        btn7 = (ToggleButton) findViewById(R.id.tmb7);btn8 = (ToggleButton) findViewById(R.id.tmb8);
        btn9 = (ToggleButton) findViewById(R.id.tmb9);




        Button button1=(Button)findViewById(R.id.buttondata); //bottom button though
        Button button2=(Button)findViewById(R.id.buttontip);

        button1.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v) {
                Intent intent1 = new Intent(MindActivity.this,DataActivity.class);
                startActivity(intent1);
            }
        });
        button2.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v) {
                Intent intent2 = new Intent(MindActivity.this,MindTipsActivity.class);
                startActivity(intent2);
            }
        });
    }

    public void changeButton(View view) {
        boolean checked = ((ToggleButton)view).isChecked();
        Drawable round = getResources().getDrawable(R.drawable.round_button);
        Drawable mood = getResources().getDrawable(R.drawable.mood_button);
        if(checked){ //this means have mood
            ((ToggleButton)view).setBackgroundDrawable(round);
            switch(view.getId()){
                case R.id.tmb1:
                    c1 -= 1;
                    String str = String.valueOf(c1);
                    System.out.printf(str);
                    break;
                case R.id.tmb2:
                    c2 -= 1;
                    break;
                case R.id.tmb3:
                    c3 -= 1;
                    break;
                case R.id.tmb4:
                    c4 -= 1;
                    break;
                case R.id.tmb5:
                    c5 -= 1;
                    break;
                case R.id.tmb6:
                    c6 -= 1;
                    break;
                case R.id.tmb7:
                    c7 -= 1;
                    break;
                case R.id.tmb8:
                    c8 -= 1;
                    break;
                case R.id.tmb9:
                    c9 -= 1;
                    break;
            }
        }
        else{
            //btn1.setBackgroundDrawable(mood);
            ((ToggleButton)view).setBackgroundDrawable(mood);
            switch(view.getId()){
                case R.id.tmb1:
                    c1 += 1;
                    String str = String.valueOf(c1);
                    System.out.printf(str);
                    break;
                case R.id.tmb2:
                    c2 += 1;
                    break;
                case R.id.tmb3:
                    c3 += 1;
                    break;
                case R.id.tmb4:
                    c4 += 1;
                    break;
                case R.id.tmb5:
                    c5 += 1;
                    break;
                case R.id.tmb6:
                    c6 += 1;
                    break;
                case R.id.tmb7:
                    c7 += 1;
                    break;
                case R.id.tmb8:
                    c8 += 1;
                    break;
                case R.id.tmb9:
                    c9 += 1;
                    break;
            }
        }

    }

}
