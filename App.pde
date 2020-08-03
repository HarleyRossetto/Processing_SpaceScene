public final class App { 

  //HashMap containing ID - SceneObject pairs.
  private HashMap<String, SceneObject> sceneObjectHashMap = new HashMap<String, SceneObject>(10);
  //HashMap containing Key - Event callback pairs.
  private HashMap<Integer, IKeyEvent> keyEventCallbackMap = new HashMap<Integer, IKeyEvent>(5);

  //Global drawStroke (wireframe because 3D) flag.
  private boolean drawStroke = false;

  //Flag for signifiying that we want to reset the scene.
  private boolean resetScene = false;
  //Flag that allows us to delay the reset for one cycle.
  //We use this to delay one cycle so that our message to user notifying them the scene is being reloaded
  //is drawn once before the scene is reset.
  private boolean delayResetCycle = false;

  //Constant variable for determining base size of earth object.
  private final float earthBaseSize = 150;

  //App constructor
  public App() {
    //Load our desired font. 
    textFont(createFont("FiraCode-Regular.ttf", 8));
    //Create our scene.
    createScene();
    //Initialise our key press callbacks.
    initialiseKeyCallbacks();
  }

  //App update loop.
  public void runAppLoop() {
    //Update Scene Objects
    for (IUpdateable updateable : sceneObjectHashMap.values()) {
      if (updateable.getDoUpdate())
        updateable.update();
    }

    //Clear the pixel buffer.
    clear();

    //Set background to mid grey.
    background(127);

    //Enable lights
    lights();

    //Disable lights for drawing skybox
    for (IDrawable drawable : sceneObjectHashMap.values()) {
      if (drawable.getDoDraw())
        drawable.draw();
    }

    //If a scene reset is requested and we have already delayed once cycle clear and recreate the scene.
    //Otherwise if the scene reset is requested and we have not delayed a cycle set flag that we have completed a cycle.
    if (resetScene) {
      if (!delayResetCycle) {
        delayResetCycle = true;
      } else {
        //Toggle resetScene flag
        resetScene = !resetScene;
        //Clear delayResetCycle flag
        delayResetCycle = false;
        //Clear our scene.
        clearScene();
        //Print message to console, it takes us a good few seconds to reload the scene textures, so notify the user something is happening.
        println("Hold tight! Reloading textures takes a few...");
        //Create our scene.
        createScene();
      }
    }
  }

  //Clears the scene object hashmap. 
  //Reset the IDAllocator (no longer used)
  //Resets renderer fill color to white.
  protected void clearScene() {
    sceneObjectHashMap.clear();
    IDAllocator.resetAllocator();
    fill(0xffffffff);
  }

  //Called to populate our SceneObject Hashmap.
  protected void createScene() {  
    //Setup Lights
    addObjectToScene(new PointLight(255, 127, 0, new Vector3f(100, 240, 200))
      .setColorAnimation(new Vector4f(1f, 1f, 1f, 1f))
      .setObjectName("PointLightOne"));

    //Skybox
    addObjectToScene(new TexturedSphere("Stars_1K.jpg", 1000, color(27, 27, 27), drawStroke)
      .setRotationAnimation(new Vector4f(0.0f, 0.025f, 0.025f, 0.0f))
      .setPosition(new Vector3f(320f, 240f, 0f))
      .setObjectName("Skybox"));

    //Earth Diffuse  
    addObjectToScene(new TexturedSphere("Earth_Diffuse_6K.jpg", earthBaseSize, color(30, 230, 30), drawStroke)
      .setRotationAnimation(new Vector4f(0.0f, 0.0f, 0.025f, 0.0f))
      .setPosition(new Vector3f(320f, 240f, 100f))
      .setObjectName("EarthDiffuse"));
    //Clouds               
    addObjectToScene(new TexturedSphere("Earth_Clouds_6K.jpg", earthBaseSize + 2, color(200, 200, 200, 40), drawStroke)
      .setRotationAnimation(new Vector4f(0.0f, 0.0f, -0.0025f, 0.0f))
      .setPosition(new Vector3f(320f, 240f, 100f))
      .setBlendMode(SCREEN)
      .setObjectName("EarthClouds"));

    //Earth Lights
    addObjectToScene(new TexturedSphere("Earth_Illumination_6K.jpg", earthBaseSize + 4, color(255, 0, 0, 255), drawStroke)
      .setRotationAnimation(new Vector4f(0.0f, 0.0f, 0.025f, 0.0f))
      .setPosition(new Vector3f(320f, 240f, 100f))
      .setBlendMode(ADD)
      .setObjectName("EarthLights"));

    //Alien Planet                
    addObjectToScene(new TexturedSphere("Planet_4K.jpg", 20, color(0, 200, 35), drawStroke)
      .setRotationAnimation(new Vector4f(0.0f, 0.1f, -0.025f, 0.0f))
      .setPosition(new Vector3f(420f, 250f, 300f))
      .setObjectName("Alien"));

    //FPS Counter
    addObjectToScene(new Text("FPS: ")
      .setPosition(new Vector3f(245, 152, 250))
      .setObjectName("Text_FPSCounterLabel"));

    addObjectToScene(new Text("00")
      .setTextAnimation(new TextFPSAnimation())
      .setPosition(new Vector3f(268, 152, 250))
      .setDoDraw(true)
      .setObjectName("Text_FPSCounter"));

    //Wireframe prompt
    addObjectToScene(new Text("Press 's' to \n toggle wireframes")
      .setFillColor(color(255, 0, 255))
      .setAlignment(RIGHT, TOP)
      .setPosition(new Vector3f(550, 152, 250))
      .setDoDraw(true)
      .setObjectName("Text_WireframePrompt"));
  }

  //Registers key events/app events to their respective key codes.
  private void initialiseKeyCallbacks() {
    //Press 'Q' or 'q' to exit/quit
    addKeyCallback((int)'Q', new KeyEventExitApp());
    addKeyCallback((int)'q', new KeyEventExitApp());

    //Add toggle stroke event to 's' key
    addKeyCallback((int)'s', new KeyEventToggleStroke());

    //Add toggle visibility event for alien planet to 'a' key
    addKeyCallback((int)'a', new KeyEventHideAlien());

    //Set light colors
    addKeyCallback((int)'r', new KeyEventSetPointLightRed());
    addKeyCallback((int)'g', new KeyEventSetPointLightGreen());
    addKeyCallback((int)'b', new KeyEventSetPointLightBlue());
    addKeyCallback((int)'w', new KeyEventSetPointLightWhite());

    //Movement
    addKeyCallback((int)'i', new KeyEventMoveUp());
    addKeyCallback((int)'k', new KeyEventMoveDown());
    addKeyCallback((int)'j', new KeyEventMoveLeft());
    addKeyCallback((int)'l', new KeyEventMoveRight());
    addKeyCallback((int)'u', new KeyEventMoveTowards());
    addKeyCallback((int)'o', new KeyEventMoveAway());
  }

  //Adds keycode/key event pairs to the Key Event Hashmap
  public void addKeyCallback(int keyCode, IKeyEvent pKeyEvent) {
    keyEventCallbackMap.put(keyCode, pKeyEvent);
  }

  //Raises scene reset flag.
  public void flagSceneReset() {
    resetScene = true;
  }

  //Gets the current global draw stroke/wireframe flag.
  public boolean getDrawStroke() {
    return drawStroke;
  }

  //Sets the global draw stroke/wireframe flag to desired value.
  public void setDrawStroke(boolean pDrawStroke) {
    drawStroke = pDrawStroke;
  }

  //Adds a object to the scene.
  //Allocates an ID prior to storage, returns ID for reference.
  /*
  public int addObjectToScene(SceneObject obj) {
   int id = IDAllocator.allocateId();
   obj.setObjectId(id);
   sceneObjectHashMap.put((str(id), obj);
   return id;
   }
   */

  //Adds a object to the scene using string identifier system
  public String addObjectToScene(SceneObject obj) {
    sceneObjectHashMap.put(obj.getObjectName(), obj);
    return obj.getObjectName();
  }

  //Used to retrieve scene object from hashmap by its name. 
  //Will return null object if value does not exist.
  public SceneObject getSceneObjectByName(String pName) {
    SceneObject returnable = null;
    if (sceneObjectHashMap.containsKey(pName))
      returnable = sceneObjectHashMap.get(pName);
    return returnable;
  }

  //Key Event/press callback.
  public void keypressedCallback() {
    //Look and see if the key map contains the pressed key.
    if (keyEventCallbackMap.containsKey((int)key)) {
      //Print out the name of the class the is paired to the key.
      println(keyEventCallbackMap.get((int)key).getClass().toString());
      //Call/trigger the key event callback.
      keyEventCallbackMap.get((int)key).trigger(this);
    }
  }

  //Key Event/press callback.
  public void mouseClickCallback() {
  }
}
