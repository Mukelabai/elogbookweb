using elogbook.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_Students_RegisterStudents : System.Web.UI.Page
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

                bool show = Utility.UserIsAllowedTo("Manage Students", userRights);

                if (!show)
                {
                    Response.Redirect("~/Account/Signin.aspx");
                    return;
                }


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
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void btnViewStudents_Click(object sender, EventArgs e)
    {
        try
        {
            lbStudents.DataBind();
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }




    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            StudentsController sc = new StudentsController();
            if (lbStudents.SelectedValues.Count <= 0)
            {
                throw new Exception("Please select students to register");
            }
            int programId = Convert.ToInt32(ddlProgramId.Value);
            int studyYear = Convert.ToInt32(ddlTargetStudyYear.Value);
            int academicYear = Convert.ToInt32(txtTargetAcademicYear.Text.Trim());
            int institutionId = Convert.ToInt32(hfInstitutionId.Value);

            foreach(object value in lbStudents.SelectedValues)
            {
                int studentId = Convert.ToInt32(value);
                sc.RegisterStudentOnProgram(programId, studentId, studyYear, academicYear, institutionId);
                
            }
            Utility.DisplayInfoMessage("Students registered", lblMessage);
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }
}