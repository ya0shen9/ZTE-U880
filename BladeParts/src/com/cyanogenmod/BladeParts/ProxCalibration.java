package com.cyanogenmod.BladeParts;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;
import android.os.Handler;
import android.os.Message;

public class ProxCalibration extends Activity {
	final private static String TAG = "ProxCal";
	Thread	 thread;
	Toast toast;
	
	private Handler mHandler = new Handler(){
		@Override
		public void handleMessage(Message msg) {
			super.handleMessage(msg);

			Bundle b = msg.getData();
			int index = b.getInt("index");
			switch(index){
				case 0://error
					String errorInfo = b.getString("errinfo");
					toast = Toast.makeText(ProxCalibration.this,
							getString(R.string.toast_error) + " " +errorInfo ,
							Toast.LENGTH_LONG);
					toast.show();
					break;
				case 1://ok
					String Calibration_value = b.getString("Calibration");			
					toast = Toast.makeText(ProxCalibration.this, getString(R.string.prox_calibration_sucess),
					Toast.LENGTH_LONG);
					toast.show();					
					break;
			}
			BladeParts.BladePartsHandler.sendEmptyMessage(1);			        			
		}
	};
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		thread = new Thread(){
			public void run(){
				Message msg = new Message();
				Bundle b = new Bundle();
				try {
					Process p;
					//p= Runtime.getRuntime().exec("mount -o remount rw /system");
					//p = Runtime.getRuntime().exec("su");
					//p = Runtime.getRuntime().exec("chmod 755 /system/etc/init.d/52sensor");
					p = Runtime.getRuntime().exec("/system/bin/52sensor");	
					//Runtime.getRuntime().exec("mount -o remount ro /system");
					BufferedReader commandResult = new BufferedReader(
					new InputStreamReader(new BufferedInputStream(
							p.getInputStream())));
					p.waitFor();
					String returned = commandResult.readLine();
					
				         b.putString("Calibration", returned);
					b.putInt("index",1);
				         msg.setData(b);
						 
					mHandler.sendMessage(msg);

				} catch (Exception ex) {
					b.putString("errinfo",ex.getMessage());
					b.putInt("index",0);
					msg.setData(b);
					mHandler.sendMessage(msg);
				}					
			
			};				
		};
 		thread.start();





		finish();

	}

}
