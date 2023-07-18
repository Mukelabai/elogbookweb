using DevExpress.Web;
using elogbook.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_Faculty_Programs : System.Web.UI.Page
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
                hfInstitutionId.Value = institutionId.ToString();
                userRights = sec.GetUserRightsOnly(institutionId, hfRole.Value);
                
                bool show = Utility.UserIsAllowedTo("Manage Programmes", userRights);
                Utility.ShowEditControls(gvProgrammes, "colCMDProgrammes", show, show, show);
                bool isGTSAdmin = Utility.UserIsGTSAdmin();
                Utility.ShowEditControls(gvProgrammeDurations, "colCMDProgrammeDurations", show, show, show);
                Utility.ShowEditControls(gvLevels, "colCMDLevels", show, show, isGTSAdmin);
                pcProgrammes.ActiveTabIndex = 0;
                gvProgrammes.DataBind();
            }
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void gvProgrammes_CustomUnboundColumnData(object sender, ASPxGridViewColumnDataEventArgs e)
    {
        
            if (e.Column.FieldName == "ProgrammesNo")
            {
                e.Value = string.Format("{0}", e.ListSourceRowIndex + 1);
            }
        
    }
    #region Programmes Logs
    #region Programmes Log
    protected void gvProgrammes_RowDeleted(object sender, DevExpress.Web.Data.ASPxDataDeletedEventArgs e)
    {
        try
        {
         //   lc.LogRequest(string.Format("Delete Programme {0}", e.Values["ProgramName"].ToString()), e.AffectedRecords > 0);

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void gvProgrammes_RowInserted(object sender, DevExpress.Web.Data.ASPxDataInsertedEventArgs e)
    {
        try
        {
         //   lc.LogRequest(string.Format("Add Programme {0}", e.NewValues["ProgramName"].ToString()), e.AffectedRecords > 0);

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void gvProgrammes_RowUpdated(object sender, DevExpress.Web.Data.ASPxDataUpdatedEventArgs e)
    {
        try
        {
          //  lc.LogRequest(string.Format("Update Programme {0}", e.OldValues["ProgramName"].ToString()), e.AffectedRecords > 0);

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }
    #endregion

    #region Levels Log
    protected void gvLevels_RowDeleted(object sender, DevExpress.Web.Data.ASPxDataDeletedEventArgs e)
    {
        try
        {
           // lc.LogRequest(string.Format("Delete Level {0}", e.Values["LevelName"].ToString()), e.AffectedRecords > 0);

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void gvLevels_RowInserted(object sender, DevExpress.Web.Data.ASPxDataInsertedEventArgs e)
    {
       
         //   lc.LogRequest(string.Format("Add Level {0}", e.NewValues["LevelName"].ToString()), e.AffectedRecords > 0);

       
    }

    protected void gvLevels_RowUpdated(object sender, DevExpress.Web.Data.ASPxDataUpdatedEventArgs e)
    {
       
           // lc.LogRequest(string.Format("Update Level {0}", e.OldValues["LevelName"].ToString()), e.AffectedRecords > 0);

       
    }
    #endregion
    #endregion

    


    #region Programme Durations Log
    protected void gvProgrammeDuration_RowDeleted(object sender, DevExpress.Web.Data.ASPxDataDeletedEventArgs e)
    {
        try
        {
          //  lc.LogRequest(string.Format("Delete Programme Duration {0}", e.Values["DurationText"].ToString()), e.AffectedRecords > 0);

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void gvProgrammeDuration_RowInserted(object sender, DevExpress.Web.Data.ASPxDataInsertedEventArgs e)
    {
        
          //  lc.LogRequest(string.Format("Add Programme Duration {0}", e.NewValues["DurationText"].ToString()), e.AffectedRecords > 0);

        
    }

    protected void gvProgrammeDuration_RowUpdated(object sender, DevExpress.Web.Data.ASPxDataUpdatedEventArgs e)
    {
        
           // lc.LogRequest(string.Format("Update Programme Duration {0}", e.OldValues["DurationText"].ToString()), e.AffectedRecords > 0);

        
    }
    #endregion

    #region Subject Area Log
    protected void gvSubjectAreas_RowDeleted(object sender, DevExpress.Web.Data.ASPxDataDeletedEventArgs e)
    {
        try
        {
            //lc.LogRequest(string.Format("Delete Subject Area {0}-{1}", e.Values["ProgrammeCode"].ToString(), e.Values["SubjectAreaName"].ToString()), e.AffectedRecords > 0);

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void gvSubjectAreas_RowInserted(object sender, DevExpress.Web.Data.ASPxDataInsertedEventArgs e)
    {
        try
        {
            //lc.LogRequest(string.Format("Add Subject Area {0}-{1}", e.NewValues["ProgrammeCode"].ToString(), e.NewValues["SubjectAreaName"].ToString()), e.AffectedRecords > 0);

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void gvSubjectAreas_RowUpdated(object sender, DevExpress.Web.Data.ASPxDataUpdatedEventArgs e)
    {
        try
        {
            //lc.LogRequest(string.Format("Update Subject Area {0}-{1}", e.OldValues["ProgrammeCode"].ToString(), e.OldValues["SubjectAreaName"].ToString()), e.AffectedRecords > 0);

        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }
    #endregion
    protected void gvProgrammeDurations_CustomUnboundColumnData(object sender, ASPxGridViewColumnDataEventArgs e)
    {
        
            if (e.Column.FieldName == "ProgrammeDurationsNo")
            {
                e.Value = string.Format("{0}", e.ListSourceRowIndex + 1);
            }
        
    }

    



    protected void gvProgrammeDurations_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
    {
        sqlDSProgrammeDurations.InsertParameters["DurationInYears"].DefaultValue = Convert.ToString(e.NewValues["DurationInYears"]);
        sqlDSProgrammeDurations.InsertParameters["DurationText"].DefaultValue = Convert.ToString(e.NewValues["DurationText"]);
        sqlDSProgrammeDurations.InsertParameters["InstitutionId"].DefaultValue = hfInstitutionId.Value;
        sqlDSProgrammeDurations.Insert();
        e.Cancel = true;
        gvProgrammeDurations.CancelEdit();
        gvProgrammeDurations.DataBind();
    }

    protected void gvProgrammeDurations_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
    {
        sqlDSProgrammeDurations.UpdateParameters["DurationId"].DefaultValue = Convert.ToString(e.Keys["DurationId"]);

        sqlDSProgrammeDurations.UpdateParameters["DurationInYears"].DefaultValue = Convert.ToString(e.NewValues["DurationInYears"]);
        sqlDSProgrammeDurations.UpdateParameters["DurationText"].DefaultValue = Convert.ToString(e.NewValues["DurationText"]);
        sqlDSProgrammeDurations.Update();
        e.Cancel = true;
        gvProgrammeDurations.CancelEdit();
        gvProgrammeDurations.DataBind();
    }
}