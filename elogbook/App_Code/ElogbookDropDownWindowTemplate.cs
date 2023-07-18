using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for ElogbookDropDownWindowTemplate
/// </summary>
public class ElogbookDropDownWindowTemplate:ITemplate
{
    private Control listBox;
    public ElogbookDropDownWindowTemplate(Control lstBx)
    {
        listBox = lstBx;
    }

    public void InstantiateIn(Control container)
    {
        //ASPxListBox listBox = new ASPxListBox();
        //listBox.SelectionMode = ListEditSelectionMode.CheckColumn;
        //listBox.FilteringSettings.ShowSearchUI = true;
        //listBox.Width = Unit.Percentage(100);
        //listBox.Height = Unit.Pixel(300);
        ////listBox.EnableSelectAll = true;
        //string[] items = options.Split(';');
        //for(int i=0;i<items.Length;i++)
        //{
        //    listBox.Items.Add(new ListEditItem(items[i].Trim(), i.ToString()));
        //}
        container.Controls.Add(listBox);
    }
}