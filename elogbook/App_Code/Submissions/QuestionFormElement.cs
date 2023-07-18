using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;

/// <summary>
/// Summary description for QuestionFormElement
/// </summary>
public class QuestionFormElement
{
    public QuestionFormElement()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public ElogbookQuestion Question { get; set; }
    public Control QuestionControl { get; set; }
    public ASPxLabel QuestionLabel { get; set; }
    public ASPxRoundPanel SectionPanel { get; set; }
}