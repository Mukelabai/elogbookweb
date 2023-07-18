<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeFile="Programs.aspx.cs" Inherits="Controls_Faculty_Programs" %>

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
            <dx:Tab Text="Programmes" NavigateUrl="#"></dx:Tab>
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
        <dx:ASPxPageControl ID="pcProgrammes" runat="server" ActiveTabIndex="0">
            <TabPages>
                <dx:TabPage Name="tab2Programs" Text="Programmes">
                    <ContentCollection>
                        <dx:ContentControl runat="server">
                            <div class="form-field">
                                <dx:ASPxGridView ID="gvProgrammes" runat="server" AutoGenerateColumns="False" DataSourceID="sqlDSProgrammes"
                                    KeyFieldName="ProgramId" OnCustomUnboundColumnData="gvProgrammes_CustomUnboundColumnData"
                                    OnRowDeleted="gvProgrammes_RowDeleted"
                                    OnRowInserted="gvProgrammes_RowInserted" OnRowUpdated="gvProgrammes_RowUpdated">
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
                                    <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" ShowFilterBar="Visible"></Settings>
                                    <SettingsBehavior AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" EnableRowHotTrack="True" ConfirmDelete="True" EnableCustomizationWindow="True"></SettingsBehavior>

                                    <SettingsPopup>
                                        <FilterControl AutoUpdatePosition="False"></FilterControl>
                                    </SettingsPopup>

                                    <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                                    <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                    <Columns>
                                        <dx:GridViewCommandColumn ShowInCustomizationForm="True" VisibleIndex="0" Name="colCMDProgrammes" ShowNewButtonInHeader="true" ShowDeleteButton="True" />
                                        <dx:GridViewDataTextColumn FieldName="ProgramId" ShowInCustomizationForm="True" VisibleIndex="1"
                                            ReadOnly="True" Visible="False">
                                            <EditFormSettings Visible="False" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SchoolName" ShowInCustomizationForm="True"
                                            VisibleIndex="2">
                                            <EditFormSettings Visible="False" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ProgramName" ShowInCustomizationForm="True"
                                            VisibleIndex="5">
                                            <PropertiesTextEdit MaxLength="150" NullText="e.g. Bachelor of Science in Non Quoters">
                                                <ValidationSettings>
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ProgrammeCode" ShowInCustomizationForm="True"
                                            VisibleIndex="6">
                                            <PropertiesTextEdit MaxLength="50" NullText="e.g. Bsc NQS">
                                                <ValidationSettings>
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataComboBoxColumn FieldName="LevelId" ShowInCustomizationForm="True"
                                            VisibleIndex="7" Caption="Level">
                                            <PropertiesComboBox ValueType="System.Int32" DataSourceID="sqlDSProgrammeLevels"
                                                IncrementalFilteringMode="Contains" TextField="LevelName" ValueField="LevelId">
                                                <ValidationSettings Display="Dynamic">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesComboBox>
                                        </dx:GridViewDataComboBoxColumn>
                                        <dx:GridViewDataComboBoxColumn FieldName="DurationId" ShowInCustomizationForm="True"
                                            VisibleIndex="8" Caption="Duration">
                                            <PropertiesComboBox ValueType="System.Boolean" DataSourceID="sqlDSProgrammeDurations0"
                                                IncrementalFilteringMode="Contains" TextField="DurationText" ValueField="DurationId">
                                                <ValidationSettings Display="Dynamic">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesComboBox>
                                        </dx:GridViewDataComboBoxColumn>
                                        <dx:GridViewDataComboBoxColumn FieldName="DepartmentId" ShowInCustomizationForm="True"
                                            VisibleIndex="3" Caption="Department">
                                            <PropertiesComboBox ValueType="System.Int32" DataSourceID="sqlDSProgrammeDepartments"
                                                IncrementalFilteringMode="Contains" TextField="DepartmentName" ValueField="DepartmentId">
                                                <ValidationSettings Display="Dynamic">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesComboBox>
                                            <EditFormSettings Visible="True" />
                                        </dx:GridViewDataComboBoxColumn>
                                    </Columns>

                                    <Styles AdaptiveDetailButtonWidth="22"></Styles>
                                </dx:ASPxGridView>
                                <asp:SqlDataSource ID="sqlDSProgrammes" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                                    SelectCommand="spGT_ProgrammeLoadAll" SelectCommandType="StoredProcedure" DeleteCommand="spGT_ProgrammeDelete"
                                    DeleteCommandType="StoredProcedure" InsertCommand="spGT_ProgrammeInsert" InsertCommandType="StoredProcedure"
                                    UpdateCommand="spGT_ProgrammeUpdate" UpdateCommandType="StoredProcedure">
                                    <DeleteParameters>
                                        <asp:Parameter Name="ProgramId" Type="Int32" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="ProgramName" Type="String" />
                                        <asp:Parameter Name="ProgrammeCode" Type="String" />
                                        <asp:Parameter Name="LevelId" Type="Int32" />
                                        <asp:Parameter Name="DepartmentId" Type="Int32" />
                                        <asp:Parameter Name="DurationId" Type="Int32" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="ProgramId" Type="Int32" />
                                        <asp:Parameter Name="ProgramName" Type="String" />
                                        <asp:Parameter Name="ProgrammeCode" Type="String" />
                                        <asp:Parameter Name="LevelId" Type="Int32" />
                                        <asp:Parameter Name="DepartmentId" Type="Int32" />
                                        <asp:Parameter Name="DurationId" Type="Int32" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="sqlDSProgrammeDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                                    SelectCommand="spGT_DepartmentLoadForDDL" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
                                        <asp:ControlParameter ControlID="hfRole" Name="UserRole" PropertyName="Value" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="sqlDSProgrammeDurations0" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                                    SelectCommand="spGT_ProgrammeDurationLoadAll" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hfInstitutionId" Name="InstitutionId" PropertyName="Value" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="sqlDSProgrammeLevels" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                                    SelectCommand="spGT_LevelsLoadAll" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                            </div>
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
                <dx:TabPage Name="tabLevels" Text="Levels">
                    <ContentCollection>
                        <dx:ContentControl runat="server">
                            <div class="form-field">
                                <dx:ASPxGridView ID="gvLevels" runat="server" AutoGenerateColumns="False" DataSourceID="sqlDSLevels"
                                    KeyFieldName="LevelId" OnCustomUnboundColumnData="gvProgrammes_CustomUnboundColumnData"
                                    OnRowDeleted="gvLevels_RowDeleted"
                                    OnRowInserted="gvLevels_RowInserted" OnRowUpdated="gvLevels_RowUpdated">
                                    <Toolbars>
                                        <dx:GridViewToolbar>
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
                                    <SettingsPager Position="TopAndBottom">
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
                                    <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                    <Columns>
                                        <dx:GridViewCommandColumn ShowInCustomizationForm="True" VisibleIndex="0" Name="colCMDLevels" ShowEditButton="True" ShowNewButtonInHeader="true" ShowDeleteButton="True" />
                                        <dx:GridViewDataTextColumn FieldName="LevelId" ReadOnly="True" ShowInCustomizationForm="True"
                                            Visible="False" VisibleIndex="1">
                                            <EditFormSettings Visible="False" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="LevelName" ShowInCustomizationForm="True" VisibleIndex="2">
                                            <PropertiesTextEdit MaxLength="50" NullText="e.g. Bachelor's Degree">
                                                <ValidationSettings>
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                    </Columns>

                                    <Styles AdaptiveDetailButtonWidth="22"></Styles>
                                </dx:ASPxGridView>
                                <asp:SqlDataSource ID="sqlDSLevels" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                                    SelectCommand="spGT_LevelsLoadAll" SelectCommandType="StoredProcedure" DeleteCommand="spGT_LevelsDelete"
                                    DeleteCommandType="StoredProcedure" InsertCommand="spGT_LevelsInsert" InsertCommandType="StoredProcedure"
                                    UpdateCommand="spGT_LevelsUpdate" UpdateCommandType="StoredProcedure">
                                    <DeleteParameters>
                                        <asp:Parameter Name="LevelId" Type="Int32" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="LevelName" Type="String" />
                                    </InsertParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="LevelId" Type="Int32" />
                                        <asp:Parameter Name="LevelName" Type="String" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                            </div>
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
                <dx:TabPage Text="Programme Durations" Name="tabProgrammeDurations">
                    <TabStyle HorizontalAlign="Left" VerticalAlign="Top">
                    </TabStyle>
                    <ContentCollection>
                        <dx:ContentControl ID="ContentControl10" runat="server" SupportsDisabledAttribute="True">
                            <div class="form-field">
                                <dx:ASPxGridView ID="gvProgrammeDurations" runat="server" AutoGenerateColumns="False"
                                    DataSourceID="sqlDSProgrammeDurations" KeyFieldName="DurationId" OnCustomUnboundColumnData="gvProgrammeDurations_CustomUnboundColumnData"
                                    OnRowDeleted="gvProgrammeDuration_RowDeleted"
                                    OnRowInserted="gvProgrammeDuration_RowInserted"
                                    OnRowUpdated="gvProgrammeDuration_RowUpdated" OnRowInserting="gvProgrammeDurations_RowInserting" OnRowUpdating="gvProgrammeDurations_RowUpdating">
                                    <Toolbars>
                                        <dx:GridViewToolbar>
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
                                    <SettingsPager Position="TopAndBottom">
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
                                    <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                    <Columns>
                                        <dx:GridViewCommandColumn Name="colCMDProgrammeDurations" ShowDeleteButton="True" ShowEditButton="True" ShowInCustomizationForm="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                                        </dx:GridViewCommandColumn>
                                        <dx:GridViewDataTextColumn FieldName="DurationId" ShowInCustomizationForm="True"
                                            VisibleIndex="1" ReadOnly="True" Visible="False">
                                            <EditFormSettings Visible="False" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="DurationInYears" ShowInCustomizationForm="True"
                                            VisibleIndex="2">
                                            <PropertiesTextEdit>
                                                <ValidationSettings>
                                                    <RegularExpression ErrorText=" numbers please, e.g. 0.5 ( for six months), or 1 (for one year)" ValidationExpression="[-+]?[0-9]*\.?[0-9]+" />
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="DurationText" ShowInCustomizationForm="True" VisibleIndex="3">
                                            <PropertiesTextEdit>
                                                <ValidationSettings>
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                    </Columns>

                                    <Styles AdaptiveDetailButtonWidth="22"></Styles>
                                </dx:ASPxGridView>
                                <asp:SqlDataSource ID="sqlDSProgrammeDurations" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                                    SelectCommand="spGT_ProgrammeDurationLoadAll" SelectCommandType="StoredProcedure"
                                    DeleteCommand="spGT_ProgrammeDurationDelete" DeleteCommandType="StoredProcedure"
                                    InsertCommand="spGT_ProgrammeDurationInsert" InsertCommandType="StoredProcedure"
                                    UpdateCommand="spGT_ProgrammeDurationUpdate" UpdateCommandType="StoredProcedure">
                                    <DeleteParameters>
                                        <asp:Parameter Name="DurationId" Type="Int32" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="DurationInYears" Type="Double" />
                                        <asp:Parameter Name="DurationText" Type="String" />
                                        <asp:Parameter Name="InstitutionId" Type="Int32" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hfInstitutionId" Name="InstitutionId" PropertyName="Value" Type="Int32" />
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="DurationId" Type="Int32" />
                                        <asp:Parameter Name="DurationInYears" Type="Double" />
                                        <asp:Parameter Name="DurationText" Type="String" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                            </div>
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>

            </TabPages>
        </dx:ASPxPageControl>
    </div>
</asp:Content>

