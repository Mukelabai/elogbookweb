<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeFile="Assignments.aspx.cs" Inherits="Controls_Assignments_Assignments" %>

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
            <dx:Tab Text="Assignments" NavigateUrl="#"></dx:Tab>
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
        <dx:ASPxGridView ID="gvAssignments" runat="server" AutoGenerateColumns="False" DataSourceID="sqlDSAssignments" KeyFieldName="AssignmentId" OnRowInserting="gvAssignments_RowInserting" OnRowUpdating="gvAssignments_RowUpdating">
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

                                    <SettingsPopup>
                                        <FilterControl AutoUpdatePosition="False"></FilterControl>
                                    </SettingsPopup>

                                    <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
            <Columns>
                <dx:GridViewCommandColumn Name="colCMDAssignments" ShowClearFilterButton="True" ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="AssignmentId" ReadOnly="True" Visible="False" VisibleIndex="1">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Assignment #" FieldName="AssignmentNumber" VisibleIndex="2">
                    <PropertiesTextEdit>
                        <ValidationSettings>
                            <RegularExpression ErrorText="Enter a number" ValidationExpression="\d+" />
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Rotation" VisibleIndex="3">
                    <PropertiesTextEdit>
                        <ValidationSettings>
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="RotationStart" VisibleIndex="4">
                    <PropertiesDateEdit>
                        <ValidationSettings>
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="RotationEnd" VisibleIndex="5">
                    <PropertiesDateEdit>
                        <ValidationSettings>
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="AcademicYear" VisibleIndex="7">
                    <PropertiesTextEdit MaxLength="4">
                        <ValidationSettings>
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="DueDate" VisibleIndex="8">
                    <PropertiesDateEdit>
                        <ValidationSettings>
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="InstitutionId" ReadOnly="True" Visible="False" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CreatedBy" ReadOnly="True" Visible="False" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="CreatedOn" ReadOnly="True" Visible="False" VisibleIndex="11">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="UpdatedBy" ReadOnly="True" Visible="False" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="UpdatedOn" ReadOnly="True" Visible="False" VisibleIndex="13">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataComboBoxColumn Caption="Elogbook" FieldName="ElogbookId" VisibleIndex="6">
                    <PropertiesComboBox DataSourceID="sqlDSELogbooks" TextField="ElogbookName" ValueField="ElogbookId" ValueType="System.Int32">
                        <ValidationSettings>
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesComboBox>
                </dx:GridViewDataComboBoxColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="sqlDSAssignments" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" DeleteCommand="spGT_ElogbookAssignmentsDelete" DeleteCommandType="StoredProcedure" InsertCommand="spGT_ElogbookAssignmentsInsert" InsertCommandType="StoredProcedure" SelectCommand="spGT_ELogbookAssignmentsLoadAll" SelectCommandType="StoredProcedure" UpdateCommand="spGT_ElogbookAssignmentsUpdate" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="AssignmentId" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="AssignmentNumber" Type="Int32" />
                <asp:Parameter Name="Rotation" Type="String" />
                <asp:Parameter DbType="Date" Name="RotationStart" />
                <asp:Parameter DbType="Date" Name="RotationEnd" />
                <asp:Parameter Name="ElogbookId" Type="Int32" />
                <asp:Parameter Name="AcademicYear" Type="Int32" />
                <asp:Parameter DbType="Date" Name="DueDate" />
                <asp:Parameter Name="InstitutionId" Type="Int32" />
                <asp:Parameter Name="UpdatedBy" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="hfInstitutionId" Name="InstitutionId" PropertyName="Value" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="AssignmentId" Type="Int32" />
                <asp:Parameter Name="AssignmentNumber" Type="Int32" />
                <asp:Parameter Name="Rotation" Type="String" />
                <asp:Parameter DbType="Date" Name="RotationStart" />
                <asp:Parameter DbType="Date" Name="RotationEnd" />
                <asp:Parameter Name="ElogbookId" Type="Int32" />
                <asp:Parameter Name="AcademicYear" Type="Int32" />
                <asp:Parameter DbType="Date" Name="DueDate" />
                <asp:Parameter Name="InstitutionId" Type="Int32" />
                <asp:Parameter Name="UpdatedBy" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
    <asp:SqlDataSource ID="sqlDSELogbooks" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_ElogbooksLoadDDL" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="hfInstitutionId" Name="InstitutionId" PropertyName="Value" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

