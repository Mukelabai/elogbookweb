using elogbook.Model;
using System;
using System.Web.Security;
using System.Web.UI;

public partial class Controls_Faculty_Centres : System.Web.UI.Page
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
                
                bool show = Utility.UserIsAllowedTo("Manage Schools", userRights);
                Utility.ShowEditControls(gvCentres, "colCMDCentres", show, show, show);


            }
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    
    protected void gvCentres_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
    {
        

            sqlDSCentres.InsertParameters["CentreName"].DefaultValue = Convert.ToString(e.NewValues["CentreName"]);
            sqlDSCentres.InsertParameters["ProvinceId"].DefaultValue = Convert.ToString(e.NewValues["ProvinceId"]);
            sqlDSCentres.InsertParameters["InstitutionId"].DefaultValue = hfInstitutionId.Value;
            sqlDSCentres.Insert();
            e.Cancel = true;
            gvCentres.CancelEdit();
            gvCentres.DataBind();
       
    }

    protected void gvCentres_RowInserted(object sender, DevExpress.Web.Data.ASPxDataInsertedEventArgs e)
    {
        try
        {
           // lc.LogRequest(string.Format("Add centre {0}", Convert.ToString(e.NewValues["CentreName"])), e.AffectedRecords > 0);
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void gvCentres_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
    {
       
            sqlDSCentres.UpdateParameters["CentreId"].DefaultValue = Convert.ToString(e.Keys["CentreId"]);
            sqlDSCentres.UpdateParameters["CentreName"].DefaultValue = Convert.ToString(e.NewValues["CentreName"]);
            sqlDSCentres.UpdateParameters["ProvinceId"].DefaultValue = Convert.ToString(e.NewValues["ProvinceId"]);
            sqlDSCentres.UpdateParameters["InstitutionId"].DefaultValue = hfInstitutionId.Value;
            sqlDSCentres.Update();
            e.Cancel = true;
            gvCentres.CancelEdit();
            gvCentres.DataBind();
      
    }

    protected void gvCentres_RowDeleted(object sender, DevExpress.Web.Data.ASPxDataDeletedEventArgs e)
    {
        try
        {
            //lc.LogRequest(string.Format("Delete centre {0}", Convert.ToString(e.Values["CentreName"])), e.AffectedRecords > 0);
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

}