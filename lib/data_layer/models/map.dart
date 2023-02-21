import 'package:collection/collection.dart';
class Map{
  final Location location;
  final String username;

  Map({required this.location,required this.username});

}

class Beacon {
  late int x;
  late int y;
  late int distance;
  final int rssi;

  Beacon({required this.rssi});
}

class Location {
  final double x;
  final double y;

  Location({required this.x, required this.y});
}



class Graph {
  int numVertices = 13;
  List<List<int>> adjacencyList = [[1,12],[0,2],[1,3],[2,4],[3,5],[4,6],[5,7],[6,8],[7,9],[8,10],[9,11],[10,12],[11,0]];
  List<List<double>> nodesCoordinates = [[35,400],[215,400],[275,400],[275,305],[275,170],[275,50],[275,8],[215,8],[8,8],[8,80],[8,185],[8,295],[8,400]];
  List<List<double>> weights = [[180,27],[180,60],[60,95],[95,135],[135,80],[80,42],[42,60],[60,207],[207,72],[72,105],[105,110],[110,105],[105,27]];



  List<List<double>> shortestPath(int start, int end) {
    var distances = List.filled(numVertices, double.infinity);
    var visited = List.filled(numVertices, false);
    var previous = List.filled(numVertices, -1);

    distances[start] = 0;

    var queue = PriorityQueue<int>((a, b) =>
        distances[a].compareTo(distances[b]));
    queue.add(start);

    while (queue.isNotEmpty) {
      var current = queue.removeFirst();
      visited[current] = true;

      if (current == end) {
        break;
      }

      for (var i = 0; i < adjacencyList[current].length; i++) {
        var neighbor = adjacencyList[current][i];
        var weight = weights[current][i];
        if (!visited[neighbor]) {
          var newDistance = distances[current] + weight;
          if (newDistance < distances[neighbor]) {
            distances[neighbor] = newDistance;
            previous[neighbor] = current;
            queue.add(neighbor);
          }
        }
      }
    }

    var path = <int>[];
    var node = end;
    while (node != -1) {
      path.add(node);
      node = previous[node];
    }
    path = path.reversed.toList();
    List<List<double>> pathCoordinates = List.generate(path.length, (i) => []);
    for (var i=0;i<path.length;i++){
      pathCoordinates[i] = nodesCoordinates[path[i]];
    }

    return pathCoordinates;

  }

}