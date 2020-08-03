App myApp;

void setup() {
  //Set window size and enable 3D render
  size(800, 480, P3D);
  //Set pixel density according to device.
  pixelDensity(displayDensity());
  //Initialise our app object.
  myApp = new App();
}

//Render Callback
void draw() {  
  myApp.runAppLoop();
}

//Mouse click callback.
void mouseClicked() {
  myApp.mouseClickCallback();
}

//Key pressed callback
void keyPressed() {
  println("Key: " + key + " #" +(int)key);
  myApp.keypressedCallback();
}
