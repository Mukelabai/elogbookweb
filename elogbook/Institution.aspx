<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeFile="Institution.aspx.cs" Inherits="Institution" %>

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
    <dx:ASPxLabel ID="lblMessage" runat="server">
    </dx:ASPxLabel>
    <dx:ASPxGridViewExporter ID="geExporter" runat="server" ExportSelectedRowsOnly="False">
    </dx:ASPxGridViewExporter>
    <asp:HiddenField ID="hfUsername" runat="server" />
    <asp:HiddenField ID="hfRole" runat="server" />
    <div class="form-field">
        <dx:ASPxRoundPanel ID="rpInstitution" runat="server" ShowCollapseButton="true" Width="100%" HeaderText="Institution Details">
            <PanelCollection>
                <dx:PanelContent>
                    <div class="form-field">
                        <dx:ASPxGridView runat="server" KeyFieldName="InstitutionId" AutoGenerateColumns="False" DataSourceID="sqlDSSchools" ID="gvInstitutions">
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

                            <Columns>
                                <dx:GridViewCommandColumn Name="colCMDInstitution" SelectAllCheckboxMode="Page" ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" ShowSelectCheckbox="True" VisibleIndex="0">
                                </dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn FieldName="InstitutionId" ReadOnly="True" VisibleIndex="1" Visible="False">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="InstitutionName" VisibleIndex="2">
                                    <EditFormSettings Visible="False"></EditFormSettings>
                                    <PropertiesTextEdit>
                                        <ValidationSettings>
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                    </PropertiesTextEdit>
                                    <EditFormSettings Visible="True" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataCheckColumn FieldName="ExamTimeTableIsManual" Visible="False" VisibleIndex="5">
                                    <PropertiesCheckEdit DisplayTextChecked="Yes" DisplayTextUnchecked="No">
                                    </PropertiesCheckEdit>
                                    <EditFormSettings Visible="True" />
                                </dx:GridViewDataCheckColumn>
                                <dx:GridViewDataTextColumn FieldName="Motto" VisibleIndex="6" Visible="False">
                                    <PropertiesTextEdit MaxLength="150">
                                    </PropertiesTextEdit>
                                    <EditFormSettings Visible="True" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Telephone" VisibleIndex="7">
                                    <PropertiesTextEdit MaxLength="50">
                                    </PropertiesTextEdit>
                                    <EditFormSettings Visible="True" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="MobilePhone" VisibleIndex="8">
                                    <PropertiesTextEdit MaxLength="50">
                                    </PropertiesTextEdit>
                                    <EditFormSettings Visible="True" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Email" VisibleIndex="9">
                                    <PropertiesTextEdit MaxLength="50">
                                        <ValidationSettings>
                                            <RegularExpression ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                        </ValidationSettings>
                                    </PropertiesTextEdit>
                                    <EditFormSettings Visible="True" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Fax" Visible="False" VisibleIndex="10">
                                    <PropertiesTextEdit MaxLength="50">
                                    </PropertiesTextEdit>
                                    <EditFormSettings Visible="True" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="PostalAddress" VisibleIndex="11">
                                    <EditFormSettings Visible="True" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="PhysicalAddress" Visible="False" VisibleIndex="12">
                                    <EditFormSettings Visible="True" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CentreName" Visible="False" VisibleIndex="14">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="DistrictName" VisibleIndex="15">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="ProvinceName" VisibleIndex="16">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="InstitutionCode" Visible="False" VisibleIndex="19">
                                    <EditFormSettings Visible="True" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="LogoURL" Visible="False" VisibleIndex="21">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataComboBoxColumn Caption="Main Exam Centre" FieldName="CentreId" Visible="False" VisibleIndex="13">
                                    <PropertiesComboBox DataSourceID="sqlDSCentres" TextField="CentreName" ValueField="CentreId">
                                    </PropertiesComboBox>
                                    <EditFormSettings Visible="True" />
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataComboBoxColumn Caption="District" FieldName="DistrictId" Visible="False" VisibleIndex="18">
                                    <PropertiesComboBox DataSourceID="sqlDSDistricts" TextField="DistrictName" ValueField="DistrictId">
                                        <ValidationSettings>
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                    </PropertiesComboBox>
                                    <EditFormSettings Visible="True" />
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataComboBoxColumn FieldName="RunningAgency" VisibleIndex="20">
                                    <PropertiesComboBox>
                                        <Items>
                                            <dx:ListEditItem Text="GRZ" Value="GRZ" />
                                            <dx:ListEditItem Text="Private" Value="Private" />
                                            <dx:ListEditItem Text="Church" Value="Church" />
                                            <dx:ListEditItem Text="Other religion" Value="Other religion" />
                                            <dx:ListEditItem Text="Other" Value="Other" />
                                        </Items>
                                    </PropertiesComboBox>
                                    <EditFormSettings Visible="True" />
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataComboBoxColumn FieldName="InstitutionLevel" Visible="False" VisibleIndex="17">
                                    <PropertiesComboBox>
                                        <Items>
                                            <dx:ListEditItem Selected="True" Text="Learning Institution" Value="Institution" />
                                            <dx:ListEditItem Text="District" Value="District" />
                                            <dx:ListEditItem Text="Provincial" Value="Provincial" />
                                            <dx:ListEditItem Text="National" Value="National" />
                                        </Items>
                                    </PropertiesComboBox>
                                    <EditFormSettings Visible="True" />
                                </dx:GridViewDataComboBoxColumn>
                            </Columns>
                            <Styles AdaptiveDetailButtonWidth="22">
                            </Styles>

                        </dx:ASPxGridView>
                        <asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" DeleteCommand="spGT_InstitutionDelete" DeleteCommandType="StoredProcedure" SelectCommand="spGT_InstitutionLoadAll" SelectCommandType="StoredProcedure" ID="sqlDSSchools" InsertCommand="spGT_InstitutionInsert" InsertCommandType="StoredProcedure" UpdateCommand="spGT_InstitutionUpdate" UpdateCommandType="StoredProcedure">
                            <DeleteParameters>
                                <asp:Parameter Name="InstitutionId" Type="Int32"></asp:Parameter>
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="InstitutionName" Type="String" />
                                <asp:Parameter Name="ExamTimeTableIsManual" Type="Boolean" />
                                <asp:Parameter Name="Motto" Type="String" />
                                <asp:Parameter Name="Telephone" Type="String" />
                                <asp:Parameter Name="MobilePhone" Type="String" />
                                <asp:Parameter Name="Email" Type="String" />
                                <asp:Parameter Name="Fax" Type="String" />
                                <asp:Parameter Name="PostalAddress" Type="String" />
                                <asp:Parameter Name="PhysicalAddress" Type="String" />
                                <asp:Parameter Name="CentreId" Type="Int32" />
                                <asp:Parameter Name="InstitutionLevel" Type="String" />
                                <asp:Parameter Name="DistrictId" Type="Int32" />
                                <asp:Parameter Name="InstitutionCode" Type="String" />
                                <asp:Parameter Name="RunningAgency" Type="String" />
                                <asp:Parameter Name="LogoURL" Type="String" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
                                <asp:ControlParameter ControlID="hfRole" Name="Role" PropertyName="Value" Type="String" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="InstitutionId" Type="Int32" />
                                <asp:Parameter Name="InstitutionName" Type="String" />
                                <asp:Parameter Name="ExamTimeTableIsManual" Type="Boolean" />
                                <asp:Parameter Name="Motto" Type="String" />
                                <asp:Parameter Name="Telephone" Type="String" />
                                <asp:Parameter Name="MobilePhone" Type="String" />
                                <asp:Parameter Name="Email" Type="String" />
                                <asp:Parameter Name="Fax" Type="String" />
                                <asp:Parameter Name="PostalAddress" Type="String" />
                                <asp:Parameter Name="PhysicalAddress" Type="String" />
                                <asp:Parameter Name="CentreId" Type="Int32" />
                                <asp:Parameter Name="InstitutionLevel" Type="String" />
                                <asp:Parameter Name="DistrictId" Type="Int32" />
                                <asp:Parameter Name="InstitutionCode" Type="String" />
                                <asp:Parameter Name="RunningAgency" Type="String" />
                                <asp:Parameter Name="LogoURL" Type="String" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sqlDSCentres" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_CentresLoadDDL" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sqlDSDistricts" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_DistrictsLoadAllDDL" SelectCommandType="StoredProcedure"></asp:SqlDataSource>


                    </div>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>

    </div>
</asp:Content>

