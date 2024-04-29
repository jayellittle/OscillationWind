// oscillation4

float m;
float x, y;
float vx, vy;
float fx, fy;

float radius;

float xPrev, yPrev;
float vxPrev, vyPrev;
float fxPrev, fyPrev;

float k = 100.0;
float l0 = 0.2;
float d = 0.5;
float gx = 0.0;
float gy = 9.8;

float dt = 0.01;

float ms;
float wx = 0.0;
float wy = 0.0;

float viewingSize = 0.5;

int xOffset;
int yOffset;
float viewingScale;

void setup() {
  size(512, 512);
  frameRate(60);
  smooth(4);
  
  xOffset = width / 2;
  yOffset = 0;
  viewingScale = width / viewingSize;
  
  m = 0.5;
  x = 0.05;
  y = 0.2;
  vx = 0.0;
  vy = 0.0;
  fx = 0.0;
  fy = 0.0;
  
  radius = 0.05;
  
  xPrev = x;
  yPrev = y;
  vxPrev = vx;
  vyPrev = vy;
  fxPrev = fx;
  fyPrev = fy;
}

void strokeWeightScaled(float s) {
  strokeWeight(s / viewingScale);
}

void keyPressed() {
  if (key == ESC || key == 'q') {
    exit();
  }
}

void draw() {
  ms = float(millis()) / 1000;
  wx = 10 * abs(sin(ms));
  
  float l = sqrt(x*x + y*y);
  float ex = x / l;
  float ey = y / l;
  fx = -k*(l-l0)*ex - d*vx + m*wx;
  fy = -k*(l-l0)*ey - d*vy + m*gy;
  float xNew = x + ((3*vx)/2 - vxPrev/2)*dt;
  float yNew = y + ((3*vy)/2 - vyPrev/2)*dt;
  float vxNew = vx + ((3*fx)/2 - fxPrev/2)*(dt/m);
  float vyNew = vy + ((3*fy)/2 - fyPrev/2)*(dt/m);
  
  xPrev = x;
  yPrev = y;
  vxPrev = vx;
  vyPrev = vy;
  fxPrev = fx;
  fyPrev = fy;
  
  x = xNew;
  y = yNew;
  vx = vxNew;
  vy = vyNew;
  
  ellipseMode(RADIUS);
  background(255);
  
  translate(xOffset, yOffset);
  scale(viewingScale);
  
  fill(224);
  stroke(128);
  strokeWeightScaled(1.0);
  
  line(0, 0, x, y);
  translate(x, y);
  ellipse(0, 0, radius, radius);
}
