using elogbook.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class Controls_Reports_buildachievementsretroactively : System.Web.UI.Page
{
    SecurityController sec = new SecurityController();
    private string userRights, modules;
    private static double progress;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Membership.GetUser() == null || Session == null)
            {
                Response.Redirect("~/Account/Signin.aspx");
                return;
            }

            if (!IsPostBack && !IsCallback)
            {
                progress = 0;


            }
            if (!Page.IsPostBack)
            {
                hfRole.Value = Roles.GetRolesForUser()[0];
                hfUsername.Value = Membership.GetUser().UserName;
                int institutionId = sec.GetUserInstitutionId();
                hfInstitutionId.Value = Convert.ToString(institutionId);
                userRights = sec.GetUserRightsOnly(institutionId, hfRole.Value);

                if (!Utility.UserIsAdmin())
                {
                    Response.Redirect("~/Account/Signin.aspx");
                    return;
                }
                // Utility.LoadYearsToCurrent(ddlAcademicYearChoice);

            }
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }
    protected void ASPxCallback1_Callback(object source, DevExpress.Web.CallbackEventArgs e)
    {
        try
        {
            if (ddlAcademicYearChoice.Value == null)
            {
                throw new Exception("Select academic year");
            }
            SubmissionController sc = new SubmissionController();
            int academicYear = Convert.ToInt32(ddlAcademicYearChoice.Value);
            //first delete existing for this year
            sc.DeleteElogbookReport(academicYear);
            List<ElogbookReportSubmission> submissions = sc.GetElogbookReportSubmission(academicYear);
            int submissionsSize = submissions.Count;
            for (int i = 0; i < submissionsSize; i++)
            {
                ElogbookReportSubmission submission = submissions[i];
                long submissionId = submission.SubmissionId;
                //save achievements
                List<ElogbookAchievement> responses = sc.GetResponsesForElogbookAchievement(submissionId);
                //get elogbookId
                int elogbookId = responses[0].ElogbookId;
                int assignmentId = responses[0].AssignmentId;
                int studentId = responses[0].StudentId;
                //get expected competencies for elogbook
                List<ElogbookAchievement> expectedCompetencies = sc.GetCompetenciesForSubmissionAchievement(elogbookId);
                //fr each expected competence, find how much has been acheived
                foreach (ElogbookAchievement ec in expectedCompetencies)
                {
                    //in case multiple options, interepreted as OR. e.g., Lumbar puture or Interestation of results
                    string[] options = ec.QuestionOption.Split(';');
                    ElogbookAchievement ea = null;
                    foreach (string option in options)
                    {
                        ea = responses.Where(a => a.QuestionId == ec.QuestionId && a.ResponseText.Contains(option.Trim())).FirstOrDefault();
                        if (ea != null)
                        {
                            break;
                        }
                    }


                    if (ea != null)
                    {
                        //get respnses that contain the target questionoption
                        int achieved = 0;
                        foreach (string option in options)
                        {
                            achieved += (responses.Where(a => a.QuestionId == ec.QuestionId && a.ResponseText.Contains(option.Trim()))).Count();
                        }

                        sc.AddElogbookAchivement(elogbookId, assignmentId, submissionId, ec.QuestionId, ec.QuestionOption, studentId, achieved);
                    }
                    else
                    {
                        //if no response matches competence then achiveed is 0
                        sc.AddElogbookAchivement(elogbookId, assignmentId, submissionId, ec.QuestionId, ec.QuestionOption, studentId, 0);
                    }
                }
                
                progress = Convert.ToDouble(i + 1) / Convert.ToDouble(submissionsSize) * 100;
            }

            e.Result = "Error|" + "Report build completed successfully";
        }
        catch (Exception ex)
        {
            e.Result = "Error|" + ex.Message;

        }

    }
    protected void ASPxCallback2_Callback(object source, DevExpress.Web.CallbackEventArgs e)
    {
        e.Result = progress.ToString("#.#") + "%";
    }

}