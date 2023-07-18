using elogbook.Model;
using System;
using System.Web.Security;
using System.Web.UI;

public partial class Controls_Assignments_Assignments : System.Web.UI.Page
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

                bool show = Utility.UserIsAllowedTo("Manage Elogbook Assignments", userRights);
                Utility.ShowEditControls(gvAssignments, "colCMDAssignments", show, show, show);


            }
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }
    protected void gvAssignments_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
    {
        sqlDSAssignments.UpdateParameters["AssignmentId"].DefaultValue = Convert.ToString(e.Keys["AssignmentId"]);
        sqlDSAssignments.UpdateParameters["AssignmentNumber"].DefaultValue = Convert.ToString(e.NewValues["AssignmentNumber"]);
        sqlDSAssignments.UpdateParameters["Rotation"].DefaultValue = Convert.ToString(e.NewValues["Rotation"]);
        sqlDSAssignments.UpdateParameters["RotationStart"].DefaultValue = Convert.ToString(e.NewValues["RotationStart"]);
        sqlDSAssignments.UpdateParameters["RotationEnd"].DefaultValue = Convert.ToString(e.NewValues["RotationEnd"]);
        sqlDSAssignments.UpdateParameters["ElogbookId"].DefaultValue = Convert.ToString(e.NewValues["ElogbookId"]);
        sqlDSAssignments.UpdateParameters["AcademicYear"].DefaultValue = Convert.ToString(e.NewValues["AcademicYear"]);
        sqlDSAssignments.UpdateParameters["DueDate"].DefaultValue = Convert.ToString(e.NewValues["DueDate"]);
        sqlDSAssignments.UpdateParameters["InstitutionId"].DefaultValue = hfInstitutionId.Value;
        sqlDSAssignments.UpdateParameters["UpdatedBy"].DefaultValue = hfUsername.Value;
        sqlDSAssignments.Update();
        e.Cancel = true;
        gvAssignments.CancelEdit();
        gvAssignments.DataBind();
    }

    protected void gvAssignments_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
    {
        sqlDSAssignments.InsertParameters["AssignmentNumber"].DefaultValue = Convert.ToString(e.NewValues["AssignmentNumber"]);
        sqlDSAssignments.InsertParameters["Rotation"].DefaultValue = Convert.ToString(e.NewValues["Rotation"]);
        sqlDSAssignments.InsertParameters["RotationStart"].DefaultValue = Convert.ToString(e.NewValues["RotationStart"]);
        sqlDSAssignments.InsertParameters["RotationEnd"].DefaultValue = Convert.ToString(e.NewValues["RotationEnd"]);
        sqlDSAssignments.InsertParameters["ElogbookId"].DefaultValue = Convert.ToString(e.NewValues["ElogbookId"]);
        sqlDSAssignments.InsertParameters["AcademicYear"].DefaultValue = Convert.ToString(e.NewValues["AcademicYear"]);
        sqlDSAssignments.InsertParameters["DueDate"].DefaultValue = Convert.ToString(e.NewValues["DueDate"]);
        sqlDSAssignments.InsertParameters["InstitutionId"].DefaultValue = hfInstitutionId.Value;
        sqlDSAssignments.InsertParameters["UpdatedBy"].DefaultValue = hfUsername.Value;
        sqlDSAssignments.Insert();
        e.Cancel = true;
        gvAssignments.CancelEdit();
        gvAssignments.DataBind();

    }
}