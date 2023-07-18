using System;
using System.Web.Security;
using DevExpress.Web;
using elogbook.Model;

    public partial class SignInModule : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
        }

        protected void SignInButton_Click(object sender, EventArgs e) {
            FormLayout.FindItemOrGroupByName("GeneralError").Visible = false;
        if (Membership.ValidateUser(UserNameTextBox.Text, PasswordButtonEdit.Text))
        {
            if (string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]))
            {
                FormsAuthentication.SetAuthCookie(UserNameTextBox.Text, false);
                ASPxPanel headerPanel = (ASPxPanel)this.Master.FindControl("HeaderPanel");
                ASPxMenu mainMenu = (ASPxMenu)headerPanel.FindControl("RightAreaMenu");
                if (mainMenu != null)
                {
                    mainMenu.Items.FindByName("SignInItem").Visible = false;
                    mainMenu.Items.FindByName("RegisterItem").Visible = false;
                    mainMenu.Items.FindByName("MyAccountItem").Visible = true;
                    mainMenu.Items.FindByName("SignOutItem").Visible = true;
                }
                Response.Redirect("~/");
            }
            else
                FormsAuthentication.RedirectFromLoginPage(UserNameTextBox.Text, false);
        }
        else
        {
            UserNameTextBox.ErrorText = "Invalid user";
            UserNameTextBox.IsValid = false;
        }
        //if (ASPxEdit.ValidateEditorsInContainer(this)) {
        //        // DXCOMMENT: You Authentication logic
        //        if(!AuthHelper.SignIn(UserNameTextBox.Text, PasswordButtonEdit.Text)) {
        //            GeneralErrorDiv.InnerText = "Invalid login attempt.";
        //            FormLayout.FindItemOrGroupByName("GeneralError").Visible = true;
        //        }
        //        else
        //            Response.Redirect("~/");
        //    }
        }
    }