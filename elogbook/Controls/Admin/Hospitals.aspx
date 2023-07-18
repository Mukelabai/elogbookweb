<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeFile="Hospitals.aspx.cs" Inherits="Controls_Admin_Hospitals" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" Runat="Server">
     <link rel="stylesheet" type="text/css" href='<%# ResolveUrl("~/Content/GridView.css") %>' />
    <script type="text/javascript" src='<%# ResolveUrl("~/Content/GridView.js") %>'></script>
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
            <dx:Tab Text="Hospitals" NavigateUrl="#"></dx:Tab>
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
        <dx:ASPxGridView ID="gvHospitals" runat="server" AutoGenerateColumns="False"
            DataSourceID="sqlDSHospitals" KeyFieldName="HospitalId" >
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
            <SettingsEditing Mode="Batch"></SettingsEditing>
                                    <SettingsPopup>
                                        <FilterControl AutoUpdatePosition="False"></FilterControl>
                                    </SettingsPopup>

                                    <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
            <Columns>
                <dx:GridViewCommandColumn Name="colCMDHospitals" ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="HospitalId" ReadOnly="True"
                    VisibleIndex="1" Visible="False">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="HospitalName"
                    VisibleIndex="2" Caption="Site Name">
                    <PropertiesTextEdit>
                        <ValidationSettings>
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                
                <dx:GridViewDataComboBoxColumn Caption="District" FieldName="DistrictId" VisibleIndex="3">
                    <PropertiesComboBox DataSourceID="sqlDSDistricts" TextField="DistrictName" ValueField="DistrictId" ValueType="System.Int32">
                        <ValidationSettings>
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesComboBox>
                </dx:GridViewDataComboBoxColumn>
            </Columns>


            <Styles AdaptiveDetailButtonWidth="22"></Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="sqlDSHospitals" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
            SelectCommand="spGT_HospitalsLoadAll" SelectCommandType="StoredProcedure" DeleteCommand="spGT_HospitalsDelete"
            DeleteCommandType="StoredProcedure" InsertCommand="spGT_HospitalsInsert" InsertCommandType="StoredProcedure"
            UpdateCommand="spGT_HospitalsUpdate" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="HospitalId" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="HospitalName" Type="String" />                
                <asp:Parameter Name="DistrictId" Type="Int32" />
                
            </InsertParameters>
            
            <UpdateParameters>
                <asp:Parameter Name="HospitalId" Type="Int32" />
                <asp:Parameter Name="HospitalName" Type="String" />                
                <asp:Parameter Name="DistrictId" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
       
         <asp:SqlDataSource ID="sqlDSDistricts" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
            SelectCommand="spGT_DistrictsLoadAllDDL" SelectCommandType="StoredProcedure">            
        </asp:SqlDataSource>
    </div>
</asp:Content>

