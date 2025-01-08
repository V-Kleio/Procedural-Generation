import java.util.*;

// L-System Parameters
String axiom = "VZFFF";
String sentence = axiom;
float angle = 90; // Rotation angle in degrees
int iterations = 8;
int len = 5;

// L-System Rules
Map<Character, String> rules = new HashMap<Character, String>() {{
  put('F', "F+F-F-");
}};


void setup() {
  fullScreen();
  background(40, 42, 54);
  strokeWeight(2);
  stroke(248, 248, 242);
  
  generate();

  Drawer pen = new Drawer(width / 2, height / 2 - 200, 0);

  drawLSystem(pen);
}

void draw() {
  noLoop();
}

void generate() {
  for (int i = 0; i < iterations; i++) {
    String next = "";
    for (char c : sentence.toCharArray()) {
      if (rules.containsKey(c)) {
        next += rules.get(c);
      } else {
        next += c;
      }
    }
    sentence = next;
  }
}

void drawLSystem(Drawer pen) {
  Stack<Drawer.State> stack = new Stack<Drawer.State>();

  for (char cmd : sentence.toCharArray()) {
    if (cmd == 'F') {
      float rad = radians(pen.angle);
      float newX = pen.x + len * cos(rad);
      float newY = pen.y + len * sin(rad);
      line(pen.x, pen.y, newX, newY);
      pen.x = newX;
      pen.y = newY;
    } else if (cmd == '+') {
      pen.angle += angle;
    } else if (cmd == '-') {
      pen.angle -= angle;
    } else if (cmd == '[') {
      stack.push(pen.getState());
    } else if (cmd == ']') {
      if (!stack.isEmpty()) {
        Drawer.State state = stack.pop();
        pen.setState(state);
      }
    }
  }
}

class Drawer {
  float x, y; // Current position
  float angle; // Current angle in degrees

  Drawer(float x, float y, float angle) {
    this.x = x;
    this.y = y;
    this.angle = angle;
  }

  State getState() {
    return new State(x, y, angle);
  }

  void setState(State s) {
    this.x = s.x;
    this.y = s.y;
    this.angle = s.angle;
  }

  class State {
    float x, y;
    float angle;

    State(float x, float y, float angle) {
      this.x = x;
      this.y = y;
      this.angle = angle;
    }
  }
}
