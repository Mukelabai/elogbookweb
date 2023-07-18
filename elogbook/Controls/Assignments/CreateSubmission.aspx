<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeFile="CreateSubmission.aspx.cs" Inherits="Controls_Assignments_CreateSubmission" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="Server">
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
            <dx:Tab Text="Create or update assignment submissions" NavigateUrl="#"></dx:Tab>
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
        <dx:ASPxRoundPanel ID="rpCreateSubmission" runat="server" ShowCollapseButton="true" Width="500px" HeaderText="Create Submission" View="Standard">
            <PanelCollection>
                <dx:PanelContent>
                    <div class="form-field">
                        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Select Assignment"></dx:ASPxLabel>
                    </div>
                    <div style="padding:5px">
                        <dx:ASPxComboBox ID="ddlAssignments" runat="server" Width="100%" TextField="Rotation" ValueField="AssignmentId" ValueType="System.Int32" DataSourceID="sqlDSAssignments"></dx:ASPxComboBox>
                        <asp:SqlDataSource ID="sqlDSAssignments" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_ElogbookAssignmentLoadForStudent" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="hfUsername" Name="WebUsername" PropertyName="Value" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                    <div style="padding:5px">
                        <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Mentor"></dx:ASPxLabel>
                        <dx:ASPxComboBox ID="txtMentor" runat="server" Width="170px" DataSourceID="sqlSMentors" TextField="MentorName" ValueField="MentorId" ValueType="System.Int32"></dx:ASPxComboBox>
                        <asp:SqlDataSource ID="sqlSMentors" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_ElogbookMentorsLoadAll" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                    </div>
                    <div style="padding:5px">
                        <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Hospital"></dx:ASPxLabel>
                        <dx:ASPxComboBox ID="ddlHospital" runat="server" TextField="HospitalName" ValueField="HospitalId" Width="170px" DataSourceID="sqlDSHospitals" ValueType="System.Int32"></dx:ASPxComboBox>
                        <asp:SqlDataSource ID="sqlDSHospitals" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_HospitalLoadDDL" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                    </div>
                    <div style="padding:5px">
                        <dx:ASPxButton ID="btnSaveSubmission" runat="server" Text="Create Submission" OnClick="btnSaveSubmission_Click"></dx:ASPxButton>
                    </div>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>
    </div>
   
</asp:Content>

