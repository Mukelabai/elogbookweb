using elogbook.Model;
using System;
using System.Collections.Generic;
using System.Web.Security;
using System.Web.UI;

public partial class Users : System.Web.UI.Page
{
    SecurityController sec = new SecurityController();
    string userRights;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (Membership.GetUser() == null || Session == null)
            {
                Response.Redirect("~/Account/Signin.aspx");
                return;
            }


            if (!Page.IsPostBack)
            {
                hfRole.Value = Roles.GetRolesForUser()[0];
                hfUsername.Value = Membership.GetUser().UserName;
                int institutionId = sec.GetUserInstitutionId();
                hfInstitutionId.Value = Convert.ToString(institutionId);
                userRights = sec.GetUserRightsOnly(institutionId, hfRole.Value);
               
                if (!Utility.UserIsAllowedTo("Manage Users", userRights))
                {
                    Response.Redirect("~/Account/Login.aspx");
                    return;
                }
                btnDeleteUser.Attributes.Add("onClick", "javascript:return confirm('Are you sure you want to delete the selected user?');");
                btnResetPassword.Attributes.Add("onClick", "javascript:return confirm('Are you sure you want to reset password for the selected user?');");

               
            }

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }
    protected void btnDeleteUser_Click(object sender, EventArgs e)
    {
        try
        {
            if (gvUsers.Selection.Count <= 0)
            {
                throw new Exception("Select user to delete");
            }
            int count = 0;
            List<object> userNames = gvUsers.GetSelectedFieldValues("UserName");
            foreach (object userName in userNames)
            {

                if (Membership.DeleteUser(userName.ToString()))
                {

                    count++;
                    //lc.LogRequest(string.Format("Delete user  {0}", userName.ToString()), true);
                }
            }
            if (userNames.Count == count)
            {
                Utility.DisplayInfoMessage("Seleted users have been deleted", lblMessage);
            }
            else
            {
                Utility.DisplayErrorMessage(string.Format("{0}/{1} users deleted", count, userNames.Count), lblMessage);

            }
            gvUsers.DataBind();

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }


    protected void gvUsers_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
    {
        try
        {
            string userName = Convert.ToString(e.NewValues["UserName"]);
            string email = Convert.ToString(e.NewValues["Email"]);
            string password = Convert.ToString(e.NewValues["Password"]);
            bool isApproved = Convert.ToBoolean(e.NewValues["IsApproved"]);
            bool isLockedOut = Convert.ToBoolean(e.NewValues["IsLockedOut"]);
            bool resetPassword = Convert.ToBoolean(e.NewValues["ResetPassword"]);
            string roleName = Convert.ToString(e.NewValues["RoleName"]);
            int institutionId = sec.GetUserInstitutionId();

            MembershipUser user = Membership.GetUser(userName);
            if (user == null)
            {
                user = Membership.CreateUser(userName, password, email);
                user.IsApproved = isApproved;
                //lc.LogRequest(string.Format("Register user {0}", userName), true);
                if (isLockedOut)
                {
                    user.UnlockUser();
                }

                Membership.UpdateUser(user);
                //assign role
                if (!Roles.IsUserInRole(userName, roleName))
                {
                    Roles.AddUserToRole(userName, roleName);
                    //lc.LogRequest(string.Format("Assign {0} role to {1}", roleName, userName), true);
                }
                sec.AddUserInstitution(user.UserName, institutionId);
            }
            gvUsers.DataBind();
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void gvUsers_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
    {
        try
        {
            string userName = Convert.ToString(e.NewValues["UserName"]);
            string email = Convert.ToString(e.NewValues["Email"]);
            string password = Convert.ToString(e.NewValues["Password"]);
            bool isApproved = Convert.ToBoolean(e.NewValues["IsApproved"]);
            bool isLockedOut = Convert.ToBoolean(e.NewValues["IsLockedOut"]);
            bool resetPassword = Convert.ToBoolean(e.NewValues["ResetPassword"]);
            string roleName = Convert.ToString(e.NewValues["RoleName"]);
            int institutionId = Convert.ToInt32(e.NewValues["InstitutionId"]);
            string newPassword = null;
            MembershipUser user = Membership.GetUser(userName);
            if (user != null)
            {
                //lc.LogRequest(string.Format("{0} user {1}", isApproved ? "Approving" : "Invalidating", userName), true);
                user.IsApproved = isApproved;
                if (isLockedOut)
                {
                    user.UnlockUser();
                    //lc.LogRequest(string.Format("Unlock user {0}", userName), true);
                }
                //if (resetPassword)
                //{
                //    newPassword = user.ResetPassword();
                //    Utility.DisplayInfoMessage(string.Format("The user's new password is <b>{0}</b>", newPassword), lblMessage3);
                //    throw new Exception(string.Format("The user's new password is <b>{0}</b>", newPassword));
                //    //gvUsers.e
                //}
                Membership.UpdateUser(user);

                //update roles
                //first remove old ones
                string[] roles = Roles.GetRolesForUser(userName);
                Roles.RemoveUserFromRoles(userName, roles);
                //now add new role
                Roles.AddUserToRole(userName, roleName);
                sec.AddUserInstitution(user.UserName, institutionId);
            }
            gvUsers.DataBind();
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }



    protected void btnResetUserPassword_Click(object sender, EventArgs e)
    {
        try
        {
            lblMessage.Text = string.Empty;
            if (gvUsers.Selection.Count <= 0)
            {
                throw new Exception("Select user whose password you want to reset.");
            }
            string newPassword = null;
            MembershipUser user = Membership.GetUser(Convert.ToString(gvUsers.GetSelectedFieldValues("UserName")[0]));
            if (user != null)
            {

                newPassword = user.ResetPassword();
                Utility.DisplayInfoMessage(string.Format("The user's new password is {0}", newPassword), lblMessage);
                //lc.LogRequest(string.Format("Reset password for user {0}", user.UserName), true);

                Membership.UpdateUser(user);
            }
            gvUsers.DataBind();
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }


    protected void btnUnlockUser_Click(object sender, EventArgs e)
    {
        try
        {
            if (gvUsers.Selection.Count <= 0)
            {
                throw new Exception("Select user to unlock");
            }
            string userName = Convert.ToString(gvUsers.GetSelectedFieldValues("UserName")[0]);
            MembershipUser user = Membership.GetUser(userName);
            if (user != null)
            {
                if (user.IsLockedOut)
                {
                    user.UnlockUser();
                    Membership.UpdateUser(user);
                }
            }
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

}