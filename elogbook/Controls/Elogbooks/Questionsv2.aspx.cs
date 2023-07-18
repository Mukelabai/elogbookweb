using DevExpress.Web;
using elogbook.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_Elogbooks_Questionsv2 : System.Web.UI.Page
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
        sqlDSParentQuestions.UpdateParameters["HasCompetences"].DefaultValue = Convert.ToString(e.NewValues["HasCompetences"]);
        sqlDSParentQuestions.UpdateParameters["HasSub"].DefaultValue = Convert.ToString(e.NewValues["HasSub"]);
        sqlDSParentQuestions.UpdateParameters["IsSub"].DefaultValue = Convert.ToString(e.NewValues["IsSub"]);
        sqlDSParentQuestions.UpdateParameters["ParentId"].DefaultValue = Convert.ToString(e.NewValues["ParentId"]);
        sqlDSParentQuestions.UpdateParameters["ParentOption"].DefaultValue = Convert.ToString(e.NewValues["ParentOption"]);
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
        sqlDSParentQuestions.InsertParameters["HasCompetences"].DefaultValue = Convert.ToString(e.NewValues["HasCompetences"]);
        sqlDSParentQuestions.InsertParameters["HasSub"].DefaultValue = Convert.ToString(e.NewValues["HasSub"]);
        sqlDSParentQuestions.InsertParameters["IsSub"].DefaultValue = Convert.ToString(e.NewValues["IsSub"]);
        sqlDSParentQuestions.InsertParameters["ParentId"].DefaultValue = Convert.ToString(e.NewValues["ParentId"]);
        sqlDSParentQuestions.InsertParameters["ParentOption"].DefaultValue = Convert.ToString(e.NewValues["ParentOption"]);
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