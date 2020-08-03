public interface IKeyEvent {
  public void trigger(App appInstance);
}

public class KeyEventExitApp implements IKeyEvent {
  public void trigger(App appInstance) {
    exit();
  }
}

public class KeyEventHideAlien implements IKeyEvent {
  public void trigger(App appInstance) {
    SceneObject alienPlanet = appInstance.getSceneObjectByName("Alien");
    if (alienPlanet != null) {
      //Toggle drawing on planet.
      alienPlanet.setDoDraw(!alienPlanet.getDoDraw());
    }
  }
}

public class KeyEventToggleStroke implements IKeyEvent {

  public void trigger(App appInstance) {
    //Toggle stroke drawing
    appInstance.setDrawStroke(!appInstance.getDrawStroke());
    //Add label to scene to notify user action has been taken.
    appInstance.addObjectToScene(new Text(appInstance.getDrawStroke() ? "Enabling Wireframes.." : "Disabling Wireframes..")
      .setFillColor(color(0, 255, 255))
      .setAlignment(CENTER, CENTER)
      .setPosition(new Vector3f(385, 310, 250))
      .setDoDraw(true));
    //Tell app to reset the scene.
    appInstance.flagSceneReset();
  }
}

public class KeyEventSetPointLightWhite implements IKeyEvent {
  public void trigger(App appInstance) {
    PointLight obj = (PointLight)appInstance.getSceneObjectByName("PointLightOne");
    if (obj != null) {
      obj.setColorAnimation(new Vector4f(0, 0, 0, 0));
      obj.setColor(255, 255, 255);
    }
  }
}

public class KeyEventSetPointLightRed implements IKeyEvent {
  public void trigger(App appInstance) {
    PointLight obj = (PointLight)appInstance.getSceneObjectByName("PointLightOne");
    if (obj != null) {
      obj.setColorAnimation(new Vector4f(0, 0, 0, 0));
      obj.setColor(255, 0, 0);
    }
  }
}

public class KeyEventSetPointLightGreen implements IKeyEvent {
  public void trigger(App appInstance) {
    PointLight obj = (PointLight)appInstance.getSceneObjectByName("PointLightOne");
    if (obj != null) {
      obj.setColorAnimation(new Vector4f(0, 0, 0, 0));
      obj.setColor(0, 255, 0);
    }
  }
}

public class KeyEventSetPointLightBlue implements IKeyEvent {
  public void trigger(App appInstance) {
    PointLight obj = (PointLight)appInstance.getSceneObjectByName("PointLightOne");
    if (obj != null) {
      obj.setColorAnimation(new Vector4f(0, 0, 0, 0));
      obj.setColor(0, 0, 255);
    }
  }
}

public static class MovementController {
  private static float translationDistance = 5f;

  private static String objToControl = "PointLightOne";

  public static void moveLeft(App appInstance) {
    translateObject(appInstance, objToControl, -translationDistance, 0, 0);
  }

  public static void moveRight(App appInstance) {
    translateObject(appInstance, objToControl, translationDistance, 0, 0);
  }

  public static void moveUp(App appInstance) {
    translateObject(appInstance, objToControl, 0, -translationDistance, 0);
  }

  public static void moveDown(App appInstance) {
    translateObject(appInstance, objToControl, 0, translationDistance, 0);
  }

  public static void moveTowards(App appInstance) {
    translateObject(appInstance, objToControl, 0, 0, -translationDistance);
  }

  public static void moveAway(App appInstance) {
    translateObject(appInstance, objToControl, 0, 0, translationDistance);
  }


  private static void translateObject(App appInstance, String objName, float x, float y, float z) {
    SceneObject obj = appInstance.getSceneObjectByName(objName);
    if (obj != null) {
      obj.setPosition(obj.getPosition().getX() + x, obj.getPosition().getY() + y, obj.getPosition().getZ() + z);
      println(obj.getPosition().toString());
    }
  }
}

public class KeyEventMoveLeft implements IKeyEvent {
  public void trigger(App appInstance) {
    MovementController.moveLeft(appInstance);
  }
}

public class KeyEventMoveRight implements IKeyEvent {
  public void trigger(App appInstance) {
    MovementController.moveRight(appInstance);
  }
}

public class KeyEventMoveUp implements IKeyEvent {
  public void trigger(App appInstance) {
    MovementController.moveUp(appInstance);
  }
}

public class KeyEventMoveDown implements IKeyEvent {
  public void trigger(App appInstance) {
    MovementController.moveDown(appInstance);
  }
}

public class KeyEventMoveTowards implements IKeyEvent {
  public void trigger(App appInstance) {
    MovementController.moveTowards(appInstance);
  }
}

public class KeyEventMoveAway implements IKeyEvent {
  public void trigger(App appInstance) {
    MovementController.moveAway(appInstance);
  }
}
