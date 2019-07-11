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
    /// <param name="parameters">参数</param>
    /// <returns>bool</returns>
    public static bool UpdateOpera(string sql, params SqlParameter[] parameters)
    {
        try
        {
            SqlCommand cmd = new SqlCommand(sql, Connection);
            if (parameters != null && parameters.Length >  0)
            {
                cmd.Parameters.Add(parameters);
            }
            return cmd.ExecuteNonQuery() > 0;
        }
        catch (Exception)
        {

            throw;
        }
       
    }
    
    
    /// <summary>
    /// 多行查询操作：返回SqlDataReader
    /// </summary>
    /// <param name="sql">查询SQL语句</param>
    /// <param name="parameters">参数</param>
    /// <returns>SqlDataReader</returns>
    public static SqlDataReader GetReader(string sql, params SqlParameter[] parameters)
    {
        try
        {
            SqlCommand cmd = new SqlCommand(sql, Connection);
            if (parameters != null && parameters.Length > 0)
            {
                cmd.Parameters.Add(parameters);
            }
            return cmd.ExecuteReader();
        }
        catch (Exception)
        {

            throw;
        }
        
    }

    /// <summary>
    /// 多行查询操作：返回DataTable
    /// </summary>
    /// <param name="sql">SQL语句</param>
    /// <param name="parameters">参数</param>
    /// <returns></returns>
    public static DataTable GetDataTable(string sql, params SqlParameter [] parameters)
    {
        //防止注入式攻击
        try
        {
             DataTable dt = new DataTable();
             SqlDataAdapter dad = new SqlDataAdapter(sql, Connection);
            if (parameters != null && parameters.Length > 0)
            {
                dad.SelectCommand.Parameters.AddRange(parameters);
            }
            dad.Fill(dt);
            return dt;
        }
        catch (Exception)
        {

            throw;
        }
      
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