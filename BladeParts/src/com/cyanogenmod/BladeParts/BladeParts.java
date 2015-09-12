package com.cyanogenmod.BladeParts;

import com.cyanogenmod.BladeParts.R;

import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceActivity;
import android.preference.PreferenceManager;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import android.preference.Preference;
import android.util.Log;
import android.os.Handler;
import android.os.Message;
import android.preference.PreferenceScreen;

public class BladeParts extends PreferenceActivity {

         private static Preference mPref;
	public static Handler BladePartsHandler = new Handler(){
		@Override
		public void handleMessage(Message msg) {
			super.handleMessage(msg);

			Log.e("tag", "BladePartsHandler");
			mPref.setEnabled(true);
		}
	};
		 
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		addPreferencesFromResource(R.xml.bladeparts);
		mPref = (Preference) findPreference("prox_calibration");
		mPref.setEnabled(true);
	}

   private void writeValue(String parameter, int value) {
      try {
          FileOutputStream fos = new FileOutputStream(new File(parameter));
          fos.write(String.valueOf(value).getBytes());
          fos.flush();
          fos.getFD().sync();
          fos.close();
      } catch (FileNotFoundException e) {
         e.printStackTrace();
      } catch (IOException e) {
         e.printStackTrace();
      }
   }

   @Override
   public void onPause() {
      super.onPause();

   }

   /*
   @Override 	
   public void onWindowFocusChanged(boolean hasFocus) 
{ 		
	Log.e("tag", "hasFocus"+hasFocus);	
	mPref.setEnabled(hasFocus);
	super.onWindowFocusChanged(hasFocus); 	
}
*/

  public boolean onPreferenceTreeClick(PreferenceScreen paramPreferenceScreen, Preference paramPreference)
  {
    if (paramPreference.getKey().equals("prox_calibration"))
    {
      paramPreference.setEnabled(false);
    }
    return super.onPreferenceTreeClick(paramPreferenceScreen, paramPreference);
  }
  
}