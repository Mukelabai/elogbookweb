using DevExpress.Web;
using elogbook.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_Elogbooks_Questions : System.Web.UI.Page
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

    protected void gvChildQuestions_BeforePerformDataSelect(object sender, EventArgs e)
    {
        Session["QuestionId"] = (sender as ASPxGridView).GetMasterRowKeyValue();
    }

    protected void gvChildQuestions_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
    {
        sqlDSChildQuestions.InsertParameters["DisplayOrder"].DefaultValue = Convert.ToString(e.NewValues["DisplayOrder"]);
        sqlDSChildQuestions.InsertParameters["ChildQuestionText"].DefaultValue = Convert.ToString(e.NewValues["ChildQuestionText"]);
        sqlDSChildQuestions.InsertParameters["ChildQuestionDisplayText"].DefaultValue = Convert.ToString(e.NewValues["ChildQuestionDisplayText"]);
        sqlDSChildQuestions.InsertParameters["ParentOption"].DefaultValue = Convert.ToString(e.NewValues["ParentOption"]);
        sqlDSChildQuestions.InsertParameters["ChildQuestionOptions"].DefaultValue = Convert.ToString(e.NewValues["ChildQuestionOptions"]);
        sqlDSChildQuestions.InsertParameters["ParentQuestionId"].DefaultValue = Convert.ToString(Session["QuestionId"]);
        sqlDSChildQuestions.InsertParameters["ChildResponseType"].DefaultValue = Convert.ToString(e.NewValues["ChildResponseType"]);
        sqlDSChildQuestions.InsertParameters["InstitutionId"].DefaultValue = hfInstitutionId.Value;
        sqlDSChildQuestions.InsertParameters["ElogbookId"].DefaultValue = Convert.ToString(ddlElogbooks.Value);
        sqlDSChildQuestions.InsertParameters["UpdatedBy"].DefaultValue = hfUsername.Value;
        sqlDSChildQuestions.InsertParameters["CategoryId"].DefaultValue = Convert.ToString(e.NewValues["CategoryId"]);
        sqlDSChildQuestions.InsertParameters["ShowOnDashboard"].DefaultValue = Convert.ToString(e.NewValues["ShowOnDashboard"]);
        sqlDSChildQuestions.InsertParameters["IsForSupervisor"].DefaultValue = Convert.ToString(e.NewValues["IsForSupervisor"]);
        sqlDSChildQuestions.InsertParameters["IsAssignmentLevel"].DefaultValue = Convert.ToString(e.NewValues["IsAssignmentLevel"]);
        sqlDSChildQuestions.Insert();
        e.Cancel = true;
        //child gridview
        
        ASPxGridView childGrid =sender as ASPxGridView;
        childGrid.CancelEdit();
        childGrid.DataBind();
    }

    protected void gvChildQuestions_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
    {
        sqlDSChildQuestions.UpdateParameters["ChildQuestionId"].DefaultValue = Convert.ToString(e.Keys["ChildQuestionId"]);
        sqlDSChildQuestions.UpdateParameters["DisplayOrder"].DefaultValue = Convert.ToString(e.NewValues["DisplayOrder"]);
        sqlDSChildQuestions.UpdateParameters["ChildQuestionText"].DefaultValue = Convert.ToString(e.NewValues["ChildQuestionText"]);
        sqlDSChildQuestions.UpdateParameters["ChildQuestionDisplayText"].DefaultValue = Convert.ToString(e.NewValues["ChildQuestionDisplayText"]); 
        sqlDSChildQuestions.UpdateParameters["ParentOption"].DefaultValue = Convert.ToString(e.NewValues["ParentOption"]);
        sqlDSChildQuestions.UpdateParameters["ChildQuestionOptions"].DefaultValue = Convert.ToString(e.NewValues["ChildQuestionOptions"]);
        sqlDSChildQuestions.UpdateParameters["ParentQuestionId"].DefaultValue = Convert.ToString(Session["QuestionId"]);
        sqlDSChildQuestions.UpdateParameters["ChildResponseType"].DefaultValue = Convert.ToString(e.NewValues["ChildResponseType"]);
        sqlDSChildQuestions.UpdateParameters["InstitutionId"].DefaultValue = hfInstitutionId.Value;
        sqlDSChildQuestions.UpdateParameters["ElogbookId"].DefaultValue = Convert.ToString(ddlElogbooks.Value);
        sqlDSChildQuestions.UpdateParameters["UpdatedBy"].DefaultValue = hfUsername.Value;
        sqlDSChildQuestions.UpdateParameters["CategoryId"].DefaultValue = Convert.ToString(e.NewValues["CategoryId"]);
        sqlDSChildQuestions.UpdateParameters["ShowOnDashboard"].DefaultValue = Convert.ToString(e.NewValues["ShowOnDashboard"]);
        sqlDSChildQuestions.UpdateParameters["IsForSupervisor"].DefaultValue = Convert.ToString(e.NewValues["IsForSupervisor"]);
        sqlDSChildQuestions.UpdateParameters["IsAssignmentLevel"].DefaultValue = Convert.ToString(e.NewValues["IsAssignmentLevel"]);
        sqlDSChildQuestions.Update();
        e.Cancel = true;
        //child gridview
        
        ASPxGridView childGrid = sender as ASPxGridView;
        childGrid.CancelEdit();
        childGrid.DataBind();
    }

    protected void gvParentQuestions_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
    {
        sqlDSParentQuestions.UpdateParameters["QuestionId"].DefaultValue = Convert.ToString(e.Keys["QuestionId"]);
        sqlDSParentQuestions.UpdateParameters["QuestionText"].DefaultValue = Convert.ToString(e.NewValues["QuestionText"]);
        sqlDSParentQuestions.UpdateParameters["QuestionOptions"].DefaultValue = Convert.ToString(e.NewValues["QuestionOptions"]);
        sqlDSParentQuestions.UpdateParameters["DisplayOrder"].DefaultValue = Convert.ToString(e.NewValues["DisplayOrder"]);
        sqlDSParentQuestions.UpdateParameters["SectionId"].DefaultValue = Convert.ToString(e.NewValues["SectionId"]);
        sqlDSParentQuestions.UpdateParameters["ElogbookId"].DefaultValue = Convert.ToString(ddlElogbooks.Value);
        sqlDSParentQuestions.UpdateParameters["ResponseType"].DefaultValue = Convert.ToString(e.NewValues["ResponseType"]);
        sqlDSParentQuestions.UpdateParameters["InstitutionId"].DefaultValue = hfInstitutionId.Value;
        sqlDSParentQuestions.UpdateParameters["UpdatedBy"].DefaultValue = hfUsername.Value;
        sqlDSParentQuestions.UpdateParameters["CategoryId"].DefaultValue = Convert.ToString(e.NewValues["CategoryId"]);
        sqlDSParentQuestions.UpdateParameters["ShowOnDashboard"].DefaultValue = Convert.ToString(e.NewValues["ShowOnDashboard"]);
        sqlDSParentQuestions.UpdateParameters["IsForSupervisor"].DefaultValue = Convert.ToString(e.NewValues["IsForSupervisor"]);
        sqlDSParentQuestions.UpdateParameters["IsAssignmentLevel"].DefaultValue = Convert.ToString(e.NewValues["IsAssignmentLevel"]);
        sqlDSParentQuestions.Update();
        e.Cancel = true;
        gvParentQuestions.CancelEdit();
        gvParentQuestions.DataBind();
    }

    protected void gvParentQuestions_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
    {
        sqlDSParentQuestions.InsertParameters["QuestionText"].DefaultValue = Convert.ToString(e.NewValues["QuestionText"]);
        sqlDSParentQuestions.InsertParameters["QuestionOptions"].DefaultValue = Convert.ToString(e.NewValues["QuestionOptions"]);
        sqlDSParentQuestions.InsertParameters["DisplayOrder"].DefaultValue = Convert.ToString(e.NewValues["DisplayOrder"]);
        sqlDSParentQuestions.InsertParameters["SectionId"].DefaultValue = Convert.ToString(e.NewValues["SectionId"]);
        sqlDSParentQuestions.InsertParameters["ElogbookId"].DefaultValue = Convert.ToString(ddlElogbooks.Value);
        sqlDSParentQuestions.InsertParameters["ResponseType"].DefaultValue = Convert.ToString(e.NewValues["ResponseType"]);
        sqlDSParentQuestions.InsertParameters["InstitutionId"].DefaultValue = hfInstitutionId.Value;
        sqlDSParentQuestions.InsertParameters["UpdatedBy"].DefaultValue = hfUsername.Value;
        sqlDSParentQuestions.InsertParameters["CategoryId"].DefaultValue = Convert.ToString(e.NewValues["CategoryId"]);
        sqlDSParentQuestions.InsertParameters["ShowOnDashboard"].DefaultValue = Convert.ToString(e.NewValues["ShowOnDashboard"]);
        sqlDSParentQuestions.InsertParameters["IsForSupervisor"].DefaultValue = Convert.ToString(e.NewValues["IsForSupervisor"]);
        sqlDSParentQuestions.InsertParameters["IsAssignmentLevel"].DefaultValue = Convert.ToString(e.NewValues["IsAssignmentLevel"]);
        sqlDSParentQuestions.Insert();
        e.Cancel = true;
        gvParentQuestions.CancelEdit();
        gvParentQuestions.DataBind();
    }

    protected void ddlElogbooks_ValueChanged(object sender, EventArgs e)
    {
        gvParentQuestions.DataBind();
    }
}