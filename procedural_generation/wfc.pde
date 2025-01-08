import java.util.*;

final String[] PATTERNS = {
  "WWWEWWWEWWW",
  "BWBEWWWEBWB",
  "BWBEWWWEBBB",
  "BWBEBWWEBWB",
  "BBBEWWWEBWB",
  "BWBEWWBEBWB",
  "BWBEBWBEBWB",
  "BBBEWWWEBBB",
  "BWBEBWWEBBB",
  "BBBEBWWEBWB",
  "BBBEWWBEBWB",
  "BWBEWWBEBBB",
  "BBBEBBBEBBB"
};

String getTopEdge(String pattern) {
  return pattern.substring(0, 3);
}

String getBottomEdge(String pattern) {
  return pattern.substring(8, 11);
}

String getLeftEdge(String pattern) {
  return "" + pattern.charAt(0) + pattern.charAt(4) + pattern.charAt(8);
}

String getRightEdge(String pattern) {
  return "" + pattern.charAt(2) + pattern.charAt(6) + pattern.charAt(10);
}

boolean edgesAreConnected(String edge1, String edge2) {
  for (int i = 0; i < edge1.length(); i++) {
    if (edge1.charAt(i) == 'W' && edge2.charAt(i) == 'W') {
      return true;
    }
  }
  return false;
}

final int[] RATES = {
  50,
  5,
  5,
  5,
  5,
  5,
  5,
  5,
  5,
  5,
  5,
  5,
  20
};

final color[] COLOR_PALETTE = {
  color(255, 85, 85), // Red
  color(80, 250, 123), // Green
  color(139, 233, 253), // Cyan
  color(241, 250, 140), // Yellow
  color(255, 121, 198), // Pink
  color(255, 184, 108), // Orange
  color(189, 147, 249)   // Purple
};

final int GRID_SIZE = 10;

class Tile {
  ArrayList<Integer> possibilities;
  int currentPattern;

  Tile() {
    currentPattern = -1;
    possibilities = new ArrayList<Integer>();
    for (int p = 0; p <= 12; p++) {
      possibilities.add(p);
    }
  }

  void collapse(int pattern) {
    currentPattern = pattern;
    possibilities.clear();
    possibilities.add(pattern);
  }
}

class PropagationItem {
  int row;
  int col;
  String direction;

  PropagationItem(int row, int col, String direction) {
    this.row = row;
    this.col = col;
    this.direction = direction;
  }
}

class RoomNode {
  int roomID;
  PVector position;
  color roomColor;

  RoomNode(int roomID, PVector position) {
    this.roomID = roomID;
    this.position = position;
    this.roomColor = color(40, 42, 54);
  }
}

void drawPattern(int posX, int posY, String pattern, int size) {
  int x = posX;
  int y = posY;
  char[] characters = pattern.toCharArray();

  for (int i = 0; i < characters.length; i++) {
    if (characters[i] == 'B') {
      noStroke();
      fill(68, 71, 90);
      square(x, y, size);
      x += size;
    } else if (characters[i] == 'W') {
      noStroke();
      fill(248, 248, 242);
      square(x, y, size);
      x += size;
    } else {
      x = posX;
      y += size;
    }
  }
}

void drawGrid(int initX, int initY) {
  int x = initX;
  int y = initY;

  for (int i = 0; i < GRID_SIZE; i++) {
    for (int j = 0; j < GRID_SIZE; j++) {
      if (grid[i][j].currentPattern == -1) {
        ArrayList<Integer> possibilities = grid[i][j].possibilities;
        grid[i][j].currentPattern = getRandomPatternByRate(possibilities);
      }

      String pattern = PATTERNS[grid[i][j].currentPattern];

      drawPattern(x, y, pattern, 20);
      x += 60;
    }
    x = initX;
    y += 60;
  }
}

ArrayList<Integer> getAllPossibilities(int pattern, String direction) {
  if (pattern == 0) {
    Integer[] possibilities = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};
    return new ArrayList<Integer>(Arrays.asList(possibilities));
  }

  if (pattern == 1) {
    switch(direction) {
    case "TOP":
      Integer[] topPossibilities = {0, 1, 3, 4, 5, 6, 9, 10};
      return new ArrayList<Integer>(Arrays.asList(topPossibilities));
    case "RIGHT":
      Integer[] rightPossibilities = {0, 1, 2, 4, 5, 7, 10, 11};
      return new ArrayList<Integer>(Arrays.asList(rightPossibilities));
    case "BOTTOM":
      Integer[] bottomPossibilities = {0, 1, 2, 3, 5, 6, 8, 11};
      return new ArrayList<Integer>(Arrays.asList(bottomPossibilities));
    case "LEFT":
      Integer[] leftPossibilities = {0, 1, 2, 3, 7, 8, 9, 11};
      return new ArrayList<Integer>(Arrays.asList(leftPossibilities));
    }
  }

  if (pattern == 2) {
    switch(direction) {
    case "TOP":
      Integer[] topPossibilities = {0, 1, 3, 4, 5, 6, 9, 10};
      return new ArrayList<Integer>(Arrays.asList(topPossibilities));
    case "RIGHT":
      Integer[] rightPossibilities = {0, 1, 2, 4, 5, 7, 10, 11};
      return new ArrayList<Integer>(Arrays.asList(rightPossibilities));
    case "BOTTOM":
      Integer[] bottomPossibilities = {0, 4, 7, 9, 10, 12};
      return new ArrayList<Integer>(Arrays.asList(bottomPossibilities));
    case "LEFT":
      Integer[] leftPossibilities = {0, 1, 2, 3, 7, 8, 9, 11};
      return new ArrayList<Integer>(Arrays.asList(leftPossibilities));
    }
  }

  if (pattern == 3) {
    switch(direction) {
    case "TOP":
      Integer[] topPossibilities = {0, 1, 3, 4, 5, 6, 9, 10};
      return new ArrayList<Integer>(Arrays.asList(topPossibilities));
    case "RIGHT":
      Integer[] rightPossibilities = {0, 1, 2, 4, 5, 7, 10, 11};
      return new ArrayList<Integer>(Arrays.asList(rightPossibilities));
    case "BOTTOM":
      Integer[] bottomPossibilities = {0, 1, 2, 3, 5, 6, 8, 11};
      return new ArrayList<Integer>(Arrays.asList(bottomPossibilities));
    case "LEFT":
      Integer[] leftPossibilities = {0, 5, 6, 10, 11, 12};
      return new ArrayList<Integer>(Arrays.asList(leftPossibilities));
    }
  }

  if (pattern == 4) {
    switch(direction) {
    case "TOP":
      Integer[] topPossibilities = {0, 2, 7, 8, 11, 12};
      return new ArrayList<Integer>(Arrays.asList(topPossibilities));
    case "RIGHT":
      Integer[] rightPossibilities = {0, 1, 2, 4, 5, 7, 10, 11};
      return new ArrayList<Integer>(Arrays.asList(rightPossibilities));
    case "BOTTOM":
      Integer[] bottomPossibilities = {0, 1, 2, 3, 5, 6, 8, 11};
      return new ArrayList<Integer>(Arrays.asList(bottomPossibilities));
    case "LEFT":
      Integer[] leftPossibilities = {0, 1, 2, 3, 7, 8, 9, 11};
      return new ArrayList<Integer>(Arrays.asList(leftPossibilities));
    }
  }

  if (pattern == 5) {
    switch(direction) {
    case "TOP":
      Integer[] topPossibilities = {0, 1, 3, 4, 5, 6, 9, 10};
      return new ArrayList<Integer>(Arrays.asList(topPossibilities));
    case "RIGHT":
      Integer[] rightPossibilities = {0, 3, 6, 8, 9, 12};
      return new ArrayList<Integer>(Arrays.asList(rightPossibilities));
    case "BOTTOM":
      Integer[] bottomPossibilities = {0, 1, 2, 3, 5, 6, 8, 11};
      return new ArrayList<Integer>(Arrays.asList(bottomPossibilities));
    case "LEFT":
      Integer[] leftPossibilities = {0, 1, 2, 3, 7, 8, 9, 11};
      return new ArrayList<Integer>(Arrays.asList(leftPossibilities));
    }
  }

  if (pattern == 6) {
    switch(direction) {
    case "TOP":
      Integer[] topPossibilities = {0, 1, 3, 4, 5, 6, 9, 10};
      return new ArrayList<Integer>(Arrays.asList(topPossibilities));
    case "RIGHT":
      Integer[] rightPossibilities = {0, 3, 6, 8, 9, 12};
      return new ArrayList<Integer>(Arrays.asList(rightPossibilities));
    case "BOTTOM":
      Integer[] bottomPossibilities = {0, 1, 2, 3, 5, 6, 8, 11};
      return new ArrayList<Integer>(Arrays.asList(bottomPossibilities));
    case "LEFT":
      Integer[] leftPossibilities = {0, 5, 6, 10, 11, 12};
      return new ArrayList<Integer>(Arrays.asList(leftPossibilities));
    }
  }

  if (pattern == 7) {
    switch(direction) {
    case "TOP":
      Integer[] topPossibilities = {0, 2, 7, 8, 11, 12};
      return new ArrayList<Integer>(Arrays.asList(topPossibilities));
    case "RIGHT":
      Integer[] rightPossibilities = {0, 1, 2, 4, 5, 7, 10, 11};
      return new ArrayList<Integer>(Arrays.asList(rightPossibilities));
    case "BOTTOM":
      Integer[] bottomPossibilities = {0, 4, 7, 9, 10, 12};
      return new ArrayList<Integer>(Arrays.asList(bottomPossibilities));
    case "LEFT":
      Integer[] leftPossibilities = {0, 1, 2, 3, 7, 8, 9, 11};
      return new ArrayList<Integer>(Arrays.asList(leftPossibilities));
    }
  }

  if (pattern == 8) {
    switch(direction) {
    case "TOP":
      Integer[] topPossibilities = {0, 1, 3, 4, 5, 6, 9, 10};
      return new ArrayList<Integer>(Arrays.asList(topPossibilities));
    case "RIGHT":
      Integer[] rightPossibilities = {0, 1, 2, 4, 5, 7, 10, 11};
      return new ArrayList<Integer>(Arrays.asList(rightPossibilities));
    case "BOTTOM":
      Integer[] bottomPossibilities = {0, 4, 7, 9, 10, 12};
      return new ArrayList<Integer>(Arrays.asList(bottomPossibilities));
    case "LEFT":
      Integer[] leftPossibilities = {0, 5, 6, 10, 11, 12};
      return new ArrayList<Integer>(Arrays.asList(leftPossibilities));
    }
  }

  if (pattern == 9) {
    switch(direction) {
    case "TOP":
      Integer[] topPossibilities = {0, 2, 7, 8, 11, 12};
      return new ArrayList<Integer>(Arrays.asList(topPossibilities));
    case "RIGHT":
      Integer[] rightPossibilities = {0, 1, 2, 4, 5, 7, 10, 11};
      return new ArrayList<Integer>(Arrays.asList(rightPossibilities));
    case "BOTTOM":
      Integer[] bottomPossibilities = {0, 1, 2, 3, 5, 6, 8, 11};
      return new ArrayList<Integer>(Arrays.asList(bottomPossibilities));
    case "LEFT":
      Integer[] leftPossibilities = {0, 5, 6, 10, 11, 12};
      return new ArrayList<Integer>(Arrays.asList(leftPossibilities));
    }
  }

  if (pattern == 10) {
    switch(direction) {
    case "TOP":
      Integer[] topPossibilities = {0, 2, 7, 8, 11, 12};
      return new ArrayList<Integer>(Arrays.asList(topPossibilities));
    case "RIGHT":
      Integer[] rightPossibilities = {0, 3, 6, 8, 9, 12};
      return new ArrayList<Integer>(Arrays.asList(rightPossibilities));
    case "BOTTOM":
      Integer[] bottomPossibilities = {0, 1, 2, 3, 5, 6, 8, 11};
      return new ArrayList<Integer>(Arrays.asList(bottomPossibilities));
    case "LEFT":
      Integer[] leftPossibilities = {0, 1, 2, 3, 7, 8, 9, 11};
      return new ArrayList<Integer>(Arrays.asList(leftPossibilities));
    }
  }

  if (pattern == 11) {
    switch(direction) {
    case "TOP":
      Integer[] topPossibilities = {0, 1, 3, 4, 5, 6, 9, 10};
      return new ArrayList<Integer>(Arrays.asList(topPossibilities));
    case "RIGHT":
      Integer[] rightPossibilities = {0, 3, 6, 8, 9, 12};
      return new ArrayList<Integer>(Arrays.asList(rightPossibilities));
    case "BOTTOM":
      Integer[] bottomPossibilities = {0, 4, 7, 9, 10, 12};
      return new ArrayList<Integer>(Arrays.asList(bottomPossibilities));
    case "LEFT":
      Integer[] leftPossibilities = {0, 1, 2, 3, 7, 8, 9, 11};
      return new ArrayList<Integer>(Arrays.asList(leftPossibilities));
    }
  }

  if (pattern == 12) {
    switch(direction) {
    case "TOP":
      Integer[] topPossibilities = {0, 2, 7, 8, 11, 12};
      return new ArrayList<Integer>(Arrays.asList(topPossibilities));
    case "RIGHT":
      Integer[] rightPossibilities = {0, 3, 6, 8, 9, 12};
      return new ArrayList<Integer>(Arrays.asList(rightPossibilities));
    case "BOTTOM":
      Integer[] bottomPossibilities = {0, 4, 7, 9, 10, 12};
      return new ArrayList<Integer>(Arrays.asList(bottomPossibilities));
    case "LEFT":
      Integer[] leftPossibilities = {0, 5, 6, 10, 11, 12};
      return new ArrayList<Integer>(Arrays.asList(leftPossibilities));
    }
  }

  return new ArrayList<Integer>();
}

int getOppositePattern(int row, int col, String direction) {

  switch(direction) {
  case "TOP":
    if (row + 1 >= GRID_SIZE) {
      return -1;
    }
    return grid[row + 1][col].currentPattern;
  case "RIGHT":
    if (col - 1 < 0) {
      return -1;
    }
    return grid[row][col - 1].currentPattern;
  case "BOTTOM":
    if (row - 1 < 0) {
      return -1;
    }
    return grid[row - 1][col].currentPattern;
  case "LEFT":
    if (col + 1 >= GRID_SIZE) {
      return -1;
    }
    return grid[row][col + 1].currentPattern;
  default:
    return -1;
  }
}

String getOppositeDirection(String direction) {
  switch(direction) {
  case "TOP":
    return "BOTTOM";
  case "RIGHT":
    return "LEFT";
  case "BOTTOM":
    return "TOP";
  case "LEFT":
    return "RIGHT";
  default:
    return "";
  }
}

ArrayList<PropagationItem> propagationQueue = new ArrayList<>();

void propagate(int row, int col, String direction) {
  if (row < 0 || row >= GRID_SIZE || col < 0 || col >= GRID_SIZE) {
    return;
  }

  Tile neighborTile = grid[row][col];

  if (neighborTile.currentPattern != -1) {
    return;
  }

  ArrayList<Integer> compatiblePatterns = getAllPossibilities(getOppositePattern(row, col, direction), getOppositeDirection(direction));
  neighborTile.possibilities.retainAll(compatiblePatterns);

  if (neighborTile.possibilities.size() == 1) {
    int collapsedPattern = neighborTile.possibilities.get(0);
    neighborTile.collapse(collapsedPattern);

    propagationQueue.add(new PropagationItem(row - 1, col, "TOP"));
    propagationQueue.add(new PropagationItem(row + 1, col, "BOTTOM"));
    propagationQueue.add(new PropagationItem(row, col - 1, "RIGHT"));
    propagationQueue.add(new PropagationItem(row, col + 1, "LEFT"));
  }
}

void processPropagationQueue() {
  while (!propagationQueue.isEmpty()) {
    PropagationItem item = propagationQueue.remove(0);
    propagate(item.row, item.col, item.direction);
  }
}

int[] findTileWithLowestEntropy() {
  int minEntropy = Integer.MAX_VALUE;
  int selectedRow = -1;
  int selectedCol = -1;

  for (int row = 0; row < GRID_SIZE; row++) {
    for (int col = 0; col < GRID_SIZE; col++) {
      Tile tile = grid[row][col];

      if (tile.currentPattern != -1) {
        continue;
      }

      int entropy = tile.possibilities.size();

      if (entropy < minEntropy && entropy > 0) {
        minEntropy = entropy;
        selectedRow = row;
        selectedCol = col;
      }
    }
  }

  if (selectedRow != -1 && selectedCol != -1) {
    return new int[]{selectedRow, selectedCol};
  } else {
    return null; // All tiles are collapsed
  }
}

int getRandomPatternByRate(ArrayList<Integer> possibilities) {
  int totalWeight = 0;
  for (int pattern : possibilities) {
    totalWeight += RATES[pattern];
  }

  if (totalWeight == 0) {
    return 0;
  }

  int randomNumber = int(random(totalWeight));
  int cumulativeWeight = 0;

  for (int pattern : possibilities) {
    cumulativeWeight += RATES[pattern];
    if (randomNumber < cumulativeWeight) {
      return pattern;
    }
  }

  // Fallback in case of rounding errors
  return 0;
}

boolean isTileIsolated(int row, int col) {
  Tile currentTile = grid[row][col];

  if (currentTile.currentPattern == 12) {
    return false;
  }

  String currentPattern = PATTERNS[currentTile.currentPattern];

  String topEdge = getTopEdge(currentPattern);
  String rightEdge = getRightEdge(currentPattern);
  String bottomEdge = getBottomEdge(currentPattern);
  String leftEdge = getLeftEdge(currentPattern);

  boolean isConnected = false;

  if (row > 0 && !topEdge.equals("BBB")) {
    Tile topNeighbor = grid[row - 1][col];
    String topNeighborPattern = PATTERNS[topNeighbor.currentPattern];
    String topNeighborBottomEdge = getBottomEdge(topNeighborPattern);
    if (edgesAreConnected(topEdge, topNeighborBottomEdge)) {
      isConnected = true;
    }
  }

  if (!isConnected && col < GRID_SIZE - 1 && !rightEdge.equals("BBB")) {
    Tile rightNeighbor = grid[row][col + 1];
    String rightNeighborPattern = PATTERNS[rightNeighbor.currentPattern];
    String rightNeighborLeftEdge = getLeftEdge(rightNeighborPattern);
    if (edgesAreConnected(rightEdge, rightNeighborLeftEdge)) {
      isConnected = true;
    }
  }

  if (!isConnected && row < GRID_SIZE - 1 && !bottomEdge.equals("BBB")) {
    Tile bottomNeighbor = grid[row + 1][col];
    String bottomNeighborPattern = PATTERNS[bottomNeighbor.currentPattern];
    String bottomNeighborTopEdge = getTopEdge(bottomNeighborPattern);
    if (edgesAreConnected(bottomEdge, bottomNeighborTopEdge)) {
      isConnected = true;
    }
  }

  if (!isConnected && col > 0 && !leftEdge.equals("BBB")) {
    Tile leftNeighbor = grid[row][col - 1];
    String leftNeighborPattern = PATTERNS[leftNeighbor.currentPattern];
    String leftNeighborRightEdge = getRightEdge(leftNeighborPattern);
    if (edgesAreConnected(leftEdge, leftNeighborRightEdge)) {
      isConnected = true;
    }
  }

  return !isConnected;
}

void removeIsolatedTiles() {
  ArrayList<int[]> tilesToBlank = new ArrayList<>();

  for (int row = 0; row < GRID_SIZE; row++) {
    for (int col = 0; col < GRID_SIZE; col++) {
      if (isTileIsolated(row, col)) {
        tilesToBlank.add(new int[]{row, col});
      }
    }
  }

  for (int[] coords : tilesToBlank) {
    int row = coords[0];
    int col = coords[1];
    grid[row][col].collapse(12);

    propagationQueue.add(new PropagationItem(row, col, "TOP"));
    propagationQueue.add(new PropagationItem(row, col, "RIGHT"));
    propagationQueue.add(new PropagationItem(row, col, "BOTTOM"));
    propagationQueue.add(new PropagationItem(row, col, "LEFT"));
  }

  processPropagationQueue();
}

boolean isAdjacentToRoom(int row, int col) {
  Tile currentTile = grid[row][col];
  int[][] directions = {
    {row - 1, col},
    {row + 1, col},
    {row, col - 1},
    {row, col + 1}
  };

  for (int[] dir : directions) {
    int r = dir[0];
    int c = dir[1];

    if (r >= 0 && r < GRID_SIZE && c >= 0 && c < GRID_SIZE) {
      Tile neighborTile = grid[r][c];
      String direction = getDirection(row, col, r, c);
      if (isRoom(grid[r][c]) && isRoadConnected(currentTile, neighborTile, direction)) {
        return true;
      }
    }
  }

  return false;
}

void removeIsolatedRoads() {
  boolean[][] visited = new boolean[GRID_SIZE][GRID_SIZE];
  Queue<int[]> queue = new LinkedList<>();

  for (int row = 0; row < GRID_SIZE; row++) {
    for (int col = 0; col < GRID_SIZE; col++) {
      if (isRoad(grid[row][col]) && isAdjacentToRoom(row, col)) {
        queue.add(new int[]{row, col});
        visited[row][col] = true;
      }
    }
  }

  // BFS to mark all roads connected to rooms
  while (!queue.isEmpty()) {
    int[] current = queue.poll();
    int row = current[0];
    int col = current[1];
    Tile currentTile = grid[row][col];

    int[][] directions = {
      {row - 1, col},
      {row + 1, col},
      {row, col - 1},
      {row, col + 1}
    };

    for (int[] dir : directions) {
      int r = dir[0];
      int c = dir[1];
      if (r >= 0 && r < GRID_SIZE && c >= 0 && c < GRID_SIZE) {
        Tile neighborTile = grid[r][c];
        String direction = getDirection(row, col, r, c);
        if (isRoad(grid[r][c]) && !visited[r][c] && isRoadConnected(currentTile, neighborTile, direction)) {
          visited[r][c] = true;
          queue.add(new int[]{r, c});
        }
      }
    }
  }

  for (int row = 0; row < GRID_SIZE; row++) {
    for (int col = 0; col < GRID_SIZE; col++) {
      if (isRoad(grid[row][col]) && !visited[row][col]) {
        grid[row][col].collapse(12);
      }
    }
  }
}

boolean isRoom(Tile tile) {
  String pattern = PATTERNS[tile.currentPattern];
  for (char c : pattern.toCharArray()) {
    if (c != 'W' && c != 'E') {
      return false;
    }
  }
  return true;
}

// Graph representation using adjacency list
Map<Integer, Set<Integer>> dungeonGraph = new HashMap<>();
int roomCount = 0;
int[][] roomIDs = new int[GRID_SIZE][GRID_SIZE];

void identifyRooms() {
  for (int row = 0; row < GRID_SIZE; row++) {
    for (int col = 0; col < GRID_SIZE; col++) {
      if (isRoom(grid[row][col]) && roomIDs[row][col] == -1) {
        roomCount++;
        bfsAssignRoomID(row, col, roomCount);
      }
    }
  }

  println("Total Rooms Identified: " + roomCount);
}

void bfsAssignRoomID(int startRow, int startCol, int roomID) {
  Queue<int[]> queue = new LinkedList<>();
  queue.add(new int[]{startRow, startCol});
  roomIDs[startRow][startCol] = roomID;

  while (!queue.isEmpty()) {
    int[] current = queue.poll();
    int row = current[0];
    int col = current[1];

    int[][] directions = {
      {row - 1, col}, // TOP
      {row + 1, col}, // BOTTOM
      {row, col - 1}, // LEFT
      {row, col + 1}  // RIGHT
    };

    for (int[] dir : directions) {
      int r = dir[0];
      int c = dir[1];

      if (r >= 0 && r < GRID_SIZE && c >= 0 && c < GRID_SIZE) {
        if (isRoom(grid[r][c]) && roomIDs[r][c] == -1) {
          roomIDs[r][c] = roomID;
          queue.add(new int[]{r, c});
        }
      }
    }
  }
}

void buildDungeonGraph() {
  for (int i = 1; i <= roomCount; i++) {
    dungeonGraph.put(i, new HashSet<Integer>());
  }

  for (int row = 0; row < GRID_SIZE; row++) {
    for (int col = 0; col < GRID_SIZE; col++) {
      if (isRoom(grid[row][col])) {
        int currentRoomID = roomIDs[row][col];
        Tile currentTile = grid[row][col];

        int[][] directions = {
          {row - 1, col}, // TOP
          {row + 1, col}, // BOTTOM
          {row, col - 1}, // LEFT
          {row, col + 1}  // RIGHT
        };

        for (int[] dir : directions) {
          int r = dir[0];
          int c = dir[1];

          if (r >= 0 && r < GRID_SIZE && c >= 0 && c < GRID_SIZE) {
            Tile neighborTile = grid[r][c];
            String direction = getDirection(row, col, r, c);

            if (isRoad(neighborTile) && isRoadConnected(currentTile, neighborTile, direction)) {
              // Perform BFS to find all connected rooms via roads
              Set<Integer> connectedRooms = bfsFindConnectedRooms(r, c);

              for (int connectedRoomID : connectedRooms) {
                if (connectedRoomID != currentRoomID) {
                  dungeonGraph.get(currentRoomID).add(connectedRoomID);
                  dungeonGraph.get(connectedRoomID).add(currentRoomID);
                }
              }
            }
          }
        }
      }
    }
  }

  println("Dungeon Graph Built with " + roomCount + " rooms.");
}

boolean isRoad(Tile tile) {
  String pattern = PATTERNS[tile.currentPattern];
  boolean hasW = false;
  boolean hasB = false;

  for (char c : pattern.toCharArray()) {
    if (c == 'W') hasW = true;
    if (c == 'B') hasB = true;
    if (hasW && hasB) return true;
  }
  return false;
}

boolean isRoadConnected(Tile currentTile, Tile neighborTile, String direction) {
  String currentPattern = PATTERNS[currentTile.currentPattern];
  String neighborPattern = PATTERNS[neighborTile.currentPattern];

  switch(direction) {
  case "TOP":
    if (getTopEdge(currentPattern).charAt(1) != 'W' || getBottomEdge(neighborPattern).charAt(1) != 'W') {
      return false;
    }
    break;
  case "RIGHT":
    if (getRightEdge(currentPattern).charAt(1) != 'W' || getLeftEdge(neighborPattern).charAt(1) != 'W') {
      return false;
    }
    break;
  case "BOTTOM":
    if (getBottomEdge(currentPattern).charAt(1) != 'W' || getTopEdge(neighborPattern).charAt(1) != 'W') {
      return false;
    }
    break;
  case "LEFT":
    if (getLeftEdge(currentPattern).charAt(1) != 'W' || getRightEdge(neighborPattern).charAt(1) != 'W') {
      return false;
    }
    break;
  default:
    return false;
  }

  return true;
}

Set<Integer> bfsFindConnectedRooms(int startRow, int startCol) {
  Set<Integer> connectedRooms = new HashSet<>();
  boolean[][] visited = new boolean[GRID_SIZE][GRID_SIZE];
  Queue<int[]> queue = new LinkedList<>();
  queue.add(new int[]{startRow, startCol});
  visited[startRow][startCol] = true;

  while (!queue.isEmpty()) {
    int[] current = queue.poll();
    int row = current[0];
    int col = current[1];
    Tile currentTile = grid[row][col];

    int[][] directions = {
      {row - 1, col}, // TOP
      {row + 1, col}, // BOTTOM
      {row, col - 1}, // LEFT
      {row, col + 1}  // RIGHT
    };

    for (int[] dir : directions) {
      int r = dir[0];
      int c = dir[1];

      if (r >= 0 && r < GRID_SIZE && c >= 0 && c < GRID_SIZE && !visited[r][c]) {
        Tile neighborTile = grid[r][c];
        String direction = getDirection(row, col, r, c);
        if (isRoad(neighborTile) && isRoadConnected(currentTile, neighborTile, direction)) {
          visited[r][c] = true;
          queue.add(new int[]{r, c});
        } else if (isRoom(neighborTile) && isRoadConnected(currentTile, neighborTile, direction)) {
          connectedRooms.add(roomIDs[r][c]);
        }
      }
    }
  }

  return connectedRooms;
}

String getDirection(int row, int col, int r, int c) {
  if (row == r) {
    if (col < c) {
      return "RIGHT";
    } else {
      return "LEFT";
    }
  } else {
    if (row < r) {
      return "BOTTOM";
    } else {
      return "TOP";
    }
  }
}

void removeIsolatedRoomsFromGraph() {
  Set<Integer> isolatedRooms = new HashSet<>();

  for (Map.Entry<Integer, Set<Integer>> entry : dungeonGraph.entrySet()) {
    if (entry.getValue().isEmpty()) {
      isolatedRooms.add(entry.getKey());
    }
  }

  for (int roomID : isolatedRooms) {
    dungeonGraph.remove(roomID);
    println("Removed isolated room with ID: " + roomID);

    for (Set<Integer> connections : dungeonGraph.values()) {
      connections.remove(roomID);
    }

    blankOutRoom(roomID);
  }
}

void blankOutRoom(int roomID) {
  for (int row = 0; row < GRID_SIZE; row++) {
    for (int col = 0; col < GRID_SIZE; col++) {
      if (roomIDs[row][col] == roomID) {
        grid[row][col].collapse(12);

        propagationQueue.add(new PropagationItem(row, col, "TOP"));
        propagationQueue.add(new PropagationItem(row, col, "RIGHT"));
        propagationQueue.add(new PropagationItem(row, col, "BOTTOM"));
        propagationQueue.add(new PropagationItem(row, col, "LEFT"));
      }
    }
  }

  processPropagationQueue();
}

ArrayList<RoomNode> roomNodes = new ArrayList<RoomNode>();


void generateRoomPositions() {
  roomNodes.clear();

  for (int roomID = 1; roomID <= roomCount; roomID++) {
    float sumX = 0;
    float sumY = 0;
    int tileCount = 0;

    for (int row = 0; row < GRID_SIZE; row++) {
      for (int col = 0; col < GRID_SIZE; col++) {
        if (roomIDs[row][col] == roomID) {
          // Calculate screen coordinates based on grid position
          float x = 100 + col * 60 + 30; // 100 is initX, 60 is tile size, +30 centers the node
          float y = 100 + row * 60 + 30; // 100 is initY
          sumX += x;
          sumY += y;
          tileCount++;
        }
      }
    }

    if (tileCount > 0) {
      float avgX = sumX / tileCount;
      float avgY = sumY / tileCount;
      roomNodes.add(new RoomNode(roomID, new PVector(avgX, avgY)));
    }
  }

  println("Room Positions Generated: " + roomNodes.size());
}

void drawDungeonGraph() {
  stroke(40, 42, 54);
  strokeWeight(2);

  // Draw edges
  for (Map.Entry<Integer, Set<Integer>> entry : dungeonGraph.entrySet()) {
    int fromRoomID = entry.getKey();
    RoomNode fromNode = getRoomNodeByID(fromRoomID);

    for (int toRoomID : entry.getValue()) {
      RoomNode toNode = getRoomNodeByID(toRoomID);
      if (fromNode != null && toNode != null) {
        line(fromNode.position.x, fromNode.position.y, toNode.position.x, toNode.position.y);
      }
    }
  }

  // Draw nodes
  noStroke();
  for (RoomNode node : roomNodes) {
    fill(node.roomColor); // Use the room's assigned color
    ellipse(node.position.x, node.position.y, 20, 20);

    fill(248, 248, 242);
    textAlign(CENTER, CENTER);
    text(node.roomID, node.position.x, node.position.y);
  }
}

RoomNode getRoomNodeByID(int roomID) {
  for (RoomNode node : roomNodes) {
    if (node.roomID == roomID) {
      return node;
    }
  }
  return null;
}

void colorGraphWelshPowell() {
  List<RoomNode> sortedRooms = new ArrayList<RoomNode>(roomNodes);
  sortedRooms.sort((a, b) -> {
    Set<Integer> degreeASet = dungeonGraph.get(a.roomID);
    Set<Integer> degreeBSet = dungeonGraph.get(b.roomID);
    int degreeA = (degreeASet != null) ? degreeASet.size() : 0;
    int degreeB = (degreeBSet != null) ? degreeBSet.size() : 0;
    return Integer.compare(degreeB, degreeA);
  }
  );

  for (RoomNode node : sortedRooms) {
    boolean[] available = new boolean[COLOR_PALETTE.length];
    Arrays.fill(available, true);

    Set<Integer> adjacentRooms = dungeonGraph.get(node.roomID);
    if (adjacentRooms != null) {
      for (int adjacentID : adjacentRooms) {
        RoomNode adjacentNode = getRoomNodeByID(adjacentID);
        if (adjacentNode != null && adjacentNode.roomColor != color(40, 42, 54)) {
          for (int i = 0; i < COLOR_PALETTE.length; i++) {
            if (adjacentNode.roomColor == COLOR_PALETTE[i]) {
              available[i] = false;
            }
          }
        }
      }
    }

    boolean colorAssigned = false;
    for (int i = 0; i < available.length; i++) {
      if (available[i]) {
        node.roomColor = COLOR_PALETTE[i];
        colorAssigned = true;
        break;
      }
    }

    if (!colorAssigned) {
      println("No available color for Room ID: " + node.roomID + ". Assigning default color.");
      node.roomColor = color(255, 255, 255); // Assign default color (white)
    }
  }

  println("Welsh-Powell Graph Coloring Completed with " + COLOR_PALETTE.length + " colors.");
}

void colorGraphWelshPowellWithCount(int desiredColorCount) {
  List<RoomNode> sortedRooms = new ArrayList<RoomNode>(roomNodes);
  sortedRooms.sort((a, b) -> {
    Set<Integer> degreeASet = dungeonGraph.get(a.roomID);
    Set<Integer> degreeBSet = dungeonGraph.get(b.roomID);
    int degreeA = (degreeASet != null) ? degreeASet.size() : 0;
    int degreeB = (degreeBSet != null) ? degreeBSet.size() : 0;
    return Integer.compare(degreeB, degreeA);
  }
  );

  int[] colorUsage = new int[desiredColorCount];

  for (RoomNode node : sortedRooms) {
    boolean[] available = new boolean[desiredColorCount];
    Arrays.fill(available, true);

    Set<Integer> adjacentRooms = dungeonGraph.get(node.roomID);
    if (adjacentRooms != null) {
      for (int adjacentID : adjacentRooms) {
        RoomNode adjacentNode = getRoomNodeByID(adjacentID);
        if (adjacentNode != null && adjacentNode.roomColor != color(40, 42, 54)) {
          for (int i = 0; i < desiredColorCount; i++) {
            if (adjacentNode.roomColor == COLOR_PALETTE[i]) {
              available[i] = false;
            }
          }
        }
      }
    }

    int selectedColorIndex = -1;
    int minUsage = Integer.MAX_VALUE;
    for (int i = 0; i < desiredColorCount; i++) {
      if (available[i] && colorUsage[i] < minUsage) {
        selectedColorIndex = i;
        minUsage = colorUsage[i];
      }
    }

    if (selectedColorIndex == -1) {
      println("No available color within the desired count for Room ID: " + node.roomID + ". Assigning default color.");
      node.roomColor = color(255, 255, 255); // Assign default color (white)
    } else {
      node.roomColor = COLOR_PALETTE[selectedColorIndex];
      colorUsage[selectedColorIndex]++;
    }
  }

  println("Welsh-Powell Graph Coloring Completed with " + desiredColorCount + " colors.");
}

void initializeDungeonGraphKeys() {
  for (RoomNode node : roomNodes) {
    if (!dungeonGraph.containsKey(node.roomID)) {
      dungeonGraph.put(node.roomID, new HashSet<Integer>());
    }
  }
}


Tile[][] grid = new Tile[GRID_SIZE][GRID_SIZE];

void setup() {
  fullScreen();

  for (int i = 0; i < GRID_SIZE; i++) {
    for (int j = 0; j < GRID_SIZE; j++) {
      grid[i][j] = new Tile();
    }
  }

  for (int i = 0; i < GRID_SIZE; i++) {
    for (int j = 0; j < GRID_SIZE; j++) {
      roomIDs[i][j] = -1;
    }
  }

  int randomRow = int(random(GRID_SIZE));
  int randomCol = int(random(GRID_SIZE));
  grid[randomRow][randomCol].collapse(getRandomPatternByRate(grid[randomRow][randomCol].possibilities));

  propagate(randomRow - 1, randomCol, "TOP");
  propagate(randomRow + 1, randomCol, "BOTTOM");
  propagate(randomRow, randomCol - 1, "RIGHT");
  propagate(randomRow, randomCol + 1, "LEFT");

  processPropagationQueue(); // Ensure initial propagation is processed
}

void draw() {
  background(40, 42, 54);

  if (propagationQueue.isEmpty()) {
    int tilesToProcess = 1;
    for (int n = 0; n < tilesToProcess; n++) {
      int[] coords = findTileWithLowestEntropy();
      if (coords == null) {
        println("WFC Complete");
        identifyRooms();       
        buildDungeonGraph();   
        generateRoomPositions();
        removeIsolatedRoomsFromGraph(); 
        removeIsolatedTiles(); 
        removeIsolatedRoads();
        initializeDungeonGraphKeys();
        generateRoomPositions();
        //colorGraphWelshPowell();
        colorGraphWelshPowellWithCount(6);
        drawDungeonGraph();
        noLoop();
        break;
      }
      grid[coords[0]][coords[1]].collapse(getRandomPatternByRate(grid[coords[0]][coords[1]].possibilities));
      propagate(coords[0] - 1, coords[1], "TOP");
      propagate(coords[0] + 1, coords[1], "BOTTOM");
      propagate(coords[0], coords[1] - 1, "RIGHT");
      propagate(coords[0], coords[1] + 1, "LEFT");
      processPropagationQueue();
    }
  }

  drawGrid(100, 100);

  drawDungeonGraph();
}
