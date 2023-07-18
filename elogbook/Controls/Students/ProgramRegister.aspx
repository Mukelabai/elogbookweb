<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeFile="ProgramRegister.aspx.cs" Inherits="Controls_Students_ProgramRegister" %>

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
            <dx:Tab Text="Program Student Register" NavigateUrl="#"></dx:Tab>
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
    <div class="form-field">
        <dx:ASPxGridView ID="gvStudents" runat="server" AutoGenerateColumns="False" DataSourceID="sqlDSStudents" KeyFieldName="RegisterId" OnRowInserting="gvStudents_RowInserting" OnRowUpdating="gvStudents_RowUpdating">
                                    <%--<SettingsAdaptivity AdaptivityMode="HideDataCells">
                                    </SettingsAdaptivity>--%>
                                    <SettingsContextMenu Enabled="True">
                                    </SettingsContextMenu>
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
                                    <SettingsPager Position="Bottom">
                                        <AllButton Visible="True">
                                        </AllButton>
                                        <PageSizeItemSettings Items="10, 20, 50, 100, 200, 1000, 2000" Visible="True">
                                        </PageSizeItemSettings>
                                    </SettingsPager>
            <SettingsEditing Mode="Batch"></SettingsEditing>
                                    <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" ShowFilterBar="Visible"></Settings>
                                    <SettingsBehavior AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" EnableRowHotTrack="True" ConfirmDelete="True" EnableCustomizationWindow="True"></SettingsBehavior>

                                    <SettingsDataSecurity AllowDelete="True" AllowEdit="True" AllowInsert="False" />

                                    <SettingsPopup>
                                        <FilterControl AutoUpdatePosition="False"></FilterControl>
                                    </SettingsPopup>

                                    <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                                    <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="WYSIWYG" />
            <Columns>
                <dx:GridViewCommandColumn Name="colCMDProgramRegister" ShowDeleteButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="RegisterId" ReadOnly="True" VisibleIndex="1" Visible="False">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="StudyYear" VisibleIndex="3">
                    <PropertiesTextEdit>
                        <ValidationSettings>
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="StudentId" VisibleIndex="5" ReadOnly="True" Visible="False">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Student" VisibleIndex="6" ReadOnly="True">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ComputerNumber" VisibleIndex="7" Caption="Student #" ReadOnly="True">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Sex" VisibleIndex="8" ReadOnly="True">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="MobilePhone" VisibleIndex="9" ReadOnly="True">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="EmailAddress" ReadOnly="True" VisibleIndex="10">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="NRC" FieldName="NationalId" ReadOnly="True" VisibleIndex="11">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="InstitutionId" ReadOnly="True" Visible="False" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataComboBoxColumn Caption="Centre" FieldName="CentreId" ReadOnly="True" VisibleIndex="12">
                    <PropertiesComboBox DataSourceID="sqlDSProvincialCentresStudents" TextField="CentreName" ValueField="CentreId" ValueType="System.Int32">
                    </PropertiesComboBox>
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataComboBoxColumn>
                <dx:GridViewDataSpinEditColumn FieldName="AcademicYear" VisibleIndex="4">
                    <PropertiesSpinEdit DisplayFormatString="g" MaxLength="4" MaxValue="2099" MinValue="2021">
                        <ValidationSettings>
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesSpinEdit>
                </dx:GridViewDataSpinEditColumn>
                <dx:GridViewDataComboBoxColumn Caption="Program" FieldName="ProgramId" VisibleIndex="2">
                    <PropertiesComboBox DataSourceID="sqlDSSupervisionPrograms" TextField="ProgramName" ValueField="ProgramId">
                        <ValidationSettings>
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesComboBox>
                </dx:GridViewDataComboBoxColumn>
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
        <asp:SqlDataSource ID="sqlDSStudents" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" DeleteCommand="spGT_ProgramRegisterDelete" DeleteCommandType="StoredProcedure" InsertCommand="spGT_ProgramRegisterInsert" InsertCommandType="StoredProcedure" SelectCommand="spGT_ProgramRegisterLoad" SelectCommandType="StoredProcedure" UpdateCommand="spGT_ProgramRegisterInsert" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="RegisterId" Type="Int64" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="ProgramId" Type="Int32" />
                <asp:Parameter Name="StudentId" Type="Int32" />
                <asp:Parameter Name="StudyYear" Type="Int32" />
                <asp:Parameter Name="AcademicYear" Type="Int32" />
                <asp:Parameter Name="InstitutionId" Type="Int32" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlProgramId" Name="ProgramId" PropertyName="Value" Type="Int32" />
                <asp:ControlParameter ControlID="ddlStartingStudyYear" Name="StudyYear" PropertyName="Value" Type="Int32" />
                <asp:ControlParameter ControlID="txtAcademicYear" Name="AcademicYear" PropertyName="Text" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="ProgramId" Type="Int32" />
                <asp:Parameter Name="StudentId" Type="Int32" />
                <asp:Parameter Name="StudyYear" Type="Int32" />
                <asp:Parameter Name="AcademicYear" Type="Int32" />
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
</asp:Content>

