using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Road_Map_Web_API
{
    public static class Data
    {
        #region PreDefined DataSet

        //no of vertices in the graphs
        public static int footGrapheVertices = 115;
        public static int vehicleGrapheVertices = 115;
        public static int CSDepartmentGrapheVertices = 71;

        //no of routes in the graphs
        public static int noOfFootRoutes = 141;
        public static int noOfVehicleRoutes = 141;
        public static int noOfCSMainRoutes = 76;

        //time per meter from seconds
        public static double walkingTimePerMeter = 3.1;
        public static double drivingTimePerMeter = 0.45;

        //end points of each route 
        //index=route number 
        public static int[,] foorRouteEndpoints = new int[noOfFootRoutes, 2];

        public static int[,] vehicleRouteEndpoints = new int[noOfVehicleRoutes, 2];

        public static int[,] CSDepartmentRouteEndpoints = new int[noOfCSMainRoutes, 2];    

        //graphs of each map
        public static int[,] footRoutesGraph = new int[footGrapheVertices, footGrapheVertices];

        public static int[,] vehicleRoutesGraph = new int[vehicleGrapheVertices, vehicleGrapheVertices];

        public static int[,] CSDepartmentGraph = new int[CSDepartmentGrapheVertices,CSDepartmentGrapheVertices];

        //CS Department floor route number set
        public static int[] CSStairRouteNumbers = new int[] { 19,53,18,65,64,27,66,15,17 };
        public static int[] CSFloor_0_RouteNumbers = new int[] { 54,55,56,57,58,59,60,61,62,63,75,74,73,72,71,70,69,68,67,27 };
        public static int[] CSFloor_1_RouteNumbers = new int[] { 16,20,21,22,23,24,25,26,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52};
        public static int[] CSFloor_2_RouteNumbers = new int[] { 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14};

        //CS Department staire route numbers
        public static int[] CSStairBetwenn_0_1 = new int[] { 66,64,65,53 };
        public static int[] CSStairBetwenn_1_2 = new int[] { 19,18,15,17 };
               
        //CS Department floor by floor vertices numbers set of CS Main graph
        public static int[] CSFloo_0_VerticesSet = new int[] { 50,51,54,55,57,58,59,61,62,64,63,70,68,69,67,26,66,60,56,65 };
        public static int[] CSFloo_1_VerticesSet = new int[] { 19,21,32,22,31,23,24,25,27,28,29,33,30,17,34,35,36,38,37,39,46,40,41,42,43,44,47,52,53,16,48,49,45,18,20 };
        public static int[] CSFloo_2_VerticesSet = new int[] { 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 };

        //Vehicle Route graph vertex number set
        public static int[] VehicleGraph_VerticesSet = new int[] { 0, 113, 114, 1, 111, 3, 112, 15, 46, 51, 52, 58, 47, 59, 84, 81, 82, 83, 93, 91, 78, 77, 75, 26, 89, 85, 108, 24, 23, 25, 29, 33, 34, 6, 27, 22, 20, 18, 12, 90, 5, 7, 2, 109, 4, 99 };

        //missing vertices set of foot graph
        public static int[] FootGraph_MissingVerticesSet = new int[] { 53, 56, 73, 79, 86, 88 };

        //includes place numbers for relavelt vertex numbers of CS Department main graph 
        //index=department graph vertex number,value=place id
        public static int[] CSMainPlaceMatch = new int[71];

        //index=inner Vertex number, value=matching outer Vertex no
        public static int[] CSMainOuterInnerMatch = new int[71];

        //index=Entrance Number, value=matching inner Vertex no
        public static int[] CSMainEntranceInnerMatch = new int[9];        

        //includes foot graph vertex numbers for relavelt entrance number
        //index=entrance no,value=foot graph vertex no
        public static int[] EntranceOuterMatch = new int[9];
        
        // graph_numbers   graph_name 
        //0               flootRoutesGraph
        //1               vehicleRoutesGraph                 
        //2               CSDepartmentGraph
        #endregion

        public static void LoadData()
        {
            string[] lines;
            string[] split;
            int j;
            try
            {
                j = 0;
                lines = System.IO.File.ReadAllLines(@"wwwroot/DataSet/footGraph.txt");
                foreach (string line in lines)
                {
                    split = line.Split(',');
                    for (int i = 0; i < footGrapheVertices; i++)
                        footRoutesGraph[j, i] = int.Parse(split[i]);

                    j++;
                }

                j = 0;
                lines = System.IO.File.ReadAllLines(@"wwwroot/DataSet/CSMainGraph.txt");
                foreach (string line in lines)
                {
                    split = line.Split(',');
                    for (int i = 0; i < CSDepartmentGrapheVertices; i++)
                        CSDepartmentGraph[j, i] = int.Parse(split[i]);

                    j++;
                }


                j = 0;
                lines = System.IO.File.ReadAllLines(@"wwwroot/DataSet/vehicleGraph.txt");
                foreach (string line in lines)
                {
                    split = line.Split(',');
                    for (int i = 0; i < vehicleGrapheVertices; i++)
                        vehicleRoutesGraph[j, i] = int.Parse(split[i]);

                    j++;
                }

                j = 0;
                lines = System.IO.File.ReadAllLines(@"wwwroot/DataSet/footGraphEndPoints.txt");
                foreach (string line in lines)
                {
                    split = line.Split(',');
                    for (int i = 0; i < 2; i++)
                        foorRouteEndpoints[j, i] = int.Parse(split[i]);

                    j++;
                }

                j = 0;
                lines = System.IO.File.ReadAllLines(@"wwwroot/DataSet/CSMainEndPoints.txt");
                foreach (string line in lines)
                {
                    split = line.Split(',');
                    for (int i = 0; i < 2; i++)
                        CSDepartmentRouteEndpoints[j, i] = int.Parse(split[i]);

                    j++;
                }

                j = 0;
                lines = System.IO.File.ReadAllLines(@"wwwroot/DataSet/vehicleGrapheEndPoints.txt");
                foreach (string line in lines)
                {
                    split = line.Split(',');
                    for (int i = 0; i < 2; i++)
                        vehicleRouteEndpoints[j, i] = int.Parse(split[i]);

                    j++;
                }

            }
            catch(Exception e)
            {
                Console.WriteLine(e.Message);
            }
            #region PreDefineGraphData
            CSMainPlaceMatch[1] = 1;
            CSMainPlaceMatch[5] = 2;
            CSMainPlaceMatch[9] = 3;
            CSMainPlaceMatch[15] = 4;
            CSMainPlaceMatch[32] = 5;
            CSMainPlaceMatch[31] = 6;
            CSMainPlaceMatch[20] = 7;
            CSMainPlaceMatch[33] = 8;
            CSMainPlaceMatch[35] = 9;
            CSMainPlaceMatch[46] = 10;
            CSMainPlaceMatch[49] = 11;
            CSMainPlaceMatch[41] = 12;
            CSMainPlaceMatch[44] = 13;
            CSMainPlaceMatch[69] = 14;
            CSMainPlaceMatch[62] = 15;
            CSMainPlaceMatch[59] = 16;
            CSMainPlaceMatch[54] = 17;

            CSMainOuterInnerMatch[55] = 44;
            CSMainOuterInnerMatch[61] = 16;
            CSMainOuterInnerMatch[63] = 17;
            CSMainOuterInnerMatch[26] = 19;
            CSMainOuterInnerMatch[60] = 21;
            CSMainOuterInnerMatch[25] = 39;
            CSMainOuterInnerMatch[36] = 41;
            CSMainOuterInnerMatch[39] = 42;
            CSMainOuterInnerMatch[47] = 43;

            CSMainEntranceInnerMatch[0] = 55;
            CSMainEntranceInnerMatch[1] = 61;
            CSMainEntranceInnerMatch[2] = 63;
            CSMainEntranceInnerMatch[3] = 26;
            CSMainEntranceInnerMatch[4] = 60;
            CSMainEntranceInnerMatch[5] = 25;
            CSMainEntranceInnerMatch[6] = 36;
            CSMainEntranceInnerMatch[7] = 39;
            CSMainEntranceInnerMatch[8] = 47;

            EntranceOuterMatch[0] = 44;
            EntranceOuterMatch[1] = 16;
            EntranceOuterMatch[2] = 17;
            EntranceOuterMatch[3] = 19;
            EntranceOuterMatch[4] = 21;
            EntranceOuterMatch[5] = 39;
            EntranceOuterMatch[6] = 41;
            EntranceOuterMatch[7] = 42;
            EntranceOuterMatch[8] = 43;

            #endregion
        }

    }
}
