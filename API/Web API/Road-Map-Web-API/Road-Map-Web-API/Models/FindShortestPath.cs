using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Road_Map_Web_API
{
    public class FindShortestPath
    {
        int start;
        int V;
        int[] dist;
        int[,,] shortestPath;
        List<int[]> path = new List<int[]>();
        List<int> preNodes = new List<int>();

        public List<int[]> GetShortestPathList(int[,] graph,int noOfVertex,int start)
        {
            V = noOfVertex;
            this.start = start;
            shortestPath = new int[noOfVertex, noOfVertex - 1, 2];
            dijkstra(graph, start);
            CalPaths();
            return path;
        }

        public int[] GetShortestDistanceList(int[,] graph, int noOfVertex, int start)
        {
            V = noOfVertex;
            this.start = start;
            shortestPath = new int[noOfVertex, noOfVertex - 1, 2];
            dijkstra(graph, start);
            return dist;
        }

        int minDistance(int[] dist, bool[] sptSet)
        {
            int min = int.MaxValue, min_index = -1;
            for (int v = 0; v < V; v++)
                if (sptSet[v] == false && dist[v] <= min)
                {
                    min = dist[v];
                    min_index = v;
                }
            return min_index;
        }
        void dijkstra(int[,] graph, int src)
        {
            dist = new int[V];
            bool[] sptSet = new bool[V];

            for (int i = 0; i < V; i++)
            {
                dist[i] = int.MaxValue;
                sptSet[i] = false;
            }
            dist[src] = 0;
            for (int count = 0; count < V - 1; count++)
            {
                int u = minDistance(dist, sptSet);
                sptSet[u] = true;
                for (int v = 0; v < V; v++)                
                    if (!sptSet[v] && graph[u, v] != 0 && dist[u] != int.MaxValue && dist[u] + graph[u, v] < dist[v])                    
                        dist[v] = dist[u] + graph[u, v];                    
                
                for (int i = 0; i < V; i++)
                {
                    shortestPath[i, count, 0] = dist[i];
                    shortestPath[i, count, 1] = u;
                }
            }
        }

        int CalPre(int preNode)
        {
            int a = shortestPath[preNode, V - 2, 0];
            int index = preNode;
            for (int j = V - 3; j >= 0; j--)
            {
                if (a == shortestPath[index, j, 0])
                    preNode = shortestPath[index, j, 1];
                else
                {
                    preNodes.Add(preNode);
                    break;
                }
            }
            return preNode;
        }

        void CalPaths()
        {
            int a, preNode;

            for (int i = 0; i < V; i++)
            {
                a = shortestPath[i, V - 2, 0];
                preNode = shortestPath[i, V - 2, 1];
                preNodes.Add(i);
                for (int j = V - 3; j >= 0; j--)
                {
                    if (a == shortestPath[i, j, 0])
                        preNode = shortestPath[i, j, 1];
                    else
                    {
                        preNodes.Add(preNode);
                        break;
                    }
                }
                while (preNode != start)
                {
                    preNode = CalPre(preNode);
                }
                preNodes.Add(start);
                preNodes.Reverse();
                path.Add(preNodes.ToArray());
                preNodes.Clear();
            }
        }
    }
}
