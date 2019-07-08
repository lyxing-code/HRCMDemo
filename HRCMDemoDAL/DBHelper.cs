using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

/// <summary>
///DBHelper：数据库访问操作类
/// </summary>
public class DBHelper
{
    /// <summary>
    /// 更新操作：增，删，改 共用
    /// </summary>
    /// <param name="sql"></param>
    /// <returns>bool</returns>
    public static bool UpdateOpera(string sql)
    {
        SqlCommand cmd = new SqlCommand(sql, Connection);
        return cmd.ExecuteNonQuery() > 0;
    }

    /// <summary>
    /// 多行查询操作：返回SqlDataReader
    /// </summary>
    /// <param name="sql">查询SQL语句</param>
    /// <returns>SqlDataReader</returns>
    public static SqlDataReader GetReader(string sql)
    {
        SqlCommand cmd = new SqlCommand(sql, Connection);
        return cmd.ExecuteReader();
    }

    /// <summary>
    /// 多行查询操作：返回DataTable
    /// </summary>
    /// <param name="sql"></param>
    /// <returns></returns>
    public static DataTable GetDataTable(string sql)
    {
        DataTable dt = new DataTable();
        SqlDataAdapter dad = new SqlDataAdapter(sql, Connection);
        dad.Fill(dt);
        return dt;
    }

    /// <summary>
    /// 查询操作：返回首行首列数据
    /// </summary>
    /// <param name="sql">查询SQL语句</param>
    /// <returns>object</returns>
    public static object GetScalar(string sql)
    {
        SqlCommand cmd = new SqlCommand(sql, Connection);
        return cmd.ExecuteScalar();
    }

    private static SqlConnection _connection;
    /// <summary>
    /// Connection对象
    /// </summary>
    public static SqlConnection Connection
    {
        get
        {
            string connectionString = ConfigurationManager.ConnectionStrings["SqlConnStr"].ConnectionString;
            if (_connection == null)
            {
                _connection = new SqlConnection(connectionString);
                _connection.Open();
            }
            else if (_connection.State == ConnectionState.Closed)
            {
                _connection.Open();
            }
            else if (_connection.State == ConnectionState.Broken || _connection.State == ConnectionState.Open)
            {
                _connection.Close();
                _connection.Open();
            }
            return _connection;
        }
    }
}