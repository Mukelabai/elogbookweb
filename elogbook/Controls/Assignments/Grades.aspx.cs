using elogbook.Model;
using System;
using System.Web.Security;
using System.Web.UI;

public partial class Controls_Assignments_Grades : System.Web.UI.Page
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

                bool show = Utility.UserIsAllowedTo("Manage Elogbook Grades", userRights);
                Utility.ShowEditControls(gvGrades, "colCMDGrades", show, show, show);


            }
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }
}