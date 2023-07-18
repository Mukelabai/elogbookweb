using elogbook.Model;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Threading;
using System.Web.Security;
using System.Web.UI;

public partial class Controls_Students_AddStudents : System.Web.UI.Page
{
    StudentsController sc = new StudentsController();
    SecurityController sec = new SecurityController();
    //LogController lc = new LogController();
    private string userRights;
    private double progress;
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

                bool show = Utility.UserIsAllowedTo("Manage Students", userRights);
                gvStudents.Columns["WebUsername"].Visible = show;

                Utility.ShowEditControls(gvStudents, "colCMDStudents", show, show, show);
               



            }
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void ddlProgramId_ValueChanged(object sender, EventArgs e)
    {
        try
        {
            ddlStartingStudyYear.DataBind();
        }catch(Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void btnViewStudents_Click(object sender, EventArgs e)
    {
        try
        {
            gvStudents.DataBind();
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void gvStudents_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
    {
        sqlDSStudents.InsertParameters["ProgramId"].DefaultValue = Convert.ToString(ddlProgramId.Value);
        sqlDSStudents.InsertParameters["StudyYear"].DefaultValue = Convert.ToString(ddlStartingStudyYear.Value);
        sqlDSStudents.InsertParameters["AcademicYear"].DefaultValue = Convert.ToString(txtAcademicYear.Text);
        sqlDSStudents.InsertParameters["StudentId"].DefaultValue = Convert.ToString(e.NewValues["StudentId"]);
        sqlDSStudents.InsertParameters["FirstName"].DefaultValue = Convert.ToString(e.NewValues["FirstName"]);
        sqlDSStudents.InsertParameters["LastName"].DefaultValue = Convert.ToString(e.NewValues["LastName"]);
        sqlDSStudents.InsertParameters["ComputerNumber"].DefaultValue = Convert.ToString(e.NewValues["ComputerNumber"]);
        sqlDSStudents.InsertParameters["DateOfBirth"].DefaultValue = Convert.ToString(e.NewValues["DateOfBirth"]);
        sqlDSStudents.InsertParameters["Sex"].DefaultValue = Convert.ToString(e.NewValues["Sex"]);
        sqlDSStudents.InsertParameters["MobilePhone"].DefaultValue = Convert.ToString(e.NewValues["MobilePhone"]);
        sqlDSStudents.InsertParameters["EmailAddress"].DefaultValue = Convert.ToString(e.NewValues["EmailAddress"]);
        sqlDSStudents.InsertParameters["CentreId"].DefaultValue = Convert.ToString(e.NewValues["CentreId"]);
        sqlDSStudents.InsertParameters["NationalId"].DefaultValue = Convert.ToString(e.NewValues["NationalId"]);
        sqlDSStudents.InsertParameters["InstitutionId"].DefaultValue = hfInstitutionId.Value;
        sqlDSStudents.Insert();
        e.Cancel = true;
        gvStudents.CancelEdit();
        gvStudents.DataBind();
    }

    protected void gvStudents_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
    {
        sqlDSStudents.UpdateParameters["ProgramId"].DefaultValue = Convert.ToString(ddlProgramId.Value);
        sqlDSStudents.UpdateParameters["StudyYear"].DefaultValue = Convert.ToString(ddlStartingStudyYear.Value);
        sqlDSStudents.UpdateParameters["AcademicYear"].DefaultValue = Convert.ToString(txtAcademicYear.Text);
        sqlDSStudents.UpdateParameters["StudentId"].DefaultValue = Convert.ToString(e.NewValues["StudentId"]);
        sqlDSStudents.UpdateParameters["FirstName"].DefaultValue = Convert.ToString(e.NewValues["FirstName"]);
        sqlDSStudents.UpdateParameters["LastName"].DefaultValue = Convert.ToString(e.NewValues["LastName"]);
        sqlDSStudents.UpdateParameters["ComputerNumber"].DefaultValue = Convert.ToString(e.NewValues["ComputerNumber"]);
        sqlDSStudents.UpdateParameters["DateOfBirth"].DefaultValue = Convert.ToString(e.NewValues["DateOfBirth"]);
        sqlDSStudents.UpdateParameters["Sex"].DefaultValue = Convert.ToString(e.NewValues["Sex"]);
        sqlDSStudents.UpdateParameters["MobilePhone"].DefaultValue = Convert.ToString(e.NewValues["MobilePhone"]);
        sqlDSStudents.UpdateParameters["EmailAddress"].DefaultValue = Convert.ToString(e.NewValues["EmailAddress"]);
        sqlDSStudents.UpdateParameters["CentreId"].DefaultValue = Convert.ToString(e.NewValues["CentreId"]);
        sqlDSStudents.UpdateParameters["NationalId"].DefaultValue = Convert.ToString(e.NewValues["NationalId"]);
        sqlDSStudents.UpdateParameters["InstitutionId"].DefaultValue = hfInstitutionId.Value;
        sqlDSStudents.Update();
        e.Cancel = true;
        gvStudents.CancelEdit();
        gvStudents.DataBind();
    }

    protected void ASPxCallback3_Callback(object source, DevExpress.Web.CallbackEventArgs e)
    {

        try
        {
            Thread.CurrentThread.CurrentCulture = CultureInfo.GetCultureInfo("en-US");


            int count = 0;
            int schoolId = sec.GetUserInstitutionId();
            List<String> computerIDsActive = sc.GetComputerNumbersUnAssigned(schoolId);
            int size = computerIDsActive.Count;
            List<string> computerIDsCompleted = sc.GetComputerIDsCompletedMoreThan2YearsAgo(schoolId);
            //first delete old accounts older than 2 years from the date of completion
            foreach (string computerID in computerIDsCompleted)
            {
                Membership.DeleteUser(string.Format("{0}-{1}", schoolId, computerID));
                progress = Convert.ToDouble(++count) / Convert.ToDouble(size) * 100;
            }
            MembershipUser user = null;
            //now add new ones who don't have usernames
            count = 0;
            if (computerIDsActive != null && computerIDsActive.Count > 0)
            {
                MembershipCreateStatus status = MembershipCreateStatus.UserRejected;
                foreach (string computerID in computerIDsActive)
                {
                    string iD = string.Format("{0}-{1}", schoolId, computerID);
                    user = Membership.GetUser(iD);
                    if (user == null)
                    {
                        user = Membership.CreateUser(iD, Utility.Reverse(iD), string.Format("{0}@me.com", iD), "Who are you", "Student", true, out status);
                        if (status == MembershipCreateStatus.Success)
                        {
                            //Add user to role
                            if (!Roles.RoleExists("Student"))
                            {
                                Roles.CreateRole("Student");
                            }
                            //if (!Roles.RoleExists("Pupil"))
                            //{
                            //    Roles.CreateRole("Pupil");
                            //}
                            Roles.AddUserToRole(user.UserName, "Student");
                            //Roles.AddUserToRole(user.UserName,"Pupil");
                            //Update SchoolId
                            sec.AddUserInstitution(user.UserName, schoolId);
                            //Update User for Pupil
                            sec.UpdateStudentUsername(computerID, user.UserName, schoolId);

                            count++;
                            progress = Convert.ToDouble(count) / Convert.ToDouble(size) * 100;
                        }
                    }
                    else
                    {
                        sec.UpdateStudentUsername(computerID, user.UserName, schoolId);

                        count++;
                    }
                }

            }

            Utility.DisplayInfoMessage(string.Format("User accounts updated: {0}", count), lblMessage);
            //lc.LogRequest(string.Format("Update student user accounts updated: {0}", count), true);


        }
        catch (Exception ex)
        {
            e.Result = "Error|" + ex.Message;

        }

    }
    protected void ASPxCallback4_Callback(object source, DevExpress.Web.CallbackEventArgs e)
    {
        e.Result = progress.ToString("#.#") + "%";
    }
}