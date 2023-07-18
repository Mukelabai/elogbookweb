using DevExpress.Export;
using DevExpress.Utils;
using DevExpress.Web;
using DevExpress.Web.ASPxPivotGrid;
using DevExpress.XtraCharts;
using DevExpress.XtraCharts.Web;
using DevExpress.XtraPrinting;
using elogbook.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Data.PivotGrid;

public partial class Controls_Reports_achievementspivot : System.Web.UI.Page
{
    SecurityController sec = new SecurityController();
    private string userRights, modules;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Membership.GetUser() == null || Session == null)
            {
                Response.Redirect("~/Account/Signin.aspx");
                return;
            }


            if (!Page.IsPostBack)
            {
                hfRole.Value = Roles.GetRolesForUser()[0];
                hfUsername.Value = Membership.GetUser().UserName;
                int institutionId = sec.GetUserInstitutionId();
                hfInstitutionId.Value = Convert.ToString(institutionId);
                userRights = sec.GetUserRightsOnly(institutionId, hfRole.Value);

                if (!Utility.UserIsAllowedTo("View Reports", userRights))
                {
                    Response.Redirect("~/Account/Signin.aspx");
                    return;
                }
                // Utility.LoadYearsToCurrent(ddlAcademicYearChoice);
                //Set Charts
                SetChartTypes();

            }
        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }

    protected void btnViewData_Click(object sender, EventArgs e)
    {
        //BindPivotTotals();
        pivotData.DataBind();
    }

    protected void buttonSaveAs_Click(object sender, EventArgs e)
    {
        foreach (PivotGridField field in pivotData.Fields)
        {
            if (field.ValueFormat != null && !string.IsNullOrEmpty(field.ValueFormat.FormatString))
                field.UseNativeFormat = checkCustomFormattedValuesAsText.Checked ? DefaultBoolean.False : DefaultBoolean.True;
        }

        ASPxPivotGridExporter1.OptionsPrint.PrintColumnAreaOnEveryPage = checkPrintColumnAreaOnEveryPage.Checked;
        ASPxPivotGridExporter1.OptionsPrint.PrintRowAreaOnEveryPage = checkPrintRowAreaOnEveryPage.Checked;
        ASPxPivotGridExporter1.OptionsPrint.MergeColumnFieldValues = checkMergeColumnFieldValues.Checked;
        ASPxPivotGridExporter1.OptionsPrint.MergeRowFieldValues = checkMergeRowFieldValues.Checked;

        ASPxPivotGridExporter1.OptionsPrint.PrintFilterHeaders = checkPrintFilterFieldHeaders.Checked ? DefaultBoolean.True : DefaultBoolean.False;
        ASPxPivotGridExporter1.OptionsPrint.PrintColumnHeaders = checkPrintColumnFieldHeaders.Checked ? DefaultBoolean.True : DefaultBoolean.False;
        ASPxPivotGridExporter1.OptionsPrint.PrintRowHeaders = checkPrintRowFieldHeaders.Checked ? DefaultBoolean.True : DefaultBoolean.False;
        ASPxPivotGridExporter1.OptionsPrint.PrintDataHeaders = checkPrintDataFieldHeaders.Checked ? DefaultBoolean.True : DefaultBoolean.False;

        const string fileName = "PivotGrid";
        XlsxExportOptionsEx options;
        switch (listExportFormat.SelectedIndex)
        {
            case 0:
                ASPxPivotGridExporter1.ExportPdfToResponse(fileName);
                break;
            case 1:
                options = new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG };
                ASPxPivotGridExporter1.ExportXlsxToResponse(fileName, options);
                break;
            case 2:
                ASPxPivotGridExporter1.ExportMhtToResponse(fileName, "utf-8", "ASPxPivotGrid Printing Sample", true);
                break;
            case 3:
                ASPxPivotGridExporter1.ExportRtfToResponse(fileName);
                break;
            case 4:
                ASPxPivotGridExporter1.ExportTextToResponse(fileName);
                break;
            case 5:
                ASPxPivotGridExporter1.ExportHtmlToResponse(fileName, "utf-8", "ASPxPivotGrid Printing Sample", true);
                break;
            case 6:
                options = new XlsxExportOptionsEx()
                {
                    ExportType = ExportType.DataAware,
                    AllowGrouping = allowGroupingCheckBox.Checked ? DefaultBoolean.True : DefaultBoolean.False,
                    TextExportMode = exportCellValuesAsText.Checked ? TextExportMode.Text : TextExportMode.Value,
                    AllowFixedColumns = allowFixedColumns.Checked ? DefaultBoolean.True : DefaultBoolean.False,
                    AllowFixedColumnHeaderPanel = allowFixedColumns.Checked ? DefaultBoolean.True : DefaultBoolean.False,
                    RawDataMode = exportRawData.Checked
                };
                ASPxPivotGridExporter1.ExportXlsxToResponse(fileName, options);
                break;
        }
    }

    private void SetChartTypes()
    {
        ViewType[] restrictedTypes = new ViewType[] { ViewType.PolarArea, ViewType.PolarLine, ViewType.SideBySideGantt,
                ViewType.SideBySideRangeBar, ViewType.RangeBar, ViewType.Gantt, ViewType.PolarPoint, ViewType.Stock, ViewType.CandleStick,
                ViewType.SwiftPlot };
        InitialiseChartTypes(restrictedTypes, ddlBarChartType, WebChartControl1);
    }

    private void InitialiseChartTypes(ViewType[] restrictedTypes, ASPxComboBox ddlList, WebChartControl chartControl)
    {
        ddlList.Items.Clear();
        foreach (ViewType type in Enum.GetValues(typeof(ViewType)))
        {
            if (Array.IndexOf<ViewType>(restrictedTypes, type) >= 0) continue;
            ddlList.Items.Add(type.ToString());
        }
        ddlList.Value = ViewType.Bar.ToString();
        SetChartType(ddlList.Value.ToString(), chartControl);
    }

    protected void btnRefreshCharts_Click(object sender, EventArgs e)
    {
        lblMessage.Text = string.Empty;
        try
        {


            // WebChartControl1.SeriesTemplate.Label.Visible = chkShowLabelsBar.Checked;
            WebChartControl1.SeriesTemplate.LabelsVisibility = chkShowLabelsBar.Checked ? DevExpress.Utils.DefaultBoolean.True : DevExpress.Utils.DefaultBoolean.False;
            SetChartType(ddlBarChartType.Value.ToString(), WebChartControl1);
            pivotData.OptionsChartDataSource.ProvideColumnGrandTotals = chkShowColumnGrandTotals.Checked;
            pivotData.OptionsChartDataSource.ProvideColumnTotals = chkShowColumnTotals.Checked;
            pivotData.OptionsChartDataSource.ProvideRowGrandTotals = chkShowRowGrandTotals.Checked;
            pivotData.OptionsChartDataSource.ProvideRowTotals = chkShowRowTotals.Checked;
            pivotData.OptionsChartDataSource.ProvideDataByColumns = chkGenerateSeriesFromColumns.Checked;
            //show or hide totals
            pivotData.OptionsView.ShowColumnGrandTotals = chkShowColumnGrandTotals.Checked;
            pivotData.OptionsView.ShowColumnTotals = chkShowColumnTotals.Checked;
            pivotData.OptionsView.ShowRowGrandTotals = chkShowRowGrandTotals.Checked;
            pivotData.OptionsView.ShowRowTotals = chkGenerateSeriesFromColumns.Checked;


        }
        catch (Exception ex)
        {
            Utility.DisplayErrorMessage(ex, lblMessage);
        }
    }


    private void CreateBarChart()
    {
        WebChartControl1.SeriesTemplate.LabelsVisibility = chkShowLabelsBar.Checked ? DevExpress.Utils.DefaultBoolean.True : DevExpress.Utils.DefaultBoolean.False;
        SetChartType(ddlBarChartType.Value.ToString(), WebChartControl1);

    }
    public void SetChartType(string text, WebChartControl webChart)
    {
        if ((ViewType)Enum.Parse(typeof(ViewType), text) == ViewType.Pie ||
                (ViewType)Enum.Parse(typeof(ViewType), text) == ViewType.Pie3D ||
                (ViewType)Enum.Parse(typeof(ViewType), text) == ViewType.Doughnut ||
                (ViewType)Enum.Parse(typeof(ViewType), text) == ViewType.Doughnut3D ||
                (ViewType)Enum.Parse(typeof(ViewType), text) == ViewType.Funnel ||
                (ViewType)Enum.Parse(typeof(ViewType), text) == ViewType.Funnel3D)
        {
            webChart.SeriesTemplate.PointOptions.ValueNumericOptions.Format = NumericFormat.Percent;
            //webChart.SeriesTemplate.Label.TextPattern
            webChart.SeriesTemplate.PointOptions.ValueNumericOptions.Precision = 1;

        }
        else
        {
            webChart.SeriesTemplate.PointOptions.ValueNumericOptions.Format = NumericFormat.Number;
            webChart.SeriesTemplate.PointOptions.ValueNumericOptions.Precision = 0;

        }

        webChart.SeriesTemplate.ChangeView((ViewType)Enum.Parse(typeof(ViewType), text));
        webChart.DataBind();

    }

    //private void BindPivotTotals()
    //{
    //    pivotData.OptionsView.ShowColumnGrandTotals = chkTotalsShowOptions.SelectedValues.Contains("CGT");
    //    pivotData.OptionsView.ShowColumnTotals = chkTotalsShowOptions.SelectedValues.Contains("CT");
    //    pivotData.OptionsView.ShowRowGrandTotals = chkTotalsShowOptions.SelectedValues.Contains("RGT");
    //    pivotData.OptionsView.ShowRowTotals = chkTotalsShowOptions.SelectedValues.Contains("RT");
    //    fieldExpected.SummaryType = GetSummaryType();
    //    fieldExpected.CellFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
    //    fieldExpected.CellFormat.FormatString = "#.#";
    //    fieldExpected.ValueFormat.FormatString = "#.#";
    //    fieldExpected.ValueFormat.FormatType = DevExpress.Utils.FormatType.Numeric;

    //    fieldAchieved.SummaryType = GetSummaryType();
    //    fieldAchieved.CellFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
    //    fieldAchieved.CellFormat.FormatString = "#.#";
    //    fieldAchieved.ValueFormat.FormatString = "#.#";
    //    fieldAchieved.ValueFormat.FormatType = DevExpress.Utils.FormatType.Numeric;

    //    fieldAchievedPercentage.SummaryType = GetSummaryType();
    //    fieldAchievedPercentage.CellFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
    //    fieldAchievedPercentage.CellFormat.FormatString = "#.#";
    //    fieldAchievedPercentage.ValueFormat.FormatString = "#.#";
    //    fieldAchievedPercentage.ValueFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
    //}
    //private PivotSummaryType GetSummaryType()
    //{
    //    switch (Convert.ToString(ddlSummaryType.Value))
    //    {
    //        case "Avg":
    //            return PivotSummaryType.Average;
    //        case "Min":
    //            return PivotSummaryType.Min;
    //        case "Max":
    //            return PivotSummaryType.Max;
    //        default:
    //            return PivotSummaryType.Sum;
    //    }
    //}


}