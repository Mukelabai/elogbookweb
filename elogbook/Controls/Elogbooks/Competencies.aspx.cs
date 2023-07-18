using DevExpress.Web;
using elogbook.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class Controls_Elogbooks_Competencies : System.Web.UI.Page
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


                int institutionId = sec.GetUserInstitutionId();
                hfInstitutionId.Value = Convert.ToString(institutionId);
                userRights = sec.GetUserRightsOnly(institutionId, hfRole.Value);

                bool show = Utility.UserIsAllowedTo("Manage Elogbooks", userRights);
                Utility.ShowEditControls(gvParentQuestions, "colCMDParentQuestions", show, show, show);


            }
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }


    protected void ddlElogbooks_ValueChanged(object sender, EventArgs e)
        {
            gvParentQuestions.DataBind();
        }

    protected void btnPopulateTable_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlElogbooks.Value == null)
            {
                throw new Exception("Please select Elogbook");
            }
            //get all questions for elogbook
            int elogbookId = Convert.ToInt32(ddlElogbooks.Value);
            SubmissionController sc = new SubmissionController();
            List<ElogbookQuestion> questions = sc.GetQuestionsForElogbookWithCompetencies(elogbookId);
            
            //now go through each question and split it
            foreach(ElogbookQuestion q in questions)
            {
                string[] options = q.QuestionOptions.Split(';');
                //now insert each option
                foreach(string option in options)
                {
                    sc.AddQuestionCompetenceRecord(elogbookId, q.QuestionId,q.QuestionText, option.Trim(), hfUsername.Value, Convert.ToInt32(hfInstitutionId.Value));
                }
                
            }
            gvParentQuestions.DataBind();
            Utility.DisplayInfoMessage("Updated data",lblMessage);

        }catch(Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }
}