using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ElogbookQuestion
/// </summary>
public class ElogbookQuestion
{
    public ElogbookQuestion()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public double DisplayOrder { get; set; }
    public int QuestionId { get; set; }
    public string QuestionText { get; set; }
    public string QuestionOptions { get; set; }
    public bool HasSub { get; set; }
    public bool IsSub { get; set; }
    public int ParentId { get; set; }
    public string ParentOption { get; set; }
    public string ResponseType { get; set; }
    public int SectionId { get; set; }
    public string SectionName { get; set; }
    public double SectionOrder { get; set; }
    public int ElogbookId { get; set; }
    public int InstitutionId { get; set; }
    public string CreatedBy { get; set; }
    public DateTime CreatedOn { get; set; }
    public string UpdatedBy { get; set; }
    public DateTime UpdatedOn { get; set; }
    public int CategoryId { get; set; }
    public bool ShowOnDashboard { get; set; }
    public bool IsForSupervisor { get; set; }
    public bool IsAssignmentLevel { get; set; }
    public bool HasCompetences { get; set; }
}