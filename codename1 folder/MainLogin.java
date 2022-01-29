package com.mycompany.pageApp;

import com.codename1.ui.Command;
import com.codename1.ui.Dialog;
import com.codename1.ui.Display;
//import com.codename1.ui.Display;
import com.codename1.ui.Form;
import com.codename1.ui.Label;
import com.codename1.ui.TextField;
import com.codename1.ui.layouts.BoxLayout;

public class MainLogin extends Form{
	public MainLogin() {
		Command cOk = new Command("OK");
		Command bOk = new Command("Exit");
		Command[] cmds = new Command[] {cOk, bOk};
		TextField myTF = new TextField();
		TextField myTF2 = new TextField();
		Command c = Dialog.show("Enter Username: ", myTF, cmds);
		String username = myTF.getText().toString();		
		if(c == cOk) 
		{
			Command c2 = Dialog.show("Enter Password: ", myTF2, cmds);
			String password = myTF2.getText().toString();
			if(username.equals("username") && password.equals("password"))
			{
				Dialog.show("Welcome", "Login Successful", cOk);
				new Information();
				//Display.getInstance().exitApplication();
			}
			else
			{
				Dialog.show("Error", "Login Unsuccessful.\n Please Try Again", cOk);
				Display.getInstance().exitApplication();
			}
		}
     }
}
