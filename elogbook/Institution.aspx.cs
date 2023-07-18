using elogbook.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Institution : System.Web.UI.Page
{
    SecurityController sec = new SecurityController();
    private string userRights;
    protected void Page_Load(object sender, EventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        if ( user== null || Session == null)
        {
            Response.Redirect("~/Account/Signin.aspx");
            return;
        }
        hfRole.Value = System.Web.Security.Roles.GetRolesForUser()[0];
        hfUsername.Value = user.UserName;

        if (!Page.IsPostBack)
        {
            //school admins
            int institutionId = sec.GetUserInstitutionId();
            userRights = sec.GetUserRightsOnly(institutionId, hfRole.Value);
            bool edit = Utility.UserIsAllowedTo("Manage Institution Details", userRights);
            bool show = Utility.UserIsGTSAdmin();
            Utility.ShowEditControls(gvInstitutions, "colCMDInstitution", show, edit, show);
        }
    }
}