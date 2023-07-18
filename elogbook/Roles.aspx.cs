using elogbook.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RolesElog : System.Web.UI.Page
{
    SecurityController sec = new SecurityController();
    private string userRights;
    protected void Page_Load(object sender, EventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        if (user == null || Session == null)
        {
            Response.Redirect("~/Account/Signin.aspx");
            return;
        }
        hfRole.Value = System.Web.Security.Roles.GetRolesForUser()[0];
        hfUsername.Value = user.UserName;
        if (!Page.IsPostBack)
        {
            int institutionId = sec.GetUserInstitutionId();
            hfInstitutionId.Value = Convert.ToString(institutionId);
            userRights = sec.GetUserRightsOnly(institutionId, hfRole.Value);
            
            if (!Utility.UserIsAllowedTo("Manage Roles", userRights))
            {
                Response.Redirect("~/Account/Login.aspx");
                return;
            }
            gvRoles.Columns["InstitutionName"].Visible = Utility.UserIsGTSAdmin();

            if (!System.Web.Security.Roles.IsUserInRole("GTSAdmin"))
            {
                ddlInstitutions.DataBind();
                ddlInstitutions.SelectedIndex = 0;
            }
            btnDeleteRole0.Attributes.Add("onClick", "javascript:return confirm('Are you sure you want to delete the selected role?');");

        }
    }

    protected void btnDeleteRole_Click(object sender, EventArgs e)
    {
        try
        {
            if (gvRoles.Selection.Count <= 0)
            {
                throw new Exception("Select role to delete");
            }
            int count = 0;
            List<object> roleNames = gvRoles.GetSelectedFieldValues("RoleName");
            foreach (object roleName in roleNames)
            {

                if (System.Web.Security.Roles.RoleExists(roleName.ToString()))
                {
                    System.Web.Security.Roles.DeleteRole(roleName.ToString());
                    count++;
                    //lc.LogRequest(string.Format("Delete user Role {0}", roleName), true);
                }
            }
            if (roleNames.Count == count)
            {
                Utility.DisplayInfoMessage("Seleted roles have been deleted", lblMessage);
            }
            else
            {
                Utility.DisplayErrorMessage(string.Format("{0}/{1} roles deleted", count, roleNames.Count), lblMessage);

            }
            gvRoles.DataBind();

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }
    protected void btnUpdateRights_Click(object sender, EventArgs e)
    {
        try
        {
            if (gvRoles.Selection.Count <= 0)
            {
                throw new Exception("Select role to update");
            }
            ddlRoles.Text = Convert.ToString(gvRoles.GetSelectedFieldValues("RoleName")[0]);
            //get rirhgts for role
            string rights = Convert.ToString(gvRoles.GetSelectedFieldValues("RoleRights")[0]); //sec.GetRoleRights(ddlRoles.Text);
            ddlRoles.ReadOnly = true;
            Utility.FillChecklistFromString(rights, chkRights);
            btnSaveRoleName0.Text = "Update";
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        try
        {
            ddlRoles.Value = null;
            ddlRoles.Text = string.Empty;
            chkRights.UnselectAll();
            ddlRoles.ReadOnly = false;
            btnSaveRoleName0.Text = "Save";

        }
        catch (Exception ex)
        {
            GeneralErrorDiv.InnerText = ex.Message;
            FormLayout.FindItemOrGroupByName("GeneralError").Visible = true;
            //Utility.DisplayErrorMessage(ex, lblMessage2);
        }
    }
    protected void btnSaveRoleName_Click(object sender, EventArgs e)
    {
        try
        {
            string userName = Membership.GetUser() != null ? Membership.GetUser().UserName : "Annoymous";

            string roleName = ddlRoles.Text.Trim();
            if (string.IsNullOrWhiteSpace(roleName))
            {
                throw new Exception("Specify role name");
            }

            if (!System.Web.Security.Roles.RoleExists(roleName))
            {

                System.Web.Security.Roles.CreateRole(roleName);
                sec.UpdateInstitutionRoles(roleName, Convert.ToInt32(ddlInstitutions.Value), Utility.GetSelectedItemValues(chkRights));

                //lc.AddLog(userName, System.Web.Security.Roles.GetRolesForUser()[0], string.Format("Create user Role {0}, institution", roleName, ddlInstitutions.SelectedItem.Text), true, Convert.ToInt32(ddlInstitutions.Value));

                Utility.DisplayInfoMessage(string.Format("{0} role saved", roleName), lblMessage2);
            }
            else
            {
                sec.UpdateInstitutionRoles(roleName, Convert.ToInt32(ddlInstitutions.Value), Utility.GetSelectedItemValues(chkRights));

                //lc.AddLog(userName, System.Web.Security.Roles.GetRolesForUser()[0], string.Format("Update rights for Role {0}, institution", roleName, ddlInstitutions.SelectedItem.Text), true, Convert.ToInt32(ddlInstitutions.Value));

                Utility.DisplayInfoMessage(string.Format("Rights for {0} role saved", roleName), lblMessage2);

            }
            gvRoles.DataBind();
            ddlRoles.DataBind();

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage2);
        }
    }
}