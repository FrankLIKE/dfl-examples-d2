// To compile:
// 	dfl -gui listviewdirsort

/*
	Generated by Entice Designer
	Entice Designer written by Christopher E. Miller
	www.dprogramming.com/entice.php
*/

private import dfl.all;

import std.conv, std.file;


class ListViewDirSort: dfl.form.Form
{
	// Do not modify or move this block of variables.
	//~Entice Designer variables begin here.
	dfl.listview.ListView dirlist;
	//~Entice Designer variables end here.
	
	
	this()
	{
		initializeListViewDirSort();
		
		dirlist.sorter = &filenamesorter;
		
		dirlist.columnClick ~= &dirlist_columnClick;
		
		ColumnHeader ch;
		
		ch = new ColumnHeader();
		ch.text = "Name";
		ch.width = 200;
		dirlist.columns.add(ch);
		
		ch = new ColumnHeader();
		ch.text = "Size";
		ch.width = 60;
		dirlist.columns.add(ch);
		
/++
		listdir(".",
			(DirEntry* de)
			{
				string s = de.name;
				if(s.length >= 2 && s[0 .. 2] == ".\\")
					s = s[2 .. s.length];
				dirlist.addRow(s, std.conv.to!string(de.size));
				return true; // Continue.
			});
++/
			foreach (DirEntry e; dirEntries(".", SpanMode.breadth)) {
				string s = e.name;
				if (s.length >= 2 && s[0 .. 2] == ".\\")
					s = s[2 .. s.length];
				
				dirlist.addRow(s, std.conv.to!string(e.size));
			}
	}
	
	
	private void dirlist_columnClick(ListView sender, ColumnClickEventArgs ea)
	{
		switch(ea.column)
		{
			case 0: // File name.
				dirlist.sorter = &filenamesorter;
				break;
			
			case 1: // File size.
				dirlist.sorter = &filesizesorter;
				break;
			
			default:
				assert(0);
		}
	}
	
	
	private int filenamesorter(ListViewItem a, ListViewItem b)
	{
		return a.opCmp(b);
	}
	
	
	private int filesizesorter(ListViewItem a, ListViewItem b)
	{
		return std.conv.to!int(a.subItems[0].toString()) - std.conv.to!int(b.subItems[0].toString());
	}
	
	
	private void initializeListViewDirSort()
	{
		// Do not manually modify this function.
		//~Entice Designer 0.8.2.1 code begins here.
		//~DFL Form
		text = "Current Directory";
		clientSize = dfl.drawing.Size(292, 273);
		//~DFL dfl.listview.ListView=dirlist
		dirlist = new dfl.listview.ListView();
		dirlist.name = "dirlist";
		dirlist.dock = dfl.control.DockStyle.FILL;
		dirlist.view = dfl.base.View.DETAILS;
		dirlist.bounds = dfl.drawing.Rect(0, 0, 292, 273);
		dirlist.parent = this;
		//~Entice Designer 0.8.2.1 code ends here.
	}
}


int main()
{
	int result = 0;
	
	try
	{
		// Application initialization code here.
		
		Application.run(new ListViewDirSort());
	}
	catch(DflThrowable o)
	{
		msgBox(o.toString(), "Fatal Error", MsgBoxButtons.OK, MsgBoxIcon.ERROR);
		
		result = 1;
	}
	
	return result;
}

