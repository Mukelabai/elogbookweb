using elogbook.Model;
using System;
using System.Web.Security;
using System.Web.UI;


public partial class Controls_Elogbooks_Sections : System.Web.UI.Page
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
                Utility.ShowEditControls(gvElogbookSection, "colCMDSections", show, show, show);


            }
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }


    protected void gvElogbooks_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
    {


        sqlDSElogbookSection.InsertParameters["SectionName"].DefaultValue = Convert.ToString(e.NewValues["SectionName"]);
        sqlDSElogbookSection.InsertParameters["Description"].DefaultValue = Convert.ToString(e.NewValues["Description"]);
        sqlDSElogbookSection.InsertParameters["DisplayOrder"].DefaultValue = Convert.ToString(e.NewValues["DisplayOrder"]);
        sqlDSElogbookSection.InsertParameters["ElogbookId"].DefaultValue = Convert.ToString(e.NewValues["ElogbookId"]);
        sqlDSElogbookSection.InsertParameters["UpdatedBy"].DefaultValue = hfUsername.Value;
        sqlDSElogbookSection.InsertParameters["InstitutionId"].DefaultValue = hfInstitutionId.Value;
        sqlDSElogbookSection.Insert();
        e.Cancel = true;
        gvElogbookSection.CancelEdit();
        gvElogbookSection.DataBind();

    }



    protected void gvElogbooks_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
    {

        sqlDSElogbookSection.UpdateParameters["SectionId"].DefaultValue = Convert.ToString(e.Keys["SectionId"]);
        sqlDSElogbookSection.UpdateParameters["SectionName"].DefaultValue = Convert.ToString(e.NewValues["SectionName"]);
        sqlDSElogbookSection.UpdateParameters["Description"].DefaultValue = Convert.ToString(e.NewValues["Description"]);
        sqlDSElogbookSection.UpdateParameters["DisplayOrder"].DefaultValue = Convert.ToString(e.NewValues["DisplayOrder"]);
        sqlDSElogbookSection.UpdateParameters["ElogbookId"].DefaultValue = Convert.ToString(e.NewValues["ElogbookId"]);
        sqlDSElogbookSection.UpdateParameters["UpdatedBy"].DefaultValue = hfUsername.Value;
        sqlDSElogbookSection.UpdateParameters["InstitutionId"].DefaultValue = hfInstitutionId.Value;
        sqlDSElogbookSection.Update();
        e.Cancel = true;
        gvElogbookSection.CancelEdit();
        gvElogbookSection.DataBind();

    }
}