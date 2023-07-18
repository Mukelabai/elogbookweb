<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeFile="achievementslist.aspx.cs" Inherits="Controls_Reports_achievementslist" %>


<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="Server">
    <link rel="stylesheet" type="text/css" href='<%# ResolveUrl("~/Content/GridView.css") %>' />
    <script type="text/javascript" src='<%# ResolveUrl("~/Content/GridView.js") %>'></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LeftPanelContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="RightPanelContent" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="PageToolbar" runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageContent" runat="Server">
    <dx:ASPxTabControl ID="SchoolsTabControl" runat="server" Width="100%" TabAlign="Justify" Paddings-Padding="0">
        <Tabs>
            <dx:Tab Text="List of Submission Competence Achievements" NavigateUrl="#"></dx:Tab>
            <%--<dx:Tab Text="Register" NavigateUrl="Register.aspx"></dx:Tab>--%>
        </Tabs>
    </dx:ASPxTabControl>
    <div>
        <dx:ASPxLabel ID="lblMessage" runat="server">
        </dx:ASPxLabel>
        <asp:HiddenField ID="hfUsername" runat="server" />
        <asp:HiddenField ID="hfRole" runat="server" />
        <asp:HiddenField ID="hfInstitutionId" runat="server" />

    </div>
    <div style="padding: 7px">
        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Academic Year"></dx:ASPxLabel>
    </div>
    <div style="padding: 7px">
        
        <dx:ASPxComboBox ID="ddlAcademicYear" runat="server" ValueType="System.Int32" DataSourceID="sqlDSAcademicYears" TextField="AcademicYear" ValueField="AcademicYear" AutoPostBack="true" OnValueChanged="ddlAcademicYear_ValueChanged"></dx:ASPxComboBox>
        <asp:SqlDataSource ID="sqlDSAcademicYears" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_ElogbookAssignmentAcademicYearsLoad" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="hfInstitutionId" Name="InstitutionId" PropertyName="Value" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    <div style="padding: 7px">
        <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Assignment"></dx:ASPxLabel>
    </div>
    <div style="padding: 7px">
        
        <dx:ASPxComboBox ID="ddlAssignments" runat="server" Width="100%" TextField="Rotation" ValueField="AssignmentId" ValueType="System.Int32" DataSourceID="sqlDSAssignmentsDDL" AutoPostBack="true" OnValueChanged="ddlAssignments_ValueChanged"></dx:ASPxComboBox>
        <asp:SqlDataSource ID="sqlDSAssignmentsDDL" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_ElogbookAssignmentsLoadForLecturer" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="hfRole" Name="Role" PropertyName="Value" Type="String" />
                <asp:ControlParameter ControlID="hfUsername" Name="WebUsername" PropertyName="Value" Type="String" />
                <asp:ControlParameter ControlID="ddlAcademicYear" Name="AcademicYear" PropertyName="Value" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    <div class="form-field">
        <dx:ASPxGridView ID="gvAssignments" runat="server" AutoGenerateColumns="False" DataSourceID="sqlDSSubmissions">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="SectionName" VisibleIndex="0" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="QuestionText" VisibleIndex="1" Caption="Question" GroupIndex="0" SortIndex="0" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="QuestionOption" VisibleIndex="2" Caption="Response">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="StudentId" VisibleIndex="3" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Expected" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Achieved" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="AchievedPercentage" VisibleIndex="6" Caption="Achieved Perc.">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="AcademicYear" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ElogbookName" VisibleIndex="8" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Rotation" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="RotationPeriod" Visible="False" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="RotationYear" Visible="False" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Student" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ComputerNumber" VisibleIndex="13" Caption="Student no.">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Sex" Visible="True" VisibleIndex="14">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Program" Visible="True" VisibleIndex="15">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="StudyYear" Visible="True" VisibleIndex="16">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Mentor" VisibleIndex="17">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Hospital" VisibleIndex="18">
                </dx:GridViewDataTextColumn>
            </Columns>
            <Toolbars>
                <dx:GridViewToolbar Position="Bottom">
                    <SettingsAdaptivity Enabled="true" EnableCollapseRootItemsToIcons="true" />
                    <Items>
                        <dx:GridViewToolbarItem Command="ExportToPdf" />
                        <dx:GridViewToolbarItem Command="ExportToXlsx" />
                        <dx:GridViewToolbarItem Command="ExportToDocx" />
                        <dx:GridViewToolbarItem Command="ExportToRtf" />
                        <dx:GridViewToolbarItem Command="ExportToCsv" />
                    </Items>
                </dx:GridViewToolbar>
            </Toolbars>
            <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="WYSIWYG" />
            <SettingsContextMenu Enabled="True">
            </SettingsContextMenu>
            <SettingsAdaptivity AdaptivityMode="HideDataCells">
            </SettingsAdaptivity>
            <SettingsPager Position="Bottom">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Items="10, 20, 50, 100, 200, 1000, 2000" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <%--<SettingsEditing Mode="Batch">
            </SettingsEditing>--%>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" ShowFilterBar="Visible"></Settings>
            <SettingsBehavior AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" EnableRowHotTrack="True" ConfirmDelete="True" EnableCustomizationWindow="True"></SettingsBehavior>

            <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />

            <SettingsPopup>
                <FilterControl AutoUpdatePosition="False"></FilterControl>
            </SettingsPopup>

            <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="sqlDSSubmissions" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_ElogbookAchievementReportLoadForAssignment" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlAssignments" Name="AssignmentId" PropertyName="Value" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    <asp:SqlDataSource ID="sqlDSELogbooks" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_ElogbooksLoadDDL" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="hfInstitutionId" Name="InstitutionId" PropertyName="Value" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>



