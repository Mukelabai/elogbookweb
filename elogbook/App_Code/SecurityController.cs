
using System;
using System.Text;
using Microsoft.ApplicationBlocks.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Configuration;
using System.Web.Security;
using elogbook.Model.Faculty;
using System.Collections.Generic;

namespace elogbook.Model

{
    public class SecurityController
    {
        private string connectionString;
        //onstructor
        public SecurityController()
        {
            connectionString = ConfigurationManager.ConnectionStrings["ApplicationServices"].ToString();

        }
        public List<StaffContact> GetStaffIDsForUserAccounts(int institutionId)
        {
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                SqlDataReader reader = SqlHelper.ExecuteReader(sqlConnection, "spGT_StaffIDsLoadForUserAccounts", institutionId);
                Utility u = new Utility();
                List<StaffContact> iDs = new List<StaffContact>();
                while (reader.Read())
                {
                    StaffContact contact = new global::StaffContact();
                    contact.StaffNumber = u.GetStringFromReader(reader, "StaffNumber");
                    contact.EmailAddress = u.GetStringFromReader(reader, "EmailAddress");
                    iDs.Add(contact);
                }
                reader.Close();
                return iDs;
            }
        }
        public string GetUserRightsOnly(int institutionId, string roleName)
        {
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                SqlDataReader reader = SqlHelper.ExecuteReader(sqlConnection, "spGT_UserRightsLoadRightsOnly", institutionId, roleName);
                Utility u = new Utility();
                string rights = null;
                if (reader.Read())
                {
                    rights = u.GetStringFromReader(reader, "Rights");
                }
                reader.Close();
                return rights;
            }
        }
        public string GetInstitutionModules(int institutionId)
        {
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                SqlDataReader reader = SqlHelper.ExecuteReader(sqlConnection, "spGT_ModulesLoadByInstitutionId", institutionId);
                Utility u = new Utility();
                string modules = null;
                if (reader.Read())
                {
                    modules = u.GetStringFromReader(reader, "Modules");
                }
                reader.Close();
                return modules;
            }

        }
        public string GetStaffNameFromUsername(string username)
        {
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                object record = SqlHelper.ExecuteScalar(sqlConnection, "spGT_StaffLoadNameByUsername", username);
                return record is DBNull ? null : Convert.ToString(record);
            }

        }
        public Institution GetInstitutionDetails(string userName)
        {
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                SqlDataReader reader = SqlHelper.ExecuteReader(sqlConnection, "spGT_InstitutionLoadHeaderForUser", userName);
                Institution school = new Institution();
                Utility u = new Utility();
                if (reader.Read())
                {
                    school.InstitutionName = u.GetStringFromReader(reader, "InstitutionName");
                    school.ContactDetails = u.GetStringFromReader(reader, "ContactDetails");
                    school.Motto = u.GetStringFromReader(reader, "Motto");
                    school.LogoURL = u.GetStringFromReader(reader, "LogoURL");
                }
                reader.Close();
                return school;
            }
        }
        public string GetRoleRights(string roleName)
        {
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                return Convert.ToString(SqlHelper.ExecuteScalar(sqlConnection, "spGT_SSRoleRightsLoad", roleName));
            }
        }
        public bool UpdateRoleRights(string roleName, string rights)
        {
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                return SqlHelper.ExecuteNonQuery(sqlConnection, "spGT_RoleRightsUpdate", roleName, rights) > 0;
            }
        }

        public bool UpdateInstitutionRoles(string roleName, int institutionId, string rights)
        {
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                return SqlHelper.ExecuteNonQuery(sqlConnection, "spGT_InstitutionRolesInsert", roleName, institutionId, rights) > 0;
            }
        }
        public bool UpdateRoleInstitutionId(string roleName, int institutionId)
        {
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                return SqlHelper.ExecuteNonQuery(sqlConnection, "spGT_RoleInstitutionIdUpdate", roleName, institutionId) > 0;
            }
        }
        public string GetUserLevel(string userName)
        {
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                return Convert.ToString(SqlHelper.ExecuteScalar(sqlConnection, "spGT_SSUserLoadLevel", userName));
            }
        }
        public int GetUserInstitutionId(string userName)
        {
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                return Convert.ToInt32(SqlHelper.ExecuteScalar(sqlConnection, "spGT_UserLoadInstitutionId", userName));
            }
        }
        public int GetUserInstitutionId()
        {
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                return Convert.ToInt32(SqlHelper.ExecuteScalar(sqlConnection, "spGT_UserLoadInstitutionId", Membership.GetUser().UserName));
            }
        }
        

        public bool UpdateStaffUsername(string staffNumber, string userName, int institutionId)
        {
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                return SqlHelper.ExecuteNonQuery(sqlConnection, "spGT_StaffUpdateUsername", staffNumber, userName, institutionId) > 0;
            }
        }
        public bool UpdateStaffUsernameById(int staffId, string userName, int institutionId)
        {
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                return SqlHelper.ExecuteNonQuery(sqlConnection, "spGT_StaffUpdateUsernameByStaffId", staffId, userName, institutionId) > 0;
            }
        }
        public bool UpdateStudentUsername(string computerNumber, string userName, int institutionId)
        {
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                return SqlHelper.ExecuteNonQuery(sqlConnection, "spGT_StudentUpdateUsername", computerNumber, userName, institutionId) > 0;
            }
        }
        //public static void EnablePrint(DevExpress.XtraGrid.GridControl gvcList,DevExpress.XtraEditors.SimpleButton btnPrint)
        //{
        //    btnPrint.Enabled = (gvcList.DataSource as IList).Count != 0;
        //}

        //public void StartService(string serviceName, int timeoutMilliseconds)
        //{
        //    ServiceController service = new ServiceController(serviceName);

        //    TimeSpan timeout = TimeSpan.FromMilliseconds(timeoutMilliseconds);
        //    if ((service.Status.Equals(ServiceControllerStatus.Stopped)) ||
        //            (service.Status.Equals(ServiceControllerStatus.StopPending)))
        //    {
        //        // Start the service if the current status is stopped.


        //        service.Start();
        //        service.WaitForStatus(ServiceControllerStatus.Running, timeout);
        //    }
        //}

        public bool BackupDB()
        {
            SqlConnection sqlConnection = new SqlConnection("Data Source=(local)\\SQLEXPRESS; Initial Catalog=Master; User ID=sa; Password=5$H2o|o2H$5");
            sqlConnection.Open();
            SqlCommand sqlCMD = sqlConnection.CreateCommand();
            // string dbDestinationFilesPath = System.IO.Path.Combine(installationPath, "dbFiles\\GTSESchool.mdf");
            // string dbDestinationFilesPath = System.IO.Path.Combine(installationPath, "dbFiles\\GTSESchool.mdf");
            sqlCMD.CommandText = @"BACKUP DATABASE [GTSESchool] TO  DISK = N'C:\dbFiles\GTSESchoolData.bak' WITH NOFORMAT, NOINIT,  NAME = N'GTSESchool-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10";


            //"USE MASTER RESTORE DATABASE GTSESchool "
            //   + "FROM DISK = '" + dbSourceFilePath + "' "
            //   + "WITH MOVE MySIMSDatabase TO '" + System.IO.Path.Combine(installationPath, "dbFiles\\GTSESchool.mdf") 
            //   + "', MOVE MySIMSDatabase_log TO '" + System.IO.Path.Combine(installationPath, "dbFiles\\GTSESchool_log.ldf")
            //   + "', REPLACE";
            //  SqlCommand cmd = new SqlCommand(string.Format("RESTORE DATABASE [GTSESchool] FROM  DISK = N'GTSESchool.bak' WITH  FILE = 1,  MOVE N'MySIMSDatabase' TO N'{0}\\Database\\SCHOOL.mdf',  MOVE N'MySIMSDatabase_log' TO N'{0}\\Database\\SCHOOL_1.ldf',  NOUNLOAD,  REPLACE", installationPath));
            //cmd.Connection = new SqlConnection("Data Source=.\\GTSESchool;Database=master;user id=sa;password=5$H2o|o2H$5");
            sqlCMD.CommandTimeout = 100000;
            return sqlCMD.ExecuteNonQuery() > 0;

            // return SqlHelper.ExecuteNonQuery(sqlConnection, CommandType.Text, @"BACKUP DATABASE [GTSESchool] TO  DISK = N'C:\dbFiles2\GTSESchoolData.bak' WITH NOFORMAT, NOINIT,  NAME = N'GTSESchool-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10") > 0;



        }

        public bool AddUserInstitution(string userName, int institutionId)
        {
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                return SqlHelper.ExecuteNonQuery(sqlConnection, "spGT_UsersUpdateInstitutionId", userName, institutionId) > 0;
            }
        }
        //public string GetStringFromCheckListBox(DevExpress.XtraEditors.CheckedListBoxControl chkList)
        //{
        //    //set implemnted services
        //    StringBuilder myString = new StringBuilder();
        //    string returnedString = null;


        //    if (chkList.CheckedItems != null && chkList.CheckedItems.Count != 0)
        //    {
        //        foreach (object item in chkList.CheckedItems)
        //        {
        //            if (chkList.CheckedItems.Count == 1)
        //            {
        //                myString.Append(item.ToString());

        //            }
        //            else if (chkList.CheckedItems.IndexOf(item) != chkList.CheckedItems.Count - 1)
        //            {
        //                myString.Append(item.ToString());
        //                myString.Append(",");
        //            }
        //            else
        //            {
        //                myString.Append(item.ToString());

        //            }
        //        }
        //        returnedString = myString.ToString();
        //    }


        //    return returnedString;
        //}

        //public void LoadChkListBoxFromString(string items, DevExpress.XtraEditors.CheckedListBoxControl chkList)
        //{
        //    if (!string.IsNullOrWhiteSpace(items))
        //    {
        //        string[] listItems = items.Split(',');
        //        string itemInCheckList;
        //        string userRole;
        //        for (int i = 0; i < chkList.ItemCount; i++)
        //        {
        //            // object item = FindByText(listItems[i], chkList);
        //            itemInCheckList = chkList.Items[i].Value.ToString();
        //            bool isContained = false;
        //            for (int j = 0; j < listItems.Length; j++)
        //            {
        //                userRole = listItems[j];
        //                isContained = string.Compare(userRole, itemInCheckList, true) == 0;
        //                if (isContained) break;
        //                else continue;
        //            }


        //            chkList.SetItemChecked(i, isContained);


        //        }

        //    }
        //}

        //public void InitialiseDateControls(DateEdit[] dateControls)
        //{

        //    foreach (DateEdit control in dateControls)
        //    {
        //        //display format
        //        control.Properties.DisplayFormat.FormatString = "ddd, MMM dd, yyyy";
        //        control.Properties.EditFormat.FormatString = "mm/dd/yyyy";
        //        control.Properties.EditMask = "d";
        //        //edit format type
        //        control.Properties.EditFormat.FormatType = DevExpress.Utils.FormatType.DateTime;
        //        //edit style
        //        control.Properties.TextEditStyle = DevExpress.XtraEditors.Controls.TextEditStyles.Standard;
        //        //max value
        //        control.Properties.MaxValue = DateTime.Now;
        //        //min value
        //        control.Properties.MinValue = new DateTime(1900, 1, 1);
        //        //intialise to current date
        //        control.DateTime = DateTime.Now;
        //    }

        //}

        public string Encrypt(string inp)
        {

            MD5CryptoServiceProvider hasher = new MD5CryptoServiceProvider();

            byte[] tBytes = Encoding.ASCII.GetBytes(inp);

            byte[] hBytes = hasher.ComputeHash(tBytes);

            StringBuilder sb = new StringBuilder();

            for (int c = 0; c < hBytes.Length; c++)

                sb.AppendFormat("{0:x2}", hBytes[c]);

            return (sb.ToString());

        }


        //
        public void DeleteUserRoles(int userId)
        {
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                SqlHelper.ExecuteNonQuery(sqlConnection, "spCM_DeleteUserRoles", userId);
            }
        }
        public bool UpdateUserRoles(int userId, string roleName)
        {
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                return SqlHelper.ExecuteNonQuery(sqlConnection, "spCM_UpdateUserRoles", userId, roleName) > 0;
            }
        }


        public bool DeleteUser(int UserId)
        {
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                return SqlHelper.ExecuteNonQuery(sqlConnection, "spGT_DeleteUser", UserId) > 0;//if afftected rows >0 then user deleted
            }
        }

        public bool UpdatePassword(string username, string oldPassword, string newPassword)
        {
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                return SqlHelper.ExecuteNonQuery(sqlConnection, "UpdatePassword", username, oldPassword, newPassword) > 0;//if afftected rows >0 then password updated
            }
        }

       

       
        public bool DeleteLogRequest(int UserId, string request, bool granted, DateTime requestdate)
        {
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                return SqlHelper.ExecuteNonQuery(sqlConnection, "spGT_SALogDelete", UserId, request, granted, requestdate) > 0;
            }
        }



        public bool EmailAddressExists(string email)
        {
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                return Convert.ToInt32(SqlHelper.ExecuteScalar(sqlConnection, "spGT_SAEmailExists", email)) > 0;
            }
        }
        //Load roles
       
    }
}
