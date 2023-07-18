<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeFile="Departments.aspx.cs" Inherits="Controls_Faculty_Departments" %>

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
            <dx:Tab Text="Departents" NavigateUrl="#"></dx:Tab>
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
        <dx:ASPxGridView ID="gvDepartments" runat="server" AutoGenerateColumns="False" DataSourceID="sqlDSDepartments"
            KeyFieldName="DepartmentId">
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
                <dx:GridViewCommandColumn ShowInCustomizationForm="True" VisibleIndex="0" Name="colCMDDepartments" ShowEditButton="True" ShowNewButtonInHeader="true" ShowDeleteButton="True" />
                <dx:GridViewDataTextColumn FieldName="DepartmentId" ReadOnly="True" ShowInCustomizationForm="True"
                    VisibleIndex="1" Visible="False">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DepartmentName" ShowInCustomizationForm="True"
                    VisibleIndex="2">
                    <PropertiesTextEdit MaxLength="50" NullText="e.g. Computer Science">
                        <ValidationSettings>
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="SchoolName" ShowInCustomizationForm="True"
                    VisibleIndex="3" Caption="Faculty">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataComboBoxColumn FieldName="SchoolId" ShowInCustomizationForm="True"
                    VisibleIndex="4" Visible="False">
                    <PropertiesComboBox ValueType="System.Int32" DataSourceID="sqlDSDepartmentsSchools"
                        IncrementalFilteringMode="Contains" TextField="SchoolName" ValueField="SchoolId">
                        <ValidationSettings>
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesComboBox>
                    <EditFormSettings Caption="School" Visible="True" />
                </dx:GridViewDataComboBoxColumn>
            </Columns>

            <Styles AdaptiveDetailButtonWidth="22"></Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="sqlDSDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
            SelectCommand="spGT_DepartmenTLoadAll" SelectCommandType="StoredProcedure" DeleteCommand="spGT_DepartmentDelete"
            DeleteCommandType="StoredProcedure" InsertCommand="spGT_DepartmentInsert" InsertCommandType="StoredProcedure"
            UpdateCommand="spGT_DepartmentUpdate" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="DepartmentId" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="DepartmentName" Type="String" />
                <asp:Parameter Name="SchoolId" Type="Int32" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="DepartmentId" Type="Int32" />
                <asp:Parameter Name="DepartmentName" Type="String" />
                <asp:Parameter Name="SchoolId" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlDSDepartmentsSchools" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
            SelectCommand="spGT_SchoolsLoadAllForGridView" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>

