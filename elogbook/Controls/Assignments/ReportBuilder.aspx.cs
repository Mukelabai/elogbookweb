using elogbook.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_Assignments_ReportBuilder : System.Web.UI.Page
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
                
                if (!Utility.UserIsAllowedTo("Build Reports", userRights))
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
            for (int i = 0; i < submissionsSize ; i++)
            {
                ElogbookReportSubmission submission = submissions[i];
                List<ElogbookReportResponse> responses = sc.GetElogbookReportResponses(submission.SubmissionId);
                foreach(ElogbookReportResponse response in responses)
                {
                    
                        //add parent question response
                        submission.QuestionText = response.QuestionText;
                        submission.QuestionId = response.QuestionId;
                        submission.ParentQuestion = response.Parent;
                        submission.Section = response.SectionName;
                        submission.SectionOrder = response.SectionOrder;
                        submission.Category = response.Category;
                        submission.ResponseText = response.ResponseText;
                        submission.Patient = response.Patient;
                        submission.DisplayOrder = response.DisplayOrder;
                        submission.ResponseYear = response.ResponseYear;
                        submission.ResponseMonthNo = response.ResponseMonthNo;
                        submission.ResponseMonth = response.ResponseMonth;
                        submission.ResponseType = response.ResponseType;
                        submission.ShowOnDashboard = response.ShowOnDashboard;
                    
                    //now insert
                    
                    if (submission.ResponseType.ToLower() == "multiselect")
                    {
                        //first split the options in the response
                        string[] items = submission.ResponseText.Split(';');
                        foreach(string responseItem in items)
                        {
                            submission.ResponseText = responseItem.Trim();
                            sc.AddElogbookReport(submission);
                        }
                    }
                    else
                    {
                        //submit without splitting options
                        sc.AddElogbookReport(submission);
                    }
                }
                //now insert achievements
                sc.AddElogbookAchivementReport(submission.SubmissionId);
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