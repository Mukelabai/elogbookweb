<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeFile="RecordCase.aspx.cs" Inherits="Controls_Assignments_RecordCase" %>


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
            <dx:Tab Text="Record a Case" NavigateUrl="#"></dx:Tab>
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
                        <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="Select Submission"></dx:ASPxLabel>
                    </div>
    <div style="padding:5px"></div>
                    <div style="padding:5px">
                        <dx:ASPxComboBox ID="ddlSubmission" runat="server" Width="100%" TextField="SubmissionName" ValueField="SubmissionId" ValueType="System.Int32" DataSourceID="sqlDSSubmissionsDDL" AutoPostBack="true" OnValueChanged="ddlSubmission_ValueChanged"></dx:ASPxComboBox>
                        <asp:SqlDataSource ID="sqlDSSubmissionsDDL" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_ElogbookSubmissionsLoadForStudent" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="hfUsername" Name="WebUsername" PropertyName="Value" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
    <div style="padding-bottom:5px"></div>
                    <div style="padding:5px">
                        <dx:ASPxButton ID="btnAddCase" runat="server" Text="Add a Case" OnClick="btnAddCase_Click"></dx:ASPxButton>
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
</asp:Content>

