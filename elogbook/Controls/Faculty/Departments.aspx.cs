using elogbook.Model;
using System;
using System.Web.Security;
using System.Web.UI;

public partial class Controls_Faculty_Departments : System.Web.UI.Page
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
                
                bool show = Utility.UserIsAllowedTo("Manage Departments", userRights);
                Utility.ShowEditControls(gvDepartments, "colCMDDepartments", show, show, show);
                           }
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }
}