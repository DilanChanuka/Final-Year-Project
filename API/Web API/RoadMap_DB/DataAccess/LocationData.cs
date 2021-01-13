using Microsoft.AspNetCore.Routing;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Internal;
using Microsoft.VisualStudio.Web.CodeGeneration.Contracts.Messaging;
using Newtonsoft.Json;
using RoadMap_DB.Data;
using RoadMap_DB.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Threading.Tasks;

namespace RoadMap_DB.DataAccess
{
    public class LocationData
    {
        #region GEOLOCATION
        public static ApplicationDBContext _db;

        public static double[,] GetFloorLocations(int departmentID, int floorID)
        {
           
            var location = new List<Location>();
            int n = 0;

            try
            {
                location = (from f in _db.floor
                            join l in _db.location
                            on f.f_location_id equals l.location_id
                            where f.floor_id == floorID & f.f_dept_id == departmentID
                            select l).ToList();
            }
            catch(Exception ex)
            {

            }

            n = location.Count;
            double[,] arr = new double[n, 2];

            if (location.Count>0)
            {
                
                for (int i = 0; i < n; i++)
                {
                    arr[i, 0] = location[i].lat_value;
                    arr[i, 1] = location[i].lng_value;
                }
            }
            
            return arr;

        }

        public static Dictionary<string, double[]> GetFloorPlaces(int departmentID, int floorID)
        {
            var placeAlocation = new List<Location>();
            Dictionary<String, double[]> places = new Dictionary<string, double[]>();
            int n = 0;

            try
            {
                placeAlocation = (from p in _db.place
                                  join l in _db.location
                                  on p.p_location_id equals l.location_id
                                  where p.p_floor_id == floorID & p.p_dept_id == departmentID
                                  select l).ToList();

                n = placeAlocation.Count;
            }catch(Exception e)
            {

            }

            if(placeAlocation.Count>0)
            {
                for (int i = 0; i < n; i++)
                {
                    double lat = placeAlocation[i].lat_value;
                    double lng = placeAlocation[i].lng_value;
                    places.Add(placeAlocation[i].location_name, new double[] { lat, lng });
                }
            }
            return places;
        }

        public static double[,] GetVehicleRoute(int routeID)
        {
            
            var location = new List<Location>();
            int n = 0;

            try
            {
                location = (from v in _db.foot_route
                            join l in _db.location
                            on v.f_location_id equals l.location_id
                            where v.f_route_id == routeID
                            select l).ToList();

            }
            catch(Exception ex)
            {
               
            }
            n = location.Count;
            double[,] arr = new double[n, 2];

            if (location.Count > 0)
            {
                for (int i = 0; i < n; i++)
                {
                    arr[i, 0] = location[i].lat_value;
                    arr[i, 1] = location[i].lng_value;
                }
            }

            return arr;
        
        }

        public static double[] GetVertexLoaction(int graphNo, int vertexNo)
        {

            double[] arr = new double[2];
            var location = new List<Location>();
            if (graphNo == 1)
                graphNo = 0;

            try
            {
                location = (from vtx in _db.vertext_location
                            join l in _db.location
                            on vtx.location_id equals l.location_id
                            where vtx.vertex_No == vertexNo & vtx.graph_No == graphNo
                            select l).ToList();

                if (location.Count != 0)
                {
                    arr[0] = location[0].lat_value;
                    arr[1] = location[0].lng_value;
                }
            }
            catch(Exception ex)
            {

            }

            return arr;
        }

        public static double[,] GetFootRoute(int routeID)
        {

            var foot_location = new List<Location>();
            int n = 0;

            try
            {
                 foot_location = (from fr in _db.foot_route
                                     join l in _db.location
                                     on fr.f_location_id equals l.location_id
                                     where fr.f_route_id == routeID
                                     select l).ToList();
                n = foot_location.Count;
            }
            catch (Exception ex)
            {

            }
            
            double[,] arr = new double[n, 2];

            if(foot_location.Count>0)
            {
                for (int i = 0; i < n; i++)
                {
                    arr[i, 0] = foot_location[i].lat_value;
                    arr[i, 1] = foot_location[i].lng_value;
                }

            }

            return arr;
        }

        public static int[] GetDepartmentAndFloor(int placeID)
        {
            //get departmentID and floorID relevent placeID
            int[] arr = new int[2];
            var deptAfloor = new List<Place>();

            try
            {
                deptAfloor = (from p in _db.place
                              where p.place_id == placeID
                              select p).ToList();

                if (deptAfloor.Count > 0)
                {
                    arr[0] = deptAfloor[0].p_dept_id;
                    arr[1] = deptAfloor[0].p_floor_id;
                }
            }
            catch(Exception ex)
            {

            }
            

            return arr;

        }

        public static double[,] GetEntranceLocations(int departmentID)
        {
            var entranceLocation = new List<Location>();
            int n = 0;

            entranceLocation = (from e in _db.entrance
                                join l in _db.location
                                on e.e_location_id equals l.location_id
                                where e.e_dept_id == departmentID
                                select l).ToList();


            n = entranceLocation.Count;
            double[,] arr = new double[n, 2];

            if (entranceLocation.Count > 0)
            {
                for (int i = 0; i < n; i++)
                {
                    arr[i, 0] = entranceLocation[i].lat_value;
                    arr[i, 1] = entranceLocation[i].lng_value;
                }
            }
            return arr;
        }

        public static double[,] GetInnerRoute(int departmentID, int routeID)
        {
            var innrtLocation = new List<Location>();
            int n = 0;

            try
            {
                innrtLocation = (from i in _db.inner_route
                                 join l in _db.location
                                 on i.i_location_id equals l.location_id
                                 where i.in_route_id == routeID & i.i_dept_id == departmentID
                                 select l).ToList();

                n = innrtLocation.Count;

            }
            catch (Exception ex)
            {

            }
            double[,] arr = new double[n, 2];
            if (innrtLocation.Count > 0)
            {

                for (int i = 0; i < n; i++)
                {
                    arr[i, 0] = innrtLocation[i].lat_value;
                    arr[i, 1] = innrtLocation[i].lng_value;
                }
            }
            return arr;
        }

        public static bool GetUserIdentity(string username, string password)
        {
            String sql = "SELECT name,pwd FROM roadmap_db.user " +
                "where name='"+ username + "' and pwd='"+MySqlDataAccess.GetHash(password)+"';";

            string[] data = MySqlDataAccess.GetIdentity(sql);
            if (data[0] == username && data[1] == MySqlDataAccess.GetHash(password))
                return true;
            else
                return false;
        }

        public static bool IdentifyAdmin(string username, string password)
        {
            if (username == "Admin")
            {
                try
                {
                    string[] userList = (from usr in _db.user
                                         where usr.name == "Admin"
                                         select usr.pwd).ToArray();

                    if (userList[0] == MySqlDataAccess.GetHash(password))
                        return true;
                }
                catch { }
            }
            return false;
        }

        public static double[] GetPlace(int placeID)
        {
            var placeLocation = new List<Location>();
            double[] arr = new double[2];

            try
            {
                placeLocation = (from p in _db.place
                                 join l in _db.location
                                 on p.p_location_id equals l.location_id
                                 where p.place_id == placeID
                                 select l).ToList();
               
                if (placeLocation.Count > 0)
                {
                    arr[0] = placeLocation[0].lat_value;
                    arr[1] = placeLocation[0].lng_value;
                }
            }catch(Exception ex)
            {

            }
            return arr;
        }

        public static Dictionary<string, double[]> GetPlaceWithName(int placeID)
        {

            var placeDetails = new List<Location>();
            Dictionary<string, double[]> arr = new Dictionary<string, double[]>();

            try
            {
                placeDetails = (from p in _db.place
                                join l in _db.location
                                on p.p_location_id equals l.location_id
                                where p.place_id == placeID
                                select l).ToList();

            }
            catch(Exception e)
            {
                
            }

            if(placeDetails.Count>0)
            {
                double lat = placeDetails[0].lat_value;
                double lng = placeDetails[0].lng_value;
                arr.Add(placeDetails[0].location_name, new double[] { lat, lng });
            }

            return arr;
        }

        public static bool SetUser(string username, string email, string type, string faculty, string password)
        {
            try
            {
                var userList = new List<User>();
                userList = (from usr in _db.user
                            where usr.name == username
                            select usr).ToList();

                if (userList.Count == 0)
                {
                    User u = new User()
                    {
                        name = username,
                        email = email,
                        type = type,
                        faculty = faculty,
                        pwd = MySqlDataAccess.GetHash(password),
                    };

                    try
                    {
                        _db.user.Add(u);
                        _db.SaveChanges();
                        return true;
                    }
                    catch { }
                }
            }
            catch { }           
            return false;
        }

        //location shairing system

        public static int GetUserId(string username)
        {
            try
            {
                var userList = new List<User>();
                userList = (from usr in _db.user
                            where usr.name == username
                            select usr).ToList();

                if (userList.Count >= 0)
                {
                    return userList[0].user_id;
                }
            }
            catch { }
            return 0;
        }

        public static int[] GetConfirmedUserId(string username)
        {
            int userId = GetUserId(username);
            int[] userList=new int[] { };
            if (userId != 0)
            {
                try
                {
                    userList = (from up in _db.user_privilage
                                where up.status == "confirmed" && up.user1_id == userId
                                select up.user2_id).ToArray();
                }
                catch { }
            }
            return userList;
        }

        public static string[] GetConfirmedUsernames(string username)
        {
            int userId = GetUserId(username);
            List<string> userList = new List<string>();
            if (userId != 0)
            {
                try
                {
                    User_privilage[] ary = null;
                    ary=_db.user_privilage.Where(up => up.status == "Confirmed" && up.user1_id == userId)
                        .Include(up => up.user2).ToArray();
                    if(ary != null)
                    {
                        userList = new List<string>(ary.Length);
                        foreach (var item in ary)
                            userList.Add(item.user2.name);
                    }
                }
                catch { }
            }
            return userList.ToArray();
        }

        public static string[] GetRequestedUsernames(string username)
        {
            int userId = GetUserId(username);
            List<string> userList = new List<string>();
            if (userId != 0)
            {
                try
                {
                    User_privilage[] ary = null;
                    ary = _db.user_privilage.Where(up => up.status == "Requested" && up.user1_id == userId)
                        .Include(up => up.user2).ToArray();
                    if (ary != null)
                    {
                        userList = new List<string>(ary.Length);
                        foreach (var item in ary)
                            userList.Add(item.user2.name);
                    }
                }
                catch { }
            }
            return userList.ToArray();
        }

        public static string[] GetAllUsernames(string username)
        {
            string[] userList=new string[] { };
            try
            {
                userList = (from usr in _db.user
                            where usr.name != username && usr.name != "Admin"
                            select usr.name).ToArray();            
            }
            catch { }
            return userList;
        }

        public static bool AddFriendRequest(string user1, string user2)
        {
            int user1Id = GetUserId(user1);
            int user2Id = GetUserId(user2);

            try
            {
                var userList = new List<User_privilage>();
                userList = (from usr in _db.user_privilage
                            where usr.user1_id == user2Id && usr.user2_id == user1Id && usr.status == "Requested"
                            select usr).ToList();

                if (userList.Count == 0)
                {
                    User_privilage up = new User_privilage()
                    {
                        user1_id = user2Id,
                        user2_id = user1Id,
                        status= "Requested"
                    };
                    try
                    {
                        _db.user_privilage.Add(up);
                        _db.SaveChanges();
                        return true;
                    }
                    catch { }
                }
            }
            catch { }
            return false;
        }

        public static bool ConfirmFriendRequest(string user1, string user2)
        {
            int user1Id = GetUserId(user1);
            int user2Id = GetUserId(user2);

            int rows= _db.Database.ExecuteSqlRaw($"UPDATE user_privilage SET status = 'Confirmed' " +
                $"WHERE user1_id = '{user1Id}' and user2_id = '{user2Id}'");
            if (rows >= 1)
            {
                try
                {
                    var userList = new List<User_privilage>();
                    userList = (from usr in _db.user_privilage
                                where usr.user1_id == user2Id && usr.user2_id == user1Id && usr.status == "Confirmed"
                                select usr).ToList();

                    if (userList.Count == 0)
                    {
                        User_privilage up = new User_privilage()
                        {
                            user1_id = user2Id,
                            user2_id = user1Id,
                            status = "Confirmed"
                        };
                        try
                        {
                            _db.user_privilage.Add(up);
                            _db.SaveChanges();
                            return true;
                        }
                        catch { }
                    }
                }
                catch { }
            }
            return false;
        }

        public static bool RemoveFriendRequest(string user1, string user2)
        {
            int user1Id = GetUserId(user1);
            int user2Id = GetUserId(user2);

            int rows = _db.Database.ExecuteSqlRaw($"DELETE FROM user_privilage WHERE " +
                $"(status = 'Confirmed' AND user1_id = '{user1Id}' AND user2_id = '{user2Id}') " +
                $"OR (status = 'Confirmed' AND user1_id = '{user2Id}' AND user2_id = '{user1Id}')");
            if (rows >= 1)
                return true;
            return false;
        }

        public static bool RemoveUser(string username)
        {
            int userId = GetUserId(username);

            int rows1 = _db.Database.ExecuteSqlRaw($"DELETE FROM user_privilage WHERE " +
                $"(user1_id = '{userId}') " +
                $"OR (user2_id = '{userId}')");


            User[] userList = new User[] { };
            try
            {
                userList = (from usr in _db.user
                            where usr.name == username
                            select usr).ToArray();

                using (StreamWriter sw = File.AppendText(@"wwwroot/users/DeletedUserList.txt"))
                {
                    sw.WriteLine("ID- { "+userList[0].user_id + " }\tName- { " + userList[0].name + " }\tEmail- { " + userList[0].email + " }\tType- { " + userList[0].type + " }\tFaculty- { " + userList[0].faculty + " }\tDeletedDate&Time- { "+DateTime.Now+" }" );
                }
            }
            catch { }

            int rows2 = _db.Database.ExecuteSqlRaw($"DELETE FROM user WHERE " +
            $"(id = '{userId}') ");

            if (rows1 >= 1 || rows2 >= 1)
                return true;
            return false;
        }

        public static Dictionary<string, string[]> GetAllUsers()
        {
            var final = new Dictionary<string, string[]>();
            try
            {
                var userList = new List<User>();
                userList = (from usr in _db.user
                            where usr.name != "Admin"
                            select usr).ToList();

                if (userList.Count > 0)
                {
                    int n = 1;
                    foreach (var u in userList)
                    {
                        final.Add(n.ToString(), new string[] { u.name, u.faculty, u.type });
                        n++;
                    }
                }
            }
            catch { }
            return final;
        }

        public static Dictionary<string, string[]> GetFriendsOfUser(string username)
        {
            int userId = GetUserId(username);
            var final = new Dictionary<string, string[]>();
            if (userId != 0)
            {
                try
                {
                    User_privilage[] ary = null;
                    ary = _db.user_privilage.Where(up => up.status == "Confirmed" && up.user1_id == userId)
                        .Include(up => up.user2).ToArray();
                    if (ary != null)
                    {
                        int n = 1;
                        foreach (var u in ary)
                        {
                            final.Add(n.ToString(), new string[] { u.user2.name,u.user2.faculty,u.user2.type });
                            n++;
                        }
                    }
                }
                catch { }
            }
            return final;
        }
        #endregion
    }
}

