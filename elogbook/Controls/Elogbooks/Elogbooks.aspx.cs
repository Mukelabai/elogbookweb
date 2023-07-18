using elogbook.Model;
using System;
using System.Web.Security;
using System.Web.UI;

public partial class Controls_Elogbooks_Elogbooks : System.Web.UI.Page
{
    SecurityController sec = new SecurityController();
    //LogController lc = new LogController();
    private string userRights;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Membership.GetUser() == null || Session == null)
            {
                Response.Redirect("~/Account/Signin.aspx");
                return;
            }
            hfUsername.Value = Membership.GetUser() == null ? null : Membership.GetUser().UserName;
            hfRole.Value = Membership.GetUser() == null ? null : Roles.GetRolesForUser()[0];

            if (!Page.IsPostBack)
            {


                int institutionId = sec.GetUserInstitutionId();
                hfInstitutionId.Value = Convert.ToString(institutionId);
                userRights = sec.GetUserRightsOnly(institutionId, hfRole.Value);

                bool show = Utility.UserIsAllowedTo("Manage Elogbooks", userRights);
                Utility.ShowEditControls(gvElogbooks, "colCMDElogbooks", show, show, show);


            }
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }


    protected void gvElogbooks_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
    {
       

            sqlDSElogbooks.InsertParameters["ElogbookName"].DefaultValue = Convert.ToString(e.NewValues["ElogbookName"]);
            sqlDSElogbooks.InsertParameters["Description"].DefaultValue = Convert.ToString(e.NewValues["Description"]);
            sqlDSElogbooks.InsertParameters["ProgramId"].DefaultValue = Convert.ToString(e.NewValues["ProgramId"]);
            sqlDSElogbooks.InsertParameters["StudyYear"].DefaultValue = Convert.ToString(e.NewValues["StudyYear"]);
            sqlDSElogbooks.InsertParameters["ElogbookName"].DefaultValue = Convert.ToString(e.NewValues["ElogbookName"]);
            sqlDSElogbooks.InsertParameters["Version"].DefaultValue = Convert.ToString(e.NewValues["Version"]);
            sqlDSElogbooks.InsertParameters["UpdatedBy"].DefaultValue = hfUsername.Value;
            sqlDSElogbooks.InsertParameters["InstitutionId"].DefaultValue = hfInstitutionId.Value;
            sqlDSElogbooks.Insert();
            e.Cancel = true;
            gvElogbooks.CancelEdit();
            gvElogbooks.DataBind();
       
    }

    

    protected void gvElogbooks_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
    {
       
            sqlDSElogbooks.UpdateParameters["ElogbookId"].DefaultValue = Convert.ToString(e.Keys["ElogbookId"]);
            sqlDSElogbooks.UpdateParameters["ElogbookName"].DefaultValue = Convert.ToString(e.NewValues["ElogbookName"]);
            sqlDSElogbooks.UpdateParameters["Description"].DefaultValue = Convert.ToString(e.NewValues["Description"]);
            sqlDSElogbooks.UpdateParameters["ProgramId"].DefaultValue = Convert.ToString(e.NewValues["ProgramId"]);
            sqlDSElogbooks.UpdateParameters["StudyYear"].DefaultValue = Convert.ToString(e.NewValues["StudyYear"]);
            sqlDSElogbooks.UpdateParameters["ElogbookName"].DefaultValue = Convert.ToString(e.NewValues["ElogbookName"]);
            sqlDSElogbooks.UpdateParameters["Version"].DefaultValue = Convert.ToString(e.NewValues["Version"]);
            sqlDSElogbooks.UpdateParameters["UpdatedBy"].DefaultValue = hfUsername.Value;
            sqlDSElogbooks.UpdateParameters["InstitutionId"].DefaultValue = hfInstitutionId.Value;
            sqlDSElogbooks.Update();
            e.Cancel = true;
            gvElogbooks.CancelEdit();
            gvElogbooks.DataBind();
      
    }

    
}