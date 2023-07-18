<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeFile="StaffTypes.aspx.cs" Inherits="Controls_Faculty_StaffTypes" %>

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
            <dx:Tab Text="Staff Types" NavigateUrl="#"></dx:Tab>
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
        <dx:ASPxPageControl ID="pcStaff" runat="server" ActiveTabIndex="0">
            <TabPages>

                <dx:TabPage Name="tabStaffTypes" Text="Staff Types">
                    <ContentCollection>
                        <dx:ContentControl ID="ContentControl6" runat="server">
                            <div class="form-field">
                                <dx:ASPxGridView ID="gvStaffTypes" runat="server" AutoGenerateColumns="False" DataSourceID="sqlDSStaffTypes"
                                    KeyFieldName="StaffTypeId"
                                    OnRowDeleted="gvStaffTypes_RowDeleted" OnRowInserted="gvStaffTypes_RowInserted"
                                    OnRowUpdated="gvStaffTypes_RowUpdated">
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
                                        <dx:GridViewCommandColumn ShowInCustomizationForm="True" VisibleIndex="0" Name="colCMDStaffTypes" ShowEditButton="True" ShowNewButtonInHeader="true" ShowDeleteButton="True" ShowClearFilterButton="True" />
                                        <dx:GridViewDataTextColumn FieldName="StaffTypeId" ReadOnly="True" ShowInCustomizationForm="True"
                                            Visible="False" VisibleIndex="1">
                                            <EditFormSettings Visible="False" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="StaffTypeName" ShowInCustomizationForm="True"
                                            VisibleIndex="2">
                                            <PropertiesTextEdit MaxLength="50" NullText="e.g. Academic">
                                                <ValidationSettings>
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                    </Columns>

                                </dx:ASPxGridView>
                                <asp:SqlDataSource ID="sqlDSStaffTypes" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                                    SelectCommand="spGT_StaffTypesLoadAll" SelectCommandType="StoredProcedure" DeleteCommand="spGT_StaffTypesDelete"
                                    DeleteCommandType="StoredProcedure" InsertCommand="spGT_StaffTypeInsert" InsertCommandType="StoredProcedure"
                                    UpdateCommand="spGT_StaffTypeUpdate" UpdateCommandType="StoredProcedure">
                                    <DeleteParameters>
                                        <asp:Parameter Name="StaffTypeId" Type="Int32" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="StaffTypeName" Type="String" />
                                    </InsertParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="StaffTypeId" Type="Int32" />
                                        <asp:Parameter Name="StaffTypeName" Type="String" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                            </div>
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
                <dx:TabPage Name="tabStaffStatusses" Text="Staff Statusses">
                    <ContentCollection>
                        <dx:ContentControl ID="ContentControl7" runat="server">
                            <div class="form-field">
                                <dx:ASPxGridView ID="gvStaffStatus" runat="server" AutoGenerateColumns="False" DataSourceID="sqlDSStaffStatus"
                                    KeyFieldName="StatusId"
                                    OnRowDeleted="gvStaffStatusses_RowDeleted"
                                    OnRowInserted="gvStaffStatusses_RowInserted"
                                    OnRowUpdated="gvStaffStatusses_RowUpdated">
                                    <Toolbars>
                                        <dx:GridViewToolbar>
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
                                        <dx:GridViewCommandColumn ShowInCustomizationForm="True" VisibleIndex="0" Name="colCMDStaffStatuses" ShowEditButton="True" ShowNewButtonInHeader="true" ShowDeleteButton="True" ShowClearFilterButton="True" />
                                        <dx:GridViewDataTextColumn FieldName="StatusId" ReadOnly="True" ShowInCustomizationForm="True"
                                            Visible="False" VisibleIndex="1">
                                            <PropertiesTextEdit MaxLength="50" NullText="e.g. Deceased">
                                                <ValidationSettings>
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesTextEdit>
                                            <EditFormSettings Visible="False" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="StatusName" ShowInCustomizationForm="True"
                                            VisibleIndex="2">
                                        </dx:GridViewDataTextColumn>
                                    </Columns>

                                </dx:ASPxGridView>
                                <asp:SqlDataSource ID="sqlDSStaffStatus" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                                    SelectCommand="spStaffStatusLoadAll" SelectCommandType="StoredProcedure" DeleteCommand="spStaffStatusDelete"
                                    DeleteCommandType="StoredProcedure" InsertCommand="spStaffStatusInsert" InsertCommandType="StoredProcedure"
                                    UpdateCommand="spStaffStatusUpdate" UpdateCommandType="StoredProcedure">
                                    <DeleteParameters>
                                        <asp:Parameter Name="StatusId" Type="Int32" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="StatusName" Type="String" />
                                    </InsertParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="StatusId" Type="Int32" />
                                        <asp:Parameter Name="StatusName" Type="String" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                            </div>
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
                <dx:TabPage Name="tabStaffTitles" Text="Staff Titles">
                    <ContentCollection>
                        <dx:ContentControl ID="ContentControl8" runat="server">
                            <div class="form-field">
                                <dx:ASPxGridView ID="gvStaffTitles" runat="server" AutoGenerateColumns="False" DataSourceID="sqlDSStaffTitles"
                                    KeyFieldName="StaffTitleId"
                                    OnRowDeleted="gvStaffTitles_RowDeleted"
                                    OnRowInserted="gvStaffTitles_RowInserted"
                                    OnRowUpdated="gvStaffTitles_RowUpdated">
                                    <Toolbars>
                                        <dx:GridViewToolbar>
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
                                        <dx:GridViewCommandColumn ShowInCustomizationForm="True" VisibleIndex="0" Name="colCMDStaffTitles" ShowEditButton="True" ShowNewButtonInHeader="true" ShowDeleteButton="True" ShowClearFilterButton="True" />
                                        <dx:GridViewDataTextColumn FieldName="StaffTitleId" ReadOnly="True" ShowInCustomizationForm="True"
                                            Visible="False" VisibleIndex="1">
                                            <EditFormSettings Visible="False" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn Caption="Title" FieldName="StaffTitleName" ShowInCustomizationForm="True"
                                            VisibleIndex="2">
                                            <PropertiesTextEdit MaxLength="50" NullText="e.g. Mr">
                                                <ValidationSettings>
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                    </Columns>

                                </dx:ASPxGridView>
                                <asp:SqlDataSource ID="sqlDSStaffTitles" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                                    SelectCommand="spGT_StaffTitlesLoadAll" SelectCommandType="StoredProcedure"
                                    DeleteCommand="spGT_StaffTitlesDelete" DeleteCommandType="StoredProcedure" InsertCommand="spGT_StaffTitlesInsert"
                                    InsertCommandType="StoredProcedure" UpdateCommand="spGT_StaffTitlesUpdate" UpdateCommandType="StoredProcedure">
                                    <DeleteParameters>
                                        <asp:Parameter Name="StaffTitleId" Type="Int32" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="StaffTitleName" Type="String" />
                                    </InsertParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="StaffTitleId" Type="Int32" />
                                        <asp:Parameter Name="StaffTitleName" Type="String" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                            </div>
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>

            </TabPages>
        </dx:ASPxPageControl>

    </div>
</asp:Content>

