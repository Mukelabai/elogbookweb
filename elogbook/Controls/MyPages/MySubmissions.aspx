<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeFile="MySubmissions.aspx.cs" Inherits="Controls_MyPages_MySubmissions" %>


<asp:Content ID="Content1" ContentPlaceHolderID="Head" Runat="Server">
  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LeftPanelContent" Runat="Server">
    <h3 class="section-caption contents-caption">Cases</h3>
    <asp:HiddenField ID="hfSubmissionId" runat="server" />
    <dx:ASPxRadioButtonList ID="rblCases" runat="server" ValueType="System.Int32" AutoPostBack="True" DataSourceID="sqlDSCases" ItemSpacing="10px" OnValueChanged="rblCases_ValueChanged" TextField="Patient" ValueField="CaseId" Width="100%">
        <RadioButtonStyle>
            <BorderBottom BorderStyle="None" />
        </RadioButtonStyle>
        <Paddings Padding="5px" />        
        <Border BorderStyle="None" />
    </dx:ASPxRadioButtonList>
    <asp:SqlDataSource ID="sqlDSCases" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_ElogbookCasesLoadDDL" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="hfSubmissionId" Name="SubmissionId" PropertyName="Value" Type="Int64" />
        </SelectParameters>
    </asp:SqlDataSource>
    
      <div style="padding:5px">
        <hr />
        <div>
            <dx:ASPxLabel ID="lblMessageComment" runat="server" ></dx:ASPxLabel>
        </div>
    <dx:ASPxMemo ID="txtComment" runat="server" Height="100px" Width="100%" AutoResizeWithContainer="True" Font-Names="Consolas"></dx:ASPxMemo>
        </div>
    <div style="padding:5px">
        <dx:ASPxButton ID="btnComment" runat="server" Text="Comment" Width="100%" OnClick="btnComment_Click" Visible="false"></dx:ASPxButton>
    </div>
    <div style="padding:5px">
        <hr />
    </div>
    <h3 class="section-caption contents-caption">Comments</h3>
    <div style="padding:5px">
        <dx:ASPxNewsControl ID="ncComments" runat="server" Width="100%" DataSourceID="sqlDSComments" DateField="CreatedOn" NameField="CommentId" TextField="CommentText" HeaderTextField="CreatedByFullName"></dx:ASPxNewsControl>
        <asp:SqlDataSource ID="sqlDSComments" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" DeleteCommand="spGT_ElogbookSubmissionCommentsDelete" DeleteCommandType="StoredProcedure" InsertCommand="spGT_ElogbookSubmissionCommentsInsert" InsertCommandType="StoredProcedure" SelectCommand="spGT_ElogbookSubmissionCommentsLoadAll" SelectCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="CommentId" Type="Int64" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="CommentText" Type="String" />
                <asp:Parameter Name="CreatedBy" Type="String" />
                <asp:Parameter Name="SubmissionId" Type="Int64" />
                <asp:Parameter Name="InstitutionId" Type="Int32" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="hfSubmissionId" Name="SubmissionId" PropertyName="Value" Type="Int64" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="RightPanelContent" Runat="Server">
     <h3 class="section-caption contents-caption">Delete Your Comments</h3>
    <asp:HiddenField ID="hfSubmissionIdRight" runat="server" />
    <asp:HiddenField ID="hfUsernameRight" runat="server" />
    <div>
        <dx:ASPxGridView ID="gvDeleteComments" runat="server" AutoGenerateColumns="False" DataSourceID="sqlDSDeleteCOmments" KeyFieldName="CommentId">
            <SettingsBehavior ConfirmDelete="True" />
            <SettingsDataSecurity AllowEdit="False" AllowInsert="False" />
<SettingsPopup>
<FilterControl AutoUpdatePosition="False"></FilterControl>
</SettingsPopup>
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowDeleteButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="CommentId" ReadOnly="True" Visible="False" VisibleIndex="1">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Comment" FieldName="CommentText" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn Caption="Date" FieldName="CreatedOn" VisibleIndex="3">
                </dx:GridViewDataDateColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="sqlDSDeleteCOmments" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" DeleteCommand="spGT_ElogbookSubmissionCommentsDelete" DeleteCommandType="StoredProcedure" SelectCommand="spGT_ElogbookSubmissionCommentsLoadForDelete" SelectCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="CommentId" Type="Int64" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="hfSubmissionIdRight" Name="SubmissionId" PropertyName="Value" Type="Int64" />
                <asp:ControlParameter ControlID="hfUsernameRight" Name="Webusername" PropertyName="Value" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="PageToolbar" Runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageContent" Runat="Server">
    <dx:ASPxTabControl ID="SchoolsTabControl" runat="server" Width="100%" TabAlign="Justify" Paddings-Padding="0">
        <Tabs>
            <dx:Tab Text="All My Submissions" NavigateUrl="#"></dx:Tab>
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
     <div style="padding:5px">
         <dx:ASPxGridView ID="gvSubmissions" runat="server" AutoGenerateColumns="False" DataSourceID="sqlDSSubmissionsView" KeyFieldName="SubmissionId" OnSelectionChanged="gvSubmissions_SelectionChanged">
             <SettingsAdaptivity AdaptivityMode="HideDataCellsWindowLimit">
                 <AdaptiveDetailLayoutProperties>
                     <Items>
                         <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="Submission Name">
                         </dx:GridViewColumnLayoutItem>
                         <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="Cases">
                         </dx:GridViewColumnLayoutItem>
                         <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="Status">
                         </dx:GridViewColumnLayoutItem>
                         <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="Is Published">
                         </dx:GridViewColumnLayoutItem>
                     </Items>
                 </AdaptiveDetailLayoutProperties>
             </SettingsAdaptivity>
             <SettingsBehavior AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
             <SettingsResizing ColumnResizeMode="Control" />
             <SettingsDataSecurity AllowInsert="False" />
<SettingsPopup>
<FilterControl AutoUpdatePosition="False"></FilterControl>
</SettingsPopup>
             <SettingsSearchPanel Visible="True" />
             <SettingsPager Position="Bottom" PageSize="5">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Items="5, 10, 20, 50, 100, 200, 1000, 2000" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <SettingsEditing Mode="Batch">
            </SettingsEditing>
             <Columns>
                 <dx:GridViewCommandColumn ShowDeleteButton="True" VisibleIndex="0">
                 </dx:GridViewCommandColumn>
                 <dx:GridViewDataTextColumn FieldName="SubmissionId" ReadOnly="True" Visible="False" VisibleIndex="1">
                     <EditFormSettings Visible="False" />
                 </dx:GridViewDataTextColumn>
                 <dx:GridViewDataTextColumn FieldName="SubmissionName" ReadOnly="True" VisibleIndex="2">
                     <EditFormSettings Visible="False" />
                 </dx:GridViewDataTextColumn>
                 <dx:GridViewDataTextColumn FieldName="Cases" ReadOnly="True" VisibleIndex="3">
                     <EditFormSettings Visible="False" />
                 </dx:GridViewDataTextColumn>
                 <dx:GridViewDataTextColumn FieldName="Status" VisibleIndex="4">
                     <EditFormSettings Visible="False" />
                 </dx:GridViewDataTextColumn>
                 <dx:GridViewDataTextColumn FieldName="Grade" ReadOnly="True" VisibleIndex="5">
                     <EditFormSettings Visible="False" />
                 </dx:GridViewDataTextColumn>
                 <dx:GridViewDataCheckColumn FieldName="IsPublished" VisibleIndex="6">
                 </dx:GridViewDataCheckColumn>
             </Columns>
         </dx:ASPxGridView>
                    <asp:SqlDataSource ID="sqlDSSubmissionsView" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" DeleteCommand="spGT_ElogbookSubmissionsDelete" DeleteCommandType="StoredProcedure" SelectCommand="spGT_ElogbookSubmissionsLoadForStudentView" SelectCommandType="StoredProcedure" UpdateCommand="spGT_ElogbookSubmissionUpdatePublishStatus" UpdateCommandType="StoredProcedure">
                        <DeleteParameters>
                            <asp:Parameter Name="SubmissionId" Type="Int64" />
                        </DeleteParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hfUsername" Name="Webusername" PropertyName="Value" Type="String" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="SubmissionId" Type="Int64" />
                            <asp:Parameter Name="IsPublished" Type="Boolean" />
                        </UpdateParameters>
         </asp:SqlDataSource>
                    </div>
    <div style="padding:5px">
                        <dx:ASPxButton ID="btnShowCases" runat="server" Text="Show Cases" OnClick="btnShowCases_Click"></dx:ASPxButton> | 
        <dx:ASPxButton ID="btnAddCase" runat="server" Text="Add a Case" OnClick="btnAddCase_Click"></dx:ASPxButton>
        | 
        <dx:ASPxButton ID="btnAssignmentLevelQuestions" runat="server" Text="General Questions" OnClick="btnAssignmentLevelQuestions_Click"></dx:ASPxButton>

        | 
        <dx:ASPxButton ID="btnShowComptenceAchievements" runat="server" Text="Competence Achivements" OnClick="btnShowComptenceAchievements_Click"></dx:ASPxButton>
        
                    </div>
       <div style="padding-bottom:5px"></div>
                    <div style="padding:5px">
                        <dx:ASPxProgressBar ID="progressBarAchievements" runat="server" Position="0" Width="200px" Caption="Overall Competence Achievement" Visible="false"></dx:ASPxProgressBar>
                    </div>
    
    <div>
        <hr />
    </div>
     <div>
         
        <dx:ASPxRoundPanel ID="rpCase" runat="server" ShowCollapseButton="true" Width="500px" HeaderText="Record a Case" Visible="false">
            <PanelCollection>
                <dx:PanelContent>                    
                    <div style="padding:5px">
                    <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Patient Initials"></dx:ASPxLabel>
                    <dx:ASPxTextBox ID="txtPatientIntials" runat="server" Width="170px" MaxLength="4"></dx:ASPxTextBox>
                        </div>
                    
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>
    </div>
    <div>
        <dx:ASPxButton ID="btnSave" runat="server" Text="Save Case Data" OnClick="btnSave_Click" Width="100%" Visible="false"></dx:ASPxButton>
    </div>

    <div>
         
        <dx:ASPxRoundPanel ID="rpAssignmentLevelQuestions" runat="server" ShowCollapseButton="true" Width="500px" HeaderText="Assignment-level Questions" Visible="false">
            <PanelCollection>
                <dx:PanelContent>                    
                    <div style="padding:5px">
                    
                        </div>
                    
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>
    </div>
    <div>
        <dx:ASPxButton ID="btnSaveAssignmentLevelQuestions" runat="server" Text="Save Assignment-level Data" OnClick="btnSaveAssignmentLevelQuestions_Click" Width="100%" Visible="false"></dx:ASPxButton>
    </div>
     <div>
         
        <dx:ASPxRoundPanel ID="rpComptencies" runat="server" ShowCollapseButton="true" Width="500px" HeaderText="Competence Achivements--numbers indicate achieved out of expected followed by progress in percentage " Visible="false" GroupBoxHeaderStyle-Wrap="True">
            <PanelCollection>
                <dx:PanelContent>                    
                    <div style="padding:5px">
                    
                        </div>
                    
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>
    </div>

</asp:Content>


