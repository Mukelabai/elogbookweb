using elogbook.Model;
using Microsoft.ApplicationBlocks.Data;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for StudentsController
/// </summary>
public class StudentsController
{
    private string connectionString;
    public StudentsController()
    {
        connectionString = ConfigurationManager.ConnectionStrings["ApplicationServices"].ToString();
    }
    public List<String> GetComputerNumbersUnAssigned(int institutionId)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            using (SqlDataReader reader = SqlHelper.ExecuteReader(sqlConnection, "spGT_ComputerNumbersLoadUnAssignedUserAccounts", institutionId))
            {
                Utility u = new Utility();
                List<String> iDs = new List<string>();
                while (reader.Read())
                {
                    string iD = u.GetStringFromReader(reader, "ComputerNumber");
                    iDs.Add(iD);
                }
                reader.Close();
                return iDs;
            }
        }
    }
    public List<String> GetComputerIDsCompletedMoreThan2YearsAgo(int institutionId)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            Utility u = new Utility();
            using (SqlDataReader reader = SqlHelper.ExecuteReader(sqlConnection, "spGT_ComputerNumbersLoadCompletedTwoYearsAgo", institutionId))
            {
                List<String> iDs = new List<string>();
                while (reader.Read())
                {
                    string iD = u.GetStringFromReader(reader, "ComputerNumber");
                    iDs.Add(iD);
                }
                reader.Close();
                return iDs;
            }
        }
    }

    public bool RegisterStudentOnProgram(int ProgramId,int StudentId,int StudyYear,int AcademicYear,int InstitutionId)
    {
        using (SqlConnection sqlConnection = new SqlConnection(connectionString))
        {
            return SqlHelper.ExecuteNonQuery(sqlConnection, "spGT_ProgramRegisterInsert", ProgramId,
StudentId,
StudyYear,
AcademicYear,
InstitutionId) > 0;
        }
    }
}