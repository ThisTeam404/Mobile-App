package com.mycompany.a190;

import com.codename1.ui.Command;
import com.codename1.ui.Dialog;
import com.codename1.ui.TextField;
import com.codename1.ui.events.ActionEvent;

public class ConfirmCommand extends Command{
	public ConfirmCommand()
	{
		super("Confirm");
	}
	public void actionPerformed(ActionEvent ev) {
		Command cYes = new Command("Yes");
		Command cNo = new Command("No");
		Command cOk = new Command("OK");
		Command[] cmds = new Command[] {cYes, cNo};
		TextField myTf = new TextField();
		Command c = Dialog.show("Confirmation", "Do you want to save the job information to the Add Lock page?", cmds);
		if(c == cYes)
		{
			Dialog.show("Confirmation", "Job information has been added to the Add Lock page.", cOk);
			
		}
	}
}
