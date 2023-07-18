using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ElogbookReportResponse
/// </summary>
public class ElogbookReportResponse
{
    public ElogbookReportResponse()
    {
        //
        // TODO: Add constructor logic here
        //
    }

   
    public int SectionId
    {
        get; set;
    }

    public int QuestionId
    {
        get;set;
    }

    

    public int ResponseYear
    {
        get; set;
    }

    public int ResponseMonthNo
    {
        get; set;
    }

    public int StudentId
    {
        get; set;
    }

    public int InstitutionId
    {
        get; set;
    }

    public long CaseId
    {
        get; set;
    }

    public long SubmissionId
    {
        get; set;
    }

    public string Patient
    {
        get; set;
    }

    public string QuestionText
    {
        get;set;
    }

    public string SectionName
    {
        get;set;
    }

    public string Category
    {
        get;set;
    }

   

 

    public string ResponseText
    {
        get; set;
    }

    public string ResponseMonth
    {
        get; set;
    }

    public double DisplayOrder
    {
        get; set;
    }

   

    public string ResponseType
    {
        get; set;
    }

    



    public double SectionOrder
    {
        get; set;
    }

    public bool ShowOnDashboard
    {
        get; set;
    }

   

    public bool HasSub
    {
        get; set;
    }

    public bool IsSub
    {
        get; set;
    }
    public string Parent { get; set; }
}