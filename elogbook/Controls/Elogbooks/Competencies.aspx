<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeFile="Competencies.aspx.cs" Inherits="Controls_Elogbooks_Competencies" %>


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
            <dx:Tab Text="Elogbook Competencies" NavigateUrl="#"></dx:Tab>
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
        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Select Elogbook">
        </dx:ASPxLabel>
        <dx:ASPxComboBox ID="ddlElogbooks" runat="server" Width="400px" ValueType="System.Int32" DataSourceID="sqlDSElogbooksDDL" TextField="ElogbookName" ValueField="ElogbookId" AutoPostBack="True" OnValueChanged="ddlElogbooks_ValueChanged">
            <ClearButton DisplayMode="Always">
            </ClearButton>
        </dx:ASPxComboBox>
       
        <asp:SqlDataSource ID="sqlDSElogbooksDDL" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_ElogbooksLoadDDL" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="hfInstitutionId" Name="InstitutionId" PropertyName="Value" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlDSSectionsDDL" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="ElogbookSectionLoadDDL" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlElogbooks" Name="ElogbookId" PropertyName="Value" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
         <asp:SqlDataSource ID="sqlDSParentQuestionsDDL" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_ElogbookQuestionsParentsDDL" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlElogbooks" Name="ElogbookId" PropertyName="Value" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlDSCategories" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_ElogbookAnalysisCategoriesLoadAll" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    </div>
    <div class="form-field">
         <dx:ASPxButton ID="btnPopulateTable" runat="server" Text="Populate With Questions from Elogbook" OnClick="btnPopulateTable_Click"></dx:ASPxButton>
    </div>
    <div class="form-field">
        <dx:ASPxGridView ID="gvParentQuestions" runat="server" AutoGenerateColumns="False" DataSourceID="sqlDSParentQuestions" KeyFieldName="CompetenceId">
          
            <SettingsEditing Mode="Batch">
            </SettingsEditing>
            <SettingsPopup>
                <FilterControl AutoUpdatePosition="False"></FilterControl>
            </SettingsPopup>
            <SettingsBehavior ConfirmDelete="true" />
            <SettingsDetail ShowDetailRow="True" />
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

            <SettingsDataSecurity AllowInsert="False" />

            <SettingsPopup>
                <FilterControl AutoUpdatePosition="False"></FilterControl>
            </SettingsPopup>

            <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
          
            <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="WYSIWYG" />
            <Columns>
                <dx:GridViewCommandColumn ShowDeleteButton="True" VisibleIndex="0" Name="colCMDParentQuestions">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="CompetenceId" ReadOnly="True" VisibleIndex="1" Visible="False">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ElogbookId" VisibleIndex="2" Visible="False">
                </dx:GridViewDataTextColumn>
                <%--<dx:GridViewDataTextColumn FieldName="SectionName" VisibleIndex="3">
                </dx:GridViewDataTextColumn>--%>
                <dx:GridViewDataTextColumn FieldName="QuestionId" VisibleIndex="4" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="QuestionText" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="QuestionOption" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Expected" VisibleIndex="7">
                    <PropertiesTextEdit>
                        <ValidationSettings>
                            <RegularExpression ValidationExpression="\d+" />
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CreatedBy" Visible="False" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="CreatedOn" Visible="False" VisibleIndex="9">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="UpdatedBy" Visible="False" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="UpdatedOn" Visible="False" VisibleIndex="11">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="InstitutionId" VisibleIndex="12" Visible="False">
                </dx:GridViewDataTextColumn>
            </Columns>
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
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="sqlDSParentQuestions" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" DeleteCommand="spGT_ElogbookCompetenceDelete" DeleteCommandType="StoredProcedure" SelectCommand="spGT_ElogbookCompetenceLoadForElogbook" SelectCommandType="StoredProcedure" UpdateCommand="spGT_ElogbookCompetenceUpdate" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="CompetenceId" Type="Int64" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlElogbooks" Name="ElogbookId" PropertyName="Value" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="CompetenceId" Type="Int64" />
                <asp:Parameter Name="Expected" Type="Int32" />
                <asp:Parameter Name="QuestionText" Type="String" />
                <asp:Parameter Name="QuestionOption" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        
    </div>
</asp:Content>



