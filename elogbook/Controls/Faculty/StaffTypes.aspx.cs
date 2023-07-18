using DevExpress.Web;
using elogbook.Model;
using System;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_Faculty_StaffTypes : System.Web.UI.Page
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
                Response.Redirect("~/Account/Signin.aspx?ReturnUrl=~/Controls/Faculty/StaffTypes.aspx");
                return;
            }

            if (!Page.IsPostBack)
            {
                hfUsername.Value = Membership.GetUser() == null ? null : Membership.GetUser().UserName;
                hfRole.Value = Membership.GetUser() == null ? null : Roles.GetRolesForUser()[0];
                int institutionId = sec.GetUserInstitutionId();
                hfInstitutionId.Value = Convert.ToString(institutionId);
                userRights = sec.GetUserRightsOnly(institutionId, hfRole.Value);

                bool show = Utility.UserIsAllowedTo("Manage Staff", userRights);
                bool delete = Utility.UserIsGTSAdmin(); ;
                
                Utility.ShowEditControls(gvStaffTypes, "colCMDStaffTypes", show, show, delete);
                Utility.ShowEditControls(gvStaffStatus, "colCMDStaffStatuses", show, show, delete);
                Utility.ShowEditControls(gvStaffTitles, "colCMDStaffTitles", show, show, delete);





            }
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    #region Staff Log
    protected void gvStaff_RowInserted(object sender, DevExpress.Web.Data.ASPxDataInsertedEventArgs e)
    {

        string StaffNumber = Convert.ToString(e.NewValues["StaffNumber"]);
        string FirstName = Convert.ToString(e.NewValues["FirstName"]);
        string LastName = Convert.ToString(e.NewValues["LastName"]);
        string EmailAddress = Convert.ToString(e.NewValues["EmailAddress"]);
        string SystemRole = Convert.ToString(e.NewValues["RoleName"]);
        //lc.LogRequest(string.Format("Add Staff-{0} {1}, Staff Number {2}", FirstName, LastName, StaffNumber), e.AffectedRecords > 0);

        if (e.AffectedRecords > 0)
        {

            AddStaffAsUser(StaffNumber, EmailAddress, SystemRole, null);
        }


    }
    protected void gvStaff_RowDeleted(object sender, DevExpress.Web.Data.ASPxDataDeletedEventArgs e)
    {


        //lc.LogRequest(string.Format("Delete Staff {0} {1}", e.Values["FirstName"].ToString(), e.Values["LastName"].ToString()), e.AffectedRecords > 0);

        if (e.AffectedRecords > 0)
        {
            int institutionId = sec.GetUserInstitutionId(Membership.GetUser().UserName);
            string StaffNumber = Convert.ToString(e.Values["StaffNumber"]);

            bool deleted = Membership.DeleteUser(Utility.GetUserNameFromStaffNumber(StaffNumber, institutionId));

            //lc.LogRequest(string.Format("Delete User {0} {1}", e.Values["FirstName"].ToString(), e.Values["LastName"].ToString()), deleted);

        }



    }



    protected void gvStaff_RowUpdated(object sender, DevExpress.Web.Data.ASPxDataUpdatedEventArgs e)
    {

        string StaffNumber = Convert.ToString(e.NewValues["StaffNumber"]);
        string FirstName = Convert.ToString(e.NewValues["FirstName"]);
        string LastName = Convert.ToString(e.NewValues["LastName"]);
        string EmailAddress = Convert.ToString(e.NewValues["EmailAddress"]);
        string SystemRole = Convert.ToString(e.NewValues["RoleName"]);
        bool resetPassword = Convert.ToBoolean(e.NewValues["ResetPassword"]);
        string oldRole = Convert.ToString(e.OldValues["RoleName"]);
        //lc.LogRequest(string.Format("Update Staff-{0} {1}, Staff Number {2}", Convert.ToString(e.OldValues["FirstName"]), Convert.ToString(e.OldValues["LastName"]), Convert.ToString(e.OldValues["StaffNumber"])), e.AffectedRecords > 0);

        if (e.AffectedRecords > 0)
        {

            AddStaffAsUser(StaffNumber, EmailAddress, SystemRole, oldRole);
        }


        //lc.LogRequest(string.Format("Update Staff {0} {1}", e.OldValues["FirstName"].ToString(), e.OldValues["LastName"].ToString()), e.AffectedRecords > 0);


    }
    private void AddStaffAsUser(string StaffNumber, string EmailAddress, string SystemRole, string oldRole)
    {
        int institutionId = sec.GetUserInstitutionId(Membership.GetUser().UserName);
        string username = string.Format("{0}-{1}", institutionId, StaffNumber);
        MembershipUser newUser = Membership.GetUser(username);
        bool userDoesntExist = newUser == null;
        //attempt to add new user
        if (userDoesntExist)
        {
            if (!string.IsNullOrWhiteSpace(StaffNumber))
            {

                MembershipCreateStatus createStatus;

                newUser = Membership.CreateUser(username, Utility.Reverse(username), string.IsNullOrWhiteSpace(EmailAddress) ? string.Format("{0}@me.com", username) : EmailAddress, "Who are you", "CoinfomasUser", Membership.GetUser() != null ? true : false, out createStatus);
                //Log Event

                switch (createStatus)
                {
                    case MembershipCreateStatus.Success:

                        //add this user as a  Teacher
                        if (string.IsNullOrWhiteSpace(SystemRole))
                        {
                            if (!Roles.RoleExists("Staff"))
                            {
                                Roles.CreateRole("Staff");
                            }
                            Roles.AddUserToRole(newUser.UserName, "Staff");
                        }
                        else
                        {
                            if (!Roles.RoleExists(SystemRole))
                            {
                                Roles.CreateRole(SystemRole);
                            }
                            Roles.AddUserToRole(newUser.UserName, SystemRole);
                        }

                        //Update SchoolId
                        sec.AddUserInstitution(newUser.UserName, institutionId);

                        //Update User for Teacher
                        sec.UpdateStaffUsername(StaffNumber, username, institutionId);

                        break;
                }



                //log
                // lc.LogRequest(string.Format("Add Staff as User--, Username: {0}", username), createStatus == MembershipCreateStatus.Success);



            }
        }

        else if (oldRole != null && SystemRole != null && SystemRole.Trim() != "" && oldRole != SystemRole)
        {

            Roles.AddUserToRole(username, SystemRole);
            //log
            //lc.LogRequest(string.Format("Add User to role Username: {0}, Role: {1}", username, SystemRole), true);

            Roles.RemoveUserFromRole(username, oldRole);
            //log
            //lc.LogRequest(string.Format("Remove role from user with Username: {0}, Role: {1}", username, oldRole), true);
        }
        else if (oldRole == null && SystemRole != null && SystemRole.Trim() != "")
        {
            Roles.AddUserToRole(username, SystemRole);
            //log
            //lc.LogRequest(string.Format("Add User to role Username: {0}, Role: {1}", username, SystemRole), true);

        }

    }

    #endregion

    #region Staff Courses Log
    protected void gvStaffCourses_RowDeleted(object sender, DevExpress.Web.Data.ASPxDataDeletedEventArgs e)
    {
        try
        {
            //lc.LogRequest("Delete Staff Courses", e.AffectedRecords > 0);

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void gvStaffCourses_RowInserted(object sender, DevExpress.Web.Data.ASPxDataInsertedEventArgs e)
    {
        try
        {
            //lc.LogRequest("Add Staff Courses", e.AffectedRecords > 0);

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void gvStaffCourses_RowUpdated(object sender, DevExpress.Web.Data.ASPxDataUpdatedEventArgs e)
    {
        try
        {
            // lc.LogRequest("Update Staff Courses", e.AffectedRecords > 0);

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }
    #endregion

    #region Staff Types Log
    protected void gvStaffTypes_RowDeleted(object sender, DevExpress.Web.Data.ASPxDataDeletedEventArgs e)
    {
        try
        {
            // lc.LogRequest(string.Format("Delete Staff Type {0}", e.Values["StaffTypeName"].ToString()), e.AffectedRecords > 0);

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void gvStaffTypes_RowInserted(object sender, DevExpress.Web.Data.ASPxDataInsertedEventArgs e)
    {
        try
        {
            // lc.LogRequest(string.Format("Add Staff Type {0}", e.NewValues["StaffTypeName"].ToString()), e.AffectedRecords > 0);

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void gvStaffTypes_RowUpdated(object sender, DevExpress.Web.Data.ASPxDataUpdatedEventArgs e)
    {
        try
        {
            // lc.LogRequest(string.Format("Update Staff Type {0}", e.OldValues["StaffTypeName"].ToString()), e.AffectedRecords > 0);

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }
    #endregion

    #region Staff Statusses Log
    protected void gvStaffStatusses_RowDeleted(object sender, DevExpress.Web.Data.ASPxDataDeletedEventArgs e)
    {
        try
        {
            // lc.LogRequest(string.Format("Delete Staff Status {0}", e.Values["StatusName"].ToString()), e.AffectedRecords > 0);

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void gvStaffStatusses_RowInserted(object sender, DevExpress.Web.Data.ASPxDataInsertedEventArgs e)
    {
        try
        {
            // lc.LogRequest(string.Format("Add Staff Status {0}", e.NewValues["StatusName"].ToString()), e.AffectedRecords > 0);

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void gvStaffStatusses_RowUpdated(object sender, DevExpress.Web.Data.ASPxDataUpdatedEventArgs e)
    {
        try
        {
            //  lc.LogRequest(string.Format("Update Staff Status {0}", e.OldValues["StatusName"].ToString()), e.AffectedRecords > 0);

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }
    #endregion

    #region Staff Titles Log
    protected void gvStaffTitles_RowDeleted(object sender, DevExpress.Web.Data.ASPxDataDeletedEventArgs e)
    {
        try
        {
            // lc.LogRequest(string.Format("Delete Title {0}", e.Values["StaffTitleName"].ToString()), e.AffectedRecords > 0);

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void gvStaffTitles_RowInserted(object sender, DevExpress.Web.Data.ASPxDataInsertedEventArgs e)
    {
        try
        {
            // lc.LogRequest(string.Format("Add Title {0}", e.NewValues["StaffTitleName"].ToString()), e.AffectedRecords > 0);

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void gvStaffTitles_RowUpdated(object sender, DevExpress.Web.Data.ASPxDataUpdatedEventArgs e)
    {
        try
        {
            //lc.LogRequest(string.Format("Update Title {0}", e.OldValues["StaffTitleName"].ToString()), e.AffectedRecords > 0);

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }
    #endregion

    #region AgeGroups Log
    protected void gvAgeGroups_RowDeleted(object sender, DevExpress.Web.Data.ASPxDataDeletedEventArgs e)
    {
        try
        {
            //  lc.LogRequest(string.Format("Delete AgeGroup {0}", e.Values["AgeGroupText"].ToString()), e.AffectedRecords > 0);

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void gvAgeGroups_RowInserted(object sender, DevExpress.Web.Data.ASPxDataInsertedEventArgs e)
    {
        try
        {
            // lc.LogRequest(string.Format("Add AgeGroup {0}", e.NewValues["AgeGroupText"].ToString()), e.AffectedRecords > 0);

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void gvAgeGroups_RowUpdated(object sender, DevExpress.Web.Data.ASPxDataUpdatedEventArgs e)
    {
        try
        {
            //  lc.LogRequest(string.Format("Update AgeGroup {0}-->{1}", e.OldValues["AgeGroupText"].ToString(), e.NewValues["AgeGroupText"].ToString()), e.AffectedRecords > 0);

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }
    #endregion





    private int CheckedItemsCount(CheckBoxList chkList)
    {
        int count = 0;
        foreach (ListItem item in chkList.Items)
        {
            if (item.Selected) { count++; }

        }

        return count;
    }



    protected void gvStaff_CellEditorInitialize(object sender, ASPxGridViewEditorEventArgs e)
    {
        try
        {
            if (e.Column.FieldName == "InstitutionId")
            {
                ASPxComboBox edit = e.Editor as ASPxComboBox;
                edit.SelectedIndex = 0;
            }
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

 

   
}