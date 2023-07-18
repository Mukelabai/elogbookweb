<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeFile="Roles.aspx.cs" Inherits="RolesElog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LeftPanelContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="RightPanelContent" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="PageToolbar" runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageContent" runat="Server">
    <h3 class="section-caption contents-caption">Roles</h3>
    <div>
        <dx:ASPxLabel ID="lblMessage" runat="server">
        </dx:ASPxLabel>
        <asp:HiddenField ID="hfUsername" runat="server" />
        <asp:HiddenField ID="hfRole" runat="server" />
        <asp:HiddenField ID="hfInstitutionId" runat="server" />

    </div>
    <div class="form-field">
        <dx:ASPxGridView ID="gvRoles" runat="server" AutoGenerateColumns="False" ClientInstanceName="gvRoles" DataSourceID="sqlDSRoles" KeyFieldName="RoleId">
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
            <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />

            <Columns>
                <dx:GridViewCommandColumn SelectAllCheckboxMode="Page" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="RoleId" ShowInCustomizationForm="True" VisibleIndex="1" Visible="False" ReadOnly="True">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="RoleName" ShowInCustomizationForm="True" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="InstitutionId" ShowInCustomizationForm="True" VisibleIndex="3" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="InstitutionName" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="RoleRights" ShowInCustomizationForm="True" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
            </Columns>
            <Styles AdaptiveDetailButtonWidth="22">
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="sqlDSRoles" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_InstitutionRolesLoad" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
                <asp:ControlParameter ControlID="hfRole" Name="Role" PropertyName="Value" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    <div style="text-anchor: end; align-items: flex-end">
        <dx:ASPxButton ID="btnUpdateRights"  runat="server" OnClick="btnUpdateRights_Click" Text="Update Rights"></dx:ASPxButton>
        <dx:ASPxButton ID="btnDeleteRole0"  runat="server" OnClick="btnDeleteRole_Click" Text="Delete Role"></dx:ASPxButton>

    </div>
    <div class="formLayout-verticalAlign">
        <div class="formLayout-container">
           
            <dx:ASPxFormLayout runat="server" ID="FormLayout" ClientInstanceName="formLayout" UseDefaultPaddings="false">
                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                <SettingsItemCaptions Location="Top" />
                <Styles LayoutGroup-Cell-Paddings-Padding="0" LayoutItem-Paddings-PaddingBottom="8" />
                <Items>
                    <dx:LayoutGroup ShowCaption="False" GroupBoxDecoration="None" Paddings-Padding="16">
                        <Items>
                            <dx:LayoutItem ShowCaption="False" Name="lblMessageInfo">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxLabel ID="lblMessage2" runat="server" Text=""></dx:ASPxLabel>
                                        
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Institution" HelpText="Please, select institution for which you are to specify roles">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxComboBox ID="ddlInstitutions" runat="server" DataSourceID="sqlDSInstitutionsDDL" TextField="InstitutionName" ValueField="InstitutionId">
                                        </dx:ASPxComboBox>
                                        <asp:SqlDataSource ID="sqlDSInstitutionsDDL" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_InstitutionLoadAllDDL" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
                                                <asp:ControlParameter ControlID="hfRole" Name="Role" PropertyName="Value" Type="String" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="Role name">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxComboBox ID="ddlRoles" runat="server" DataSourceID="sqlDSRolesDDL" DropDownStyle="DropDown" TextField="RoleName" ValueField="RoleName">
                                            <ClearButton DisplayMode="Always">
                                            </ClearButton>
                                        </dx:ASPxComboBox>
                                        <asp:SqlDataSource ID="sqlDSRolesDDL" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_RolesLoadAllDDL" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                           
                             <dx:LayoutItem Caption="Role Rights" Paddings-PaddingTop="13">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxCheckBoxList ID="chkRights" runat="server" RepeatColumns="3">
                                                                            <Items>
                                                                                <dx:ListEditItem Text="Manage Users" Value="Manage Users" />
                                                                                <dx:ListEditItem Text="Manage Roles" Value="Manage Roles" />
                                                                                <dx:ListEditItem Text="Manage Institution Details" Value="Manage Institution Details" />
                                                                                <dx:ListEditItem Text="Manage Schools" Value="Manage Schools" />
                                                                                <dx:ListEditItem Text="Manage Departments" Value="Manage Departments" />
                                                                                <dx:ListEditItem Text="Manage Staff" Value="Manage Staff" />
                                                                                <dx:ListEditItem Text="View Staff" Value="View Staff" />
                                                                                <dx:ListEditItem Text="View Supervision" Value="View Supervision" />
                                                                                <dx:ListEditItem Text="Manage Programmes" Value="Manage Programmes" />
                                                                                <dx:ListEditItem Text="Manage Elogbooks" Value="Manage Elogbooks" />
                                                                                <dx:ListEditItem Text="Manage Elogbook Assignments" Value="Manage Elogbook Assignments" />
                                                                                <dx:ListEditItem Text="Manage Elogbook Grades" Value="Manage Elogbook Grades" />
                                                                                <dx:ListEditItem Text="Manage Hospitals" Value="Manage Hospitals" />
                                                                                <dx:ListEditItem Text="Manage Mentors" Value="Manage Mentors" />
                                                                                <dx:ListEditItem Text="View Submissions" Value="View Submissions" />
                                                                                <dx:ListEditItem Text="Build Reports" Value="Build Reports" />   
                                                                                <dx:ListEditItem Text="View Reports" Value="View Reports" />                                                                             
                                                                                <dx:ListEditItem Text="Manage Announcements" Value="Manage Announcements" />
                                                                                <dx:ListEditItem Text="View Students" Value="View Students" />
                                                                                <dx:ListEditItem Text="Manage Students" Value="Manage Students" />
                                                                                
                                                                                

                                                                            </Items>
                                                                        </dx:ASPxCheckBoxList>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem ShowCaption="False" Name="GeneralError">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <div id="GeneralErrorDiv" runat="server" class="formLayout-generalErrorText"></div>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>

                    <dx:LayoutGroup GroupBoxDecoration="HeadingLine" ShowCaption="False">
                        <Paddings PaddingTop="13" PaddingBottom="13" />
                        <GroupBoxStyle CssClass="formLayout-groupBox" />
                        <Items>
                            <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center" Paddings-Padding="0">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxButton ID="btnSaveRoleName0" runat="server" OnClick="btnSaveRoleName_Click" Text="Save"></dx:ASPxButton>
                                        <dx:ASPxButton ID="btnClear"  runat="server" OnClick="btnClear_Click" Text="Clear"></dx:ASPxButton>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>
                </Items>
            </dx:ASPxFormLayout>
        </div>
    </div>
</asp:Content>

