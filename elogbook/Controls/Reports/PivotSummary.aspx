<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeFile="PivotSummary.aspx.cs" Inherits="Controls_Reports_PivotSummary" %>

<%@ Register Assembly="DevExpress.Web.ASPxPivotGrid.v20.2, Version=20.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPivotGrid" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.XtraCharts.v20.2.Web, Version=20.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts.Web" TagPrefix="dxchartsui" %>
<%@ Register Assembly="DevExpress.XtraCharts.v20.2, Version=20.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LeftPanelContent" runat="Server">
    <script>
        function onInit(s, e) {
            //var fieldHeaderOptionsPanel = optionsFormLayout.GetItemByName('fieldHeaderOptionsPanel');
            fieldHeaderOptionsPanel.SetVisible(false);
            //var fieldValuesOptionsPanel = optionsFormLayout.GetItemByName('fieldValuesOptionsPanel');
            fieldValuesOptionsPanel.SetVisible(false);
            //var dataAwareOptionsPanel = dataAwareOptionsPanel;//optionsFormLayout.GetItemByName('dataAwareOptionsPanel');
            dataAwareOptionsPanel.SetVisible(true);
            checkCustomFormattedValuesAsText.SetEnabled(false);
        }
        function onSelectedIndexChanged(s, e) {
            var selectedIndex = s.GetSelectedIndex(),
                isExportToExcel = selectedIndex == 1,
                isDataAwareExport = selectedIndex == 6;
            //var fieldHeaderOptionsPanel = optionsFormLayout.GetItemByName('fieldHeaderOptionsPanel');
            fieldHeaderOptionsPanel.SetVisible(!isDataAwareExport);
            //var fieldValuesOptionsPanel = optionsFormLayout.GetItemByName('fieldValuesOptionsPanel');
            fieldValuesOptionsPanel.SetVisible(!isDataAwareExport);
            //var dataAwareOptionsPanel = optionsFormLayout.GetItemByName('dataAwareOptionsPanel');
            dataAwareOptionsPanel.SetVisible(isDataAwareExport);
            checkCustomFormattedValuesAsText.SetEnabled(isExportToExcel);
        }
    </script>
    <h3 class="section-caption contents-caption">Export Settings</h3>
    <div style="padding: 5px">
        <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="Export to"></dx:ASPxLabel>


    </div>
    <div style="padding: 5px">
        <dx:ASPxComboBox ID="listExportFormat" runat="server" Style="vertical-align: middle" SelectedIndex="6"
            ValueType="System.String" Width="170px">
            <Items>
                <dx:ListEditItem Text="Pdf" Value="0" />
                <dx:ListEditItem Text="Excel" Value="1" />
                <dx:ListEditItem Text="Mht" Value="2" />
                <dx:ListEditItem Text="Rtf" Value="3" />
                <dx:ListEditItem Text="Text" Value="4" />
                <dx:ListEditItem Text="Html" Value="5" />
                <dx:ListEditItem Text="Excel (Data Aware)" Value="6" />
            </Items>
            <ClientSideEvents Init="onInit" SelectedIndexChanged="onSelectedIndexChanged" />
        </dx:ASPxComboBox>
    </div>
    <div style="padding: 5px">
        <dx:ASPxButton ID="ASPxButton3" ClientInstanceName="buttonSaveAs" runat="server" ToolTip="Export and Save"
            OnClick="buttonSaveAs_Click" Text="Export" Width="170px" />
    </div>
    <div style="padding: 5px">
        <dx:ASPxRoundPanel ID="panelDataAware" runat="server" Width="100%" ClientInstanceName="dataAwareOptionsPanel" HeaderText="Data Aware Options" ShowCollapseButton="true" View="GroupBox">
            <PanelCollection>
                <dx:PanelContent>

                    <dx:ASPxCheckBox ID="allowGroupingCheckBox" ClientInstanceName="allowGroupingCheckBox" runat="server" Checked="True" Text="Allow grouping columns/rows" />


                    <dx:ASPxCheckBox ID="allowFixedColumns" ClientInstanceName="allowFixedColumns" runat="server" Checked="True" Text="Allow fixed ColumnArea and RowArea" />

                    <dx:ASPxCheckBox ID="exportCellValuesAsText" ClientInstanceName="exportCellValuesAsText" runat="server" Text="Export cell values as display text" />

                    <dx:ASPxCheckBox ID="exportRawData" ClientInstanceName="exportRawData" runat="server" CheckState="Unchecked" Text="Export raw data" />

                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>
    </div>
    <div style="padding: 5px">
        <dx:ASPxRoundPanel ID="fieldHeaderOptionsPanel" runat="server" Width="100%" ClientInstanceName="fieldHeaderOptionsPanel" HeaderText="Field Header Options" ShowCollapseButton="true" View="GroupBox">
            <PanelCollection>
                <dx:PanelContent>
                    <dx:ASPxCheckBox ID="checkPrintFilterFieldHeaders" runat="server" Checked="True" Text="Print filter field headers" />
                    <dx:ASPxCheckBox ID="checkPrintColumnFieldHeaders" runat="server" Checked="True" Text="Print column field headers" />
                    <dx:ASPxCheckBox ID="checkPrintRowFieldHeaders" runat="server" Checked="True" Text="Print row field headers" />
                    <dx:ASPxCheckBox ID="checkPrintDataFieldHeaders" runat="server" Checked="True" Text="Print data field headers" />
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>
    </div>
    <div style="padding: 5px">
        <dx:ASPxRoundPanel ID="fieldValuesOptionsPanel" runat="server" Width="100%" ClientInstanceName="fieldValuesOptionsPanel" HeaderText="Field Values Options" ShowCollapseButton="true" View="GroupBox">
            <PanelCollection>
                <dx:PanelContent>
                   <dx:ASPxCheckBox ID="checkPrintColumnAreaOnEveryPage" runat="server" Text="Print column area on every page" />
                    <dx:ASPxCheckBox ID="checkPrintRowAreaOnEveryPage" runat="server" Text="Print row area on every page" />
                    <dx:ASPxCheckBox ID="checkMergeColumnFieldValues" runat="server" Checked="True" Text="Merge values of outer column fields" />
                    <dx:ASPxCheckBox ID="checkMergeRowFieldValues" runat="server" Checked="True" Text="Merge values of outer row fields" />
                    <dx:ASPxCheckBox ID="checkCustomFormattedValuesAsText" ClientInstanceName="checkCustomFormattedValuesAsText" runat="server" Checked="True" Text="Export custom formatted values as text" />
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>
    </div>
    <div style="padding: 5px">
    </div>
   
    <h3 class="section-caption contents-caption">Chart Settings</h3>
    <div style="padding: 5px">
        <hr />
    </div>
    <div style="padding: 5px">
        <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Select Chart Type"></dx:ASPxLabel>

    </div>
    <div style="padding: 5px">
        <dx:ASPxComboBox ID="ddlBarChartType" runat="server" SelectedIndex="0">
            <Items>
                <dx:ListEditItem Selected="True" Text="Bar" Value="Bar" />
            </Items>
        </dx:ASPxComboBox>
        <dx:ASPxCheckBox ID="chkShowLabelsBar" runat="server" Text="Show Chart Labels?">
        </dx:ASPxCheckBox>
    </div>
    <div style="padding: 5px">
        <dx:ASPxButton ID="btnRefreshCharts" runat="server" Text="Refresh Chart" Width="170px" OnClick="btnRefreshCharts_Click">
        </dx:ASPxButton>
    </div>
    <div style="padding: 5px">
        <dx:ASPxCheckBox ID="chkShowColumnGrandTotals" runat="server" Text="Show Column Grand Totals?">
        </dx:ASPxCheckBox>
        <dx:ASPxCheckBox ID="chkShowColumnTotals" runat="server" Text="Show Column Totals?">
        </dx:ASPxCheckBox>
        <dx:ASPxCheckBox ID="chkShowRowGrandTotals" runat="server" Text="Show Row Grand Totals?">
        </dx:ASPxCheckBox>
        <dx:ASPxCheckBox ID="chkShowRowTotals" runat="server" Text="Show Row Totals?">
        </dx:ASPxCheckBox>
        <dx:ASPxCheckBox ID="chkGenerateSeriesFromColumns" runat="server" Text="Generate Series from Columns">
        </dx:ASPxCheckBox>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="RightPanelContent" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="PageToolbar" runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageContent" runat="Server">
    <dx:ASPxTabControl ID="SchoolsTabControl" runat="server" Width="100%" TabAlign="Justify" Paddings-Padding="0">
        <Tabs>
            <dx:Tab Text="All Data Pivot Summary" NavigateUrl="#"></dx:Tab>
            <%--<dx:Tab Text="Register" NavigateUrl="Register.aspx"></dx:Tab>--%>
        </Tabs>
    </dx:ASPxTabControl>
    <div>
        <dx:ASPxLabel ID="lblMessage" runat="server">
        </dx:ASPxLabel>
        <asp:HiddenField ID="hfUsername" runat="server" />
        <asp:HiddenField ID="hfRole" runat="server" />
        <asp:HiddenField ID="hfInstitutionId" runat="server" />
        <dx:ASPxPivotGridExporter ID="ASPxPivotGridExporter1" runat="server" ASPxPivotGridID="pivotData" Visible="False" />
    </div>
    <div style="padding: 5px">
        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Academic Year From"></dx:ASPxLabel>
        <dx:ASPxComboBox ID="ddlYearFrom" runat="server" ValueType="System.Int32" DataSourceID="sqlDSYears" TextField="Academicyear" ValueField="Academicyear"></dx:ASPxComboBox>
        <asp:SqlDataSource ID="sqlDSYears" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_AcademicYearsLoadWithAssignments" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="To"></dx:ASPxLabel>
        <dx:ASPxComboBox ID="ddlYearTo" runat="server" ValueType="System.Int32" DataSourceID="sqlDSYears" TextField="Academicyear" ValueField="Academicyear"></dx:ASPxComboBox>
    </div>
     <div class="form-field">
         <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="Table options"></dx:ASPxLabel>
        <dx:ASPxCheckBoxList ID="chkTotalsShowOptions" runat="server" ValueType="System.String" RepeatDirection="Horizontal">
            <Items>
                <dx:ListEditItem Text="Show Column Grand Totals" Value="CGT" />
                <dx:ListEditItem Text="Show Column Totals" Value="CT" />
                <dx:ListEditItem Text="Show Row Grand Totals" Value="RGT" />
                <dx:ListEditItem Text="Show Row Totals" Value="RT" />
            </Items>
        </dx:ASPxCheckBoxList>
         <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="Summary Type"></dx:ASPxLabel>
        <dx:ASPxComboBox ID="ddlSummaryType" runat="server" ValueType="System.String">
            <Items>
                <dx:ListEditItem Text="Sum" Value="Sum" />
                <dx:ListEditItem Text="Average" Value="Avg" />
                <dx:ListEditItem Text="Min" Value="Min" />
                <dx:ListEditItem Text="Max" Value="Max" />
            </Items>
        </dx:ASPxComboBox>
    </div>
    <div style="padding: 5px">
        <dx:ASPxButton ID="btnViewData" runat="server" Text="View Data" OnClick="btnViewData_Click" Width="170px"></dx:ASPxButton>
    </div>
    <div style="padding: 5px">
        <hr />
    </div>
    <div style="padding: 5px">
        <dx:ASPxPivotGrid ID="pivotData" runat="server" OptionsData-DataProcessingEngine="Optimized" ClientIDMode="AutoID" DataSourceID="sqlDSPivotData">
            <Fields>
                <dx:PivotGridField ID="field" AreaIndex="7" Name="field">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="AcademicYear" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field1" Area="RowArea" AreaIndex="0" Name="field1" Visible="False">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="Category" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field2" Name="field2" Visible="False">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="ComputerNumber" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field3" AreaIndex="0" Name="field3" Area="RowArea" Caption="Order">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="DisplayOrder" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field4" AreaIndex="4" Name="field4">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="Elogbook" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field5" Name="field5" Visible="False">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="ElogbookVersion" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field6" Name="field6" Visible="False">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="Grade" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field7" Name="field7" Visible="False">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="GradedBy" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field8" AreaIndex="3" Name="field8">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="Hospital" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field9" AreaIndex="2" Name="field9">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="Mentor" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field10" Area="DataArea" AreaIndex="0" Name="field10" Caption="Cases">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="Number" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field11" AreaIndex="0" Name="field11">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="ParentQuestion" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field12" AreaIndex="1" Name="field12" SummaryType="Count">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="Patient" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field13" AreaIndex="0" Name="field13" Visible="False">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="Program" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field14" AreaIndex="1" Name="field14" Area="RowArea">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="Question" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field15" Name="field15" Visible="False">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="ResponseMonth" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field16" Name="field16" Visible="False">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="ResponseMonthNo" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field17" AreaIndex="2" Name="field17" Area="RowArea" Caption="Response">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="ResponseText" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field18" Name="field18" Visible="False">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="ResponseYear" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field19" Area="ColumnArea" AreaIndex="0" Name="field19">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="Rotation" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field20" Name="field20" Visible="False">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="RotationPeriod" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field21" Name="field21" Visible="False">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="RotationYear" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field22" AreaIndex="9" Name="field22" Visible="False">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="Section" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field23" AreaIndex="5" Name="field23" Caption="Student Sex">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="Sex" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field24" AreaIndex="9" Name="field24" Visible="False">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="Status" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field25" AreaIndex="6" Name="field25" SummaryType="CountDistinct">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="Student" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field26" AreaIndex="10" Name="field26" Visible="False">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="StudyYear" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field27" AreaIndex="8" Name="field27">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="ShowOnDashboard" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field28" AreaIndex="14" Name="field28" Visible="False">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="SectionOrder" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
                <dx:PivotGridField ID="field29" AreaIndex="9" Name="field29">
                    <DataBindingSerializable>
                        <dx:DataSourceColumnBinding ColumnName="ResponseType" />
                    </DataBindingSerializable>
                </dx:PivotGridField>
            </Fields>
            <OptionsData DataProcessingEngine="Optimized"></OptionsData>
            <OptionsPager RowsPerPage="500">
                <AllButton Visible="true"></AllButton>
                <PageSizeItemSettings Items="5,10,20,50,100,200,500,1000,2000" Visible="true"></PageSizeItemSettings>
            </OptionsPager>

        </dx:ASPxPivotGrid>
        <asp:SqlDataSource ID="sqlDSPivotData" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_ElogbookReportLoadPivot" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlYearFrom" Name="AcademicYearStart" PropertyName="Value" Type="Int32" />
                <asp:ControlParameter ControlID="ddlYearTo" Name="AcademicYearEnd" PropertyName="Value" Type="Int32" />
                <asp:ControlParameter ControlID="hfRole" Name="Role" PropertyName="Value" Type="String" />
                <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    <div style="padding: 5px">
        <dxchartsui:WebChartControl ID="WebChartControl1" runat="server" CrosshairEnabled="True" DataSourceID="pivotData" Height="728px" SeriesDataMember="Series" Width="1280px">
            <DiagramSerializable>
                <cc1:XYDiagram>
                    <AxisX Title-Text="Category" VisibleInPanesSerializable="-1">
                        <Label Angle="45" EnableAntialiasing="True">
                        </Label>
                    </AxisX>
                    <AxisY Title-Text="Cases" VisibleInPanesSerializable="-1">
                    </AxisY>
                </cc1:XYDiagram>
            </DiagramSerializable>
            <Legend MaxHorizontalPercentage="30"></Legend>
            <SeriesTemplate ArgumentDataMember="Arguments" ArgumentScaleType="Qualitative" ValueDataMembersSerializable="Values">
            </SeriesTemplate>
        </dxchartsui:WebChartControl>
    </div>
</asp:Content>

