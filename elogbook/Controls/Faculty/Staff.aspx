<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeFile="Staff.aspx.cs" Inherits="Controls_Faculty_Staff" %>

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
            <dx:Tab Text="Staff" NavigateUrl="#"></dx:Tab>
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
                <dx:TabPage Name="tabStaff" Text="Staff">
                    <ContentCollection>
                        <dx:ContentControl ID="ContentControl1" runat="server">
                            <div class="form-field">

                                <dx:ASPxGridView ID="gvStaff" runat="server" AutoGenerateColumns="False" DataSourceID="sqlDSStaff"
                                    KeyFieldName="StaffId" ClientInstanceName="gvStaff"
                                    OnRowInserted="gvStaff_RowInserted" OnRowDeleted="gvStaff_RowDeleted"
                                    OnRowUpdated="gvStaff_RowUpdated" OnCellEditorInitialize="gvStaff_CellEditorInitialize" OnRowInserting="gvStaff_RowInserting">
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
                                        <dx:GridViewCommandColumn ShowInCustomizationForm="True" VisibleIndex="0" Name="colCMDStaff" ShowSelectCheckbox="True" ShowEditButton="True" ShowNewButtonInHeader="true" ShowDeleteButton="True" />
                                        <dx:GridViewDataTextColumn FieldName="StaffId" ShowInCustomizationForm="True" VisibleIndex="1"
                                            ReadOnly="True" Visible="False">
                                            <EditFormSettings Visible="False" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="StaffNumber" ShowInCustomizationForm="True"
                                            VisibleIndex="2" Caption="Staff No." ToolTip="Can be Social Security Number or Man Number">
                                            <PropertiesTextEdit MaxLength="50" NullText="e.g. 4567">
                                                <ValidationSettings>
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataComboBoxColumn FieldName="TitleId" ShowInCustomizationForm="True"
                                            VisibleIndex="3" Caption="Title">
                                            <PropertiesComboBox ValueType="System.Int32" DataSourceID="sqlDSStaffStaffTitles"
                                                IncrementalFilteringMode="Contains" TextField="StaffTitleName" ValueField="StaffTitleId">
                                                <ValidationSettings>
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesComboBox>
                                        </dx:GridViewDataComboBoxColumn>
                                        <dx:GridViewDataTextColumn FieldName="FirstName" ShowInCustomizationForm="True" VisibleIndex="5">
                                            <PropertiesTextEdit>
                                                <ValidationSettings>
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="LastName" ShowInCustomizationForm="True" VisibleIndex="4">
                                            <PropertiesTextEdit>
                                                <ValidationSettings>
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataComboBoxColumn FieldName="Sex" ShowInCustomizationForm="True" VisibleIndex="6">
                                            <PropertiesComboBox ValueType="System.String" IncrementalFilteringMode="Contains">
                                                <Items>
                                                    <dx:ListEditItem Text="Male" Value="Male" />
                                                    <dx:ListEditItem Text="Female" Value="Female" />
                                                </Items>
                                                <ValidationSettings>
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesComboBox>
                                        </dx:GridViewDataComboBoxColumn>
                                        <dx:GridViewDataDateColumn FieldName="DateOfBirth" ShowInCustomizationForm="True"
                                            VisibleIndex="7" Visible="False">
                                            <PropertiesDateEdit NullText="Select or type mm/dd/yyy">
                                            </PropertiesDateEdit>
                                            <EditFormSettings Visible="True" />
                                        </dx:GridViewDataDateColumn>
                                        <dx:GridViewDataDateColumn FieldName="EngangementDate" ShowInCustomizationForm="True"
                                            VisibleIndex="8" Visible="False">
                                            <PropertiesDateEdit NullText="Select or type mm/dd/yyy">
                                            </PropertiesDateEdit>
                                            <EditFormSettings Visible="True" />
                                        </dx:GridViewDataDateColumn>
                                        <dx:GridViewDataTextColumn FieldName="BusinessPhone" ShowInCustomizationForm="True"
                                            VisibleIndex="9" Visible="False">
                                            <PropertiesTextEdit NullText="211223344">
                                            </PropertiesTextEdit>
                                            <EditFormSettings Visible="True" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="MobileNumber" ShowInCustomizationForm="True"
                                            VisibleIndex="10" Visible="False">
                                            <PropertiesTextEdit NullText="0955441447">
                                            </PropertiesTextEdit>
                                            <EditFormSettings Visible="True" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="OfficeExtension" ShowInCustomizationForm="True"
                                            VisibleIndex="11" Caption="Office Ext.">
                                            <PropertiesTextEdit NullText="4756">
                                            </PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="EmailAddress" ShowInCustomizationForm="True"
                                            VisibleIndex="12" Caption="Email">
                                            <PropertiesTextEdit NullText="you@me.com">
                                                <ValidationSettings>
                                                    <RegularExpression ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                                </ValidationSettings>
                                            </PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="PostalAddress" ShowInCustomizationForm="True"
                                            VisibleIndex="13" Visible="False">
                                            <PropertiesTextEdit NullText="e.g. PO Box 32379, Lusaka">
                                            </PropertiesTextEdit>
                                            <EditFormSettings Visible="True" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="PhysicalAddress" ShowInCustomizationForm="True"
                                            VisibleIndex="14" Visible="False">
                                            <PropertiesTextEdit MaxLength="300" NullText="e.g. Plot 1423, Palm Drive, Chelstone">
                                            </PropertiesTextEdit>
                                            <EditFormSettings Visible="True" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataComboBoxColumn FieldName="Nationality" ShowInCustomizationForm="True"
                                            VisibleIndex="15" Visible="False">
                                            <PropertiesComboBox ValueType="System.String" DataSourceID="sqlDSStaffCountries"
                                                IncrementalFilteringMode="Contains" TextField="CountryName" ValueField="CountryName">
                                                <ValidationSettings>
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesComboBox>
                                            <EditFormSettings Visible="True" />
                                        </dx:GridViewDataComboBoxColumn>
                                        <dx:GridViewDataTextColumn FieldName="NationalId" ShowInCustomizationForm="True"
                                            VisibleIndex="16" Visible="False">
                                            <PropertiesTextEdit>
                                                <ValidationSettings>
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesTextEdit>
                                            <EditFormSettings Visible="True" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataComboBoxColumn FieldName="NationalIdType" ShowInCustomizationForm="True"
                                            VisibleIndex="17" Visible="False">
                                            <PropertiesComboBox ValueType="System.String" IncrementalFilteringMode="Contains"
                                                NullDisplayText="Select">
                                                <Items>
                                                    <dx:ListEditItem Text="National Registration" Value="National Registration" />
                                                    <dx:ListEditItem Text="Passport" Value="Passport" />
                                                </Items>
                                                <ValidationSettings>
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesComboBox>
                                            <EditFormSettings Visible="True" />
                                        </dx:GridViewDataComboBoxColumn>
                                        <dx:GridViewDataCheckColumn FieldName="IsLecturer" ShowInCustomizationForm="True"
                                            VisibleIndex="18" Visible="False">
                                            <PropertiesCheckEdit DisplayTextChecked="Lecturer" DisplayTextGrayed="NotLecturer"
                                                DisplayTextUnchecked="NotLecturer" DisplayTextUndefined="NotLecturer">
                                            </PropertiesCheckEdit>
                                        </dx:GridViewDataCheckColumn>
                                        <dx:GridViewDataComboBoxColumn FieldName="StaffTypeId" ShowInCustomizationForm="True"
                                            VisibleIndex="19" Caption="Staff Type">
                                            <PropertiesComboBox ValueType="System.String" DataSourceID="sqlDSStaffStaffTypes"
                                                IncrementalFilteringMode="Contains" TextField="StaffTypeName" ValueField="StaffTypeId">
                                                <ValidationSettings>
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesComboBox>
                                        </dx:GridViewDataComboBoxColumn>
                                        <dx:GridViewDataComboBoxColumn FieldName="StatusId" ShowInCustomizationForm="True"
                                            VisibleIndex="20" Caption="Status" Visible="False">
                                            <PropertiesComboBox ValueType="System.Int32" DataSourceID="sqlDSStaffStaffStatuses"
                                                IncrementalFilteringMode="Contains" TextField="StatusName" ValueField="StatusId">
                                                <ValidationSettings>
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesComboBox>
                                            <EditFormSettings Visible="True" />
                                        </dx:GridViewDataComboBoxColumn>
                                        <dx:GridViewDataComboBoxColumn FieldName="DepartmentId" ShowInCustomizationForm="True"
                                            VisibleIndex="21" Caption="Department">
                                            <PropertiesComboBox ValueType="System.Int32" DataSourceID="sqlDSStaffDepartments"
                                                IncrementalFilteringMode="Contains" TextField="DepartmentName" ValueField="DepartmentId">
                                                <ValidationSettings>
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesComboBox>
                                        </dx:GridViewDataComboBoxColumn>
                                        <dx:GridViewDataComboBoxColumn FieldName="CentreId" ShowInCustomizationForm="True"
                                            VisibleIndex="22" Caption="Centre" Visible="False">
                                            <PropertiesComboBox ValueType="System.Int32" DataSourceID="sqlDSStaffCentres" IncrementalFilteringMode="Contains"
                                                TextField="CentreName" ValueField="CentreId">
                                                <ValidationSettings>
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesComboBox>
                                            <EditFormSettings Visible="True" />
                                        </dx:GridViewDataComboBoxColumn>
                                        <dx:GridViewDataComboBoxColumn FieldName="RoleName" ShowInCustomizationForm="True"
                                            VisibleIndex="23" Visible="False">
                                            <PropertiesComboBox ValueType="System.String" IncrementalFilteringMode="Contains" DataSourceID="sqlDSStaffRoles" TextField="RoleName" ValueField="RoleName">
                                            </PropertiesComboBox>
                                            <EditFormSettings Caption="System Role" Visible="True" />
                                        </dx:GridViewDataComboBoxColumn>
                                        <dx:GridViewDataComboBoxColumn Caption="Institution" FieldName="InstitutionId" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="24">
                                            <PropertiesComboBox DataSourceID="sqlDSStaffInstitutions" TextField="InstitutionName" ValueField="InstitutionId">
                                            </PropertiesComboBox>
                                            <EditFormSettings Visible="True" />
                                        </dx:GridViewDataComboBoxColumn>
                                        <dx:GridViewDataTextColumn FieldName="WebUsername" ShowInCustomizationForm="True" Visible="False" VisibleIndex="25">
                                            <EditFormSettings Visible="False" />
                                        </dx:GridViewDataTextColumn>
                                    </Columns>

                                    <Styles AdaptiveDetailButtonWidth="22"></Styles>

                                </dx:ASPxGridView>
                                <dx:ASPxButton ID="btnCreateUserAccounts" runat="server" OnClick="btnCreateUserAccounts_Click" Text="Update User Accounts">
                                </dx:ASPxButton>
                                <asp:SqlDataSource ID="sqlDSStaff" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                                    SelectCommand="spGT_StaffLoadAll" SelectCommandType="StoredProcedure" DeleteCommand="spGT_StaffDelete"
                                    DeleteCommandType="StoredProcedure" InsertCommand="spGT_StaffInsert" InsertCommandType="StoredProcedure"
                                    UpdateCommand="spGT_StaffUpdate" UpdateCommandType="StoredProcedure">
                                    <DeleteParameters>
                                        <asp:Parameter Name="StaffId" Type="Int32" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="StaffNumber" Type="String" />
                                        <asp:Parameter Name="TitleId" Type="Int32" />
                                        <asp:Parameter Name="FirstName" Type="String" />
                                        <asp:Parameter Name="LastName" Type="String" />
                                        <asp:Parameter Name="Sex" Type="String" />
                                        <asp:Parameter DbType="Date" Name="DateOfBirth" />
                                        <asp:Parameter DbType="Date" Name="EngangementDate" />
                                        <asp:Parameter Name="BusinessPhone" Type="String" />
                                        <asp:Parameter Name="MobileNumber" Type="String" />
                                        <asp:Parameter Name="OfficeExtension" Type="String" />
                                        <asp:Parameter Name="EmailAddress" Type="String" />
                                        <asp:Parameter Name="PostalAddress" Type="String" />
                                        <asp:Parameter Name="PhysicalAddress" Type="String" />
                                        <asp:Parameter Name="Nationality" Type="String" />
                                        <asp:Parameter Name="NationalId" Type="String" />
                                        <asp:Parameter Name="NationalIdType" Type="String" />
                                        <asp:Parameter Name="IsLecturer" Type="Boolean" />
                                        <asp:Parameter Name="StaffTypeId" Type="Int32" />
                                        <asp:Parameter Name="StatusId" Type="Int32" />
                                        <asp:Parameter Name="DepartmentId" Type="Int32" />
                                        <asp:Parameter Name="CentreId" Type="Int32" />
                                        <asp:Parameter Name="RoleName" Type="String" />
                                        <asp:Parameter Name="InstitutionId" Type="Int32" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hfUsername" Name="Username"
                                            PropertyName="Value" Type="String" />
                                        <asp:ControlParameter ControlID="hfRole" Name="Role"
                                            PropertyName="Value" Type="String" />
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="StaffId" Type="Int32" />
                                        <asp:Parameter Name="StaffNumber" Type="String" />
                                        <asp:Parameter Name="TitleId" Type="Int32" />
                                        <asp:Parameter Name="FirstName" Type="String" />
                                        <asp:Parameter Name="LastName" Type="String" />
                                        <asp:Parameter Name="Sex" Type="String" />
                                        <asp:Parameter DbType="Date" Name="DateOfBirth" />
                                        <asp:Parameter DbType="Date" Name="EngangementDate" />
                                        <asp:Parameter Name="BusinessPhone" Type="String" />
                                        <asp:Parameter Name="MobileNumber" Type="String" />
                                        <asp:Parameter Name="OfficeExtension" Type="String" />
                                        <asp:Parameter Name="EmailAddress" Type="String" />
                                        <asp:Parameter Name="PostalAddress" Type="String" />
                                        <asp:Parameter Name="PhysicalAddress" Type="String" />
                                        <asp:Parameter Name="Nationality" Type="String" />
                                        <asp:Parameter Name="NationalId" Type="String" />
                                        <asp:Parameter Name="NationalIdType" Type="String" />
                                        <asp:Parameter Name="IsLecturer" Type="Boolean" />
                                        <asp:Parameter Name="StaffTypeId" Type="Int32" />
                                        <asp:Parameter Name="StatusId" Type="Int32" />
                                        <asp:Parameter Name="DepartmentId" Type="Int32" />
                                        <asp:Parameter Name="CentreId" Type="Int32" />
                                        <asp:Parameter Name="RoleName" Type="String" />
                                        <asp:Parameter Name="InstitutionId" Type="Int32" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="sqlDSStaffStaffTitles" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                                    SelectCommand="spGT_StaffTitlesLoadAll" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                <asp:SqlDataSource ID="sqlDSStaffCentres" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                                    SelectCommand="spGT_CentresLoadDDL" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="sqlDSStaffStaffStatuses" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                                    SelectCommand="spStaffStatusLoadAll" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                <asp:SqlDataSource ID="sqlDSStaffStaffTypes" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                                    SelectCommand="spGT_StaffTypesLoadAll" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                <asp:SqlDataSource ID="sqlDSStaffDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                                    SelectCommand="spGT_DepartmentLoadForDDL" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hfUsername" Name="Username"
                                            PropertyName="Value" Type="String" />
                                        <asp:ControlParameter ControlID="hfRole" Name="UserRole"
                                            PropertyName="Value" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="sqlDSStaffCountries" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                                    SelectCommand="spGT_CountriesLoad" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                <asp:SqlDataSource ID="sqlDSStaffInstitutions" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_InstitutionLoadAllDDL" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
                                        <asp:ControlParameter ControlID="hfRole" Name="Role" PropertyName="Value" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="sqlDSStaffRoles" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_RolesLoadAllDDLInstitutionByUser" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <dx:ASPxGridViewExporter ID="ASPxGridViewExporter5" runat="server">
                                </dx:ASPxGridViewExporter>
                            </div>
                            <div class="form-field">
                                <dx:ASPxRoundPanel ID="rpAssignUserName" runat="server" AllowCollapsingByHeaderClick="True" HeaderText="Assign existing username to staff member" ShowCollapseButton="True" Width="200px">
                                    <PanelCollection>
                                        <dx:PanelContent runat="server">
                                            <div class="form-field">
                                                <dx:ASPxLabel ID="lblMessageAssign" runat="server" Text=""></dx:ASPxLabel>
                                            </div>
                                            <div class="form-field">Select staff member (type for quick selection)</div>
                                            <div class="form-field">
                                                <dx:ASPxComboBox ID="ddlStaff" runat="server" ValueType="System.Int32" DataSourceID="sqlDSStaffDDL" TextField="StaffName" ValueField="StaffId"></dx:ASPxComboBox>
                                                <asp:SqlDataSource ID="sqlDSStaffDDL" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_StaffLoadDDL" SelectCommandType="StoredProcedure">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
                                                        <asp:ControlParameter ControlID="hfRole" Name="Role" PropertyName="Value" Type="String" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </div>
                                            <div class="form-field">Select username (type for quick selection)</div>
                                            <div class="form-field">
                                                <dx:ASPxComboBox ID="ddlUsernames" runat="server" ValueType="System.String" DataSourceID="sqlDSUsernames" TextField="UserName" ValueField="UserName"></dx:ASPxComboBox>
                                                <asp:SqlDataSource ID="sqlDSUsernames" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_UsersnamesLoadStaff" SelectCommandType="StoredProcedure">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
                                                        <asp:ControlParameter ControlID="hfRole" Name="Role" PropertyName="Value" Type="String" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                                <dx:ASPxButton ID="btnAssignUserName" runat="server" OnClick="btnAssignUserName_Click" Text="Assign" />
                                            </div>
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxRoundPanel>
                            </div>
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
                <dx:TabPage Name="tabStaffCourses" Text="Supervisors" ToolTip="Staff that supervise student rotations">
                    <ContentCollection>
                        <dx:ContentControl runat="server">
                            <div class="form-field">
                                <dx:ASPxGridView ID="gvStaffCourses" runat="server" AutoGenerateColumns="False" DataSourceID="sqlDSSupervision"
                                    KeyFieldName="SupervisionId" OnRowInserting="gvStaffCourses_RowInserting">
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
                                        <dx:GridViewCommandColumn Name="colCMDSupervision" ShowInCustomizationForm="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                                        </dx:GridViewCommandColumn>
                                        <dx:GridViewDataTextColumn FieldName="SupervisionId" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                                            <EditFormSettings Visible="False" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="InstitutionId" ShowInCustomizationForm="True" Visible="False" VisibleIndex="6">
                                            <EditFormSettings Visible="False" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="DepartmentName" ShowInCustomizationForm="True" VisibleIndex="7">
                                            <EditFormSettings Visible="False" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SchoolName" ShowInCustomizationForm="True" VisibleIndex="8">
                                            <EditFormSettings Visible="False" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataComboBoxColumn Caption="Supervisor" FieldName="StaffId" ShowInCustomizationForm="True" VisibleIndex="2">
                                            <PropertiesComboBox DataSourceID="sqlDSSupervisionStaff" TextField="StaffName" ValueField="StaffId" ValueType="System.Int32">
                                                <ValidationSettings>
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesComboBox>
                                        </dx:GridViewDataComboBoxColumn>
                                        <dx:GridViewDataComboBoxColumn Caption="Program" FieldName="ProgramId" ShowInCustomizationForm="True" VisibleIndex="3">
                                            <PropertiesComboBox DataSourceID="sqlDSSupervisionPrograms" TextField="ProgramName" ValueField="ProgramId" ValueType="System.Int32">
                                                <ValidationSettings>
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesComboBox>
                                        </dx:GridViewDataComboBoxColumn>
                                        <dx:GridViewDataComboBoxColumn FieldName="StudyYear" ShowInCustomizationForm="True" VisibleIndex="4">
                                            <PropertiesComboBox>
                                                <Items>
                                                    <dx:ListEditItem Text="1" Value="1" />
                                                    <dx:ListEditItem Text="2" Value="2" />
                                                    <dx:ListEditItem Text="3" Value="3" />
                                                    <dx:ListEditItem Text="4" Value="4" />
                                                    <dx:ListEditItem Text="5" Value="5" />
                                                    <dx:ListEditItem Text="6" Value="6" />
                                                    <dx:ListEditItem Text="7" Value="7" />
                                                </Items>
                                                <ValidationSettings>
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesComboBox>
                                        </dx:GridViewDataComboBoxColumn>
                                        <dx:GridViewDataSpinEditColumn FieldName="AcademicYear" ShowInCustomizationForm="True" VisibleIndex="5">
                                            <PropertiesSpinEdit DisplayFormatString="g" MaxValue="2099" MinValue="2021" NumberType="Integer">
                                                <ValidationSettings>
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesSpinEdit>
                                        </dx:GridViewDataSpinEditColumn>
                                    </Columns>
                                </dx:ASPxGridView>
                                <asp:SqlDataSource ID="sqlDSSupervision" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                                    SelectCommand="spGT_SupervisionLoadAll" SelectCommandType="StoredProcedure" DeleteCommand="spGT_SupervisionDelete"
                                    DeleteCommandType="StoredProcedure" InsertCommand="spGT_SupervisionInsert"
                                    InsertCommandType="StoredProcedure">
                                    <DeleteParameters>
                                        <asp:Parameter Name="SupervisionId" Type="Int32" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="StaffId" Type="Int32" />
                                        <asp:Parameter Name="ProgramId" Type="Int32" />
                                        <asp:Parameter Name="StudyYear" Type="Int32" />
                                        <asp:Parameter Name="AcademicYear" Type="Int32" />
                                        <asp:Parameter Name="InstitutionId" Type="Int32" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hfInstitutionId" Name="InstitutionId" PropertyName="Value" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="sqlDSSupervisionStaff" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                                    SelectCommand="spGT_StaffLoadDDL" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
                                        <asp:ControlParameter ControlID="hfRole" Name="Role" PropertyName="Value" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="sqlDSSupervisionPrograms" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                                    SelectCommand="spGT_ProgrammeLoadAllDDL" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
                <dx:TabPage Name="tabMentors" Text="Mentors">
                    <ContentCollection>
                        <dx:ContentControl>
                              <div class="form-field">
        <dx:ASPxGridView ID="gvMentors" runat="server" AutoGenerateColumns="False"
            DataSourceID="sqlDSMentors" KeyFieldName="MentorId" >
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
            <SettingsEditing Mode="Batch"></SettingsEditing>
                                    <SettingsPopup>
                                        <FilterControl AutoUpdatePosition="False"></FilterControl>
                                    </SettingsPopup>

                                    <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
            <Columns>
                <dx:GridViewCommandColumn Name="colCMDMentors" ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="MentorId" ReadOnly="True"
                    VisibleIndex="1" Visible="False">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="MentorName"
                    VisibleIndex="2">
                    <PropertiesTextEdit>
                        <ValidationSettings>
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                
              
            </Columns>


            <Styles AdaptiveDetailButtonWidth="22"></Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="sqlDSMentors" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
            SelectCommand="spGT_ElogbookMentorsLoadAll" SelectCommandType="StoredProcedure" DeleteCommand="spGT_ElogbookMentorsDelete"
            DeleteCommandType="StoredProcedure" InsertCommand="spGT_ElogbookMentorsInsert" InsertCommandType="StoredProcedure"
            UpdateCommand="spGT_ElogbookMentorsUpdate" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="MentorId" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="MentorName" Type="String" />                
                
                
            </InsertParameters>
            
            <UpdateParameters>
                <asp:Parameter Name="MentorId" Type="Int32" />
                <asp:Parameter Name="MentorName" Type="String" />                
                
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

