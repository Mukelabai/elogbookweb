<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeFile="AnalysisCategories.aspx.cs" Inherits="Controls_Elogbooks_AnalysisCategories" %>

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
                    <dx:Tab Text="Assignment Categorys" NavigateUrl="#"></dx:Tab>
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
 <dx:ASPxGridView ID="gvCategorys" runat="server" AutoGenerateColumns="False" DataSourceID="sqlDSCategorys"
                                                KeyFieldName="CategoryId" 
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
                                                    <dx:GridViewCommandColumn ShowInCustomizationForm="True" VisibleIndex="0" Name="colCMDCategorys" ShowEditButton="True" ShowNewButtonInHeader="true" ShowDeleteButton="True" ShowClearFilterButton="True"/>
                                                    <dx:GridViewDataTextColumn FieldName="CategoryId" ShowInCustomizationForm="True" VisibleIndex="1"
                                                        ReadOnly="True" Visible="False">
                                                        <EditFormSettings Visible="False" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="CategoryName" ShowInCustomizationForm="True"
                                                        VisibleIndex="2">
                                                        <PropertiesTextEdit MaxLength="50">
                                                            <ValidationSettings>
                                                                <RequiredField IsRequired="True" />
                                                            </ValidationSettings>
                                                        </PropertiesTextEdit>
                                                    </dx:GridViewDataTextColumn>
                                                    
                                                </Columns>
                                                <SettingsBehavior ConfirmDelete="True" />
                                                <Settings ShowFilterRow="True" ShowFilterBar="Visible" ShowFilterRowMenu="True" />
                                            </dx:ASPxGridView>
                                            <asp:SqlDataSource ID="sqlDSCategorys" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                                                SelectCommand="spGT_ElogbookAnalysisCategoriesLoadAll" SelectCommandType="StoredProcedure"
                                                DeleteCommand="spGT_ElogbookAnalysisCategoriesDelete" DeleteCommandType="StoredProcedure" InsertCommand="spGT_ElogbookAnalysisCategoriesInsert"
                                                InsertCommandType="StoredProcedure" UpdateCommand="spGT_ElogbookAnalysisCategoriesUpdate" UpdateCommandType="StoredProcedure">
                                                <DeleteParameters>
                                                    <asp:Parameter Name="CategoryId" Type="Int32" />
                                                </DeleteParameters>
                                                <InsertParameters>
                                                    <asp:Parameter Name="CategoryName" Type="String" />
                                                    
                                                </InsertParameters>
                                                
                                                <UpdateParameters>
                                                    <asp:Parameter Name="CategoryId" Type="Int32" />
                                                    <asp:Parameter Name="CategoryName" Type="String" />
                                                    
                                                </UpdateParameters>
                                            </asp:SqlDataSource>
    </div>
</asp:Content>



