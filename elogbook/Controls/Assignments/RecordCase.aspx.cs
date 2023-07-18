using DevExpress.Web;
using elogbook.Model;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;
using System.Web.UI;

public partial class Controls_Assignments_RecordCase : System.Web.UI.Page
{
    SecurityController sec = new SecurityController();
    private List<QuestionFormElement> formElements = new List<QuestionFormElement>();
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
            AddControls();

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
    protected void btnAddCase_Click(object sender, EventArgs e)
    {
        try
        {
            lblMessage.Text = null;
            if (ddlSubmission.Value == null)
            {
                throw new Exception("Please select submission to which you want to add a case");
            }
            ResetControls();
            rpCase.Visible = true;
            btnSave.Visible = true;

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    public void AddControls()
    {
        if (ddlSubmission.Value == null)
        {
            return;
        }
        SubmissionController sc = new SubmissionController();
        int submissionId = Convert.ToInt32(ddlSubmission.Value);
        List<ElogbookQuestion> allQuestions = sc.GetQuestionsForSubmission(submissionId);
        //since we are getting questions for students for patients, skip the assignment level ones
        allQuestions = allQuestions.Where(q => !q.IsAssignmentLevel).ToList();

        if (allQuestions.Count <= 0)
        {
            return;
        }

        //get sections
        string[] sections = (from sec in allQuestions
                             orderby sec.SectionOrder
                             select sec.SectionName
                             ).Distinct().ToArray();
        //keep track of each question's control Id
        Dictionary<int, string> questionCtrlIds = new Dictionary<int, string>();
        foreach (string section in sections)
        {
            //create round panels with section names
            //get sec record
            ElogbookQuestion[] secrecords = allQuestions.Where(q => q.SectionName == section).OrderBy(q => q.DisplayOrder).ToArray();
            ASPxRoundPanel secRP = new ASPxRoundPanel();
            secRP.EnableViewState = true;
            string sectionCtrlId = "rp" + secrecords[0].SectionId;
            secRP.ID = sectionCtrlId;
            secRP.HeaderText = section;
            secRP.ShowCollapseButton = true;
            rpCase.Controls.Add(secRP);

            //get all first-level questions, i.e. questions with no parents
            //go through  section's questions in their order
            foreach (ElogbookQuestion question in secrecords)
            {
                //now display question
                ASPxLabel qLabel = new ASPxLabel();
                qLabel.Text = question.QuestionText;

                if (question.IsSub)
                {
                    qLabel.Visible = false;//hide label since it will be activated by parent choice
                }

                secRP.Controls.Add(qLabel);
                string ctrlId = null;
                Control questionControl = null;


                if (question.ParentId <= 0)//if question has no parent use its own id
                {
                    ctrlId = string.Format("{0}_ctrl{1}", sectionCtrlId, question.QuestionId.ToString());


                }
                else//prefix it with parent's ID
                {
                    //child ctrlId
                    ctrlId = string.Format("{0}_ctrl{1}", questionCtrlIds[question.ParentId], question.QuestionId.ToString());

                    //hide label if it's a sub question
                }
                questionCtrlIds.Add(question.QuestionId, ctrlId);
                //now get the control
                questionControl = Utility.GetControl(question.ResponseType, question.QuestionOptions, ctrlId, question.IsSub);

                secRP.Controls.Add(questionControl);

                //add empty label
                secRP.Controls.Add(new ASPxLabel());

                //if the question has sub questions, let's add event listeners to show the sub questions
                if (question.HasSub && !string.IsNullOrWhiteSpace(question.QuestionOptions))
                {
                    //create event
                    if (question.ResponseType.ToLower() == "multiselect")
                    {
                        ASPxListBox chkP = questionControl as ASPxListBox;
                        chkP.ValueChanged += chkParent_ValueChanged;
                        chkP.AutoPostBack = true;


                    }
                    else if (question.ResponseType.ToLower() == "singleselect")
                    {
                        ASPxRadioButtonList chkP = questionControl as ASPxRadioButtonList;
                        chkP.ValueChanged += rblParent_ValueChanged;
                        chkP.AutoPostBack = true;

                    }
                }

                //add question controls to form elements
                formElements.Add(new QuestionFormElement { Question = question, QuestionControl = questionControl, QuestionLabel = qLabel, SectionPanel = secRP });

            }


        }
    }







    protected void chkParent_ValueChanged(object sender, EventArgs e)
    {
        ASPxListBox chkParent = sender as ASPxListBox;
        string parentCtrlId = chkParent.ID;

        QuestionFormElement parentFormElement = formElements.Where(q => q.QuestionControl.ID == parentCtrlId).FirstOrDefault();
        if (parentFormElement == null)
        {
            return;
        }

        //get all child elements for this parent

        List<QuestionFormElement> childFormElements = formElements.Where(q => q.Question.ParentId == parentFormElement.Question.QuestionId).ToList();

        foreach (ListEditItem item in chkParent.SelectedItems)
        {
            //get child element whose parent option matches selected item's text
            QuestionFormElement childElement = childFormElements.Where(q => q.Question.ParentOption.Trim() == item.Text.Trim()).FirstOrDefault();
            //if no child found
            if (childElement != null)
            {
                childElement.QuestionControl.Visible = true;
                childElement.QuestionLabel.Visible = true;
            }
        }
        //hide those not selected
        foreach (ListEditItem item in chkParent.Items)
        {
            if (!item.Selected)
            {
                //get controls for this item and hide them
                QuestionFormElement childElement = childFormElements.Where(q => q.Question.ParentOption.Trim() == item.Text.Trim()).FirstOrDefault();
                //if no child found
                if (childElement != null)
                {
                    childElement.QuestionControl.Visible = false;
                    childElement.QuestionLabel.Visible = false;
                }
            }
        }



    }


    protected void rblParent_ValueChanged(object sender, EventArgs e)
    {
        ASPxRadioButtonList chkParent = sender as ASPxRadioButtonList;
        string parentCtrlId = chkParent.ID;
        QuestionFormElement parentFormElement = formElements.Where(q => q.QuestionControl.ID == parentCtrlId).FirstOrDefault();
        if (parentFormElement == null)
        {
            return;
        }

        //get all child elements for this parent

        List<QuestionFormElement> childFormElements = formElements.Where(q => q.Question.ParentId == parentFormElement.Question.QuestionId).ToList();


        //get child element whose parent option matches selected item's text
        foreach (QuestionFormElement childElement in childFormElements)
        {
            if (chkParent.SelectedItem.Text.Trim() == childElement.Question.ParentOption.Trim())
            {
                childElement.QuestionControl.Visible = true;
                childElement.QuestionLabel.Visible = true;
            }
            else
            {
                childElement.QuestionControl.Visible = false;
                childElement.QuestionLabel.Visible = false;
            }

        }


    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            lblMessage.Text = null;
            if (ddlSubmission.Value == null)
            {
                throw new Exception("Please select a submission");
            }
            if (string.IsNullOrWhiteSpace(txtPatientIntials.Text))
            {
                throw new Exception("Please specify initials for this case's patient");
            }
            SubmissionController sc = new SubmissionController();
            //save case
            ElogbookCase elogbookCase = new ElogbookCase();
            elogbookCase.Patient = txtPatientIntials.Text.ToUpper().Trim();
            elogbookCase.SubmissionId = Convert.ToInt64(ddlSubmission.Value);
            elogbookCase.InstitutionId = Convert.ToInt32(hfInstitutionId.Value);
            elogbookCase.UpdatedBy = hfUsername.Value.ToString();
            long caseId = sc.AddCase(elogbookCase);

            string username = Convert.ToString(hfUsername.Value);
            int institutionId = Convert.ToInt32(hfInstitutionId.Value);

            //next get all questions

            int submissionId = Convert.ToInt32(ddlSubmission.Value);
            List<ElogbookQuestion> allQuestions = sc.GetQuestionsForSubmission(submissionId);
            allQuestions = allQuestions.Where(q => !q.IsAssignmentLevel).ToList();

            if (allQuestions.Count <= 0)
            {
                return;
            }

            foreach (QuestionFormElement qfe in formElements)
            {
                //save those responses from controls that are visible
                if (qfe.QuestionControl.Visible)
                {
                    string response = Utility.GetResponse(qfe.Question.QuestionText, qfe.Question.ResponseType, qfe.QuestionControl);
                    sc.AddResponse(caseId, qfe.Question.QuestionId, response, username, institutionId, submissionId);

                }
            }



            Utility.DisplayInfoMessage("Case data successfuly saved", lblMessage);
            rblCases.DataBind();
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void rblCases_ValueChanged(object sender, EventArgs e)
    {
        try
        {

            LoadCase();

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void ddlSubmission_ValueChanged(object sender, EventArgs e)
    {
        try
        {

            hfSubmissionId.Value = ddlSubmission.Value.ToString();
            rblCases.DataBind();
            hfSubmissionIdRight.Value = hfSubmissionId.Value;
            hfUsernameRight.Value = hfUsername.Value;
            gvDeleteComments.DataBind();
            btnComment.Visible = true;
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }

    }

    public void ResetControls()
    {
        try
        {
            lblMessage.Text = null;


            txtPatientIntials.Value = null;


            //next get all questions

            foreach (QuestionFormElement qfe in formElements)
            {
                if (qfe.Question.IsSub)
                {
                    qfe.QuestionControl.Visible = false;
                    qfe.QuestionLabel.Visible = false;
                }
                //save those responses from controls that are visible
                Utility.ResetControl(qfe.Question.ResponseType, qfe.QuestionControl);

            }

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    //load case
    public void LoadCase()
    {
        try
        {
            ResetControls();
            lblMessage.Text = null;
            rpCase.Visible = true;
            btnSave.Visible = true;

            SubmissionController sc = new SubmissionController();

            txtPatientIntials.Value = rblCases.SelectedItem.Text.ToUpper();
            string username = Convert.ToString(hfUsername.Value);
            int institutionId = Convert.ToInt32(hfInstitutionId.Value);

            int caseId = Convert.ToInt32(rblCases.Value);
            List<ElogbookResponse> allResponses = sc.GetResponsesForCase(caseId);

            //next get all questions

            int submissionId = Convert.ToInt32(ddlSubmission.Value);

            foreach (QuestionFormElement q in formElements)
            {
                ElogbookResponse questionResponse = allResponses.FirstOrDefault(a => a.QuestionId == q.Question.QuestionId);
                //get response
                string responseText = questionResponse == null ? null : questionResponse.ResponseText;

                Utility.SetResponse(q.Question.ResponseType, q.QuestionControl, responseText);
                if (q.Question.IsSub && responseText != null)
                {
                    q.QuestionControl.Visible = true;
                    q.QuestionLabel.Visible = true;
                }
            }

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }
    protected void btnComment_Click(object sender, EventArgs e)
    {
        try
        {
            lblMessageComment.Value = null;

            SubmissionController sc = new SubmissionController();
            sc.AddSubmissionComment(txtComment.Text, hfUsername.Value, Convert.ToInt64(hfSubmissionId.Value), Convert.ToInt32(hfInstitutionId.Value), "Student");

            ncComments.DataBind();
            gvDeleteComments.DataBind();

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessageComment);
        }
    }
}