using elogbook.Model;
using System;
using System.Web.Security;
using System.Web.UI;


public partial class Controls_Students_ProgramRegister : System.Web.UI.Page
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


                Utility.ShowEditControls(gvStudents, "colCMDProgramRegister", false, show, show);




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
            gvStudents.DataBind();
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }



    protected void gvStudents_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
    {
        sqlDSStudents.InsertParameters["ProgramId"].DefaultValue = Convert.ToString(e.NewValues["ProgramId"]);
        sqlDSStudents.InsertParameters["StudyYear"].DefaultValue = Convert.ToString(e.NewValues["StudyYear"]);
        sqlDSStudents.InsertParameters["AcademicYear"].DefaultValue = Convert.ToString(e.NewValues["AcademicYear"]);
        sqlDSStudents.InsertParameters["StudentId"].DefaultValue = Convert.ToString(e.NewValues["StudentId"]);
        
        sqlDSStudents.InsertParameters["InstitutionId"].DefaultValue = hfInstitutionId.Value;
        sqlDSStudents.Insert();
        e.Cancel = true;
        gvStudents.CancelEdit();
        gvStudents.DataBind();
    }

    protected void gvStudents_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
    {
        sqlDSStudents.UpdateParameters["ProgramId"].DefaultValue = Convert.ToString(e.NewValues["ProgramId"]);
        sqlDSStudents.UpdateParameters["StudyYear"].DefaultValue = Convert.ToString(e.NewValues["StudyYear"]);
        sqlDSStudents.UpdateParameters["AcademicYear"].DefaultValue = Convert.ToString(e.NewValues["AcademicYear"]);
        sqlDSStudents.UpdateParameters["StudentId"].DefaultValue = Convert.ToString(e.NewValues["StudentId"]);        
        sqlDSStudents.UpdateParameters["InstitutionId"].DefaultValue = hfInstitutionId.Value;
        sqlDSStudents.Update();
        e.Cancel = true;
        gvStudents.CancelEdit();
        gvStudents.DataBind();
    }
}