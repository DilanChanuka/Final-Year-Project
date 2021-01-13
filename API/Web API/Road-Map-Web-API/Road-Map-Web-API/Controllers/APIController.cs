using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Text.Json;
using System.Collections;
using RoadMap_DB.DataAccess;
using RoadMap_DB.Data;
using RoadMap_DB.Models;
using Firebase.Database;
using Firebase.Database.Query;
using Road_Map_Web_API.Models;

namespace Road_Map_Web_API.Controllers
{
    [ApiController]    
    public class APIController : Controller
    {
        public APIController(ApplicationDBContext db)
        {
            LocationData._db = db;
        }

        [HttpGet]
        [Route("GetFloor/{department:int}/{floor:int}")]
        public IActionResult GetFloor(int department, int floor)
        {
            int n = 0;
            List<double[]> lst = new List<double[]>();
            var final = new Hashtable();
            double[] temp = new double[2];
            double[,] floorLocations = LocationData.GetFloorLocations(department, floor);
            Dictionary<string, double[]> places = LocationData.GetFloorPlaces(department, floor);
            Place[] arr = new Place[places.Count];

            for (int i = 0; i < floorLocations.GetLength(0); i++)
                lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
            //this should change according to the department
            if (floor == 0)
                final.Add("floor_0_locations", lst);
            else if (floor == 1)
                final.Add("floor_1_locations", lst);
            else
                final.Add("floor_2_locations", lst);

            foreach (KeyValuePair<string, double[]> pair in places)
            {
                temp = pair.Value;
                arr[n++] = new Place()
                {
                    name = pair.Key,
                    lat = temp[0],
                    lon = temp[1]
                };
            }
            final.Add("places", arr);
            return Json(final);
        }

        [HttpGet]
        [Route("GetFloorWithPlace/{placeID:int}")]
        public IActionResult GetFloorWithPlace(int placeID)
        {
            int n = 0;
            int[] ids = LocationData.GetDepartmentAndFloor(placeID);
            List<double[]> lst = new List<double[]>();
            var final = new Hashtable();
            double[] temp = new double[2];
            double[,] floorLocations = LocationData.GetFloorLocations(ids[0], ids[1]);
            Dictionary<string, double[]> places = LocationData.GetFloorPlaces(ids[0], ids[1]);
            Dictionary<string, double[]> place = LocationData.GetPlaceWithName(placeID);
            Place[] arr = new Place[places.Count];
            Place pl = new Place();

            for (int i = 0; i < floorLocations.GetLength(0); i++)
                lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
            //this should change according to the department
            if (ids[1] == 0)
                final.Add("floor_0_locations", lst);
            else if (ids[1] == 1)
                final.Add("floor_1_locations", lst);
            else
                final.Add("floor_2_locations", lst);

            foreach (KeyValuePair<string, double[]> pair_0 in place)//only once
            {
                foreach (KeyValuePair<string, double[]> pair in places)
                {
                    if (pair_0.Key == pair.Key)
                    {
                        temp = pair.Value;
                        pl = new Place()
                        {
                            name = pair.Key,
                            lat = temp[0],
                            lon = temp[1]
                        };
                    }
                    else
                    {
                        temp = pair.Value;
                        arr[n++] = new Place()
                        {
                            name = pair.Key,
                            lat = temp[0],
                            lon = temp[1]
                        };
                    }
                }
            }
            final.Add("places", arr);
            final.Add("place", pl);
            return Json(final);
        }

        [HttpGet]
        [Route("GetRoute/{startLAT:double}/{startLON:double}/{endLAT:double}/{endLON:double}/{method}")]
        public IActionResult GetRoute(double startLAT, double startLON, double endLAT, double endLON, [FromRoute] string method)
        {
            List<double[]> lst = new List<double[]>();
            var final = new Hashtable();
            Calculations cal = new Calculations();
            int V_No, grapgNo, start, end;
            switch (method)
            {
                case "f":
                    V_No = Data.footGrapheVertices;
                    grapgNo = 0;
                    break;
                case "v":
                    V_No = Data.vehicleGrapheVertices;
                    grapgNo = 1;
                    break;
                default:
                    V_No = Data.footGrapheVertices;
                    grapgNo = 0;
                    break;
            }
            start = cal.GetNearestVertexNo(V_No, grapgNo, startLAT, startLON);
            end = cal.GetNearestVertexNo(V_No, grapgNo, endLAT, endLON);
            if (start != end)
            {
                int[] routes = cal.GetRouteNumbers(grapgNo, start, end);
                double[,] routeLocations;
                foreach (int r in routes)
                {
                    if (grapgNo == 0)
                        routeLocations = LocationData.GetFootRoute(r);
                    else
                        routeLocations = LocationData.GetVehicleRoute(r);

                    lst.AddRange(new List<double[]>(cal.ValidateRoute(start, end, grapgNo, r, routeLocations)));
                }
                final.Add("routelocations", lst);

                final.Add("distance_time", cal.FindDistanceAndTime(grapgNo, start, end));

                return Json(final);
            }
            return Json(final);
        }

        [HttpGet]
        [Route("GetPlace/{startLAT:double}/{startLON:double}/{placeID:int}/{method}")]
        public IActionResult GetPlace(double startLAT, double startLON, int placeID, string method)
        {
            List<double[]> lst = new List<double[]>();
            List<double[]> zeroFloorRouteSet = new List<double[]>();
            List<double[]> stair_0_1_RouteSet = new List<double[]>();
            List<double[]> stair_1_2_RouteSet = new List<double[]>();
            List<double[]> firstFloorRouteSet = new List<double[]>();
            List<double[]> secondFloorRouteSet = new List<double[]>();
            double distance = 0, time = 0;
            var final = new Hashtable();
            double[,] routeLocations;
            double[] temp = new double[2], distanceAndTime;
            Calculations cal = new Calculations();
            int V_No, graphNo, start, localEnd, innerStart = 0, innerEnd = 0;
            int[] ids, routes;
            double[,] floorLocations;
            Dictionary<string, double[]> place;
            Place pl;

            switch (method)
            {
                case "f":
                    V_No = Data.footGrapheVertices;
                    graphNo = 0;
                    break;
                case "v":
                    V_No = Data.vehicleGrapheVertices;
                    graphNo = 1;
                    break;
                default:
                    V_No = Data.footGrapheVertices;
                    graphNo = 0;
                    break;
            }
            start = cal.GetNearestVertexNo(V_No, graphNo, startLAT, startLON);
            localEnd = cal.FindEnterenceVertexNo(V_No, graphNo, start, placeID);

            if (start != localEnd)
            {
                int[] route = cal.GetRouteNumbers(graphNo, start, localEnd);
                distanceAndTime = cal.FindDistanceAndTime(graphNo, start, localEnd);
                distance += distanceAndTime[0];
                time += distanceAndTime[1];

                foreach (int r in route)
                {
                    if (graphNo == 0)
                        routeLocations = LocationData.GetFootRoute(r);
                    else
                        routeLocations = LocationData.GetVehicleRoute(r);

                    lst.AddRange(new List<double[]>(cal.ValidateRoute(start, localEnd, graphNo, r, routeLocations)));
                }
                final.Add("outerroutelocations", new List<double[]>(lst));

            }
            lst.Clear();

            for (int i = 0; i < Data.CSMainOuterInnerMatch.Length; i++)
                if (Data.CSMainOuterInnerMatch[i] == localEnd)
                {
                    innerStart = i;
                    break;
                }

            for (int i = 0; i < Data.CSMainPlaceMatch.Length; i++)
                if (Data.CSMainPlaceMatch[i] == placeID)
                {
                    innerEnd = i;
                    break;
                }

            graphNo = 2;
            ids = LocationData.GetDepartmentAndFloor(placeID);
            routes = cal.GetRouteNumbers(graphNo, innerStart, innerEnd);
            distanceAndTime = cal.FindDistanceAndTime(graphNo, innerStart, innerEnd);
            distance += distanceAndTime[0];
            time += distanceAndTime[1];

            //according to the department,no of arrays should change
            foreach (int rt in routes)
            {
                if (Data.CSFloor_0_RouteNumbers.Contains(rt))
                {
                    routeLocations = LocationData.GetInnerRoute(ids[0], rt);
                    zeroFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(innerStart, innerEnd, graphNo, rt, routeLocations)));
                }
                else if (Data.CSFloor_1_RouteNumbers.Contains(rt))
                {
                    routeLocations = LocationData.GetInnerRoute(ids[0], rt);
                    firstFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(innerStart, innerEnd, graphNo, rt, routeLocations)));
                }
                else if (Data.CSFloor_2_RouteNumbers.Contains(rt))
                {
                    routeLocations = LocationData.GetInnerRoute(ids[0], rt);
                    secondFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(innerStart, innerEnd, graphNo, rt, routeLocations)));
                }
                else if (Data.CSStairBetwenn_0_1.Contains(rt))
                {
                    routeLocations = LocationData.GetInnerRoute(ids[0], rt);
                    stair_0_1_RouteSet.AddRange(new List<double[]>(cal.ValidateRoute(innerStart, innerEnd, graphNo, rt, routeLocations)));
                }
                else if (Data.CSStairBetwenn_1_2.Contains(rt))
                {
                    routeLocations = LocationData.GetInnerRoute(ids[0], rt);
                    stair_1_2_RouteSet.AddRange(new List<double[]>(cal.ValidateRoute(innerStart, innerEnd, graphNo, rt, routeLocations)));
                }
            }

            if (zeroFloorRouteSet.Count != 0)
            {
                final.Add("floor_0_routelocations", new List<double[]>(zeroFloorRouteSet));
                lst.Clear();
                floorLocations = LocationData.GetFloorLocations(ids[0], 0);

                for (int i = 0; i < floorLocations.GetLength(0); i++)
                    lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
                final.Add("floor_0_locations", new List<double[]>(lst));
            }

            if (firstFloorRouteSet.Count != 0)
            {
                final.Add("floor_1_routelocations", new List<double[]>(firstFloorRouteSet));
                lst.Clear();
                floorLocations = LocationData.GetFloorLocations(ids[0], 1);

                for (int i = 0; i < floorLocations.GetLength(0); i++)
                    lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
                final.Add("floor_1_locations", new List<double[]>(lst));
            }

            if (secondFloorRouteSet.Count != 0)
            {
                final.Add("floor_2_routelocations", new List<double[]>(secondFloorRouteSet));
                lst.Clear();
                floorLocations = LocationData.GetFloorLocations(ids[0], 2);

                for (int i = 0; i < floorLocations.GetLength(0); i++)
                    lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
                final.Add("floor_2_locations", new List<double[]>(lst));
            }

            if (stair_0_1_RouteSet.Count != 0)
                final.Add("stair_0_1_locations", stair_0_1_RouteSet);
            if (stair_1_2_RouteSet.Count != 0)
                final.Add("stair_1_2_locations", stair_1_2_RouteSet);

            place = LocationData.GetPlaceWithName(placeID);
            pl = new Place();
            foreach (KeyValuePair<string, double[]> pair in place)//only once
            {
                temp = pair.Value;
                pl = new Place()
                {
                    name = pair.Key,
                    lat = temp[0],
                    lon = temp[1]
                };
            }
            final.Add("place", pl);
            final.Add("distance_time", new double[] { distance, Math.Round(time, 1) });
            return Json(final);
        }

        [HttpGet]
        [Route("GetPlaceInOut/{department:int}/{floor:int}/{startLAT:double}/{startLON:double}/{endLAT:double}/{endLON:double}")]
        public IActionResult GetPlaceInOut(int department, int floor, double startLAT, double startLON, double endLAT, double endLON)
        {
            List<double[]> lst = new List<double[]>();
            double distance = 0, time = 0;
            double[] distanceAndTime;
            var final = new Hashtable();
            double[,] routeLocations;
            double[,] floorLocations;
            Calculations cal = new Calculations();
            int graphNo = 2, V_No = Data.CSDepartmentGrapheVertices, start, innerEnd, outerStrat, outerEnd;
            int[] EntranceAndInnerEnd;

            start = cal.GetNearestVertexNo(department, floor, V_No, graphNo, startLAT, startLON);
            EntranceAndInnerEnd = cal.FindEnterenceVertexNo(department, floor, startLAT, startLON, endLAT, endLON);
            innerEnd = EntranceAndInnerEnd[1];

            if (start != innerEnd)
            {
                int[] routes = cal.GetRouteNumbers(graphNo, start, innerEnd);
                distanceAndTime = cal.FindDistanceAndTime(graphNo, start, innerEnd);
                distance += distanceAndTime[0];
                time += distanceAndTime[1];

                List<double[]> zeroFloorRouteSet = new List<double[]>();
                List<double[]> stair_0_1_RouteSet = new List<double[]>();
                List<double[]> stair_1_2_RouteSet = new List<double[]>();
                List<double[]> firstFloorRouteSet = new List<double[]>();
                List<double[]> secondFloorRouteSet = new List<double[]>();

                //according to the department,no of arrays should change
                foreach (int rt in routes)
                {
                    if (Data.CSFloor_0_RouteNumbers.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(department, rt);
                        zeroFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, innerEnd, graphNo, rt, routeLocations)));
                    }
                    else if (Data.CSFloor_1_RouteNumbers.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(department, rt);
                        firstFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, innerEnd, graphNo, rt, routeLocations)));
                    }
                    else if (Data.CSFloor_2_RouteNumbers.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(department, rt);
                        secondFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, innerEnd, graphNo, rt, routeLocations)));
                    }
                    else if (Data.CSStairBetwenn_0_1.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(department, rt);
                        stair_0_1_RouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, innerEnd, graphNo, rt, routeLocations)));
                    }
                    else if (Data.CSStairBetwenn_1_2.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(department, rt);
                        stair_1_2_RouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, innerEnd, graphNo, rt, routeLocations)));
                    }
                }

                if (zeroFloorRouteSet.Count != 0)
                {
                    final.Add("floor_0_routelocations", new List<double[]>(zeroFloorRouteSet));
                    lst.Clear();
                    floorLocations = LocationData.GetFloorLocations(department, 0);

                    for (int i = 0; i < floorLocations.GetLength(0); i++)
                        lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
                    final.Add("floor_0_locations", new List<double[]>(lst));
                }

                if (firstFloorRouteSet.Count != 0)
                {
                    final.Add("floor_1_routelocations", new List<double[]>(firstFloorRouteSet));
                    lst.Clear();
                    floorLocations = LocationData.GetFloorLocations(department, 1);

                    for (int i = 0; i < floorLocations.GetLength(0); i++)
                        lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
                    final.Add("floor_1_locations", new List<double[]>(lst));
                }

                if (secondFloorRouteSet.Count != 0)
                {
                    final.Add("floor_2_routelocations", new List<double[]>(secondFloorRouteSet));
                    lst.Clear();
                    floorLocations = LocationData.GetFloorLocations(department, 2);

                    for (int i = 0; i < floorLocations.GetLength(0); i++)
                        lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
                    final.Add("floor_2_locations", new List<double[]>(lst));
                }

                if (stair_0_1_RouteSet.Count != 0)
                    final.Add("stair_0_1_locations", stair_0_1_RouteSet);
                if (stair_1_2_RouteSet.Count != 0)
                    final.Add("stair_1_2_locations", stair_1_2_RouteSet);
            }

            graphNo = 0;
            outerStrat = Data.EntranceOuterMatch[EntranceAndInnerEnd[0]];
            outerEnd = cal.GetNearestVertexNo(Data.footGrapheVertices, graphNo, endLAT, endLON);
            lst.Clear();
            if (outerStrat != outerEnd)
            {
                int[] routes = cal.GetRouteNumbers(graphNo, outerStrat, outerEnd);

                distanceAndTime = cal.FindDistanceAndTime(graphNo, outerStrat, outerEnd);
                distance += distanceAndTime[0];
                time += distanceAndTime[1];

                foreach (int r in routes)
                {
                    routeLocations = LocationData.GetFootRoute(r);
                    lst.AddRange(new List<double[]>(cal.ValidateRoute(outerStrat, outerEnd, 0, r, routeLocations)));
                }
                final.Add("outerroutelocations", new List<double[]>(lst));
            }
            final.Add("distance_time", new double[] { distance, Math.Round(time, 1) });
            return Json(final);
        }

        [HttpGet]
        [Route("GetPlaceInIn/{department:int}/{floor:int}/{startLAT:double}/{startLON:double}/{placeID:int}")]
        public IActionResult GetPlaceInIn(int department, int floor, double startLAT, double startLON, int placeID)
        {
            List<double[]> lst = new List<double[]>();
            var final = new Hashtable();
            double[,] floorLocations;
            double[,] routeLocations;
            double[] temp = new double[2];
            Dictionary<string, double[]> place;
            Place pl;
            Calculations cal = new Calculations();
            int graphNo = 2, start, end = 0;

            start = cal.GetNearestVertexNo(department, floor, Data.CSDepartmentGrapheVertices, graphNo, startLAT, startLON);
            for (int i = 0; i < Data.CSMainPlaceMatch.Length; i++)
                if (Data.CSMainPlaceMatch[i] == placeID)
                {
                    end = i;
                    break;
                }
            if (start != end)
            {
                int[] routes = cal.GetRouteNumbers(graphNo, start, end);
                final.Add("distance_time", cal.FindDistanceAndTime(graphNo, start, end));

                List<double[]> zeroFloorRouteSet = new List<double[]>();
                List<double[]> stair_0_1_RouteSet = new List<double[]>();
                List<double[]> stair_1_2_RouteSet = new List<double[]>();
                List<double[]> firstFloorRouteSet = new List<double[]>();
                List<double[]> secondFloorRouteSet = new List<double[]>();

                //according to the department,no of arrays should change
                foreach (int rt in routes)
                {
                    if (Data.CSFloor_0_RouteNumbers.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(department, rt);
                        zeroFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, end, graphNo, rt, routeLocations)));
                    }
                    else if (Data.CSFloor_1_RouteNumbers.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(department, rt);
                        firstFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, end, graphNo, rt, routeLocations)));
                    }
                    else if (Data.CSFloor_2_RouteNumbers.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(department, rt);
                        secondFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, end, graphNo, rt, routeLocations)));
                    }
                    else if (Data.CSStairBetwenn_0_1.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(department, rt);
                        stair_0_1_RouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, end, graphNo, rt, routeLocations)));
                    }
                    else if (Data.CSStairBetwenn_1_2.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(department, rt);
                        stair_1_2_RouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, end, graphNo, rt, routeLocations)));
                    }
                }

                if (zeroFloorRouteSet.Count != 0)
                {
                    final.Add("floor_0_routelocations", new List<double[]>(zeroFloorRouteSet));
                    lst.Clear();
                    floorLocations = LocationData.GetFloorLocations(department, 0);

                    for (int i = 0; i < floorLocations.GetLength(0); i++)
                        lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
                    final.Add("floor_0_locations", new List<double[]>(lst));
                }

                if (firstFloorRouteSet.Count != 0)
                {
                    final.Add("floor_1_routelocations", new List<double[]>(firstFloorRouteSet));
                    lst.Clear();
                    floorLocations = LocationData.GetFloorLocations(department, 1);

                    for (int i = 0; i < floorLocations.GetLength(0); i++)
                        lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
                    final.Add("floor_1_locations", new List<double[]>(lst));
                }

                if (secondFloorRouteSet.Count != 0)
                {
                    final.Add("floor_2_routelocations", new List<double[]>(secondFloorRouteSet));
                    lst.Clear();
                    floorLocations = LocationData.GetFloorLocations(department, 2);

                    for (int i = 0; i < floorLocations.GetLength(0); i++)
                        lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
                    final.Add("floor_2_locations", new List<double[]>(lst));
                }

                if (stair_0_1_RouteSet.Count != 0)
                    final.Add("stair_0_1_locations", stair_0_1_RouteSet);
                if (stair_1_2_RouteSet.Count != 0)
                    final.Add("stair_1_2_locations", stair_1_2_RouteSet);
            }
            else
            {
                lst.Clear();
                floorLocations = LocationData.GetFloorLocations(department, floor);

                for (int i = 0; i < floorLocations.GetLength(0); i++)
                    lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
                //this should change according to the department
                if (floor == 0)
                    final.Add("floor_0_locations", new List<double[]>(lst));
                else if (floor == 1)
                    final.Add("floor_1_locations", new List<double[]>(lst));
                else
                    final.Add("floor_2_locations", new List<double[]>(lst));
            }

            place = LocationData.GetPlaceWithName(placeID);
            pl = new Place();

            foreach (KeyValuePair<string, double[]> pair in place)//only once
            {
                temp = pair.Value;
                pl = new Place()
                {
                    name = pair.Key,
                    lat = temp[0],
                    lon = temp[1]
                };
            }
            final.Add("place", pl);
            return Json(final);
        }

        [HttpPost]
        [Route("IdentifyUser/{username}/{password}")]
        public IActionResult IdentifyUser(string username, string password)
        {
            if (LocationData.GetUserIdentity(username, password))
                return Ok();
            else
                return Unauthorized();
        }

        [HttpPost]
        [Route("RegisterUser")]
        public IActionResult RegisterUser([FromBody] APIUser[] user)
        {
            if (user[0].username.Length > 0)
            {
                if (LocationData.SetUser(user[0].username, user[0].email, user[0].type, user[0].faculty, user[0].password))
                    return Created("http://127.0.0.1:5000/API", user[0].username + " Registered");
                else
                    return BadRequest("Username alredy exist !");
            }
            else
                return BadRequest("Username is Empty !");
        }

        //Location Shearing system request handling methods

        [HttpGet]
        [Route("UserLocation/{userName}/{LAT:double}/{LON:double}")]
        public async Task<IActionResult> UserLocation(string userName, double LAT, double LON)
        {
            int userId = LocationData.GetUserId(userName);
            if (userId != 0)
            {
                Location loc = new Location()
                {
                    Username = userName,
                    Lat = LAT,
                    Lon = LON
                };
                try
                {
                    FirebaseClient client = new FirebaseClient("https://university-roadmap-default-rtdb.firebaseio.com/");
                    await client.Child("UserLocation/" + userId).PutAsync(loc);
                    return Ok("Successfully Updated..!");
                }
                catch
                {
                    return BadRequest("There is an issue with realtime database connection..!");
                }
            }
            else
                return BadRequest("This username is not exist in the database ..!");
        }

        private async Task<Location> FetchUserLocation(int userId)
        {
            try
            {
                FirebaseClient client = new FirebaseClient("https://university-roadmap-default-rtdb.firebaseio.com/");
                var read = await client.Child("UserLocation").Child(userId.ToString()).OnceSingleAsync<Location>();
                return new Location() { Username = read.Username, Lat = read.Lat, Lon = read.Lon };
            }
            catch
            {
                return null;
            }
        }

        [HttpGet]
        [Route("GetLocations/{userName}")]
        public async Task<IActionResult> GetLocations(string userName)
        {
            var final = new Hashtable();
            Location loc;
            int[] ConfUsers = LocationData.GetConfirmedUserId(userName);
            List<Location> arr = new List<Location>();

            foreach (int userId in ConfUsers)
            {
                loc = await FetchUserLocation(userId);
                if (loc != null)
                    arr.Add(new Location() { Username = loc.Username, Lat = loc.Lat, Lon = loc.Lon });
            }
            final.Add("friends", arr);
            return Json(final);
        }

        [HttpGet]
        [Route("GetPath/{user}/{req_user}")]
        public async Task<IActionResult> GetPath(string user, string req_user)
        {
            int user1_id, user2_id, start, end, graphNo = 0, V_No = Data.footGrapheVertices;
            Location loc_1, loc_2;
            List<double[]> lst = new List<double[]>();
            var final = new Hashtable();
            Calculations cal = new Calculations();

            user1_id = LocationData.GetUserId(user);
            user2_id = LocationData.GetUserId(req_user);

            loc_1 = await FetchUserLocation(user1_id);
            loc_2 = await FetchUserLocation(user2_id);

            start = cal.GetNearestVertexNo(V_No, graphNo, loc_1.Lat, loc_1.Lon);
            end = cal.GetNearestVertexNo(V_No, graphNo, loc_2.Lat, loc_2.Lon);

            if (start != end)
            {
                int[] routes = cal.GetRouteNumbers(graphNo, start, end);
                double[,] routeLocations;
                foreach (int r in routes)
                {
                    routeLocations = LocationData.GetFootRoute(r);
                    lst.AddRange(new List<double[]>(cal.ValidateRoute(start, end, graphNo, r, routeLocations)));
                }
                final.Add("routelocations", lst);
                final.Add("distance_time", cal.FindDistanceAndTime(graphNo, start, end));
                return Json(final);
            }
            return Json(final);
        }

        [HttpGet]
        [Route("GetAppUsers/{userName}")]
        public IActionResult GetAppUsers(string userName)
        {
            var final = new Hashtable();
            string[] ConfUsers = LocationData.GetConfirmedUsernames(userName);
            string[] ReqUsers = LocationData.GetRequestedUsernames(userName);
            string[] AllUsers = LocationData.GetAllUsernames(userName);
            List<string> otherUsers = new List<string>();
            if (ConfUsers.Length != 0)
                final.Add("friends", ConfUsers);
            if (ReqUsers.Length != 0)
                final.Add("friend_requests", ReqUsers);

            foreach (string name in AllUsers)
                if (!ConfUsers.Contains(name) && !ReqUsers.Contains(name))
                    otherUsers.Add(name);

            if (otherUsers.Count != 0)
                final.Add("other_users", otherUsers);
            return Json(final);
        }
           
        [HttpGet]
        [Route("AddFriend/{user}/{req_user}")]
        public IActionResult AddFriend(string user, string req_user)
        {
            if (LocationData.AddFriendRequest(user, req_user))
                return Ok();
            else
                return BadRequest();
        }

        [HttpGet]
        [Route("ConfirmFriend/{user}/{req_user}")]
        public IActionResult ConfirmFriend(string user, string req_user)
        {
            if (LocationData.ConfirmFriendRequest(user, req_user))
                return Ok();
            else
                return BadRequest();
        }

        [HttpGet]
        [Route("RemoveFriend/{user}/{req_user}")]
        public IActionResult RemoveFriend(string user, string req_user)
        {
            if (LocationData.RemoveFriendRequest(user, req_user))
                return Ok();
            else
                return BadRequest();
        }

        //Admin Panel methods
      
        [HttpGet]
        [Route("AdminPanel")]
        public IActionResult AdminPanel()
        {
            var final = new Dictionary<string, List<APIUser>>();
            var usersTable = LocationData.GetAllUsers();
            if (usersTable.Count > 0)
            {
                List<APIUser> usrList = new List<APIUser>();
                foreach (KeyValuePair<string,string[]> usr in usersTable)
                {
                    usrList.Add(new APIUser()
                    {
                        username=usr.Value[0],
                        faculty=usr.Value[1],
                        type=usr.Value[2]
                    });

                    var friendList = LocationData.GetFriendsOfUser(usr.Value[0]);
                    if (friendList.Count > 0)
                    {
                        foreach (KeyValuePair<string, string[]> frnd in friendList)
                        {
                            usrList.Add(new APIUser()
                            {
                                username = frnd.Value[0],
                                faculty = frnd.Value[1],
                                type = frnd.Value[2]
                            });
                        }
                    }
                    final.Add(usr.Key, new List<APIUser>(usrList));
                    usrList.Clear();
                }
            }
            return View(final);
        }

        [HttpGet]
        [Route("RemoveUser/{username}")]
        public IActionResult RemoveUser(string username)
        {
            if (LocationData.RemoveUser(username))
            {
                @TempData["status"] = "yes";
                @TempData["access"] = "yes";
                @TempData["searchText"] = "*";
                return RedirectToAction("AdminPanel");
            }
            else
            {
                @TempData["status"] = "no";
                @TempData["access"] = "yes";
                @TempData["searchText"] = "*";
                return RedirectToAction("AdminPanel");
            }
        }

        [HttpGet]
        [Route("UnfriendUser/{user_1}/{user_2}")]
        public IActionResult UnfriendUser(string user_1, string user_2)
        {
            if (LocationData.RemoveFriendRequest(user_1, user_2))
            {
                @TempData["removestatus"] = "yes";
                @TempData["access"] = "yes";
                @TempData["searchText"] = "*";
                return RedirectToAction("AdminPanel");
            }
            else
            {
                @TempData["removestatus"] = "no";
                @TempData["access"] = "yes";
                @TempData["searchText"] = "*";
                return RedirectToAction("AdminPanel");
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [Route("Login")]
        public IActionResult Login([FromForm]AdminUser user)
        {
            if (LocationData.IdentifyAdmin(user.Username, user.Password))
            {
                @TempData["access"] = "yes";
                @TempData["searchText"] = "*";
                return RedirectToAction("AdminPanel");
            }
            else
            {
                @TempData["login"] = "invalid";
                @TempData["access"] = "no";
                return RedirectToAction("Index");
            }
        }

        [HttpGet]
        [Route("")]        
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        [Route("Search/{text}")]
        public IActionResult Search(string text)
        {
            @TempData["access"] = "yes";
            @TempData["searchText"] = text;
            return Json(text);
        }
    }
}
