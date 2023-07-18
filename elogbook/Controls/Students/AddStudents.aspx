<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeFile="AddStudents.aspx.cs" Inherits="Controls_Students_AddStudents" %>

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
            <dx:Tab Text="Add Students" NavigateUrl="#"></dx:Tab>
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
        <dx:ASPxButton ID="btnViewStudents" runat="server" Text="View Current Students" OnClick="btnViewStudents_Click"></dx:ASPxButton>
    </div>
    <div class="form-field">
        <dx:ASPxGridView ID="gvStudents" runat="server" AutoGenerateColumns="False" DataSourceID="sqlDSStudents" KeyFieldName="StudentId" OnRowInserting="gvStudents_RowInserting" OnRowUpdating="gvStudents_RowUpdating">
            <SettingsAdaptivity>
                <AdaptiveDetailLayoutProperties>
                    <Items>
                        <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="First Name">
                        </dx:GridViewColumnLayoutItem>
                        <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="Last Name">
                        </dx:GridViewColumnLayoutItem>
                        <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="Student Number">
                        </dx:GridViewColumnLayoutItem>
                        <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="Date Of Birth">
                        </dx:GridViewColumnLayoutItem>
                        <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="Sex">
                        </dx:GridViewColumnLayoutItem>
                        <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="Mobile Phone">
                        </dx:GridViewColumnLayoutItem>
                        <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="Email Address">
                        </dx:GridViewColumnLayoutItem>
                        <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="NRC">
                        </dx:GridViewColumnLayoutItem>
                        <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="Centre">
                        </dx:GridViewColumnLayoutItem>
                    </Items>
                </AdaptiveDetailLayoutProperties>
            </SettingsAdaptivity>
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
                                    <%--<SettingsAdaptivity AdaptivityMode="HideDataCells">
                                    </SettingsAdaptivity>--%>
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
                                    <SettingsDataSecurity AllowDelete="True" AllowEdit="True" AllowInsert="True" />
            <SettingsEditing Mode="Batch"></SettingsEditing>
            <Columns>
                <dx:GridViewCommandColumn Name="colCMDStudents" ShowDeleteButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="StudentId" ReadOnly="True" VisibleIndex="1" Visible="False">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="FirstName" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="LastName" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ComputerNumber" VisibleIndex="4" Caption="Student Number">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="DateOfBirth" VisibleIndex="5">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="MobilePhone" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="EmailAddress" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="NationalId" VisibleIndex="9" Caption="NRC">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="InstitutionId" VisibleIndex="11" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="WebUsername" VisibleIndex="12" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataComboBoxColumn Caption="Centre" FieldName="CentreId" VisibleIndex="10">
                    <PropertiesComboBox DataSourceID="sqlDSProvincialCentresStudents" TextField="CentreName" ValueField="CentreId" ValueType="System.Int32">
                    </PropertiesComboBox>
                </dx:GridViewDataComboBoxColumn>
                <dx:GridViewDataComboBoxColumn FieldName="Sex" VisibleIndex="6">
                    <PropertiesComboBox>
                        <Items>
                            <dx:ListEditItem Text="M" Value="M" />
                            <dx:ListEditItem Text="F" Value="F" />
                        </Items>
                    </PropertiesComboBox>
                </dx:GridViewDataComboBoxColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="sqlDSStudents" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" DeleteCommand="spGT_StudentDelete" DeleteCommandType="StoredProcedure" InsertCommand="spGT_StudentInsert" InsertCommandType="StoredProcedure" SelectCommand="spGT_StudentsLoadByProgramYear" SelectCommandType="StoredProcedure" UpdateCommand="spGT_StudentInsert" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="StudentId" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="ProgramId" Type="Int32" />
                <asp:Parameter Name="StudyYear" Type="Int32" />
                <asp:Parameter Name="AcademicYear" Type="Int32" />
                <asp:Parameter Name="StudentId" Type="Int32" />
                <asp:Parameter Name="FirstName" Type="String" />
                <asp:Parameter Name="LastName" Type="String" />
                <asp:Parameter Name="ComputerNumber" Type="String" />
                <asp:Parameter DbType="Date" Name="DateOfBirth" />
                <asp:Parameter Name="Sex" Type="String" />
                <asp:Parameter Name="MobilePhone" Type="String" />
                <asp:Parameter Name="EmailAddress" Type="String" />
                <asp:Parameter Name="CentreId" Type="Int32" />
                <asp:Parameter Name="NationalId" Type="String" />
                <asp:Parameter Name="InstitutionId" Type="Int32" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlProgramId" Name="ProgramId" PropertyName="Value" Type="Int32" />
                <asp:ControlParameter ControlID="ddlStartingStudyYear" Name="StudyYear" PropertyName="Value" Type="Int32" />
                <asp:ControlParameter ControlID="txtAcademicYear" Name="AcademicYear" PropertyName="Text" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="ProgramId" Type="Int32" />
                <asp:Parameter Name="StudyYear" Type="Int32" />
                <asp:Parameter Name="AcademicYear" Type="Int32" />
                <asp:Parameter Name="StudentId" Type="Int32" />
                <asp:Parameter Name="FirstName" Type="String" />
                <asp:Parameter Name="LastName" Type="String" />
                <asp:Parameter Name="ComputerNumber" Type="String" />
                <asp:Parameter DbType="Date" Name="DateOfBirth" />
                <asp:Parameter Name="Sex" Type="String" />
                <asp:Parameter Name="MobilePhone" Type="String" />
                <asp:Parameter Name="EmailAddress" Type="String" />
                <asp:Parameter Name="CentreId" Type="Int32" />
                <asp:Parameter Name="NationalId" Type="String" />
                <asp:Parameter Name="InstitutionId" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
         <asp:SqlDataSource ID="sqlDSProvincialCentresStudents" runat="server"
                                    ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                                    SelectCommand="spGT_CentresLoadAll" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
    </div>
    <div class="form-field">
        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" ShowCollapseButton="true" Width="200px" AllowCollapsingByHeaderClick="True" Collapsed="True" HeaderText="Update Computer Numbers and User Accounts for Students">
        <PanelCollection>
            <dx:PanelContent>
            
                <div class="form-field">
         <!--CALLBACK CONTROLS  -->
                            <dx:ASPxCallback ID="ASPxCallback3" runat="server" ClientInstanceName="myCallback3" OnCallback="ASPxCallback3_Callback">
                                <ClientSideEvents
                                    CallbackComplete="function(s, e) {
                    myButton1.SetEnabled(true);
                    myTimer1.SetEnabled(false);
                var strs = e.result.split('|');
                    if (strs[0] == 'Error')
                        myLabel1.SetText(strs[1]);
                    else
                        myLabel1.SetText('Process completed');
            }" />
                            </dx:ASPxCallback>
                            <dx:ASPxButton ID="ASPxButton2" runat="server" AutoPostBack="False" Text="Update User Accounts" ToolTip="Ensure that students already have computer numbers assigned" ClientInstanceName="myButton1">
                                <ClientSideEvents
                                    Click="function(s, e) {
                    s.SetEnabled(false);
	                myCallback3.PerformCallback();
	                myLabel1.SetText('Process completion: 0% ');
	                myLabel1.SetClientVisible(true);
	                myTimer1.SetEnabled(true);
                }" />

                            </dx:ASPxButton>
                            <dx:ASPxCallback ID="ASPxCallback4" runat="server" ClientInstanceName="myCallback4" OnCallback="ASPxCallback4_Callback">
                                <ClientSideEvents
                                    CallbackComplete="function(s, e) {
                    var labelText = myLabel1.GetText();
                    if(labelText != 'Process completed'){
	                myLabel1.SetText('Process completion: ' + e.result + ' ');
	            }
                }" />
                            </dx:ASPxCallback>
                            <dx:ASPxTimer ID="ASPxTimer2" runat="server" ClientInstanceName="myTimer1" Enabled="False" Interval="1000">
                                <ClientSideEvents
                                    Tick="function(s, e) {
	                myCallback4.PerformCallback();
                }" />
                            </dx:ASPxTimer>
                            <dx:ASPxLabel ID="ASPxLabel5" runat="server" ClientInstanceName="myLabel1" ClientVisible="False"></dx:ASPxLabel>
                            <!--END CALLBACK CONTROLS  -->
    </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxRoundPanel>
    </div>
</asp:Content>

