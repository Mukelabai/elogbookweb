<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeFile="RegisterStudents.aspx.cs" Inherits="Controls_Students_RegisterStudents" %>

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
            <dx:Tab Text="Register Existing Students" NavigateUrl="#"></dx:Tab>
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
        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Program"></dx:ASPxLabel>
        <dx:ASPxComboBox ID="ddlProgramId"  runat="server" DataSourceID="sqlDSSupervisionPrograms" TextField="ProgramName" ValueField="ProgramId" ValueType="System.Int32" AutoPostBack="True" OnValueChanged="ddlProgramId_ValueChanged"></dx:ASPxComboBox>


        <asp:SqlDataSource ID="sqlDSSupervisionPrograms" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
            SelectCommand="spGT_ProgrammeLoadAllDDL" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    <div class="form-field">
        <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Study Year"></dx:ASPxLabel>
        
        <dx:ASPxComboBox ID="ddlStartingStudyYear"  runat="server" ValueType="System.Int32" DataSourceID="sqlDSStudyYearsByProgramme" TextField="StudyYearName" ValueField="StudyYear">

            <ValidationSettings>
                <RequiredField IsRequired="True" />
            </ValidationSettings>
        </dx:ASPxComboBox>
        <asp:SqlDataSource ID="sqlDSStudyYearsByProgramme" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_StudyYearsLoadByProgrammeDuration" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlProgramId" Name="ProgramId" PropertyName="Value" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    <div class="form-field">
        <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Academic Year"></dx:ASPxLabel>
        
        <dx:ASPxTextBox ID="txtAcademicYear" runat="server" Width="170px" MaxLength="4">
            <ValidationSettings>
                <RegularExpression ValidationExpression="\d+" ErrorText="Input a number" />
            </ValidationSettings>
        </dx:ASPxTextBox>
    </div>
    <div class="form-field">
        <dx:ASPxButton ID="btnViewStudents" runat="server" Text="View Students" OnClick="btnViewStudents_Click"></dx:ASPxButton>
    </div>
    <div>
        <hr />
    </div>
    <div>
        <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="Register students for the following study year and academic year"></dx:ASPxLabel>
    </div>
    <div>
        <hr />
    </div>
    <div class="form-field">
        <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="New Study Year"></dx:ASPxLabel>
        
        <dx:ASPxComboBox ID="ddlTargetStudyYear"  runat="server" ValueType="System.Int32" DataSourceID="sqlDSStudyYearsByProgramme" TextField="StudyYearName" ValueField="StudyYear">

            <ValidationSettings>
                <RequiredField IsRequired="True" />
            </ValidationSettings>
        </dx:ASPxComboBox>
        
    </div>
    <div class="form-field">
        <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="New Academic Year"></dx:ASPxLabel>
        
        <dx:ASPxTextBox ID="txtTargetAcademicYear" runat="server" Width="170px" MaxLength="4">
            <ValidationSettings>
                <RegularExpression ValidationExpression="\d+" ErrorText="Input a number" />
            </ValidationSettings>
        </dx:ASPxTextBox>
    </div>
    <div>
        <hr />
        <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="Students"></dx:ASPxLabel>
    </div>
    <div class="form-field">
        <dx:ASPxListBox ID="lbStudents" runat="server" ValueType="System.Int32" DataSecurityMode="Strict" DataSourceID="sqlDSStudents" EnableSelectAll="True" Rows="20" SelectionMode="CheckColumn" TextField="Student" ValueField="StudentId">
            <FilteringSettings ShowSearchUI="True" />
        </dx:ASPxListBox>
        <asp:SqlDataSource ID="sqlDSStudents" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_ProgramRegisterLoadDDL" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlProgramId" Name="ProgramId" PropertyName="Value" Type="Int32" />
                <asp:ControlParameter ControlID="ddlStartingStudyYear" Name="StudyYear" PropertyName="Value" Type="Int32" />
                <asp:ControlParameter ControlID="txtAcademicYear" Name="AcademicYear" PropertyName="Text" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
   <div class="form-field">
        <dx:ASPxButton ID="btnSave" runat="server" Text="Register Students" OnClick="btnSave_Click"></dx:ASPxButton>
    </div>
</asp:Content>

