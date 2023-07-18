using System;
using System.Collections.Generic;
using System.IO;
using System.Web.Security;
using System.Linq;
using System.Data;
using DevExpress.Web.Bootstrap;
using System.Web.UI.WebControls;

public partial class Default : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
        if (Membership.GetUser() == null || Session == null)
        {
            Response.Redirect("~/Account/Signin.aspx");
            return;
        }
        hfRole.Value = Roles.GetRolesForUser()[0];
        hfUsername.Value = Membership.GetUser().UserName;
        LoadData();
        //TextContent.InnerHtml = File.ReadAllText(Server.MapPath(@"~/App_Data/Overview.html"));

        //TableOfContentsTreeView.DataBind();
        //TableOfContentsTreeView.ExpandAll();
    }

    protected void LoadData()
    {
        SubmissionController sc = new SubmissionController();
        List<ElogbookDashboardQuestion> records = sc.GetDashboardQuestions(Roles.GetRolesForUser()[0], Membership.GetUser().UserName);
        //get distinct questions
        string[] questions = (from r in records
                              select r.Question).Distinct().ToArray();
        foreach(string question in questions)
        {
            List<ElogbookDashboardQuestion> questionData = records.Where(r => r.Question == question).ToList();
            //create chart
            BootstrapChart chart = new BootstrapChart();
            chart.Width = Unit.Percentage(100);
            DataTable data = GetData(questionData);
            chart.DataSource = data;
            chart.SettingsCommonSeries.ArgumentField = data.Columns[1].ColumnName;
            BootstrapChartBarSeries bar = new BootstrapChartBarSeries() { ValueField = data.Columns[2].ColumnName, Name = data.Columns[1].ColumnName };
            bar.Label.Visible = true;
            chart.SeriesCollection.Add(bar);
            chart.TitleSettings.Text = question;
            chart.DataBind();
            rpQuestionCharts.Controls.Add(chart);
        }
    }

    protected DataTable GetData(List<ElogbookDashboardQuestion> questionData)
    {
        DataTable table = new DataTable();
        table.Columns.Add("Question", typeof(string));
        table.Columns.Add("Response", typeof(string));
        table.Columns.Add("Number", typeof(int));
        foreach(ElogbookDashboardQuestion question in questionData)
        {
            table.Rows.Add(question.Question, question.ResponseText, question.Number);
        }
               
        return table;
    }
    }