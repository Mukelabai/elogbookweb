<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeFile="Grades.aspx.cs" Inherits="Controls_Assignments_Grades" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" Runat="Server">
    <link rel="stylesheet" type="text/css" href='<%# ResolveUrl("~/Content/GridView.css") %>' />
    <script type="text/javascript" src='<%# ResolveUrl("~/Content/GridView.js") %>'></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LeftPanelContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="RightPanelContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="PageToolbar" Runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageContent" Runat="Server">
     <dx:ASPxTabControl ID="SchoolsTabControl" runat="server" Width="100%" TabAlign="Justify" Paddings-Padding="0">
                <Tabs>
                    <dx:Tab Text="Assignment Grades" NavigateUrl="#"></dx:Tab>
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
    <div class="form-field">
 <dx:ASPxGridView ID="gvGrades" runat="server" AutoGenerateColumns="False" DataSourceID="sqlDSGrades"
                                                KeyFieldName="GradeId" 
                                                >
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
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" ShowFilterBar="Visible"></Settings>
            <SettingsBehavior AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" EnableRowHotTrack="True" ConfirmDelete="True" EnableCustomizationWindow="True"></SettingsBehavior>

            <SettingsPopup>
                <FilterControl AutoUpdatePosition="False"></FilterControl>
            </SettingsPopup>

            <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
            <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                                <Columns>
                                                    <dx:GridViewCommandColumn ShowInCustomizationForm="True" VisibleIndex="0" Name="colCMDGrades" ShowEditButton="True" ShowNewButtonInHeader="true" ShowDeleteButton="True" ShowClearFilterButton="True"/>
                                                    <dx:GridViewDataTextColumn FieldName="GradeId" ShowInCustomizationForm="True" VisibleIndex="1"
                                                        ReadOnly="True" Visible="False">
                                                        <EditFormSettings Visible="False" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="GradeName" ShowInCustomizationForm="True"
                                                        VisibleIndex="2">
                                                        <PropertiesTextEdit MaxLength="50" NullDisplayText="e.g A+ or Distinction or Excellent" NullText="e.g A+ or Distinction or Excellent">
                                                            <ValidationSettings>
                                                                <RequiredField IsRequired="True" />
                                                            </ValidationSettings>
                                                        </PropertiesTextEdit>
                                                    </dx:GridViewDataTextColumn>
                                                    
                                                </Columns>
                                                <SettingsBehavior ConfirmDelete="True" />
                                                <Settings ShowFilterRow="True" ShowFilterBar="Visible" ShowFilterRowMenu="True" />
                                            </dx:ASPxGridView>
                                            <asp:SqlDataSource ID="sqlDSGrades" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                                                SelectCommand="spGT_ElogbookAssignmentGradesLoadAll" SelectCommandType="StoredProcedure"
                                                DeleteCommand="spGT_ElogbookAssignmentGradesDelete" DeleteCommandType="StoredProcedure" InsertCommand="spGT_ElogbookAssignmentGradesInsert"
                                                InsertCommandType="StoredProcedure" UpdateCommand="spGT_ElogbookAssignmentGradesUpdate" UpdateCommandType="StoredProcedure">
                                                <DeleteParameters>
                                                    <asp:Parameter Name="GradeId" Type="Int32" />
                                                </DeleteParameters>
                                                <InsertParameters>
                                                    <asp:Parameter Name="GradeName" Type="String" />
                                                    
                                                </InsertParameters>
                                                
                                                <UpdateParameters>
                                                    <asp:Parameter Name="GradeId" Type="Int32" />
                                                    <asp:Parameter Name="GradeName" Type="String" />
                                                    
                                                </UpdateParameters>
                                            </asp:SqlDataSource>
    </div>
</asp:Content>



