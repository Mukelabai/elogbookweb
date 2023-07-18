using DevExpress.Web;
using elogbook.Model;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;
using System.Web.UI;

public partial class Controls_MyPages_MySubmissions : System.Web.UI.Page
{
    SecurityController sec = new SecurityController();
    private List<QuestionFormElement> formElements = new List<QuestionFormElement>();
    private List<QuestionFormElement> assignmentFormElements = new List<QuestionFormElement>();
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
            AddAssignmentControls();
            AddCompetenceControls();

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
            if (hfSubmissionId.Value == null)
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
        if (string.IsNullOrWhiteSpace(hfSubmissionId.Value))
        {
            return;
        }
        SubmissionController sc = new SubmissionController();
        int submissionId = Convert.ToInt32(hfSubmissionId.Value);
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
    public void AddAssignmentControls()
    {
        if (string.IsNullOrWhiteSpace(hfSubmissionId.Value))
        {
            return;
        }
        SubmissionController sc = new SubmissionController();
        int submissionId = Convert.ToInt32(hfSubmissionId.Value);
        List<ElogbookQuestion> allQuestions = sc.GetQuestionsForSubmission(submissionId);
        //since we are getting questions for students for patients, skip the assignment level ones
        allQuestions = allQuestions.Where(q => q.IsAssignmentLevel).ToList();

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
            rpAssignmentLevelQuestions.Controls.Add(secRP);

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
                assignmentFormElements.Add(new QuestionFormElement { Question = question, QuestionControl = questionControl, QuestionLabel = qLabel, SectionPanel = secRP });

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

    protected void chkAssignmentParent_ValueChanged(object sender, EventArgs e)
    {
        ASPxListBox chkParent = sender as ASPxListBox;
        string parentCtrlId = chkParent.ID;

        QuestionFormElement parentFormElement = assignmentFormElements.Where(q => q.QuestionControl.ID == parentCtrlId).FirstOrDefault();
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


    protected void rblAssignmentParent_ValueChanged(object sender, EventArgs e)
    {
        ASPxRadioButtonList chkParent = sender as ASPxRadioButtonList;
        string parentCtrlId = chkParent.ID;
        QuestionFormElement parentFormElement = assignmentFormElements.Where(q => q.QuestionControl.ID == parentCtrlId).FirstOrDefault();
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
            if (string.IsNullOrWhiteSpace(hfSubmissionId.Value))
            {
                throw new Exception("Please select a submission");
            }
            if (string.IsNullOrWhiteSpace(txtPatientIntials.Text))
            {
                throw new Exception("Please specify initials for this case's patient");
            }
            int submissionId = Convert.ToInt32(hfSubmissionId.Value);
            SubmissionController sc = new SubmissionController();
            //save case
            ElogbookCase elogbookCase = new ElogbookCase();
            elogbookCase.Patient = txtPatientIntials.Text.ToUpper().Trim();
            elogbookCase.SubmissionId = submissionId;
            elogbookCase.InstitutionId = Convert.ToInt32(hfInstitutionId.Value);
            elogbookCase.UpdatedBy = hfUsername.Value.ToString();
            long caseId = sc.AddCase(elogbookCase);

            string username = Convert.ToString(hfUsername.Value);
            int institutionId = Convert.ToInt32(hfInstitutionId.Value);

            //next get all questions


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

            //save achievements
            UpdateAchievements(submissionId, sc);

            Utility.DisplayInfoMessage("Case data successfuly saved", lblMessage);
            rblCases.DataBind();
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    private void UpdateAchievements(int submissionId, SubmissionController sc)
    {
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
            //find at least one response that contains thus competence (question option)

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
        //show achievement progress to student
        List<ElogbookAchievement> achievementQuestions = sc.GetAchievementsForSubmission(submissionId);

        if (achievementQuestions.Count > 0)
        {
            updateOverallAchievements(achievementQuestions);
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
    public void ResetAssignmentControls()
    {
        try
        {
            lblMessage.Text = null;



            //next get all questions

            foreach (QuestionFormElement qfe in assignmentFormElements)
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

            int submissionId = Convert.ToInt32(hfSubmissionId.Value);

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

    //load assignment data
    public void LoadAssignmentData()
    {
        try
        {
            ResetAssignmentControls();
            lblMessage.Text = null;
            rpCase.Visible = true;
            btnSave.Visible = true;


            SubmissionController sc = new SubmissionController();
            //next get all questions

            int submissionId = Convert.ToInt32(hfSubmissionId.Value);

            string username = Convert.ToString(hfUsername.Value);
            int institutionId = Convert.ToInt32(hfInstitutionId.Value);


            List<ElogbookResponse> allResponses = sc.GetResponsesForSubmisionAssignmentLevel(submissionId);



            foreach (QuestionFormElement q in assignmentFormElements)
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

    protected void gvSubmissions_SelectionChanged(object sender, EventArgs e)
    {
        try
        {
            lblMessageComment.Value = null;
            lblMessage.Value = null;
            object submissionId = gvSubmissions.GetSelectedFieldValues("SubmissionId")[0];

            hfSubmissionId.Value = submissionId.ToString(); //ddlSubmission.Value.ToString();
            rblCases.DataBind();
            hfSubmissionIdRight.Value = hfSubmissionId.Value;
            hfUsernameRight.Value = hfUsername.Value;
            gvDeleteComments.DataBind();
            btnComment.Visible = true;

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessageComment);
        }
    }

    protected void btnShowCases_Click(object sender, EventArgs e)
    {
        try
        {
            lblMessageComment.Value = null;
            lblMessage.Value = null;
            if (gvSubmissions.Selection.Count <= 0)
            {
                throw new Exception("Please select submission!");
            }
            object submissionId = gvSubmissions.GetSelectedFieldValues("SubmissionId")[0];

            hfSubmissionId.Value = submissionId.ToString(); //ddlSubmission.Value.ToString();
            rblCases.DataBind();
            hfSubmissionIdRight.Value = hfSubmissionId.Value;
            hfUsernameRight.Value = hfUsername.Value;
            gvDeleteComments.DataBind();
            btnComment.Visible = true;

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessageComment);
        }
    }

    protected void btnAssignmentLevelQuestions_Click(object sender, EventArgs e)
    {
        try
        {
            lblMessage.Text = null;
            if (gvSubmissions.Selection.Count <= 0)
            {
                throw new Exception("Please select submission!");
            }
            object submissionId = gvSubmissions.GetSelectedFieldValues("SubmissionId")[0];

            hfSubmissionId.Value = submissionId.ToString(); //ddlSubmission.Value.ToString();
            rblCases.DataBind();
            hfSubmissionIdRight.Value = hfSubmissionId.Value;
            if (rpAssignmentLevelQuestions.Controls.Count <= 1)
            {
                AddAssignmentControls();

            }
            else
            {
                ResetAssignmentControls();
            }
            rpAssignmentLevelQuestions.Visible = true;
            btnSaveAssignmentLevelQuestions.Visible = true;
            LoadAssignmentData();

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void btnSaveAssignmentLevelQuestions_Click(object sender, EventArgs e)
    {
        try
        {
            lblMessage.Text = null;
            if (string.IsNullOrWhiteSpace(hfSubmissionId.Value))
            {
                throw new Exception("Please select a submission");
            }

            int submissionId = Convert.ToInt32(hfSubmissionId.Value);
            SubmissionController sc = new SubmissionController();
            //save case

            long caseId = -1;

            string username = Convert.ToString(hfUsername.Value);
            int institutionId = Convert.ToInt32(hfInstitutionId.Value);

            //next get all questions




            foreach (QuestionFormElement qfe in assignmentFormElements)
            {
                //save those responses from controls that are visible
                if (qfe.QuestionControl.Visible)
                {
                    string response = Utility.GetResponse(qfe.Question.QuestionText, qfe.Question.ResponseType, qfe.QuestionControl);
                    sc.AddResponse(caseId, qfe.Question.QuestionId, response, username, institutionId, submissionId);

                }
            }

            UpdateAchievements(submissionId, sc);

            Utility.DisplayInfoMessage("General question data successfuly saved", lblMessage);
            rblCases.DataBind();
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void btnShowComptenceAchievements_Click(object sender, EventArgs e)
    {
        try
        {
            lblMessage.Text = null;
            if (gvSubmissions.Selection.Count <= 0)
            {
                throw new Exception("Please select submission!");
            }
            object submissionId = gvSubmissions.GetSelectedFieldValues("SubmissionId")[0];

            hfSubmissionId.Value = submissionId.ToString(); //ddlSubmission.Value.ToString();
            rblCases.DataBind();
            hfSubmissionIdRight.Value = hfSubmissionId.Value;
            rpCase.Visible = false;
            btnSave.Visible = false;
            rpAssignmentLevelQuestions.Visible = false;
            btnSaveAssignmentLevelQuestions.Visible = false;
            rpComptencies.Visible = true;
            progressBarAchievements.Visible = true;
            AddCompetenceControls();
        }
        catch(Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    private void updateOverallAchievements(List<ElogbookAchievement> allQuestions)
    {
        progressBarAchievements.Visible = true;
        //overall
        int expected = allQuestions.Sum(q => q.Expected);
        int achieved = allQuestions.Sum(q => q.Achieved);
        progressBarAchievements.Maximum = expected;
        progressBarAchievements.Position = achieved;
    }
    public void AddCompetenceControls()
    {
        if (gvSubmissions.Selection.Count <= 0)
        {
            return;
        }

        rpComptencies.Controls.Clear();
        SubmissionController sc = new SubmissionController();
        int submissionId = Convert.ToInt32(gvSubmissions.GetSelectedFieldValues("SubmissionId")[0]);
       
        List<ElogbookAchievement> allQuestions = sc.GetAchievementsForSubmission(submissionId);      

        if (allQuestions.Count <= 0)
        {
            return;
        }
        updateOverallAchievements(allQuestions);
        //unique  questions
        int[] questionIds = (from q in allQuestions select q.QuestionId).Distinct().ToArray();

        foreach (int questionId in questionIds)
        {
            //get all options for question
            List<ElogbookAchievement> questionOptions = allQuestions.Where(q => q.QuestionId == questionId).ToList();
            string questionText = questionOptions[0].QuestionText;

            //now display question
            ASPxLabel qLabel = new ASPxLabel();
            qLabel.Text = questionText;
            qLabel.Font.Bold = true;
            rpComptencies.Controls.Add(qLabel);
            foreach (ElogbookAchievement option in questionOptions)
            {
                ASPxProgressBar qBar = new ASPxProgressBar();
                qBar.Caption = string.Format("{0} ({1}/{2})", option.QuestionOption,option.Achieved,option.Expected);
                qBar.Position = option.Achieved;
                qBar.Maximum = option.Expected;
                rpComptencies.Controls.Add(qBar);
            }

        }

        


        }


    
}