using elogbook.Model;
using System;
using System.Web.Security;
using System.Web.UI;

public partial class Controls_Assignments_CreateSubmission : System.Web.UI.Page
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
            hfUsername.Value = Membership.GetUser() == null ? null : Membership.GetUser().UserName;
            hfRole.Value = Membership.GetUser() == null ? null : Roles.GetRolesForUser()[0];

            if (!Page.IsPostBack)
            {
                if (!Roles.IsUserInRole("Student"))
                {
                    Response.Redirect("~/Account/Signin.aspx");
                    return;
                }

                int institutionId = sec.GetUserInstitutionId();
                hfInstitutionId.Value = Convert.ToString(institutionId);
                //userRights = sec.GetUserRightsOnly(institutionId, hfRole.Value);

               


            }
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void btnSaveSubmission_Click(object sender, EventArgs e)
    {
        try
        {
            SubmissionController sc = new SubmissionController();
          bool added =  sc.CreateSubmission(Convert.ToInt32(txtMentor.Value), Convert.ToInt32(ddlHospital.Value), Convert.ToInt32(ddlAssignments.Value), hfUsername.Value, Convert.ToInt32(hfInstitutionId.Value));
            if (added)
            {
                Utility.DisplayInfoMessage(string.Format("Submission registered for {0}\nYou can now record cases for this submission", ddlAssignments.Text),lblMessage);
            }
            else
            {
                Utility.DisplayErrorMessage("Submission could not be recorded; we could not match your username to an existig student. Please contact admin", lblMessage);
            }
        }catch(Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

   
}