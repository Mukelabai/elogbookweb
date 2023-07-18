<%@ Page Title="" Language="C#" MasterPageFile="~/Root.master" AutoEventWireup="true" CodeFile="Mentors.aspx.cs" Inherits="Controls_Admin_Mentors" %>

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
            <dx:Tab Text="Mentors" NavigateUrl="#"></dx:Tab>
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
        <dx:ASPxGridView ID="gvMentors" runat="server" AutoGenerateColumns="False"
            DataSourceID="sqlDSMentors" KeyFieldName="MentorId" >
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
                <dx:GridViewCommandColumn Name="colCMDMentors" ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="MentorId" ReadOnly="True"
                    VisibleIndex="1" Visible="False">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="MentorName"
                    VisibleIndex="2">
                    <PropertiesTextEdit>
                        <ValidationSettings>
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                
              
            </Columns>


            <Styles AdaptiveDetailButtonWidth="22"></Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="sqlDSMentors" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
            SelectCommand="spGT_ElogbookMentorsLoadAll" SelectCommandType="StoredProcedure" DeleteCommand="spGT_ElogbookMentorsDelete"
            DeleteCommandType="StoredProcedure" InsertCommand="spGT_ElogbookMentorsInsert" InsertCommandType="StoredProcedure"
            UpdateCommand="spGT_ElogbookMentorsUpdate" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="MentorId" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="MentorName" Type="String" />                
                
                
            </InsertParameters>
            
            <UpdateParameters>
                <asp:Parameter Name="MentorId" Type="Int32" />
                <asp:Parameter Name="MentorName" Type="String" />                
                
            </UpdateParameters>
        </asp:SqlDataSource>       
        
    </div>
</asp:Content>

