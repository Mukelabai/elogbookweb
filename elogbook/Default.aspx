<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Root.master" CodeFile="Default.aspx.cs" Inherits="Default" Title="" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v20.2, Version=20.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.XtraCharts.v20.2.Web, Version=20.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts.Web" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.XtraCharts.v20.2, Version=20.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraCharts" tagprefix="dx" %>

<asp:Content ID="Content" ContentPlaceHolderID="PageContent" runat="server">
    <%--<div class="text-content" runat="server" id="TextContent"></div>--%>
    <dx:ASPxTabControl ID="SchoolsTabControl" runat="server" Width="100%" TabAlign="Justify" Paddings-Padding="0">
        <Tabs>
            <dx:Tab Text="Welcome to the LMMU Elogbook System" NavigateUrl="#"></dx:Tab>
            <%--<dx:Tab Text="Register" NavigateUrl="Register.aspx"></dx:Tab>--%>
        </Tabs>
    </dx:ASPxTabControl>
     <asp:SqlDataSource ID="sqlDSSubmissions" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_ElogbookReportLoadDashboardSubmissions" SelectCommandType="StoredProcedure">
         <SelectParameters>
             <asp:ControlParameter ControlID="hfRole" Name="Role" PropertyName="Value" Type="String" />
             <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
         </SelectParameters>
    </asp:SqlDataSource>
     <dx:ASPxLabel ID="lblMessage" runat="server">
        </dx:ASPxLabel>
        <asp:HiddenField ID="hfUsername" runat="server" />
        <asp:HiddenField ID="hfRole" runat="server" />
        <asp:HiddenField ID="hfInstitutionId" runat="server" />
    <h4>
        Cases per key question
    </h4>
    <dx:ASPxRoundPanel ID="rpQuestionCharts" runat="server" ShowCollapseButton="true" Width="100%" HeaderText="">
        <PanelCollection>
            <dx:PanelContent>

            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxRoundPanel>
    <%--<dx:WebChartControl runat="server" CrosshairEnabled="True" DataSourceID="sqlDSQuestions" Height="350px" SeriesDataMember="ResponseText" Width="1280px">
        <DiagramSerializable>
            <dx:XYDiagram>
                <axisx visibleinpanesserializable="-1">
                </axisx>
                <axisy visibleinpanesserializable="-1">
                </axisy>
            </dx:XYDiagram>
        </DiagramSerializable>
        <SeriesTemplate ArgumentDataMember="Question" SeriesDataMember="ResponseText" ValueDataMembersSerializable="Number">
        </SeriesTemplate>
</dx:WebChartControl>--%>
  <%--  <dx:BootstrapChart runat="server" DataSourceID="sqlDSQuestions" EncodeHtml="True" LoadingIndicatorText="" Palette="Office" SeriesSelectionMode="Multiple">
<ArgumentAxis Offset="0" TickVisible="True" MinorTickVisible="False">
<TickSettings Visible="True"></TickSettings>
        </ArgumentAxis>

        <SeriesCollection>
            <dx:BootstrapChartSeries ArgumentField="ResponseText" TagField="" ValueField="Number"  Type="Bar">
                <Label Visible="true">
                    <Format Type="FixedPoint" Precision="0" />
                </Label>
            </dx:BootstrapChartSeries>
        </SeriesCollection>

        <SettingsCommonSeries ArgumentField="Question"  ValueField="Number" Type="Bar">
            <Label Visible="True">
            </Label>
        </SettingsCommonSeries>

<SettingsCommonAxis Offset="0" TickVisible="False" MinorTickVisible="False"></SettingsCommonAxis>

        <SettingsSeriesTemplate NameField="ResponseText" />

<TitleSettings>
<SubTitleSettings Offset="0"></SubTitleSettings>
</TitleSettings>
    </dx:BootstrapChart>--%>
    <%--<dx:BootstrapPieChart ID="BootstrapPieChart1" runat="server" DataSourceID="sqlDSSubmissions" EncodeHtml="True" LoadingIndicatorText="" Palette="Office">
        <SeriesCollection>
            <dx:BootstrapPieChartSeries ArgumentField="Hospital" ArgumentType="String" TagField="Rotation" ValueField="Submissions">
            </dx:BootstrapPieChartSeries>
        </SeriesCollection>
<TitleSettings>
<SubTitleSettings Offset="0"></SubTitleSettings>
</TitleSettings>
    </dx:BootstrapPieChart>--%>
    <h4>
        Cases per hospital per rotation
    </h4>
    <dx:BootstrapChart ID="BootstrapChart1" runat="server" DataSourceID="sqlDSCases" EncodeHtml="True" LoadingIndicatorText="" Palette="Office">
<ArgumentAxis Offset="0" TickVisible="False" MinorTickVisible="False"></ArgumentAxis>

        <SettingsCommonSeries ArgumentField="Hospital" Type="Bar" ValueField="Cases">
            <Label Position="Outside" Visible="True">
            </Label>
        </SettingsCommonSeries>

<SettingsCommonAxis Offset="0" TickVisible="False" MinorTickVisible="False"></SettingsCommonAxis>

        <SettingsSeriesTemplate NameField="Rotation" />

<TitleSettings>
<SubTitleSettings Offset="0"></SubTitleSettings>
</TitleSettings>
        <SettingsExport ExportButtonText="Export" />
    </dx:BootstrapChart>

     <asp:SqlDataSource ID="sqlDSCases" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_ElogbookReportLoadDashboardCases" SelectCommandType="StoredProcedure">
         <SelectParameters>
             <asp:ControlParameter ControlID="hfRole" Name="Role" PropertyName="Value" Type="String" />
             <asp:ControlParameter ControlID="hfUsername" Name="Username" PropertyName="Value" Type="String" />
         </SelectParameters>
    </asp:SqlDataSource>

     <h4>
        Submissions per hospital per rotation     
       
        
    </h4>
    <dx:BootstrapChart ID="BootstrapChart2" runat="server" DataSourceID="sqlDSSubmissions">
<ArgumentAxis Offset="0" TickVisible="False" MinorTickVisible="False"></ArgumentAxis>

        <SettingsCommonSeries ArgumentField="Hospital" TagField="Grade" Type="Bar" ValueField="Submissions">
            <Label Visible="True">
            </Label>
        </SettingsCommonSeries>

<SettingsCommonAxis Offset="0" TickVisible="False" MinorTickVisible="False"></SettingsCommonAxis>

        <SettingsSeriesTemplate NameField="Rotation" />

<TitleSettings>
<SubTitleSettings Offset="0"></SubTitleSettings>
</TitleSettings>
    </dx:BootstrapChart>
<asp:SqlDataSource ID="sqlDSQuestions" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="spGT_ElogbookReportLoadDashboardQuestions" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    
</asp:Content>

<asp:Content ContentPlaceHolderID="LeftPanelContent" runat="server">
    <%--  <h3 class="section-caption contents-caption">Contents</h3>

    <dx:ASPxTreeView runat="server" ID="TableOfContentsTreeView" ClientInstanceName="tableOfContentsTreeView"
        EnableNodeTextWrapping="true" AllowSelectNode="true" Width="100%" SyncSelectionMode="None" DataSourceID="NodesDataSource">
        <Styles>
            <Elbow CssClass="tree-view-elbow" />
            <Node CssClass="tree-view-node" HoverStyle-CssClass="hovered" />
        </Styles>
        <ClientSideEvents NodeClick="function (s, e) { HideLeftPanelIfRequired(); }" />
    </dx:ASPxTreeView>

   <asp:XmlDataSource ID="NodesDataSource" runat="server" DataFile="~/App_Data/OverviewContents.xml" XPath="//Nodes/*" />--%>
</asp:Content>