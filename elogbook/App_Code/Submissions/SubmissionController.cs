using elogbook.Model;
using Microsoft.ApplicationBlocks.Data;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for SubmissionController
/// </summary>
public class SubmissionController
{
    private string connectionString;
    public SubmissionController()
    {
        connectionString = ConfigurationManager.ConnectionStrings["ApplicationServices"].ToString();
    }

    public bool CreateSubmission(int mentorId, int hospitalId, int assignmentId, string username, int institutionId)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            return SqlHelper.ExecuteNonQuery(sqlConnection, "spGT_ElogbookSubmissionsInsert", mentorId, hospitalId, assignmentId, username, institutionId) > 0;
        }
    }

    public List<ElogbookQuestion> GetQuestionsForSubmission(int submissionId)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(sqlConnection, "spGT_ElogbookQuestionLoadAllBySubmissionId", submissionId))
            {
                List<ElogbookQuestion> records = new List<ElogbookQuestion>();
                Utility u = new Utility();
                while (reader.Read())
                {
                    ElogbookQuestion record = new ElogbookQuestion();


                    record.DisplayOrder = u.GetDoubleFromReader(reader, "DisplayOrder");

                    record.QuestionId = u.GetIntFromReader(reader, "QuestionId");
                    record.QuestionText = u.GetStringFromReader(reader, "QuestionText");
                    record.QuestionOptions = u.GetStringFromReader(reader, "QuestionOptions");
                    record.HasSub = u.GetBoolFromReader(reader, "HasSub");
                    record.IsSub = u.GetBoolFromReader(reader, "IsSub");
                    record.QuestionOptions = u.GetStringFromReader(reader, "QuestionOptions");
                    record.ParentId = u.GetIntFromReader(reader, "ParentId");
                    record.ParentOption = u.GetStringFromReader(reader, "ParentOption");
                    record.ResponseType = u.GetStringFromReader(reader, "ResponseType");
                    record.SectionId = u.GetIntFromReader(reader, "SectionId");
                    record.SectionName = u.GetStringFromReader(reader, "SectionName");
                    record.SectionOrder = u.GetDoubleFromReader(reader, "SectionOrder");
                    record.ElogbookId = u.GetIntFromReader(reader, "ElogbookId");
                    record.InstitutionId = u.GetIntFromReader(reader, "InstitutionId");
                    record.CreatedBy = u.GetStringFromReader(reader, "CreatedBy");
                    record.CreatedOn = u.GetDateFromReader(reader, "CreatedOn");
                    record.UpdatedBy = u.GetStringFromReader(reader, "UpdatedBy");
                    record.UpdatedOn = u.GetDateFromReader(reader, "UpdatedOn");
                    record.CategoryId = u.GetIntFromReader(reader, "CategoryId");
                    record.ShowOnDashboard = u.GetBoolFromReader(reader, "ShowOnDashboard");
                    record.IsForSupervisor = u.GetBoolFromReader(reader, "IsForSupervisor");
                    record.IsAssignmentLevel = u.GetBoolFromReader(reader, "IsAssignmentLevel");
                    records.Add(record);
                }
                return records;
            }
        }
    }
    public List<ElogbookQuestion> GetQuestionsForElogbookWithCompetencies(int elogbookId)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(sqlConnection, "spGT_ElogbookQuestionLoadAllByElogbookIdWithCompetences", elogbookId))
            {
                List<ElogbookQuestion> records = new List<ElogbookQuestion>();
                Utility u = new Utility();
                while (reader.Read())
                {
                    records.Add(new ElogbookQuestion
                    {
                        QuestionId = u.GetIntFromReader(reader, "QuestionId"),
                        QuestionText = u.GetStringFromReader(reader, "QuestionText"),
                        QuestionOptions = u.GetStringFromReader(reader, "QuestionOptions")
                    });

                    ElogbookQuestion record = new ElogbookQuestion();


                }
                return records;
            }
        }
    }
    public bool AddQuestionCompetenceRecord(int elogbookId, int questionId,string questionText, string option, string createdBy, int institutionId)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            return SqlHelper.ExecuteNonQuery(sqlConnection, "spGT_ElogbookCompetenceAutoInsert", elogbookId, questionId,questionText, option, createdBy, institutionId) > 0;
        }
    }
    //public List<ElogbookQuestion> GetQuestionsForSubmission(int submissionId)
    //{
    //    using (SqlConnection sqlConnection = new SqlConnection(connectionString))
    //    {
    //        using (SqlDataReader reader = SqlHelper.ExecuteReader(sqlConnection, "spGT_ElogbookQuestionsLoadForSubmission", submissionId))
    //        {
    //            List<ElogbookQuestion> records = new List<ElogbookQuestion>();
    //            Utility u = new Utility();
    //            while (reader.Read())
    //            {
    //                ElogbookQuestion record = new ElogbookQuestion();
    //                record.SectionId = u.GetIntFromReader(reader, "SectionId");

    //                record.SectionName = u.GetStringFromReader(reader, "SectionName");
    //                record.SectionOrder = u.GetDoubleFromReader(reader, "SectionOrder");
    //                record.QuestionId = u.GetIntFromReader(reader, "QuestionId");
    //                record.QuestionText = u.GetStringFromReader(reader, "QuestionText");
    //                record.ParentOrder = u.GetDoubleFromReader(reader, "ParentOrder");
    //                record.QuestionOptions = u.GetStringFromReader(reader, "QuestionOptions");
    //                record.ResponseType = u.GetStringFromReader(reader, "ResponseType");
    //                record.ChildQuestionId = u.GetIntFromReader(reader, "ChildQuestionId");
    //                record.ChildQuestionText = u.GetStringFromReader(reader, "ChildQuestionText");
    //                record.ChildOrder = u.GetDoubleFromReader(reader, "ChildOrder");
    //                record.ChildQuestionDisplayText = u.GetStringFromReader(reader, "ChildQuestionDisplayText");
    //                record.ParentOption = u.GetStringFromReader(reader, "ParentOption");
    //                record.ChildResponseType = u.GetStringFromReader(reader, "ChildResponseType");
    //                record.ChildQuestionOptions = u.GetStringFromReader(reader, "ChildQuestionOptions");
    //                record.ParentIsForSupervisor = u.GetBoolFromReader(reader, "ParentIsForSupervisor");
    //                record.ParentIsAssignmentLevel = u.GetBoolFromReader(reader, "ParentIsAssignmentLevel");
    //                record.ChildIsForSupervisor = u.GetBoolFromReader(reader, "ChildIsForSupervisor");
    //                record.ChildIsAssignmentLevel = u.GetBoolFromReader(reader, "ChildIsAssignmentLevel");
    //                records.Add(record);
    //            }
    //            return records;
    //        }
    //    }
    //}
    public long AddCase(ElogbookCase elogbookCase)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            return Convert.ToInt64(SqlHelper.ExecuteScalar(sqlConnection, "spGT_ElogbookCasesInsert",
                elogbookCase.Patient, elogbookCase.SubmissionId, elogbookCase.InstitutionId, elogbookCase.UpdatedBy));
        }
    }
    public bool AddResponse(long caseId, int questionId, string responseText, string updatedBy, int institutionId, long submissionId)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            return SqlHelper.ExecuteNonQuery(sqlConnection, "spGT_ElogbookResponsesInsert",
                caseId, questionId, responseText, updatedBy, institutionId, submissionId) > 0; ;
        }
    }

    public List<ElogbookResponse> GetResponsesForCase(long caseId)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(sqlConnection, "spGT_ElogbookResponsesLoadForCase", caseId))
            {
                List<ElogbookResponse> records = new List<ElogbookResponse>();
                Utility u = new Utility();
                while (reader.Read())
                {
                    ElogbookResponse record = new ElogbookResponse();
                    record.CaseId = u.GetLongFromReader(reader, "CaseId");
                    record.QuestionId = u.GetIntFromReader(reader, "QuestionId");
                    record.ResponseText = u.GetStringFromReader(reader, "ResponseText");
                    record.SubmissionId = u.GetLongFromReader(reader, "SubmissionId");

                    records.Add(record);
                }
                return records;
            }
        }
    }
    public List<ElogbookResponse> GetResponsesForSubmisionAssignmentLevel(long submissionId)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(sqlConnection, "spGT_ElogbookResponsesLoadForSubmissionAssignmentLevel", submissionId))
            {
                List<ElogbookResponse> records = new List<ElogbookResponse>();
                Utility u = new Utility();
                while (reader.Read())
                {
                    ElogbookResponse record = new ElogbookResponse();

                    record.QuestionId = u.GetIntFromReader(reader, "QuestionId");
                    record.ResponseText = u.GetStringFromReader(reader, "ResponseText");
                    record.SubmissionId = u.GetLongFromReader(reader, "SubmissionId");

                    records.Add(record);
                }
                return records;
            }
        }
    }
    /// <summary>
    /// We use this to get responses for which we must count what competencies the student has achieved
    /// </summary>
    /// <param name="submissionId"></param>
    /// <returns></returns>
    public List<ElogbookAchievement> GetResponsesForElogbookAchievement(long submissionId)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(sqlConnection, "spGT_ElogbookResponsesLoadForCompetenceAchievements", submissionId))
            {
                List<ElogbookAchievement> records = new List<ElogbookAchievement>();
                Utility u = new Utility();
                while (reader.Read())
                {
                    records.Add(new ElogbookAchievement
                    {
                        QuestionId = u.GetIntFromReader(reader, "QuestionId"),
                        ResponseText = u.GetStringFromReader(reader, "ResponseText"),//responses
                        StudentId = u.GetIntFromReader(reader, "StudentId"),
                        InstitutionId = u.GetIntFromReader(reader, "InstitutionId"),
                        SubmissionId = u.GetIntFromReader(reader, "SubmissionId"),
                        ElogbookId = u.GetIntFromReader(reader, "ElogbookId"),
                        AssignmentId = u.GetIntFromReader(reader, "AssignmentId")//,
                        //Expected=u.GetIntFromReader(reader, "Expected"),
                        //QuestionOption = u.GetStringFromReader(reader, "QuestionOption")//option mapped to competence
                    });
                }
                return records;
            }
        }
    }

public List<ElogbookAchievement> GetCompetenciesForSubmissionAchievement(int elogbookId)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(sqlConnection, "spGT_ElogbookCompetenceLoadForSubmissionAchievement", elogbookId))
            {
                List<ElogbookAchievement> records = new List<ElogbookAchievement>();
                Utility u = new Utility();
                while (reader.Read())
                {
                    records.Add(new ElogbookAchievement
                    {
                        QuestionId = u.GetIntFromReader(reader, "QuestionId"),
                        
                        ElogbookId = u.GetIntFromReader(reader, "ElogbookId"),
                        
                        Expected=u.GetIntFromReader(reader, "Expected"),
                        QuestionOption = u.GetStringFromReader(reader, "QuestionOption")//option mapped to competence
                    });
                }
                return records;
            }
        }
    }

    public List<ElogbookAchievement> GetAchievementsForSubmission(long submissionId)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(sqlConnection, "spGT_ElogbookAchievementLoadForSubmission", submissionId))
            {
                List<ElogbookAchievement> records = new List<ElogbookAchievement>();
                Utility u = new Utility();
                while (reader.Read())
                {
                    records.Add(new ElogbookAchievement
                    {
                        QuestionId = u.GetIntFromReader(reader, "QuestionId"),
                        QuestionText = u.GetStringFromReader(reader, "QuestionText"),//responses
                        StudentId = u.GetIntFromReader(reader, "StudentId"),
                        SubmissionId = u.GetIntFromReader(reader, "SubmissionId"),
                        ElogbookId = u.GetIntFromReader(reader, "ElogbookId"),
                        AssignmentId = u.GetIntFromReader(reader, "AssignmentId"),//,
                        Expected=u.GetIntFromReader(reader, "Expected"),
                        Achieved = u.GetIntFromReader(reader, "Achieved"),
                        AchievedPercentage = u.GetDoubleFromReader(reader, "AchievedPercentage"),
                        QuestionOption = u.GetStringFromReader(reader, "QuestionOption")//option mapped to competence
                    });
                }
                return records;
            }
        }
    }
    public bool AddElogbookAchivement(int elogbookId, int assignmentId,long submissionId,int questionid,string questionOption,int studentId,int achieved)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            return SqlHelper.ExecuteNonQuery(sqlConnection, "spGT_ELogbookAchievementInsert",
                elogbookId,assignmentId,submissionId,questionid,questionOption,studentId,achieved) > 0;
        }
    }
    public bool AddElogbookAchivementReport(long submissionId)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            return SqlHelper.ExecuteNonQuery(sqlConnection, "spGT_ElogbookAchievementsReportInsert",
                submissionId) > 0;
        }
    }
    public bool AddSubmissionComment(string comment, string username, long submissionId, int institutionId, string userFullName)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            return SqlHelper.ExecuteNonQuery(sqlConnection, "spGT_ElogbookSubmissionCommentsInsert",
                comment, username, submissionId, institutionId, userFullName) > 0;
        }
    }
    public bool UpdateSubmissionStatus(long submissionId, string status)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            return SqlHelper.ExecuteNonQuery(sqlConnection, "spGT_ElogbookSubmissionStatusUpdate",
                submissionId, status) > 0;
        }
    }
    public bool UpdateSubmissionGrade(long submissionId, int gradeId, string gradedBy)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            return SqlHelper.ExecuteNonQuery(sqlConnection, "spGT_ElogbookSubmissionGradeInsert",
                submissionId, gradeId, gradedBy) > 0;
        }
    }
    public string GetSubmissionStatus(long submissionId)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            object status = SqlHelper.ExecuteScalar(sqlConnection, "spGT_ElogbookSubmissionLoadStatus",
                submissionId);
            if (status is DBNull)
            {
                return null;
            }
            else
            {
                return Convert.ToString(status);
            }

        }
    }
    public Submission GetSubmissionStatusGrades(long submissionId)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(sqlConnection, "spGT_ElogbookSubmissionsLoadStatusGrades",
                submissionId))
            {
                Utility u = new Utility();
                Submission record = null;
                if (reader.Read())
                {
                    record = new Submission();
                    record.Mentor = u.GetStringFromReader(reader, "Mentor");
                    record.Status = u.GetStringFromReader(reader, "Status");
                    record.GradeId = u.GetIntFromReader(reader, "GradeId");
                }
                return record;
            }


        }
    }
    public string GetSubmissionMentor(long submissionId)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            object mentor = SqlHelper.ExecuteScalar(sqlConnection, "spGT_ElogbookSubmissionsLoadMentor",
                submissionId);
            if (mentor is DBNull)
            {
                return null;
            }
            else
            {
                return Convert.ToString(mentor);
            }

        }
    }

    public List<ElogbookReportSubmission> GetElogbookReportSubmission(int academicYear)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(sqlConnection, "spGT_ElogbookReportLoadAssignmentSubmissions", academicYear))
            {
                List<ElogbookReportSubmission> records = new List<ElogbookReportSubmission>();
                Utility u = new Utility();
                while (reader.Read())
                {
                    ElogbookReportSubmission record = new ElogbookReportSubmission();
                    record.AssignmentId = u.GetIntFromReader(reader, "AssignmentId");
                    record.Rotation = u.GetStringFromReader(reader, "Rotation");
                    record.RotationPeriod = u.GetStringFromReader(reader, "RotationPeriod");
                    record.RotationYear = u.GetIntFromReader(reader, "RotationYear");
                    record.AcademicYear = u.GetIntFromReader(reader, "AcademicYear");
                    record.ElogbookId = u.GetIntFromReader(reader, "ElogbookId");
                    record.Elogbook = u.GetStringFromReader(reader, "Elogbook");
                    record.Program = u.GetStringFromReader(reader, "Program");
                    record.ProgramId = u.GetIntFromReader(reader, "ProgramId");
                    record.StudyYear = u.GetIntFromReader(reader, "StudyYear");
                    record.ElogbookVersion = u.GetStringFromReader(reader, "ElogbookVersion");
                    record.SubmissionId = u.GetIntFromReader(reader, "SubmissionId");
                    record.Mentor = u.GetStringFromReader(reader, "Mentor");
                    record.Hospital = u.GetStringFromReader(reader, "Hospital");
                    record.Status = u.GetStringFromReader(reader, "Status");
                    record.Grade = u.GetStringFromReader(reader, "Grade");
                    record.GradedBy = u.GetStringFromReader(reader, "GradedBy");
                    record.StudentId = u.GetIntFromReader(reader, "StudentId");
                    record.Student = u.GetStringFromReader(reader, "Student");
                    record.Sex = u.GetStringFromReader(reader, "Sex");
                    record.ComputerNumber = u.GetStringFromReader(reader, "ComputerNumber");
                    records.Add(record);

                }

                return records;

            }
        }
    }

    public List<ElogbookReportResponse> GetElogbookReportResponses(long submissionId)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(sqlConnection, "spGT_ElogbookReportLoadResponses", submissionId))
            {
                List<ElogbookReportResponse> records = new List<ElogbookReportResponse>();
                Utility u = new Utility();
                while (reader.Read())
                {
                    ElogbookReportResponse record = new ElogbookReportResponse();
                    record.CaseId = u.GetLongFromReader(reader, "CaseId");
                    record.Patient = u.GetStringFromReader(reader, "Patient");
                    record.QuestionId = u.GetIntFromReader(reader, "QuestionId");
                    record.DisplayOrder = u.GetDoubleFromReader(reader, "DisplayOrder");
                    record.QuestionText = u.GetStringFromReader(reader, "QuestionText");
                    record.ResponseType = u.GetStringFromReader(reader, "ResponseType");
                    record.ShowOnDashboard = u.GetBoolFromReader(reader, "ShowOnDashboard");
                    record.HasSub = u.GetBoolFromReader(reader, "HasSub");
                    record.IsSub = u.GetBoolFromReader(reader, "IsSub");
                    record.Parent = u.GetStringFromReader(reader, "Parent");
                    record.SectionId = u.GetIntFromReader(reader, "SectionId");
                    record.SectionOrder = u.GetDoubleFromReader(reader, "SectionOrder");
                    record.SectionName = u.GetStringFromReader(reader, "SectionName");
                    record.Category = u.GetStringFromReader(reader, "Category");
                    record.ResponseText = u.GetStringFromReader(reader, "ResponseText");
                    record.ResponseYear = u.GetIntFromReader(reader, "ResponseYear");
                    record.ResponseMonthNo = u.GetIntFromReader(reader, "ResponseMonthNo");
                    record.ResponseMonth = u.GetStringFromReader(reader, "ResponseMonth");

                    records.Add(record);

                }

                return records;

            }
        }
    }

    public bool DeleteElogbookReport(int academicYear)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            return SqlHelper.ExecuteNonQuery(sqlConnection, "spGT_ElogbookReportDeleteForYear", academicYear) > 0;
        }
    }

    public bool AddElogbookReport(ElogbookReportSubmission submission)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            return SqlHelper.ExecuteNonQuery(sqlConnection, "spGT_ELogbookReportInsert",
                submission.AssignmentId,
submission.Rotation,
submission.RotationPeriod,
submission.RotationYear,
submission.AcademicYear,
submission.ElogbookId,
submission.Elogbook,
submission.Program,
submission.ProgramId,
submission.StudyYear,
submission.ElogbookVersion,
submission.SubmissionId,
submission.Mentor,
submission.Hospital,
submission.Status,
submission.Grade,
submission.GradedBy,
submission.StudentId,
submission.Student,
submission.Sex,
submission.ComputerNumber,
submission.QuestionId,
submission.Section,
submission.Category,
submission.QuestionText,
submission.ParentQuestion,
submission.ResponseText,
submission.Patient,
submission.DisplayOrder,
submission.ResponseYear,
submission.ResponseMonthNo,
submission.ResponseMonth,
submission.SectionOrder,
submission.ShowOnDashboard,
submission.ResponseType) > 0;
        }
    }

    public List<ElogbookDashboardQuestion> GetDashboardQuestions(string role, string username)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(sqlConnection, "spGT_ElogbookReportLoadDashboardQuestions", role, username))
            {
                List<ElogbookDashboardQuestion> records = new List<ElogbookDashboardQuestion>();
                Utility u = new Utility();
                while (reader.Read())
                {
                    ElogbookDashboardQuestion record = new ElogbookDashboardQuestion();
                    record.SectionOrder = u.GetDoubleFromReader(reader, "SectionOrder");
                    record.Section = u.GetStringFromReader(reader, "Section");
                    record.DisplayOrder = u.GetDoubleFromReader(reader, "DisplayOrder");
                    record.Question = u.GetStringFromReader(reader, "Question");
                    record.ResponseText = u.GetStringFromReader(reader, "ResponseText");
                    record.ResponseType = u.GetStringFromReader(reader, "ResponseType");
                    record.Number = u.GetIntFromReader(reader, "Number");


                    records.Add(record);

                }

                return records;

            }
        }
    }
}