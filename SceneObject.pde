public class SceneObject implements IDrawable, IUpdateable {
  protected Vector3f position = new Vector3f(); 
  protected Vector3f rotation = new Vector3f();
  protected int blendingMode = NORMAL;
  protected boolean doDraw = true;
  protected boolean doUpdate = true;

  protected int objectId = -1;
  
  protected String objectName = "NIL";

  public SceneObject setBlendMode(int pBlendMode) {
    this.blendingMode = pBlendMode;
    return this;
  }

  public SceneObject setPosition(Vector3f pPosition) {
    this.position = pPosition;
    return this;
  }
  
  public SceneObject setPosition(float x, float y, float z) {
    this.position = new Vector3f(x, y, z);
    return this;
  }

  public SceneObject setDoDraw(boolean pDoDraw) {
    this.doDraw = pDoDraw;
    return this;
  }

  public SceneObject setDoUpdate(boolean pDoUpdate) {
    this.doUpdate = pDoUpdate;
    return this;
  }

  //Sets the objects ID, this can only be done once, to prevent collisions down the line.
  //returns true if successful, false otherwise.
  public boolean setObjectId(int pId) {
    if (objectId == -1) {
      objectId = pId;
      return true;
    } else {
      return false;
    }
  }
  
  public SceneObject setObjectName(String pName) {
    if (objectName == "NIL")
      this.objectName = pName;
    return this;
  }

  public boolean getDoDraw() {
    return doDraw;
  }

  public boolean getDoUpdate() {
    return doUpdate;
  }

  public int getObjectId() {
    return objectId;
  }
  
  public String getObjectName() {
    return objectName; 
  }
  
  public Vector3f getPosition() {
     return position; 
  }

  public void update() {
  }

  public void draw() {
  }
}

public interface IDrawable {
  public void draw(); 
  public boolean getDoDraw();
}

public interface IUpdateable {
  public void update();
  public boolean getDoUpdate();
}
