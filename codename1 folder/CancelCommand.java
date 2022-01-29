package com.mycompany.a190;

import com.codename1.ui.Command;
import com.codename1.ui.Dialog;
import com.codename1.ui.TextField;
import com.codename1.ui.events.ActionEvent;

public class CancelCommand extends Command{
	private Information info;
	public CancelCommand(Information i)
	{
		super("Cancel");
		info = i;
	}
	public void actionPerformed(ActionEvent ev)
	{
		Command cYes = new Command("Yes");
		Command cNo = new Command("No");
		Command cOk = new Command("OK");
		Command[] cmds = new Command[] {cYes, cNo};
		TextField myTf = new TextField();
		Command c = Dialog.show("Cancel?", "Do you want to delete your job information?", cmds);
		if(c == cYes)
		{
			Dialog.show("Confirmation", "Job information has been deleted.", cOk);
			info.disableNumberButtons();
			info.enableKW1andSK1();
			info.deselectMasterkey();
			
		}
	}
}
