<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeFile="Elogbooks.aspx.cs" Inherits="Controls_Elogbooks_Elogbooks" %>

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
            <dx:Tab Text="Elogbooks" NavigateUrl="#"></dx:Tab>
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
        <dx:ASPxGridView ID="gvElogbooks" runat="server" AutoGenerateColumns="False"
            DataSourceID="sqlDSElogbooks" KeyFieldName="ElogbookId" OnRowInserting="gvElogbooks_RowInserting" OnRowUpdating="gvElogbooks_RowUpdating">
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
            <Columns>
                <dx:GridViewCommandColumn Name="colCMDElogbooks" ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="ElogbookId" ReadOnly="True"
                    VisibleIndex="1" Visible="False">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ElogbookName"
                    VisibleIndex="2">
                    <PropertiesTextEdit>
                        <ValidationSettings>
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="StudyYear" VisibleIndex="5">
                    <PropertiesTextEdit MaxLength="1">
                        <ValidationSettings>
                            <RegularExpression ValidationExpression="\d+" />
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Version" VisibleIndex="6">
                    <PropertiesTextEdit>
                        <ValidationSettings>
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="InstitutionId" ReadOnly="True" Visible="False" VisibleIndex="7">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CreatedBy" ReadOnly="True" Visible="False" VisibleIndex="8">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="CreatedOn" ReadOnly="True" Visible="False" VisibleIndex="9">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="UpdatedBy" ReadOnly="True" Visible="False" VisibleIndex="10">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="UpdatedOn" ReadOnly="True" Visible="False" VisibleIndex="11">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataComboBoxColumn Caption="Program" FieldName="ProgramId" VisibleIndex="4">
                    <PropertiesComboBox DataSourceID="sqlDSSupervisionPrograms" TextField="ProgramName" ValueField="ProgramId" ValueType="System.Int32">
                        <ValidationSettings>
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesComboBox>
                </dx:GridViewDataComboBoxColumn>
            </Columns>


            <Styles AdaptiveDetailButtonWidth="22"></Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="sqlDSElogbooks" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
            SelectCommand="spGT_ElogbooksLoad" SelectCommandType="StoredProcedure" DeleteCommand="spGT_ElogbooksDelete"
            DeleteCommandType="StoredProcedure" InsertCommand="spGT_ElogbooksInsert" InsertCommandType="StoredProcedure"
            UpdateCommand="spGT_ElogbooksUpdate" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="ElogbookId" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="ElogbookName" Type="String" />
                <asp:Parameter Name="Description" Type="String" />
                <asp:Parameter Name="ProgramId" Type="Int32" />
                <asp:Parameter Name="StudyYear" Type="Int32" />
                <asp:Parameter Name="Version" Type="String" />
                <asp:Parameter Name="InstitutionId" Type="Int32" />
                <asp:Parameter Name="UpdatedBy" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="hfRole" Name="UserRole" PropertyName="Value" Type="String" />
                <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
                <asp:ControlParameter ControlID="hfInstitutionId" Name="InstitutionId" PropertyName="Value" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="ElogbookId" Type="Int32" />
                <asp:Parameter Name="ElogbookName" Type="String" />
                <asp:Parameter Name="Description" Type="String" />
                <asp:Parameter Name="ProgramId" Type="Int32" />
                <asp:Parameter Name="StudyYear" Type="Int32" />
                <asp:Parameter Name="Version" Type="String" />
                <asp:Parameter Name="InstitutionId" Type="Int32" />
                <asp:Parameter Name="UpdatedBy" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlDSProvicncesElogbooks" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
            DeleteCommand="spGT_ElogbooksDelete" DeleteCommandType="StoredProcedure" InsertCommand="spGT_ElogbooksInsert"
            InsertCommandType="StoredProcedure" SelectCommand="spGT_SAProvincesLoad" SelectCommandType="StoredProcedure"
            UpdateCommand="spGT_ElogbooksUpdate" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="ElogbookId" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="ElogbookName" Type="String" />
                <asp:Parameter Name="ProvinceId" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="ElogbookId" Type="Int32" />
                <asp:Parameter Name="ElogbookName" Type="String" />
                <asp:Parameter Name="ProvinceId" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
         <asp:SqlDataSource ID="sqlDSSupervisionPrograms" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
            SelectCommand="spGT_ProgrammeLoadAllDDL" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>

