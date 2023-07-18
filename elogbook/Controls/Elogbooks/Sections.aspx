<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeFile="Sections.aspx.cs" Inherits="Controls_Elogbooks_Sections" %>

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
            <dx:Tab Text="Elogbook Sections" NavigateUrl="#"></dx:Tab>
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
        <dx:ASPxGridView ID="gvElogbookSection" runat="server" AutoGenerateColumns="False"
            DataSourceID="sqlDSElogbookSection" KeyFieldName="SectionId" OnRowInserting="gvElogbooks_RowInserting" OnRowUpdating="gvElogbooks_RowUpdating">
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
                                    <SettingsEditing Mode="Batch">
            </SettingsEditing>
                                    <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" ShowFilterBar="Visible"></Settings>
                                    <SettingsBehavior AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" EnableRowHotTrack="True" ConfirmDelete="True" EnableCustomizationWindow="True"></SettingsBehavior>

                                    <SettingsPopup>
                                        <FilterControl AutoUpdatePosition="False"></FilterControl>
                                    </SettingsPopup>

                                    <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
            <Columns>
                <dx:GridViewCommandColumn Name="colCMDSections" ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="SectionId" ReadOnly="True"
                    VisibleIndex="1" Visible="False">
                </dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="SectionName" VisibleIndex="3">
    <PropertiesTextEdit>
        <ValidationSettings>
            <RequiredField IsRequired="True" />
        </ValidationSettings>
    </PropertiesTextEdit>
</dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Description"
                    VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DisplayOrder" VisibleIndex="5">
                    <PropertiesTextEdit MaxLength="4">
                        <ValidationSettings>
                            <RegularExpression ValidationExpression="\d+" />
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ElogbookName" Visible="False" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="InstitutionId" VisibleIndex="7" ReadOnly="True" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CreatedBy" VisibleIndex="8" ReadOnly="True" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="CreatedOn" ReadOnly="True" Visible="False" VisibleIndex="9">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="UpdatedBy" ReadOnly="True" Visible="False" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="UpdatedOn" ReadOnly="True" Visible="False" VisibleIndex="11">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataComboBoxColumn Caption="Elogbook" FieldName="ElogbookId" VisibleIndex="2">
                    <PropertiesComboBox DataSourceID="sqlDSELogbooks" TextField="ElogbookName" ValueField="ElogbookId">
                        <ValidationSettings>
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesComboBox>
                </dx:GridViewDataComboBoxColumn>
            </Columns>


            <Styles AdaptiveDetailButtonWidth="22"></Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="sqlDSElogbookSection" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
            SelectCommand="ElogbookSectionLoad" SelectCommandType="StoredProcedure" DeleteCommand="ElogbookSectionDelete"
            DeleteCommandType="StoredProcedure" InsertCommand="ElogbookSectionInsert" InsertCommandType="StoredProcedure"
            UpdateCommand="ElogbookSectionUpdate" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="SectionId" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="SectionName" Type="String" />
                <asp:Parameter Name="Description" Type="String" />
                <asp:Parameter Name="DisplayOrder" Type="Double" />
                <asp:Parameter Name="ElogbookId" Type="Int32" />
                <asp:Parameter Name="InstitutionId" Type="Int32" />
                <asp:Parameter Name="UpdatedBy" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="hfRole" Name="UserRole" PropertyName="Value" Type="String" />
                <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
                <asp:ControlParameter ControlID="hfInstitutionId" Name="InstitutionId" PropertyName="Value" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="SectionId" Type="Int32" />
                <asp:Parameter Name="SectionName" Type="String" />
                <asp:Parameter Name="Description" Type="String" />
                <asp:Parameter Name="DisplayOrder" Type="Double" />
                <asp:Parameter Name="ElogbookId" Type="Int32" />
                <asp:Parameter Name="InstitutionId" Type="Int32" />
                <asp:Parameter Name="UpdatedBy" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlDSELogbooks" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_ElogbooksLoadDDL" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="hfInstitutionId" Name="InstitutionId" PropertyName="Value" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
         <asp:SqlDataSource ID="sqlDSSupervisionPrograms" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
            SelectCommand="spGT_ProgrammeLoadAllDDL" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>


