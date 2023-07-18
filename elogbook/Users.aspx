<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeFile="Users.aspx.cs" Inherits="Users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LeftPanelContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="RightPanelContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="PageToolbar" Runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageContent" Runat="Server">
     <h3 class="section-caption contents-caption">Users</h3>
    <div class="form-field">
        <dx:ASPxLabel ID="lblMessage" runat="server">
                </dx:ASPxLabel>
                <asp:HiddenField ID="hfUsername" runat="server" />
                <asp:HiddenField ID="hfRole" runat="server" />
                <asp:HiddenField ID="hfInstitutionId" runat="server" />
    </div>
    <div>
        <asp:SqlDataSource ID="sqlDSRolesInstitutionDDL" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_RolesLoadAllDDLInstitution" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="hfInstitutionId" Name="InstitutionId" PropertyName="Value" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
    </div>
    <div class="form-field">
        <dx:ASPxGridView ID="gvUsers" runat="server" AutoGenerateColumns="False" ClientInstanceName="gvRoles" DataSourceID="sqlDSUsers" OnRowInserting="gvUsers_RowInserting" OnRowUpdating="gvUsers_RowUpdating" KeyFieldName="UserName">
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
            <SettingsPager Position="TopAndBottom">
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
            <SettingsDataSecurity AllowDelete="False" AllowEdit="True" AllowInsert="True" />

                                <Columns>
                                    <dx:GridViewCommandColumn ShowEditButton="True" ShowInCustomizationForm="True" ShowNewButtonInHeader="True" VisibleIndex="0" SelectAllCheckboxMode="Page" ShowSelectCheckbox="True">
                                    </dx:GridViewCommandColumn>
                                    <dx:GridViewDataTextColumn FieldName="UserName" ShowInCustomizationForm="True" VisibleIndex="1">
                                        <PropertiesTextEdit>
                                            <ValidationSettings>
                                                <RequiredField IsRequired="True" />
                                            </ValidationSettings>
                                        </PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Email" ShowInCustomizationForm="True" VisibleIndex="2">
                                        <PropertiesTextEdit>
                                            <ValidationSettings>
                                                <RegularExpression ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                                <RequiredField IsRequired="True" />
                                            </ValidationSettings>
                                        </PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataCheckColumn FieldName="IsApproved" ShowInCustomizationForm="True" VisibleIndex="3">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataDateColumn FieldName="CreateDate" ShowInCustomizationForm="True" VisibleIndex="4" Visible="False">
                                        <EditFormSettings Visible="False" />
                                    </dx:GridViewDataDateColumn>
                                    <dx:GridViewDataDateColumn FieldName="LastLoginDate" ShowInCustomizationForm="True" VisibleIndex="5">
                                        <EditFormSettings Visible="False" />
                                    </dx:GridViewDataDateColumn>
                                    <dx:GridViewDataDateColumn FieldName="LastActivityDate" ShowInCustomizationForm="True" VisibleIndex="6" Visible="False">
                                        <EditFormSettings Visible="False" />
                                    </dx:GridViewDataDateColumn>
                                    <dx:GridViewDataDateColumn FieldName="LastPasswordChangedDate" ShowInCustomizationForm="True" Visible="False" VisibleIndex="7">
                                        <EditFormSettings Visible="False" />
                                    </dx:GridViewDataDateColumn>
                                    <dx:GridViewDataTextColumn FieldName="UserId" ShowInCustomizationForm="True" Visible="False" VisibleIndex="8">
                                        <EditFormSettings Visible="False" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataCheckColumn FieldName="IsLockedOut" ShowInCustomizationForm="True" VisibleIndex="9">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataDateColumn FieldName="LastLockoutDate" ShowInCustomizationForm="True" Visible="False" VisibleIndex="10">
                                        <EditFormSettings Visible="False" />
                                    </dx:GridViewDataDateColumn>
                                    <dx:GridViewDataTextColumn FieldName="Password" ShowInCustomizationForm="True" Visible="False" VisibleIndex="11" PropertiesTextEdit-Password="true">
                                        <PropertiesTextEdit Password="True"></PropertiesTextEdit>

                                        <EditFormSettings Visible="True" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="ConfirmPassword" ShowInCustomizationForm="True" Visible="False" VisibleIndex="12" PropertiesTextEdit-Password="true">
                                        <PropertiesTextEdit Password="True"></PropertiesTextEdit>

                                        <EditFormSettings Visible="True" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataComboBoxColumn Caption="System Role" FieldName="RoleName" ShowInCustomizationForm="True" VisibleIndex="14">
                                        <PropertiesComboBox DataSourceID="sqlDSRoles0" TextField="RoleName" ValueField="RoleName">
                                            <Columns>
                                                <dx:ListBoxColumn FieldName="RoleId" Visible="False" />
                                                <dx:ListBoxColumn FieldName="RoleName" />
                                                <dx:ListBoxColumn FieldName="InstitutionName" />
                                            </Columns>
                                            <ValidationSettings>
                                                <RequiredField IsRequired="True" />
                                            </ValidationSettings>
                                        </PropertiesComboBox>
                                        <EditFormSettings Visible="True" />
                                    </dx:GridViewDataComboBoxColumn>
                                    <dx:GridViewDataCheckColumn FieldName="ResetPassword" ReadOnly="False" ShowInCustomizationForm="True" Visible="False" VisibleIndex="15">
                                        <EditFormSettings Visible="False" />
                                    </dx:GridViewDataCheckColumn>
                                </Columns>
                                <Styles AdaptiveDetailButtonWidth="22">
                                </Styles>
                            </dx:ASPxGridView>
                            <asp:SqlDataSource ID="sqlDSUsers" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" DeleteCommand="spGT_UserInsert" DeleteCommandType="StoredProcedure" InsertCommand="spGT_UserInsert" InsertCommandType="StoredProcedure" SelectCommand="spGT_UsersLoadAll" SelectCommandType="StoredProcedure" UpdateCommand="spGT_UserInsert" UpdateCommandType="StoredProcedure">
                                <DeleteParameters>
                                    <asp:Parameter Name="Username" Type="String" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="Username" Type="String" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
                                    <asp:ControlParameter ControlID="hfRole" Name="Role" PropertyName="Value" Type="String" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="Username" Type="String" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="sqlDSInstitutionsUsers" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_InstitutionLoadAllDDL" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
                                    <asp:ControlParameter ControlID="hfRole" Name="Role" PropertyName="Value" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="sqlDSRoles0" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_RolesLoadAll" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
                                    <asp:ControlParameter ControlID="hfRole" Name="Role" PropertyName="Value" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
    </div>
    <div class="form-field">
        <dx:ASPxButton ID="btnUnlockUser" runat="server"  OnClick="btnUnlockUser_Click" Text="Unlock User" />
                            <dx:ASPxButton  ID="btnDeleteUser" runat="server" OnClick="btnDeleteUser_Click" Text="Delete User"></dx:ASPxButton>
                            
                            <dx:ASPxButton ID="btnResetPassword"  runat="server" OnClick="btnResetUserPassword_Click" Text="Reset User Password" />

    </div>
</asp:Content>

