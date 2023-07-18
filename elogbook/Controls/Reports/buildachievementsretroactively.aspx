<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeFile="buildachievementsretroactively.aspx.cs" Inherits="Controls_Reports_buildachievementsretroactively" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" Runat="Server">
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
            <dx:Tab Text="Report Builder" NavigateUrl="#"></dx:Tab>
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
        <dx:ASPxLabel runat="server" Text="Academic Year" ID="ASPxLabel2" ></dx:ASPxLabel>

        <dx:ASPxComboBox runat="server" ToolTip="Indicate the Academic Year for which the build is being made." ID="ddlAcademicYearChoice" CssClass="form-field" DataSourceID="sqlDSAcademicYears" TextField="Academicyear" ValueField="Academicyear" ValueType="System.Int32">
            
        </dx:ASPxComboBox>
         <asp:SqlDataSource ID="sqlDSAcademicYears" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_AcademicYearsLoadWithAssignments" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    </div>
    

    <div style="padding:5px">
         <!--CALLBACK CONTROLS  -->
                            <dx:ASPxCallback ID="ASPxCallback1" runat="server" ClientInstanceName="myCallback1" OnCallback="ASPxCallback1_Callback">
                                <ClientSideEvents
                                    CallbackComplete="function(s, e) {
                    myButton.SetEnabled(true);
                    myTimer.SetEnabled(false);
                var strs = e.result.split('|');
                    if (strs[0] == 'Error')
                        myLabel.SetText(strs[1]);
                    else
                        myLabel.SetText('Process completed');
            }" />
                            </dx:ASPxCallback>
                            <dx:ASPxButton ID="ASPxButton1" runat="server" AutoPostBack="False" Text="Build Data" ClientInstanceName="myButton">
                                <ClientSideEvents
                                    Click="function(s, e) {
                    s.SetEnabled(false);
	                myCallback1.PerformCallback();
	                myLabel.SetText('Process completion: 0% ');
	                myLabel.SetClientVisible(true);
	                myTimer.SetEnabled(true);
                }" />

                            </dx:ASPxButton>
                            <dx:ASPxCallback ID="ASPxCallback2" runat="server" ClientInstanceName="myCallback2" OnCallback="ASPxCallback2_Callback">
                                <ClientSideEvents
                                    CallbackComplete="function(s, e) {
                    var labelText = myLabel.GetText();
                    if(labelText != 'Process completed'){
	                myLabel.SetText('Process completion: ' + e.result + ' ');
	            }
                }" />
                            </dx:ASPxCallback>
                            <dx:ASPxTimer ID="ASPxTimer1" runat="server" ClientInstanceName="myTimer" Enabled="False" Interval="1000">
                                <ClientSideEvents
                                    Tick="function(s, e) {
	                myCallback2.PerformCallback();
                }" />
                            </dx:ASPxTimer>
                            <dx:ASPxLabel ID="ASPxLabel1" runat="server" ClientInstanceName="myLabel" ClientVisible="False"></dx:ASPxLabel>
                            <!--END CALLBACK CONTROLS  -->

    </div>
</asp:Content>

