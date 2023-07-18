using System;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using DevExpress.Web;
using System.Web.Security;
using System.Web;

public partial class Root : MasterPage
{
    public bool EnableBackButton { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Page.Header.Title))
            Page.Header.Title += " - ";
        Page.Header.Title = Page.Header.Title;// + "ASP.NET WebForms/MVC Responsive Web Application Template | DevExpress";

        Page.Header.DataBind();
        UpdateUserMenuItemsVisible();
        HideUnusedContent();
        UpdateUserInfo();


        if (!Page.IsPostBack)
        {
            //load institution details
            lblCopyright.Text = DateTime.Now.Year + Server.HtmlDecode(string.Format(" &copy; {0}", "Elogbook"));
            if (ApplicationMenu.Items.Count > 0)
            {
                ApplicationMenu.Items.FindByText("Faculty").Visible = Roles.IsUserInRole("System Admin");
            }
        }
    }

    protected void HideMenuItems(MenuItem item)
    {
        //admin items
        if (item.Text == "Faculty" || item.Text == "Students" || item.Text == "Elogbooks" || item.Text == "Grades" || item.Text == "Admin" || item.Text == "Assignments")
        {
            item.Visible = Roles.IsUserInRole("System Admin");
        }
        if (item.Text == "My Pages")
        {
            item.Visible = Roles.IsUserInRole("Student");
        }
        if (item.Text == "Assignments" || item.Text == "Reports")
        {
            item.Visible = Roles.IsUserInRole("Staff") || Roles.IsUserInRole("Lecturer") || Roles.IsUserInRole("System Admin");
        }
        if (item.Text == "Home")
        {
            item.Visible = Membership.GetUser() != null && Session != null;
        }
        if (item.Text == "Build Achievements Retroactively")
        {
            item.Visible =  Roles.IsUserInRole("System Admin");
        }
    }

    protected void HideUnusedContent()
    {
        LeftAreaMenu.Items[1].Visible = EnableBackButton;

        bool hasLeftPanelContent = HasContent(LeftPanelContent);
        LeftAreaMenu.Items.FindByName("ToggleLeftPanel").Visible = hasLeftPanelContent;
        LeftPanel.Visible = hasLeftPanelContent;

        bool hasRightPanelContent = HasContent(RightPanelContent);
        RightAreaMenu.Items.FindByName("ToggleRightPanel").Visible = hasRightPanelContent;
        RightPanel.Visible = hasRightPanelContent;

        bool hasPageToolbar = HasContent(PageToolbar);
        PageToolbarPanel.Visible = hasPageToolbar;
    }

    protected bool HasContent(Control contentPlaceHolder)
    {
        if (contentPlaceHolder == null) return false;

        ControlCollection childControls = contentPlaceHolder.Controls;
        if (childControls.Count == 0) return false;

        return true;
    }

    // SignIn/Register

    protected void UpdateUserMenuItemsVisible()
    {
        var isAuthenticated = Membership.GetUser() != null && Session != null; //AuthHelper.IsAuthenticated();
        RightAreaMenu.Items.FindByName("SignInItem").Visible = !isAuthenticated;
        //RightAreaMenu.Items.FindByName("RegisterItem").Visible = !isAuthenticated;
        RightAreaMenu.Items.FindByName("MyAccountItem").Visible = isAuthenticated;
        RightAreaMenu.Items.FindByName("SignOutItem").Visible = isAuthenticated;
    }

    protected void UpdateUserInfo()
    {
        MembershipUser user = Membership.GetUser();
        if (user != null && Session != null)
        {
            //var user = AuthHelper.GetLoggedInUserInfo();
            var myAccountItem = RightAreaMenu.Items.FindByName("MyAccountItem");
            var userName = (ASPxLabel)myAccountItem.FindControl("UserNameLabel");
            var email = (ASPxLabel)myAccountItem.FindControl("EmailLabel");
            var accountImage = (HtmlGenericControl)RightAreaMenu.Items[0].FindControl("AccountImage");
            userName.Text = user.UserName;// string.Format("{0} ({1} {2})", user.UserName, user.FirstName, user.LastName);
            email.Text = user.Email;
            accountImage.Attributes["class"] = "account-image";

            //set default avartar
            var avatarUrl = (HtmlImage)myAccountItem.FindControl("AvatarUrl");
            avatarUrl.Attributes["src"] = "Content/Images/user.svg";
            accountImage.Style["background-image"] = "Content/Images/user.svg";

            //if(string.IsNullOrEmpty(user.AvatarUrl)) {
            //accountImage.InnerHtml = user.UserName.ToUpper();// string.Format("{0}{1}", user.FirstName[0], user.LastName[0]).ToUpper();
            //} else {
            //    var avatarUrl = (HtmlImage)myAccountItem.FindControl("AvatarUrl");
            //    avatarUrl.Attributes["src"] = ResolveUrl(user.AvatarUrl);
            //    accountImage.Style["background-image"] = ResolveUrl(user.AvatarUrl);                    
            //}
        }
    }

    protected void RightAreaMenu_ItemClick(object source, DevExpress.Web.MenuItemEventArgs e)
    {
        if (e.Item.Name == "SignOutItem")
        {
            HttpContext.Current.Session.Abandon();
            FormsAuthentication.SignOut();
            HttpContext.Current.Response.Redirect("~/Account/Signin.aspx");
            //AuthHelper.SignOut(); // DXCOMMENT: Your Signing out logic
            //Response.Redirect("~/");
        }
    }

    protected void ApplicationMenu_ItemDataBound(object source, MenuItemEventArgs e)
    {
        e.Item.Image.Url = string.Format("Content/Images/{0}.svg", e.Item.Text);
        e.Item.Image.UrlSelected = string.Format("Content/Images/{0}-white.svg", e.Item.Text);
        HideMenuItems(e.Item);
    }
}