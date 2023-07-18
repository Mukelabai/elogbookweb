<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeFile="Questions.aspx.cs" Inherits="Controls_Elogbooks_Questions" %>

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
            <dx:Tab Text="Elogbook Questions" NavigateUrl="#"></dx:Tab>
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
        <asp:SqlDataSource ID="sqlDSCategories" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_ElogbookAnalysisCategoriesLoadAll" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    </div>
    <div class="form-field">
        <dx:ASPxGridView ID="gvParentQuestions" runat="server" AutoGenerateColumns="False" DataSourceID="sqlDSParentQuestions" KeyFieldName="QuestionId" OnRowUpdating="gvParentQuestions_RowUpdating" OnRowInserting="gvParentQuestions_RowInserting">
            <SettingsDetail ShowDetailRow="True" />
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
            <Templates>
                <DetailRow>
                    <dx:ASPxGridView ID="gvChildQuestions" runat="server" AutoGenerateColumns="False" DataSourceID="sqlDSChildQuestions" KeyFieldName="ChildQuestionId" OnBeforePerformDataSelect="gvChildQuestions_BeforePerformDataSelect" OnRowInserting="gvChildQuestions_RowInserting" OnRowUpdating="gvChildQuestions_RowUpdating">
                        <SettingsPopup>
                            <FilterControl AutoUpdatePosition="False">
                            </FilterControl>
                        </SettingsPopup>
                        <Columns>
                            <dx:GridViewCommandColumn Name="colCMDChildQuesions" ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn FieldName="ChildQuestionId" ReadOnly="True" VisibleIndex="1" Visible="False">
                                <EditFormSettings Visible="False" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="DisplayOrder" VisibleIndex="2">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="ChildQuestionText" VisibleIndex="3">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="ChildQuestionDisplayText" VisibleIndex="4">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="ParentOption" VisibleIndex="5">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="ChildQuestionOptions" VisibleIndex="6">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="ParentQuestionId" ReadOnly="True" Visible="False" VisibleIndex="7">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="InstitutionId" ReadOnly="True" Visible="False" VisibleIndex="10">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="ElogbookId" ReadOnly="True" Visible="False" VisibleIndex="11">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="CreatedBy" ReadOnly="True" Visible="False" VisibleIndex="12">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="CreatedOn" ReadOnly="True" Visible="False" VisibleIndex="13">
                            </dx:GridViewDataDateColumn>
                            <dx:GridViewDataTextColumn FieldName="UpdatedBy" ReadOnly="True" Visible="False" VisibleIndex="14">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="UpdatedOn" ReadOnly="True" Visible="False" VisibleIndex="15">
                            </dx:GridViewDataDateColumn>
                            <dx:GridViewDataCheckColumn FieldName="ShowOnDashboard" Visible="True" VisibleIndex="10">
                            </dx:GridViewDataCheckColumn>
                            <dx:GridViewDataCheckColumn FieldName="IsForSupervisor" Visible="True" VisibleIndex="11" ToolTip="Indicate whether this question is answered by supervisors and not students">
                            </dx:GridViewDataCheckColumn>
                            <dx:GridViewDataCheckColumn FieldName="IsAssignmentLevel" Visible="True" VisibleIndex="12" ToolTip="Indicate whether this question is not answered per patient case">
                            </dx:GridViewDataCheckColumn>
                            <dx:GridViewDataComboBoxColumn FieldName="ChildResponseType" VisibleIndex="9">
                                <PropertiesComboBox>
                                    <Items>
                                        <dx:ListEditItem Text="SINGLE LINE TEXT" Value="SINGLELINE" />
                                        <dx:ListEditItem Text="MULTI LINE TEXT" Value="MULTILINE" />
                                        <dx:ListEditItem Text="DATE" Value="DATE" />
                                        <dx:ListEditItem Text="FLOAT" Value="FLOAT" />
                                        <dx:ListEditItem Text="INTEGER" Value="INTEGER" />
                                        <dx:ListEditItem Text="SINGLE SELECT" Value="SINGLESELECT" />
                                        <dx:ListEditItem Text="MULTI SELECT" Value="MULTISELECT" />
                                    </Items>
                                </PropertiesComboBox>
                            </dx:GridViewDataComboBoxColumn>
                            <dx:GridViewDataComboBoxColumn FieldName="CategoryId" VisibleIndex="6" Caption="Analysis Category">
                                <PropertiesComboBox DataSourceID="sqlDSCategories" TextField="CategoryName" ValueField="CategoryId" ValueType="System.Int32">
                                </PropertiesComboBox>
                            </dx:GridViewDataComboBoxColumn>
                        </Columns>
                    </dx:ASPxGridView>
                </DetailRow>
            </Templates>
            <SettingsEditing Mode="Batch">
            </SettingsEditing>
            <SettingsPopup>
                <FilterControl AutoUpdatePosition="False"></FilterControl>
            </SettingsPopup>
            <SettingsBehavior ConfirmDelete="true" />
            <Columns>
                <dx:GridViewCommandColumn Name="colCMDParentQuestions" ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="QuestionId" ReadOnly="True" VisibleIndex="1" Visible="False">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="QuestionText" VisibleIndex="3">
                    <EditFormSettings Visible="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="QuestionOptions" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DisplayOrder" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ElogbookId" VisibleIndex="6" ReadOnly="True" Visible="False">
                </dx:GridViewDataTextColumn>
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
                <dx:GridViewDataCheckColumn FieldName="ShowOnDashboard" Visible="True" VisibleIndex="10">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataCheckColumn FieldName="IsForSupervisor" Visible="True" VisibleIndex="11">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataCheckColumn FieldName="IsAssignmentLevel" Visible="True" VisibleIndex="12">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataComboBoxColumn FieldName="ResponseType" VisibleIndex="8">
                    <PropertiesComboBox>
                        <Items>
                            <dx:ListEditItem Text="SINGLE LINE TEXT" Value="SINGLELINE" />
                            <dx:ListEditItem Text="MULTI LINE TEXT" Value="MULTILINE" />
                            <dx:ListEditItem Text="DATE" Value="DATE" />
                            <dx:ListEditItem Text="FLOAT" Value="FLOAT" />
                            <dx:ListEditItem Text="INTEGER" Value="INTEGER" />
                            <dx:ListEditItem Text="SINGLE SELECT" Value="SINGLESELECT" />
                            <dx:ListEditItem Text="MULTI SELECT" Value="MULTISELECT" />
                        </Items>
                    </PropertiesComboBox>
                </dx:GridViewDataComboBoxColumn>

                <dx:GridViewDataComboBoxColumn FieldName="SectionId" VisibleIndex="5" Caption="Section">
                    <PropertiesComboBox DataSourceID="sqlDSSectionsDDL" TextField="SectionName" ValueField="SectionId">
                    </PropertiesComboBox>
                </dx:GridViewDataComboBoxColumn>
                <dx:GridViewDataComboBoxColumn FieldName="CategoryId" VisibleIndex="7" Caption="Analysis Category">
                    <PropertiesComboBox DataSourceID="sqlDSCategories" TextField="CategoryName" ValueField="CategoryId" ValueType="System.Int32">
                    </PropertiesComboBox>
                </dx:GridViewDataComboBoxColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="sqlDSParentQuestions" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" DeleteCommand="spGT_ParentQuestionsDelete" DeleteCommandType="StoredProcedure" InsertCommand="spGT_ParentQuestionsInsert" InsertCommandType="StoredProcedure" SelectCommand="spGT_ParentQuestionsLoadAll" SelectCommandType="StoredProcedure" UpdateCommand="spGT_ParentQuestionsUpdate" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="QuestionId" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="QuestionText" Type="String" />
                <asp:Parameter Name="QuestionOptions" Type="String" />
                <asp:Parameter Name="DisplayOrder" Type="Double" />
                <asp:Parameter Name="SectionId" Type="Int32" />
                <asp:Parameter Name="ElogbookId" Type="Int32" />
                <asp:Parameter Name="ResponseType" Type="String" />
                <asp:Parameter Name="InstitutionId" Type="Int32" />
                <asp:Parameter Name="UpdatedBy" Type="String" />
                <asp:Parameter Name="CategoryId" Type="Int32" />
                <asp:Parameter Name="ShowOnDashboard" Type="Boolean" />
                <asp:Parameter Name="IsForSupervisor" Type="Boolean" />
                <asp:Parameter Name="IsAssignmentLevel" Type="Boolean" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlElogbooks" Name="ElogbookId" PropertyName="Value" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="QuestionId" Type="Int32" />
                <asp:Parameter Name="QuestionText" Type="String" />
                <asp:Parameter Name="QuestionOptions" Type="String" />
                <asp:Parameter Name="DisplayOrder" Type="Double" />
                <asp:Parameter Name="SectionId" Type="Int32" />
                <asp:Parameter Name="ElogbookId" Type="Int32" />
                <asp:Parameter Name="ResponseType" Type="String" />
                <asp:Parameter Name="InstitutionId" Type="Int32" />
                <asp:Parameter Name="UpdatedBy" Type="String" />
                <asp:Parameter Name="CategoryId" Type="Int32" />
                <asp:Parameter Name="ShowOnDashboard" Type="Boolean" />
                 <asp:Parameter Name="IsForSupervisor" Type="Boolean" />
                <asp:Parameter Name="IsAssignmentLevel" Type="Boolean" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlDSChildQuestions" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" DeleteCommand="spGT_ChildQuestionsDelete" DeleteCommandType="StoredProcedure" InsertCommand="spGT_ChildQuestionsInsert" InsertCommandType="StoredProcedure" SelectCommand="spGT_ChildQuestionsLoadAll" SelectCommandType="StoredProcedure" UpdateCommand="spGT_ChildQuestionsUpdate" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="ChildQuestionId" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="DisplayOrder" Type="Double" />
                <asp:Parameter Name="ChildQuestionText" Type="String" />
                <asp:Parameter Name="ChildQuestionDisplayText" Type="String" />
                <asp:Parameter Name="ParentOption" Type="String" />
                <asp:Parameter Name="ChildQuestionOptions" Type="String" />
                <asp:Parameter Name="ParentQuestionId" Type="Int32" />
                <asp:Parameter Name="ChildResponseType" Type="String" />
                <asp:Parameter Name="InstitutionId" Type="Int32" />
                <asp:Parameter Name="ElogbookId" Type="Int32" />
                <asp:Parameter Name="UpdatedBy" Type="String" />
                <asp:Parameter Name="CategoryId" Type="Int32" />
                <asp:Parameter Name="ShowOnDashboard" Type="Boolean" />
                 <asp:Parameter Name="IsForSupervisor" Type="Boolean" />
                <asp:Parameter Name="IsAssignmentLevel" Type="Boolean" />
            </InsertParameters>
            <SelectParameters>
                <asp:SessionParameter Name="QuestionId" SessionField="QuestionId" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="ChildQuestionId" Type="Int32" />
                <asp:Parameter Name="DisplayOrder" Type="Double" />
                <asp:Parameter Name="ChildQuestionText" Type="String" />
                <asp:Parameter Name="ChildQuestionDisplayText" Type="String" />
                <asp:Parameter Name="ParentOption" Type="String" />
                <asp:Parameter Name="ChildQuestionOptions" Type="String" />
                <asp:Parameter Name="ParentQuestionId" Type="Int32" />
                <asp:Parameter Name="ChildResponseType" Type="String" />
                <asp:Parameter Name="InstitutionId" Type="Int32" />
                <asp:Parameter Name="ElogbookId" Type="Int32" />
                <asp:Parameter Name="UpdatedBy" Type="String" />
                <asp:Parameter Name="CategoryId" Type="Int32" />
                <asp:Parameter Name="ShowOnDashboard" Type="Boolean" />
                 <asp:Parameter Name="IsForSupervisor" Type="Boolean" />
                <asp:Parameter Name="IsAssignmentLevel" Type="Boolean" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>

