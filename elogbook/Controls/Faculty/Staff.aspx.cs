using DevExpress.Web;
using elogbook.Model;
using System;
using System.Collections.Generic;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_Faculty_Staff : System.Web.UI.Page
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

            if (!Page.IsPostBack)
            {
                hfUsername.Value = Membership.GetUser() == null ? null : Membership.GetUser().UserName;
                hfRole.Value = Membership.GetUser() == null ? null : Roles.GetRolesForUser()[0];
                int institutionId = sec.GetUserInstitutionId();
                hfInstitutionId.Value = Convert.ToString(institutionId);
                userRights = sec.GetUserRightsOnly(institutionId, hfRole.Value);
                
                bool show = Utility.UserIsAllowedTo("Manage Staff", userRights);
                bool delete = Utility.UserIsGTSAdmin(); ;
                Utility.ShowEditControls(gvStaff, "colCMDStaff", show, show, show);
                Utility.ShowEditControls(gvStaffCourses, "colCMDSupervision", show, show, show);

                show = Utility.UserIsAllowedTo("Manage Mentors", userRights);
                Utility.ShowEditControls(gvMentors, "colCMDMentors", show, show, show);


                gvStaff.Columns["WebUsername"].Visible = show;

                pcStaff.TabPages[pcStaff.TabPages.IndexOfName("tabStaff")].Enabled = show;
                


                pcStaff.TabPages[pcStaff.TabPages.IndexOfName("tabStaffCourses")].Enabled = Utility.UserIsAllowedTo("View Supervision", userRights);



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

   

  
  

  

     
    protected void btnResetUser_Click(object sender, EventArgs e)
    {
        try
        {
            if (gvStaff.Selection.Count <= 0)
            {
                throw new Exception("Please select a user to reset password for");
            }
            string StaffNumber = gvStaff.GetSelectedFieldValues("StaffNumber")[0].ToString();
            int institutionId = sec.GetUserInstitutionId(Membership.GetUser().UserName);
            string newPassword = null;
            MembershipUser user = Membership.GetUser(Utility.GetUserNameFromStaffNumber(StaffNumber, institutionId));
            if (user != null)
            {

                newPassword = user.ResetPassword();
                Utility.DisplayInfoMessage(string.Format("The user's new password is {0}", newPassword), lblMessage);
                //lc.LogRequest(string.Format("Reset password for user {0}", user.UserName), true);

                Membership.UpdateUser(user);
            }


        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    

    

    
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
    private MembershipUser AddRandomUser(StaffContact staff)
    {
        MembershipUser newUser = Membership.GetUser(staff.WebUsername);
        if (newUser == null)
        {

            MembershipCreateStatus createStatus;

            newUser = Membership.CreateUser(staff.WebUsername, Utility.Reverse(staff.WebUsername), string.IsNullOrWhiteSpace(staff.EmailAddress) ? string.Format("{0}@me.com", staff.WebUsername) : staff.EmailAddress, "Who are you", "CoinfomasUser", Membership.GetUser() != null ? true : false, out createStatus);
            //Log Event

            switch (createStatus)
            {
                case MembershipCreateStatus.Success:

                    //add this user as a  Teacher
                    if (!Roles.RoleExists("Staff"))
                    {
                        Roles.CreateRole("Staff");
                    }
                    Roles.AddUserToRole(newUser.UserName, "Staff");

                    break;
            }
        }
        return newUser;
    }
    protected void btnCreateUserAccounts_Click(object sender, EventArgs e)
    {
        try
        {
            int count = 0;
            int institutionId = sec.GetUserInstitutionId(Membership.GetUser().UserName);
            List<StaffContact> staffNUmbers = sec.GetStaffIDsForUserAccounts(institutionId);

            MembershipUser user = null;
            //now add new ones who don't have userames
            if (staffNUmbers != null && staffNUmbers.Count > 0)
            {
                foreach (StaffContact staff in staffNUmbers)
                {
                    staff.WebUsername = string.Format("{0}-{1}", institutionId, staff.StaffNumber);
                    user = AddRandomUser(staff);
                    //If user added
                    if (user != null)
                    {
                        //Update SchoolId
                        sec.AddUserInstitution(user.UserName, institutionId);

                        //Update User for Teacher
                        sec.UpdateStaffUsername(staff.StaffNumber, user.UserName, institutionId);
                        count++;
                    }
                }



            }

            gvStaff.DataBind();
            Utility.DisplayInfoMessage(string.Format("User accounts updated: {0}", count), lblMessage);
            //lc.LogRequest(string.Format("Update Teacher user accounts {0}", count), true);

        }
        catch (Exception ex)
        {

            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void btnAssignUserName_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlStaff.Value == null || ddlUsernames.Value == null)
            {
                throw new Exception("Please select staff member and username.");
            }
            //Update User for Teacher
            bool assigned = sec.UpdateStaffUsernameById(Convert.ToInt32(ddlStaff.Value), Convert.ToString(ddlUsernames.Value), sec.GetUserInstitutionId());
            Utility.DisplayInfoMessage(string.Format("User name {0} has been assigned to {1}", ddlUsernames.Text, ddlStaff.Text), lblMessageAssign);
           // lc.LogRequest(string.Format("Assign username {0} to {1}", ddlUsernames.Text, ddlStaff.Text), assigned);
            gvStaff.DataBind();
        }
        catch (Exception ex)
        {

            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void gvStaff_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
    {

        sqlDSStaff.InsertParameters["StaffNumber"].DefaultValue = Convert.ToString(e.NewValues["StaffNumber"]);
        sqlDSStaff.InsertParameters["TitleId"].DefaultValue = Convert.ToString(e.NewValues["TitleId"]);
        sqlDSStaff.InsertParameters["FirstName"].DefaultValue = Convert.ToString(e.NewValues["FirstName"]);
        sqlDSStaff.InsertParameters["LastName"].DefaultValue = Convert.ToString(e.NewValues["LastName"]);
        sqlDSStaff.InsertParameters["Sex"].DefaultValue = Convert.ToString(e.NewValues["Sex"]);
        sqlDSStaff.InsertParameters["DateOfBirth"].DefaultValue = Convert.ToString(e.NewValues["DateOfBirth"]);
        sqlDSStaff.InsertParameters["EngangementDate"].DefaultValue = Convert.ToString(e.NewValues["EngangementDate"]);
        sqlDSStaff.InsertParameters["BusinessPhone"].DefaultValue = Convert.ToString(e.NewValues["BusinessPhone"]);
        sqlDSStaff.InsertParameters["MobileNumber"].DefaultValue = Convert.ToString(e.NewValues["MobileNumber"]);
        sqlDSStaff.InsertParameters["OfficeExtension"].DefaultValue = Convert.ToString(e.NewValues["OfficeExtension"]);
        sqlDSStaff.InsertParameters["EmailAddress"].DefaultValue = Convert.ToString(e.NewValues["EmailAddress"]);
        sqlDSStaff.InsertParameters["PostalAddress"].DefaultValue = Convert.ToString(e.NewValues["PostalAddress"]);
        sqlDSStaff.InsertParameters["PhysicalAddress"].DefaultValue = Convert.ToString(e.NewValues["PhysicalAddress"]);
        sqlDSStaff.InsertParameters["Nationality"].DefaultValue = Convert.ToString(e.NewValues["Nationality"]);
        sqlDSStaff.InsertParameters["NationalId"].DefaultValue = Convert.ToString(e.NewValues["NationalId"]);
        sqlDSStaff.InsertParameters["NationalIdType"].DefaultValue = Convert.ToString(e.NewValues["NationalIdType"]);
        sqlDSStaff.InsertParameters["IsLecturer"].DefaultValue = null; Convert.ToString(e.NewValues["IsLecturer"]);
        sqlDSStaff.InsertParameters["StaffTypeId"].DefaultValue = Convert.ToString(e.NewValues["StaffTypeId"]);
        sqlDSStaff.InsertParameters["StatusId"].DefaultValue = Convert.ToString(e.NewValues["StatusId"]);
        sqlDSStaff.InsertParameters["DepartmentId"].DefaultValue = Convert.ToString(e.NewValues["DepartmentId"]);
        sqlDSStaff.InsertParameters["CentreId"].DefaultValue = Convert.ToString(e.NewValues["CentreId"]);
        sqlDSStaff.InsertParameters["RoleName"].DefaultValue = Convert.ToString(e.NewValues["RoleName"]);
        sqlDSStaff.InsertParameters["InstitutionId"].DefaultValue = hfInstitutionId.Value;
        sqlDSStaff.Insert();
        e.Cancel = true;
        gvStaff.CancelEdit();
        gvStaff.DataBind();
    }

    

    protected void gvStaffCourses_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
    {
        sqlDSSupervision.InsertParameters["StaffId"].DefaultValue = Convert.ToString(e.NewValues["StaffId"]);
        sqlDSSupervision.InsertParameters["ProgramId"].DefaultValue = Convert.ToString(e.NewValues["ProgramId"]);
        sqlDSSupervision.InsertParameters["StudyYear"].DefaultValue = Convert.ToString(e.NewValues["StudyYear"]);
        sqlDSSupervision.InsertParameters["AcademicYear"].DefaultValue = Convert.ToString(e.NewValues["AcademicYear"]);
        sqlDSSupervision.InsertParameters["InstitutionId"].DefaultValue = hfInstitutionId.Value;
        sqlDSSupervision.Insert();
        e.Cancel = true;
        gvStaffCourses.CancelEdit();
        gvStaffCourses.DataBind();
    }
}