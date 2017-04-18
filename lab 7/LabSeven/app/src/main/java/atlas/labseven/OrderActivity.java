package atlas.labseven;

import android.app.ActionBar;
import android.app.Activity;
import android.os.Bundle;
import android.webkit.WebView;

public class OrderActivity extends Activity {

    private WebView webview;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_order);

        ActionBar actionBar = getActionBar();
        actionBar.setDisplayHomeAsUpEnabled(true);

        webview = (WebView) findViewById(R.id.webView);
        webview.getSettings().getJavaScriptEnabled();
        webview.loadUrl("http://classic.motown.com/");
        /*
        webview  = new WebView(this);
        webview.getSettings().setJavaScriptEnabled(true); // enable javascript
        final Activity activity = this;
        webview.setWebViewClient(new WebViewClient() {
            public void onReceivedError(WebView view, int errorCode, String description, String failingUrl) {
                Toast.makeText(activity, description, Toast.LENGTH_SHORT).show();
            }
        });
        webview.loadUrl("http://classic.motown.com/");
        setContentView(webview);
*/
    }
}
