using DevExpress.Web;
using elogbook.Model;
using System;
using System.Web.Security;
using System.Web.UI;

public partial class Controls_Faculty_Schools : System.Web.UI.Page
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
                userRights = sec.GetUserRightsOnly(institutionId, hfRole.Value);
                

                bool show = Utility.UserIsAllowedTo("Manage Schools", userRights);
                Utility.ShowEditControls(gvSchools, "colCMDSchools", show, show, show);

               
            }
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void gvSchools_CustomUnboundColumnData(object sender, ASPxGridViewColumnDataEventArgs e)
    {
        try
        {
            if (e.Column.FieldName == "SchoolsNo")
            {
                e.Value = string.Format("{0}", e.ListSourceRowIndex + 1);
            }
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }
    #region Schools Log
    protected void gvSchools_RowDeleted(object sender, DevExpress.Web.Data.ASPxDataDeletedEventArgs e)
    {
        try
        {
            //lc.LogRequest(string.Format("Delete School {0}", e.Values["SchoolName"].ToString()), e.AffectedRecords > 0);

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void gvSchools_RowInserted(object sender, DevExpress.Web.Data.ASPxDataInsertedEventArgs e)
    {
        
            //lc.LogRequest(string.Format("Add School {0}", e.NewValues["SchoolName"].ToString()), e.AffectedRecords > 0);

        
    }

    protected void gvSchools_RowUpdated(object sender, DevExpress.Web.Data.ASPxDataUpdatedEventArgs e)
    {
        try
        {
            //lc.LogRequest(string.Format("Update School {0}", e.OldValues["SchoolName"].ToString()), e.AffectedRecords > 0);

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }
    #endregion
    protected void gvSchools_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
    {
        
            //lblMessage.Text = Convert.ToString(e.NewValues["StartTime"]) + " " + Convert.ToString(e.NewValues["EndTime"]);
            sqlDSSchools.InsertParameters["SchoolName"].DefaultValue = Convert.ToString(e.NewValues["SchoolName"]);
            sqlDSSchools.InsertParameters["SchoolCode"].DefaultValue = Convert.ToString(e.NewValues["SchoolCode"]);

            sqlDSSchools.InsertParameters["InstitutionId"].DefaultValue = Convert.ToString(sec.GetUserInstitutionId(Membership.GetUser().UserName));
            sqlDSSchools.Insert();
            e.Cancel = true;
            gvSchools.CancelEdit();
            gvSchools.DataBind();
      
    }

    protected void gvSchools_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
    {
        
            sqlDSSchools.UpdateParameters["SchoolId"].DefaultValue = Convert.ToString(e.Keys["SchoolId"]);
            sqlDSSchools.UpdateParameters["SchoolName"].DefaultValue = Convert.ToString(e.NewValues["SchoolName"]);
            sqlDSSchools.UpdateParameters["SchoolCode"].DefaultValue = Convert.ToString(e.NewValues["SchoolCode"]);
            sqlDSSchools.UpdateParameters["InstitutionId"].DefaultValue = Convert.ToString(sec.GetUserInstitutionId(Membership.GetUser().UserName));
            sqlDSSchools.Update();
            e.Cancel = true;
            gvSchools.CancelEdit();
            gvSchools.DataBind();
       
    }
}