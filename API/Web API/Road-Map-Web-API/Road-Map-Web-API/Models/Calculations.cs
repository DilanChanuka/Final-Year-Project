using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RoadMap_DB.DataAccess;

namespace Road_Map_Web_API
{
    public class Calculations
    {
        public int GetNearestVertexNo(int noOfVertices,int graphNo, double lat, double lon)
        {
            double[] distance = new double[noOfVertices];
            double[] temp;
            for (int i = 0; i < noOfVertices; i++)
                distance[i] = double.MaxValue;            

            for (int i = 0; i < noOfVertices; i++)
            {
                if (graphNo == 0)
                {
                    if (!Data.FootGraph_MissingVerticesSet.Contains(i)) 
                    {
                        temp = LocationData.GetVertexLoaction(graphNo, i);
                        distance[i] = Math.Sqrt(Math.Pow(lat - temp[0], 2) + Math.Pow(lon - temp[1], 2));
                    }
                }
                else
                {
                    if (Data.VehicleGraph_VerticesSet.Contains(i))
                    {
                        temp = LocationData.GetVertexLoaction(0, i);
                        distance[i] = Math.Sqrt(Math.Pow(lat - temp[0], 2) + Math.Pow(lon - temp[1], 2));
                    }
                }
            }
            return Array.IndexOf(distance, distance.Min());
        }

        public int GetNearestVertexNo(int department,int floor,int noOfVertices, int graphNo, double lat, double lon)
        {
            double[] distance = new double[noOfVertices],temp;
            int[] verticesSet;

            for (int i = 0; i < noOfVertices; i++)            
                distance[i] = int.MaxValue;            
            //according to the department,vertices set should change
            if (floor == 0)
                verticesSet = Data.CSFloo_0_VerticesSet;
            else if (floor == 1)
                verticesSet = Data.CSFloo_1_VerticesSet;
            else
                verticesSet = Data.CSFloo_2_VerticesSet;

            foreach (int V in verticesSet)
            {
                temp = LocationData.GetVertexLoaction(graphNo, V);
                distance[V] = Math.Sqrt(Math.Pow(lat - temp[0], 2) + Math.Pow(lon - temp[1], 2));
            }
            return Array.IndexOf(distance, distance.Min());
        }

        public int FindEnterenceVertexNo(int noOfVertices, int graphNo, int start, int placeID)
        {
            FindShortestPath find = new FindShortestPath();
            int[,] graph,innerGraph;
            int[] dist_1, dist_2, distance, ids;
            int innerStart, innerEnd = 0, innerVerticesNo;

            if (graphNo == 0)
                graph = Data.footRoutesGraph;
            else
                graph = Data.vehicleRoutesGraph;

            ids = LocationData.GetDepartmentAndFloor(placeID);

            if (ids[0] == 1)
            {
                innerGraph = Data.CSDepartmentGraph;
                innerVerticesNo = Data.CSDepartmentGrapheVertices;
            }
            else
            {
                innerGraph = Data.footRoutesGraph;
                innerVerticesNo = Data.footGrapheVertices;
            }

            for (int j = 0; j < Data.CSMainPlaceMatch.Length; j++)
                if (Data.CSMainPlaceMatch[j] == placeID)
                {
                    innerEnd = j;
                    break;
                }

            dist_1 = find.GetShortestDistanceList(graph, noOfVertices, start);
            distance = new int[Data.EntranceOuterMatch.Length];
            for (int i = 0; i < Data.EntranceOuterMatch.Length; i++)
            {
                distance[i] = dist_1[Data.EntranceOuterMatch[i]];
                innerStart = Data.CSMainEntranceInnerMatch[i];            
                dist_2 = find.GetShortestDistanceList(innerGraph, innerVerticesNo, innerStart);
                distance[i] += dist_2[innerEnd];
            }

            //according to the department,Entrance outer match should change
            return  Data.EntranceOuterMatch[Array.IndexOf(distance, distance.Min())];
        }

        public int[] FindEnterenceVertexNo(int dept_ID,int floorID,double startlat, double startlon, double endlat, double endlon)
        {
            double[,] entrance = LocationData.GetEntranceLocations(dept_ID);
            double[] distance = new double[entrance.GetLength(0)];
            int entranceNumber;
            List<int> entranceAndInnerVertex = new List<int>();

            for (int i = 0; i < entrance.GetLength(0); i++)
            {
                distance[i] = Math.Sqrt(Math.Pow(startlat - entrance[i, 0], 2) + Math.Pow(startlon - entrance[i, 1], 2)) +
                        Math.Sqrt(Math.Pow(endlat- entrance[i, 0], 2) + Math.Pow(endlon - entrance[i, 1], 2));
            }
            entranceNumber = Array.IndexOf(distance, distance.Min());
            entranceAndInnerVertex.Add(entranceNumber);
            //according to the department,Entrance inner match should change            
            entranceAndInnerVertex.Add(Data.CSMainEntranceInnerMatch[entranceNumber]);            

            return entranceAndInnerVertex.ToArray();
        }

        public int[] GetRouteNumbers(int graphNo,int start,int end)
        {
            FindShortestPath find = new FindShortestPath();
            int[,] graph, endPoints;
            int V_No;
            int[] path;
            List<int> routeNumbers = new List<int>();
            List<int[]> allPaths;

            switch (graphNo)
            {
                case 0:
                    graph = Data.footRoutesGraph;
                    V_No = Data.footGrapheVertices;
                    endPoints = Data.foorRouteEndpoints;
                    break;
                case 1:
                    graph = Data.vehicleRoutesGraph;
                    V_No = Data.vehicleGrapheVertices;
                    endPoints = Data.vehicleRouteEndpoints;
                    break;               
                case 2:
                    graph = Data.CSDepartmentGraph;
                    V_No = Data.CSDepartmentGrapheVertices;
                    endPoints = Data.CSDepartmentRouteEndpoints;
                    break;
                default:
                    graph = Data.footRoutesGraph;
                    V_No = Data.footGrapheVertices;
                    endPoints = Data.foorRouteEndpoints;
                    break;
            }
            allPaths= find.GetShortestPathList(graph, V_No, start);
            path = allPaths[end];

            for (int j = 0; j < path.Length-1; j++)
            {
                for (int i = 0; i < endPoints.GetLength(0); i++)
                {
                    if((endPoints[i,0]==path[j] && endPoints[i, 1] == path[j + 1]) ||
                        (endPoints[i, 1] == path[j] && endPoints[i, 0] == path[j + 1]))
                    {
                        routeNumbers.Add(i);
                        break;
                    }
                }
            }
            return routeNumbers.ToArray();
        }

        public List<double[]> ValidateRoute(int start,int end,int graphNo,int routNo,double[,] route)
        {
            int[,] endPoints;
            List<double[]> lst = new List<double[]>();
            int size = route.GetLength(0);

            if (graphNo == 0)
                endPoints = Data.foorRouteEndpoints;
            else if (graphNo == 1)
                endPoints = Data.vehicleRouteEndpoints;
            else 
                endPoints = Data.CSDepartmentRouteEndpoints;
            
            try
            {
                double[] temp_1 = LocationData.GetVertexLoaction(graphNo, start);
                double[] temp_2 = LocationData.GetVertexLoaction(graphNo, end);

                if ((temp_1[0] == route[0, 0] && temp_1[1] == route[0, 1]) &&
                    (temp_2[0] == route[size - 1, 0] && temp_2[1] == route[size - 1, 1]))
                {
                    for (int i = 0; i < size; i++)
                        lst.Add(new double[] { route[i, 0], route[i, 1] });
                    return lst;
                }
                if ((temp_2[0] == route[0, 0] && temp_2[1] == route[0, 1]) &&
                    (temp_1[0] == route[size - 1, 0] && temp_1[1] == route[size - 1, 1]))
                {
                    for (int i = size - 1; i >= 0; i--)
                        lst.Add(new double[] { route[i, 0], route[i, 1] });
                    return lst;
                }

                if (temp_1[0] == route[0, 0] && temp_1[1] == route[0, 1])
                {
                    for (int i = 0; i < size; i++)
                        lst.Add(new double[] { route[i, 0], route[i, 1] });

                    if (endPoints[routNo, 0] == start)
                        Middle = endPoints[routNo, 1];
                    else
                        Middle = endPoints[routNo, 0];
                    return lst;
                }
                if (temp_1[0] == route[size - 1, 0] && temp_1[1] == route[size - 1, 1])
                {
                    for (int i = size - 1; i >= 0; i--)
                        lst.Add(new double[] { route[i, 0], route[i, 1] });

                    if (endPoints[routNo, 0] == start)
                        Middle = endPoints[routNo, 1];
                    else
                        Middle = endPoints[routNo, 0];
                    return lst;
                }
                double[] mid = LocationData.GetVertexLoaction(graphNo, Middle);

                if ((mid[0] == route[0, 0] && mid[1] == route[0, 1]) &&
                    (temp_2[0] == route[size - 1, 0] && temp_2[1] == route[size - 1, 1]))
                {
                    for (int i = 0; i < size; i++)
                        lst.Add(new double[] { route[i, 0], route[i, 1] });
                    return lst;
                }
                if ((temp_2[0] == route[0, 0] && temp_2[1] == route[0, 1]) &&
                    (mid[0] == route[size - 1, 0] && mid[1] == route[size - 1, 1]))
                {
                    for (int i = size - 1; i >= 0; i--)
                        lst.Add(new double[] { route[i, 0], route[i, 1] });
                    return lst;
                }

                if (mid[0] == route[0, 0] && mid[1] == route[0, 1])
                {
                    for (int i = 0; i < size; i++)
                        lst.Add(new double[] { route[i, 0], route[i, 1] });

                    if (endPoints[routNo, 0] == Middle)
                        Middle = endPoints[routNo, 1];
                    else
                        Middle = endPoints[routNo, 0];
                    return lst;
                }
                if (mid[0] == route[size - 1, 0] && mid[1] == route[size - 1, 1])
                {
                    for (int i = size - 1; i >= 0; i--)
                        lst.Add(new double[] { route[i, 0], route[i, 1] });

                    if (endPoints[routNo, 0] == Middle)
                        Middle = endPoints[routNo, 1];
                    else
                        Middle = endPoints[routNo, 0];
                    return lst;
                }
                return lst;
            }
            catch (Exception e)
            {
                return lst;
            }
        }

        public double[] FindDistanceAndTime(int graphNo, int start, int end)
        {
            FindShortestPath find = new FindShortestPath();
            int[,] graph;
            int V_No;
            int[] distances;

            switch (graphNo)
            {
                case 0:
                    graph = Data.footRoutesGraph;
                    V_No = Data.footGrapheVertices;
                    break;
                case 1:
                    graph = Data.vehicleRoutesGraph;
                    V_No = Data.vehicleGrapheVertices;
                    break;
                case 2:
                    graph = Data.CSDepartmentGraph;
                    V_No = Data.CSDepartmentGrapheVertices;
                    break;
                default:
                    graph = Data.footRoutesGraph;
                    V_No = Data.footGrapheVertices;
                    break;
            }
            distances = find.GetShortestDistanceList(graph, V_No, start);

            if(graphNo == 1)
                return new double[] { distances[end], Math.Round((distances[end] * Data.drivingTimePerMeter) / 60, 2) };
            else
                return new double[] { distances[end], Math.Round((distances[end] * Data.walkingTimePerMeter) / 60, 1) };
        }

        int Middle { get; set; }
    }
}
