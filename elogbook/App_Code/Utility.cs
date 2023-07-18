using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI.WebControls;
using DevExpress.Web;
using System.Drawing;
using System.Web.Security;
using DevExpress.Web.ASPxPivotGrid;
using System.Data.SqlClient;
using DotNetNuke.Common.Utilities;
using System.Collections;
using System.IO;
using System.Configuration;
using System.Data;
using System.Collections.Specialized;
using System.Web.UI;

/// <summary>
/// Summary description for Utility
/// </summary>
/// 
namespace elogbook.Model

{
    public class Utility
    {

        public Utility()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public static string GetAnnouncmentURLQuery(String senderId, string phone, string message)
        {
            return string.Format("https://bulksms.zamtel.co.zm/api/v2.1/action/send/api_key/1f43c62af5c4ee0994f19a218a227fc4/contacts/{0}/senderId/{1}/message/{2}", phone, senderId, CleanMessage(message));
            //return string.Format("https://apps.zamtel.co.zm/bulksms/api/action/send/api_key/1f43c62af5c4ee0994f19a218a227fc4/senderId/{0}/contacts/{1}/message/{2}", senderId, phone, message);

        }
        public static string GetPaymentQuery(string institutionId)
        {
            string url = ConfigurationManager.AppSettings["paymentAPIURL"].ToString();
            return string.Format("{0}{1}", url, institutionId);

        }
        public static string CleanMessage(string message)
        {
            //message = message.Replace("/", "-").Replace("\\", "-").Replace("\n", " ");
            //message = message.Replace("+", "%0A");
            return HttpUtility.UrlEncode(message);
            //return message;
        }

        public static int ExecuteNonQuery(string spName, params object[] values)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ApplicationServices"].ToString();
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(spName, sqlConnection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddRange(Utility.GetParameters(values));
                sqlConnection.Open();
                int result = cmd.ExecuteNonQuery();
                sqlConnection.Close(); sqlConnection.Dispose();
                return result;
            }
        }

        public static object ExecuteScalar(string spName, params object[] values)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ApplicationServices"].ToString();
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(spName, sqlConnection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddRange(Utility.GetParameters(values));
                sqlConnection.Open();
                object result = cmd.ExecuteScalar();
                sqlConnection.Close(); sqlConnection.Dispose();
                return result;
            }
        }

        public static SqlDataReader ExecuteReader(string spName, string parNames, params object[] values)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ApplicationServices"].ToString();
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(spName, sqlConnection);
                cmd.CommandType = CommandType.StoredProcedure;
                for (int i = 0; i < values.Length; i++)
                {
                    cmd.Parameters[0].Value = values[i];
                }
                cmd.Parameters.AddRange(Utility.GetParameters(parNames, values));
                sqlConnection.Open();
                SqlDataReader result = cmd.ExecuteReader();
                sqlConnection.Close();
                sqlConnection.Dispose();
                return result;
            }
        }
        public static SqlParameter[] GetParameters(params object[] values)
        {
            List<SqlParameter> pars = new List<SqlParameter>();
            foreach (object value in values)
            {
                SqlParameter par = new SqlParameter();
                par.SqlValue = value;
                pars.Add(par);
            }
            return pars.ToArray();

        }

        public static string CleanNumber(string phoneNumber)
        {
            phoneNumber = phoneNumber.Replace(" ", "").Replace("O", "0").Replace("+", "");
            if (!phoneNumber.StartsWith("260") && phoneNumber.StartsWith("0"))
            {
                phoneNumber = "26" + phoneNumber;
            }
            else if (!phoneNumber.StartsWith("260"))
            {
                phoneNumber = "260" + phoneNumber;
            }

            return phoneNumber;
        }

        public static void writeToLog(StreamWriter w, String message)
        {
            if (w != null)
            {
                w.WriteLine(message);
                w.Flush();
            }
        }
        public static void ShowEditControls(ASPxGridView grid, string commandColumnName, bool add, bool edit, bool delete)
        {
            grid.SettingsDataSecurity.AllowDelete = delete;
            grid.SettingsDataSecurity.AllowEdit = edit;
            grid.SettingsDataSecurity.AllowInsert = add;
            grid.Columns[commandColumnName].Visible = add || edit || delete;
            ((GridViewCommandColumn)grid.Columns[commandColumnName]).ShowNewButtonInHeader = add;
            ((GridViewCommandColumn)grid.Columns[commandColumnName]).ShowEditButton = edit;
            ((GridViewCommandColumn)grid.Columns[commandColumnName]).ShowDeleteButton = delete;
        }
        public static string GetCurrentTimeString()
        {
            return string.Format("{0}", DateTime.Now.ToShortDateString().Replace("/", "_").Replace(":", "_"));
        }
        public static void ClearCheckList(CheckBoxList chkList)
        {
            foreach (ListItem item in chkList.Items)
            {
                item.Selected = false;
            }
        }
        private string GetRandomUsername()
        {
            int firstPart = new Random().Next(1000, 5000);
            int secondPart = new Random().Next(6000, 9999);
            return string.Format("{0}-{1}", firstPart, secondPart);
        }
        public int GetIntFromDropDownList(DropDownList ddlList)
        {
            return string.IsNullOrWhiteSpace(ddlList.SelectedValue) ? -1 : Convert.ToInt32(ddlList.SelectedValue);
        }
        public string GetStringtFromDropDownList(DropDownList ddlList)
        {
            return string.IsNullOrWhiteSpace(ddlList.SelectedValue) ? null : ddlList.SelectedValue;
        }
        public int GetIntFromDropDownList(ASPxComboBox ddlList)
        {
            return ddlList.Value == null ? -1 : Convert.ToInt32(ddlList.Value);
        }
        public string GetStringtFromDropDownList(ASPxComboBox ddlList)
        {
            return ddlList.Value == null ? null : Convert.ToString(ddlList.Value);
        }
        public static string GetUserNameFromStaffNumber(string staffNumber, int institutionId)
        {
            return string.Format("{0}-{1}", institutionId, staffNumber);
        }
        public static void ExportPivot(DropDownList ddList, ASPxPivotGridExporter pivotGridExporter, ASPxPivotGrid pivotGrid)
        {
            pivotGridExporter.ASPxPivotGridID = pivotGrid.ID;
            ExportPivotGrid(ddList.SelectedValue, pivotGridExporter);
        }
        public static void ExportPivot(ASPxComboBox ddList, ASPxPivotGridExporter pivotGridExporter, ASPxPivotGrid pivotGrid)
        {
            pivotGridExporter.ASPxPivotGridID = pivotGrid.ID;
            ExportPivotGrid(Convert.ToString(ddList.Value), pivotGridExporter);
        }
        private static void ExportPivotGrid(string format, ASPxPivotGridExporter gridViewExporter)
        {
            switch (format)
            {
                case "Excel":
                    gridViewExporter.ExportXlsxToResponse(gridViewExporter.ASPxPivotGridID, true); ;
                    break;
                case "Excel (97-2003)":
                    gridViewExporter.ExportXlsToResponse(gridViewExporter.ASPxPivotGridID, true);
                    break;

            }
        }





        public static void SetPageSize(ASPxPivotGrid pivotGrid, DropDownList ddlItems)
        {
            pivotGrid.OptionsPager.RowsPerPage = Convert.ToInt32(ddlItems.SelectedValue);
            pivotGrid.DataBind();
        }
        public static void SetPageSize(ASPxPivotGrid pivotGrid, ASPxComboBox ddlItems)
        {
            pivotGrid.OptionsPager.RowsPerPage = Convert.ToInt32(ddlItems.Value);
            pivotGrid.DataBind();
        }
        public static void DisplayErrorMessage(Exception ex, ASPxLabel lblMessage)
        {
            lblMessage.ForeColor = Color.Red;
            lblMessage.Font.Bold = true;
            lblMessage.Text = ex.Message;
            //if (Roles.IsUserInRole("Admin") || Roles.IsUserInRole("Administrators"))
            //{
            //    lblMessage.Text = string.Format("{0}\nStack Trace:\n{1}", lblMessage.Text, ex.StackTrace);
            //}

        }
        public static void DisplayErrorMessage(string message, ASPxLabel lblMessage)
        {
            lblMessage.ForeColor = Color.Red;
            lblMessage.Font.Bold = true;
            lblMessage.Text = message;

        }
        public static void DisplayInfoMessage(string message, ASPxLabel lblMessage)
        {
            lblMessage.ForeColor = Color.Green;
            lblMessage.Font.Bold = true;
            lblMessage.Text = message;

        }

        public static bool IsNullOrWhiteSpace(string value)
        {
            return value == null || value.Trim() == "";
        }
        public static bool IsNullOrWhiteSpace(DropDownList ddlList)
        {
            return ddlList.SelectedValue == null || ddlList.SelectedValue.Trim() == "";
        }

        public static void CheckAllItems(CheckBoxList chkList, bool check)
        {
            foreach (ListItem item in chkList.Items)
            {
                item.Selected = check;
            }
        }
        public static int CheckedItemsCount(CheckBoxList chkList)
        {
            int count = 0;
            foreach (ListItem item in chkList.Items)
            {
                if (item.Selected) count++;
            }

            return count;
        }

        public static List<string> Shuffle(List<string> list)
        {

            Random randomNumbers = new Random();
            // for each item, pick another random item and swap them
            for (int first = 0; first < list.Count; first++)
            {
                // select a random number

                // random.
                int second = randomNumbers.Next(list.Count);

                // swap current item with randomly selected item
                string temp = list[first];
                list[first] = list[second];
                list[second] = temp;
            } // end for

            return list;
        } // end method 


        //public static List<Location> Shuffle(List<Location> list)
        //{

        //    Random randomNumbers = new Random();
        //    // for each item, pick another random item and swap them
        //    for (int first = 0; first < list.Count; first++)
        //    {
        //        // select a random number

        //        // random.
        //        int second = randomNumbers.Next(list.Count);

        //        // swap current item with randomly selected item
        //        Location temp = list[first];
        //        list[first] = list[second];
        //        list[second] = temp;
        //    } // end for

        //    return list;
        //} // end method 

        public static string Reverse(string text)
        {
            if (text == null) return null;

            // this was posted by petebob as well 
            char[] array = text.ToCharArray();
            Array.Reverse(array);
            return new String(array);
        }
        public int GetIntFromReader(SqlDataReader reader, string columnName)
        {
            return reader[columnName] is DBNull ? -1 : Convert.ToInt32(reader[columnName]);
        }
        public long GetLongFromReader(SqlDataReader reader, string columnName)
        {
            return reader[columnName] is DBNull ? -1 : Convert.ToInt64(reader[columnName]);
        }
        public double GetDoubleFromReader(SqlDataReader reader, string columnName)
        {
            return reader[columnName] is DBNull ? -1 : Convert.ToDouble(reader[columnName]);
        }
        public int? GetNullIntFromReader(SqlDataReader reader, string columnName)
        {
            return reader[columnName] is DBNull ? null : (int?)Convert.ToInt32(reader[columnName]);
        }

        public Guid GetGuidFromReader(SqlDataReader reader, string columnName)
        {
            return reader[columnName] is DBNull ? Guid.Empty : Guid.Parse(Convert.ToString(reader[columnName]));
        }
        public string GetStringFromReader(SqlDataReader reader, string columnName)
        {
            return reader[columnName] is DBNull ? null : Convert.ToString(reader[columnName]);
        }
        public bool GetBoolFromReader(SqlDataReader reader, string columnName)
        {
            return reader[columnName] is DBNull ? false : Convert.ToBoolean(reader[columnName]);
        }
        public DateTime GetDateFromReader(SqlDataReader reader, string columnName)
        {
            return reader[columnName] is DBNull ? Null.NullDate : Convert.ToDateTime(reader[columnName]);
        }
        public static Guid ParseGuid(string myGuid)
        {
            return string.IsNullOrWhiteSpace(myGuid) ? Null.NullGuid : Guid.Parse(myGuid);
        }

        public int GetPos(Dictionary<string, string> tasks, string key)
        {

            var iter = tasks.Keys.GetEnumerator();
            int position = -1;
            for (int i = 0; i < tasks.Keys.Count; i++)
            {

                if (iter.MoveNext())
                {
                    if (key == iter.Current)
                    {
                        position = i + 1;
                        break;
                    }
                }

            }
            return position;
        }


        public bool userHasRight(string userRight)
        {
            bool hasRight = false;
            SecurityController sc = new SecurityController();
            string[] roles = Roles.GetRolesForUser();
            string rights = null;
            foreach (string role in roles)
            {
                rights = sc.GetRoleRights(role);
                if (rights.Contains(userRight))
                {
                    hasRight = true;
                    break;
                }
            }

            return hasRight;
        }
        public static void FillChecklistFromString(string values, ASPxCheckBoxList chkList)
        {
            if (!string.IsNullOrWhiteSpace(values))
            {
                chkList.UnselectAll();
                string[] myValues = values.Split(',');
                ListEditItem item = null;
                foreach (string value in myValues)
                {
                    item = chkList.Items.FindByValue(value);
                    if (item != null)
                    {
                        item.Selected = true;
                    }
                }

            }
        }

        public static ListEditItem FindItemByValue(ASPxCheckBoxList chkList, object value)
        {
            ListEditItem foundItem = null;
            foreach (ListEditItem item in chkList.Items)
            {
                if (Convert.ToInt32(item.Value) == Convert.ToInt32(value))
                {
                    foundItem = item;
                    break;
                }
            }
            return foundItem;
        }
        public static string GetItemsValues(ASPxCheckBoxList chkList)
        {
            object[] myArray = new object[chkList.Items.Count];
            for (int i = 0; i < chkList.Items.Count; i++)
            {
                myArray[i] = chkList.Items[i].Value;
            }
            return string.Join(",", myArray);
        }

        public static string GetSelectedItemValues(ASPxCheckBoxList chkList)
        {
            ArrayList list = new ArrayList();
            for (int i = 0; i < chkList.SelectedValues.Count; i++)
            {
                list.Add(chkList.SelectedValues[i]);
            }
            return string.Join(",", list.ToArray());
        }
        public static string GetSelectedItemText(ASPxCheckBoxList chkList)
        {
            ArrayList list = new ArrayList();
            for (int i = 0; i < chkList.SelectedValues.Count; i++)
            {
                list.Add(chkList.SelectedItems[i].Text);
            }
            return string.Join(",", list.ToArray());
        }
        public static string GetSelectedItemText(CheckBoxList chkList)
        {
            ArrayList list = new ArrayList();

            foreach (ListItem item in chkList.Items)
            {
                if (item.Selected)
                {
                    list.Add(item.Text);
                }

            }
            return string.Join(",", list.ToArray());
        }

        public static bool UserIsAllowedTo(string right, string userRights)
        {

            bool contains = !string.IsNullOrWhiteSpace(userRights) && userRights.Contains(right);
            bool isAdmin = Roles.IsUserInRole("System Admin") || UserIsGTSAdmin();
            bool userIsNotNull = Membership.GetUser() != null;
            bool finalResult = userIsNotNull && (isAdmin || contains);

            return finalResult;
        }
        public static bool InstitutionHasModule(string modules, string module)
        {
            return !string.IsNullOrWhiteSpace(modules) && modules.Contains(module);



        }
        public static bool UserIsGTSAdmin()
        {
            return Membership.GetUser() != null && Membership.GetUser().UserName != null && Roles.IsUserInRole("GTSAdmin");
        }
        public static bool UserIsAdmin()
        {
            return Membership.GetUser() != null && Membership.GetUser().UserName != null && (Roles.IsUserInRole("GTSAdmin")|| Roles.IsUserInRole("System Admin"));
        }
        public static bool UserIsLoggedIn()
        {
            return Membership.GetUser() != null;
        }
        public static void SetDropDownListValue(DropDownList ddlList, string value)
        {
            ddlList.SelectedValue = string.IsNullOrWhiteSpace(value) ? null : value;
        }
        public static void SetDropDownListValue(ASPxComboBox ddlList, string value)
        {
            ddlList.Value = string.IsNullOrWhiteSpace(value) ? null : value;
        }
        public static void SetDropDownListValue(DropDownList ddlList, int value)
        {
            ddlList.SelectedValue = value <= 0 ? null : value.ToString();
        }
        public static void SetDropDownListValue(ASPxComboBox ddlList, int value)
        {
            ddlList.Value = value <= 0 ? null : value.ToString();
        }

        public static void LoadYearsFew(ASPxComboBox ddlList)
        {
            ddlList.Items.Clear();
            for (int i = DateTime.Now.Year + 5; i >= DateTime.Now.Year - 6; i--)
            {
                ddlList.Items.Add(new ListEditItem(i.ToString(), i.ToString()));

            }
            //tick current year
            ddlList.Items.FindByText(DateTime.Now.Year.ToString()).Selected = true;

        }

        public static void LoadYearsToCurrent(ASPxComboBox ddlList)
        {
            ddlList.Items.Clear();
            for (int i = DateTime.Now.Year; i >= DateTime.Now.Year - 6; i--)
            {
                ddlList.Items.Add(new ListEditItem(i.ToString(), i.ToString()));

            }
            //tick current year
            ddlList.Items.FindByText(DateTime.Now.Year.ToString()).Selected = true;

        }
        public static void LoadPageItems(ASPxComboBox ddlList)
        {
            ddlList.Items.Clear();
            ddlList.Items.Add(new ListEditItem("10", "10"));
            ddlList.Items.Add(new ListEditItem("20", "20"));
            ddlList.Items.Add(new ListEditItem("50", "50"));
            ddlList.Items.Add(new ListEditItem("100", "100"));
            ddlList.Items.Add(new ListEditItem("500", "500"));
            ddlList.Items.Add(new ListEditItem("1000", "1000"));
            ddlList.Items.Add(new ListEditItem("2000", "2000"));
            //tick current year
            ddlList.SelectedIndex = 2;

        }
        public static void LoadPageItems(DropDownList ddlList)
        {
            ddlList.Items.Clear();
            ddlList.Items.Add(new ListItem("10", "10"));
            ddlList.Items.Add(new ListItem("20", "20"));
            ddlList.Items.Add(new ListItem("50", "50"));
            ddlList.Items.Add(new ListItem("100", "100"));
            ddlList.Items.Add(new ListItem("500", "500"));
            ddlList.Items.Add(new ListItem("1000", "1000"));
            ddlList.Items.Add(new ListItem("2000", "2000"));
            //tick current year
            ddlList.SelectedIndex = 2;

        }

        public Dictionary<string, string> GetImportTasks()
        {
            //
            //tasks for importing
            Dictionary<string, string> tasks = new Dictionary<string, string>();

            tasks.Add("Students", "Students");


            return tasks;
        }

        public static void CreateCSV(string fileName, SqlDataReader reader)
        {

            StreamWriter sw = new StreamWriter(fileName);
            object[] output = new object[reader.FieldCount];

            //for (int i = 0; i < reader.FieldCount; i++)
            //    output[i] = reader.GetName(i);

            //sw.WriteLine(string.Join(";", output));

            while (reader.Read())
            {
                reader.GetValues(output);
                sw.WriteLine(string.Join(";", output));
            }

            sw.Close();
            reader.Close();
        }


        public static String GetStringFromCollection(NameValueCollection data, string field)
        {
            return (string)data[field];
        }
        public static Double GetDoubleFromCollection(NameValueCollection data, string field)
        {
            return Convert.ToDouble(data[field]);
        }

        public static Control GetControl(string responseType, string options, string ctrlId, bool isChild)
        {
            Control ctrl = null;

            if (responseType.ToLower() == "integer")
            {
                ASPxSpinEdit txt = new ASPxSpinEdit();
                txt.NumberType = SpinEditNumberType.Integer;

                ctrl = txt;

            }
            else if (responseType.ToLower() == "date")
            {
                ASPxDateEdit txt = new ASPxDateEdit();
                ctrl = txt;
            }
            else if (responseType.ToLower() == "float")
            {
                ASPxSpinEdit txt = new ASPxSpinEdit();
                txt.NumberType = SpinEditNumberType.Float;
                ctrl = txt;
            }
            else if (responseType.ToLower() == "multiline")
            {
                ASPxMemo txt = new ASPxMemo();
                ctrl = txt;
            }
            else if (responseType.ToLower() == "singleselect")
            {
                ASPxRadioButtonList txt = new ASPxRadioButtonList();
                if (options != null)
                {
                    string[] items = options.Split(';');
                    for (int i = 0; i < items.Length; i++)
                    {
                        txt.Items.Add(new ListEditItem(items[i].Trim(), i.ToString()));
                    }

                }
                ctrl = txt;
            }
            else if (responseType.ToLower() == "multiselect")
            {


                ASPxListBox txt = new ASPxListBox();
                //txt.Border 
                txt.SelectionMode = ListEditSelectionMode.CheckColumn;

                txt.Width = Unit.Percentage(100);
                txt.Rows = 20;
                txt.Height = Unit.Pixel(200);
                if (options != null)
                {
                    string[] items = options.Split(';');
                    if (items.Length > 7)
                    {
                        txt.FilteringSettings.ShowSearchUI = true;
                        txt.Height = Unit.Pixel(300);
                    }
                    for (int i = 0; i < items.Length; i++)
                    {
                        txt.Items.Add(new ListEditItem(items[i].Trim(), i.ToString()));
                    }

                }


                ctrl = txt;

            }

            else
            {
                ASPxTextBox txt = new ASPxTextBox();
                ctrl = txt;
            }
            ctrl.ID = ctrlId;
            //if child, hide by default
            ctrl.Visible = !isChild;
            return ctrl;
        }

        public static string GetResponse(string questionText, string responseType, Control ctrl)
        {
            string response = null;

            if (responseType.ToLower() == "integer")
            {
                ASPxSpinEdit txt = ctrl as ASPxSpinEdit;
                if (txt.Value == null)
                {
                    throw new Exception("Please answer question: " + questionText);
                }
                response = txt.Value.ToString();

            }
            else if (responseType.ToLower() == "date")
            {
                ASPxDateEdit txt = ctrl as ASPxDateEdit;
                if (txt.Value == null)
                {
                    throw new Exception("Please answer question: " + questionText);
                }
                response = txt.Value.ToString();
            }
            else if (responseType.ToLower() == "float")
            {
                ASPxSpinEdit txt = ctrl as ASPxSpinEdit;
                if (txt.Value == null)
                {
                    throw new Exception("Please answer question: " + questionText);
                }
                response = txt.Value.ToString();
            }
            else if (responseType.ToLower() == "multiline")
            {
                ASPxMemo txt = ctrl as ASPxMemo;
                if (txt.Value == null)
                {
                    throw new Exception("Please answer question: " + questionText);
                }
                response = txt.Value.ToString();
            }
            else if (responseType.ToLower() == "singleselect")
            {
                ASPxRadioButtonList txt = ctrl as ASPxRadioButtonList;
                if (txt.Value == null)
                {
                    throw new Exception("Please answer question: " + questionText);
                }
                response = txt.SelectedItem.Text.ToString();
            }
            else if (responseType.ToLower() == "multiselect")
            {
                ASPxListBox txt = ctrl as ASPxListBox;
                if (txt.SelectedValues.Count <= 0)
                {
                    throw new Exception("Please answer question: " + questionText);
                }
                ArrayList list = new ArrayList();
                foreach (ListEditItem item in txt.SelectedItems)
                {
                    list.Add(item.Text.Trim());
                }
                response = string.Join(";", list.ToArray());


            }
            else
            {
                ASPxTextBox txt = ctrl as ASPxTextBox;
                if (txt.Value == null)
                {
                    throw new Exception("Please answer question: " + questionText);
                }
                response = txt.Value.ToString();
            }

            return response;
        }



        public static void ResetControl(string responseType, Control ctrl)
        {

            if (responseType.ToLower() == "integer")
            {
                ASPxSpinEdit txt = ctrl as ASPxSpinEdit;
                txt.Value = null;

            }
            else if (responseType.ToLower() == "date")
            {
                ASPxDateEdit txt = ctrl as ASPxDateEdit;
                txt.Value = null;
            }
            else if (responseType.ToLower() == "float")
            {
                ASPxSpinEdit txt = ctrl as ASPxSpinEdit;
                txt.Value = null;
            }
            else if (responseType.ToLower() == "multiline")
            {
                ASPxMemo txt = ctrl as ASPxMemo;
                txt.Value = null;
            }
            else if (responseType.ToLower() == "singleselect")
            {
                ASPxRadioButtonList txt = ctrl as ASPxRadioButtonList;
                txt.Value = null;
            }
            else if (responseType.ToLower() == "multiselect")
            {
                ASPxListBox txt = ctrl as ASPxListBox;
                txt.Value = null;


            }
            else
            {
                ASPxTextBox txt = ctrl as ASPxTextBox;
                txt.Value = null;
            }


        }

        public static void SetResponse(string responseType, Control ctrl, string responseText)
        {

            if (responseType.ToLower() == "integer")
            {
                ASPxSpinEdit txt = ctrl as ASPxSpinEdit;
                txt.Value = null;
                txt.Value = !string.IsNullOrWhiteSpace(responseText) ? responseText.Trim() : null;

            }
            else if (responseType.ToLower() == "date")
            {
                ASPxDateEdit txt = ctrl as ASPxDateEdit;
                txt.Value = null;
                txt.Value = !string.IsNullOrWhiteSpace(responseText) ? responseText.Trim() : null;
            }
            else if (responseType.ToLower() == "float")
            {
                ASPxSpinEdit txt = ctrl as ASPxSpinEdit;
                txt.Value = null;
                txt.Value = !string.IsNullOrWhiteSpace(responseText) ? responseText.Trim() : null;
            }
            else if (responseType.ToLower() == "multiline")
            {
                ASPxMemo txt = ctrl as ASPxMemo;
                txt.Value = null;
                txt.Value = !string.IsNullOrWhiteSpace(responseText)?responseText.Trim():null;
            }
            else if (responseType.ToLower() == "singleselect")
            {
                ASPxRadioButtonList txt = ctrl as ASPxRadioButtonList;
                txt.Value = null;
                if (!string.IsNullOrWhiteSpace(responseText))
                {
                    string[] rItems = responseText.Split(';');
                    foreach (string rItem in rItems)
                    {
                        foreach (ListEditItem item in txt.Items)
                        {
                            if (item.Text.Trim() == rItem.Trim())
                            {
                                item.Selected = true;
                            }
                        }
                    }
                }

            }
            else if (responseType.ToLower() == "multiselect")
            {
                ASPxListBox txt = ctrl as ASPxListBox;
                txt.Value = null;
                if (!string.IsNullOrWhiteSpace(responseText))
                {
                    string[] rItems = responseText.Split(';');
                    foreach (string rItem in rItems)
                    {
                        foreach (ListEditItem item in txt.Items)
                        {
                            if (item.Text.Trim() == rItem.Trim())
                            {
                                item.Selected = true;
                            }
                        }
                    }
                }

            }
            else
            {
                ASPxTextBox txt = ctrl as ASPxTextBox;
                txt.Value = null;
                txt.Value = !string.IsNullOrWhiteSpace(responseText) ? responseText.Trim() : null;
            }


        }


    }
}