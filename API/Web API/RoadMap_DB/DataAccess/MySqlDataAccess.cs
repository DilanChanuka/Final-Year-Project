using Microsoft.VisualBasic.CompilerServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Configuration;
using Microsoft.CodeAnalysis.CSharp;
using System.Data;
using MySql.Data.MySqlClient;
using Microsoft.AspNetCore.Mvc;
using RoadMap_DB.Models;
using System.Security.Cryptography;
using System.Text;

namespace RoadMap_DB.DataAccess
{
    
    public static class MySqlDataAccess
    {

        #region SQL QUERY

        public static string GetHash(string password)
        {
            MD5CryptoServiceProvider md5Hasher = new MD5CryptoServiceProvider();
            UTF8Encoding encoder = new UTF8Encoding();
            byte[] encrypt;
            //encrypt the given password string into Encrypted data  
            encrypt = md5Hasher.ComputeHash(encoder.GetBytes(password));
            StringBuilder encryptdata = new StringBuilder();
            //Create a new string by using the encrypted data  
            for (int i = 0; i < encrypt.Length; i++)
            {
                encryptdata.Append(encrypt[i].ToString());
            }
            return encryptdata.ToString();
        }
        public static string[] GetUser(string sql)
        {

            using (MySqlConnection con = new MySqlConnection(ConnectionString))
            {
                string[] data = new string[3];
                
                con.Open();
                MySqlCommand cmd = new MySqlCommand(sql, con);
                try
                {
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        reader.Read();
                        data[0] = reader.GetString("name");
                        data[1] = reader.GetString("email");                    
                        data[2] = reader.GetString("pwd");
                    }
                }
                catch
                {

                }
                con.Close();
                return data;

            }
        }

        public static double[,] VRoutes(string sql)
        {

            using (MySqlConnection con = new MySqlConnection(ConnectionString))
            {

                con.Open();
                double[,] empty=new double[1,1];
                try
                {
                    MySqlCommand cmd = new MySqlCommand(sql, con);
                    MySqlDataReader reader = cmd.ExecuteReader();

                    DataTable dt = new DataTable();
                    dt.Load(reader);
                    //reader.Read();
                    int numRows = dt.Rows.Count;
                    double[,] data = new double[numRows, 2];

                    for (int i = 0; i < numRows; i++)
                    {
                        data[i, 0] = double.Parse(dt.Rows[i]["lat"].ToString());
                        data[i, 1] = double.Parse(dt.Rows[i]["lng"].ToString());
                    }

                    return data;
                }
                catch(Exception e)
                {
                    Console.Write("Exception ", e);
                }
               
                con.Close();
                return empty;  //return 0.0,0.0 value if can not execute 

            }
        }

        public static double[] GetVertex(string sql)
        {
            using (MySqlConnection con = new MySqlConnection(ConnectionString))
            {
                double[] data = new double[2];
                con.Open();
                try
                {
                    MySqlCommand cmd = new MySqlCommand(sql, con);
                    MySqlDataReader reader = cmd.ExecuteReader();
                   
                    reader.Read();
                    data[0] = reader.GetDouble("lat");
                    data[1] = reader.GetDouble("lng");
                }
                catch(Exception e)
                {
                    Console.Write("Exception ", e);
                }
                            
                return data;
            }
        }

        public static double[,] FRoute(string sql)
        {

            using (MySqlConnection con = new MySqlConnection(ConnectionString))
            {

                con.Open();
                double[,] empty = new double[1, 1];
                try
                {
                    MySqlCommand cmd = new MySqlCommand(sql, con);
                    MySqlDataReader reader = cmd.ExecuteReader();

                    DataTable dt = new DataTable();
                    dt.Load(reader);
                    //reader.Read();
                    int numRows = dt.Rows.Count;
                    double[,] data = new double[numRows, 2];

                    for (int i = 0; i < numRows; i++)
                    {
                        data[i, 0] = double.Parse(dt.Rows[i]["lat"].ToString());
                        data[i, 1] = double.Parse(dt.Rows[i]["lng"].ToString());
                    }
                    return data;
                }
                catch(Exception e)
                {
                    Console.Write("Exception ", e);
                }
               

                con.Close();
                return empty;  //return 0.0,0.0 value if can not execute 

            }
        }

        public static double[,] GetFloor(string sql)
        {

            using (MySqlConnection con = new MySqlConnection(ConnectionString))
            {
                
                con.Open();
                double[,] empty = new double[1, 1];
                try
                {
                    MySqlCommand cmd = new MySqlCommand(sql, con);
                    MySqlDataReader reader = cmd.ExecuteReader();

                    DataTable dt = new DataTable();
                    dt.Load(reader);
                    //reader.Read();
                    int numRows = dt.Rows.Count;
                    double[,] data = new double[numRows, 2];

                    for (int i = 0; i < numRows; i++)
                    {
                        data[i, 0] = double.Parse(dt.Rows[i]["lat"].ToString());
                        data[i, 1] = double.Parse(dt.Rows[i]["lng"].ToString());
                    }
                    return data;
                }
                catch(Exception e)
                {
                    Console.Write("Exception ", e);
                }
                                
                con.Close();
                return empty;  //return 0.0,0.0 value if can not execute  

            }
        }

        public static Dictionary<string, double[]> GetFloorplaces(string sql)
        {
            using (MySqlConnection con=new MySqlConnection(ConnectionString))
            {
                con.Open();
                Dictionary<String, double[]> places = new Dictionary<string, double[]>();
                try
                {
                    MySqlCommand cmd = new MySqlCommand(sql, con);
                    MySqlDataReader reader = cmd.ExecuteReader();
                    DataTable dt = new DataTable();
                    dt.Load(reader);
                    int numRow = dt.Rows.Count;
                   
                    for (int i = 0; i < numRow; i++)
                    {
                        string name = dt.Rows[i]["name"].ToString();
                        double lat = double.Parse(dt.Rows[i]["lat"].ToString());
                        double lng = double.Parse(dt.Rows[i]["lng"].ToString());
                        places.Add(name, new double[] { lat, lng });
                    }

                    return places;
                }
                catch(Exception e)
                {
                    Console.Write("Exception ", e);
                }
               
                con.Clone();
                return places;  //return empty value if can not execute  
            }
        }

        public static double[] GetOnePlace(string sql)
        {
            using (MySqlConnection con = new MySqlConnection(ConnectionString))
            {
                con.Open();
                double[] data = new double[2];
                try
                {
                    MySqlCommand cmd = new MySqlCommand(sql, con);
                    MySqlDataReader reader = cmd.ExecuteReader();
                   
                    reader.Read();
                    data[0] = reader.GetDouble("lat");
                    data[1] = reader.GetDouble("lng");
                }
                catch(Exception e)
                {
                    Console.Write("Exception ", e);
                }
              
                return data;
            }
        }

        public static int[] DeptAndFloorID(string sql)
        {
            using (MySqlConnection con=new MySqlConnection(ConnectionString))
            {
                con.Open();                         
                int[] data = new int[2];               
                try
                {
                    MySqlCommand cmd = new MySqlCommand(sql, con);
                    MySqlDataReader reader = cmd.ExecuteReader();
                    reader.Read();
                    data[0] = reader.GetInt32("dept_id");
                    data[1] = reader.GetInt32("d_floor_id");
                }
                catch(Exception e)
                {
                    Console.Write("Exception ", e);
                }
               
                con.Close();
                return data;
            }
        }

        public static double[,] InnerRoute(string sql)
        {

            using (MySqlConnection con = new MySqlConnection(ConnectionString))
            {
                con.Open();
                double[,] empty = new double[1, 1];
                try
                {
                    MySqlCommand cmd = new MySqlCommand(sql, con);
                    MySqlDataReader reader = cmd.ExecuteReader();

                    DataTable dt = new DataTable();
                    dt.Load(reader);
                    //reader.Read();
                    int numRows = dt.Rows.Count;
                    double[,] data = new double[numRows, 2];

                    for (int i = 0; i < numRows; i++)
                    {
                        data[i, 0] = double.Parse(dt.Rows[i]["lat"].ToString());
                        data[i, 1] = double.Parse(dt.Rows[i]["lng"].ToString());

                    }
                    return data;
                }
                catch(Exception e)
                {
                    Console.Write("Exception ", e);
                }
               

                con.Close();
                return empty;  //return 0.0,0.0 value if can not execute 

            }
        }

        public static string[] GetIdentity(string sql)
        {
            using (MySqlConnection con=new MySqlConnection(ConnectionString))
            {
                con.Open();
                string[] data = new string[2];
                try
                {
                    MySqlCommand cmd = new MySqlCommand(sql, con);
                    MySqlDataReader reader = cmd.ExecuteReader();
                    
                    DataTable dt = new DataTable();
                    dt.Load(reader);

                    if (dt.Rows.Count > 0)
                    {

                        data[0] = dt.Rows[0]["name"].ToString();
                        data[1] = dt.Rows[0]["pwd"].ToString();
                    }
                }
                catch(Exception e)
                {
                    Console.Write("Exception ", e);
                }
               
               
                con.Close();
                return data;

            }
        }

        public static double[] Dept_place(string sql)
        {

            using (MySqlConnection con = new MySqlConnection(ConnectionString))
            {
                double[] data = new double[2];
                con.Open();
                MySqlCommand cmd = new MySqlCommand(sql, con);
                try
                {
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            data[0] = reader.GetDouble("lat");
                            data[1] = reader.GetDouble("lng");
                        }
                    }
                }
                catch(Exception e)
                {
                    Console.Write("Exception ", e);
                }
                con.Close();
                return data;
            }
        }

        public static double[,] GetEntryLocation(string sql)
        {
            using (MySqlConnection con=new MySqlConnection(ConnectionString))
            {
                con.Open();
                double[,] empty = new double[1, 1];
                try
                {
                    MySqlCommand cmd = new MySqlCommand(sql, con);
                    MySqlDataReader reader = cmd.ExecuteReader();

                    DataTable dt = new DataTable();
                    dt.Load(reader);
                    int numRows = dt.Rows.Count;
                    double[,] data = new double[numRows, 2];
                    for (int i = 0; i < numRows; i++)
                    {
                        data[i, 0] = double.Parse(dt.Rows[i]["lat_value"].ToString());
                        data[i, 1] = double.Parse(dt.Rows[i]["lng_value"].ToString());
                    }
                    return data;
                }
                catch(Exception e)
                {
                    Console.Write("Exception ", e);
                }
                
                con.Close();
                return empty;
            }
        }

        public static Dictionary<string ,double[]> GetplaceAndName(string sql)
        {
            using (MySqlConnection con = new MySqlConnection(ConnectionString))
            {
                con.Open();
                Dictionary<String, double[]> data = new Dictionary<string, double[]>();
                try
                {
                    MySqlCommand cmd = new MySqlCommand(sql, con);
                    MySqlDataReader reader = cmd.ExecuteReader();
                  
                    reader.Read();

                    string name = reader.GetString("place_name");
                    double lat = double.Parse(reader.GetDouble("lat").ToString());
                    double lng = double.Parse(reader.GetDouble("lng").ToString());
                    data.Add(name, new double[] { lat, lng });
                }
                catch(Exception e)
                {
                    Console.Write("Exception ", e);
                }
               
                con.Clone();
                return data;
            }

        }

        public static string ConnectionString //connect to server
        {
            get
            {
                return string.Format("SERVER ={0};USER ID={1};PASSWORD={2};" +
                        "DATABASE={3};", "localhost", "root", "000", "roadmap_db");

            }
        }

        #endregion


    }

}
