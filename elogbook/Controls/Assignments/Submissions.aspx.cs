using DevExpress.Web;
using elogbook.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_Assignments_Submissions : System.Web.UI.Page
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

                bool show = Utility.UserIsAllowedTo("View Submissions", userRights);
                if (!show)
                {
                    Response.Redirect("~/Account/Signin.aspx");
                    return;
                }
                //Utility.ShowEditControls(gvAssignments, "colCMDAssignments", show, show, show);


            }
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void ddlAcademicYear_ValueChanged(object sender, EventArgs e)
    {
        try
        {
            ddlAssignments.Value = null;
            ddlAssignments.DataBind();            
            gvAssignments.DataBind();
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void ddlAssignments_ValueChanged(object sender, EventArgs e)
    {
        try
        {
            gvAssignments.DataBind();
        }catch(Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }
    protected string GetUrl(GridViewDataItemTemplateContainer Container)
    {
        int studentId = Convert.ToInt32(Container.Grid.GetRowValues(Container.VisibleIndex, new string[] { "SubmissionId" }));
        string student = Convert.ToString(Container.Grid.GetRowValues(Container.VisibleIndex, new string[] { "Student" }));
        return "viewsubmission.aspx?SubmissionId=" + studentId+"&Student="+student+"&Assignment="+ddlAssignments.Text;
    }
}