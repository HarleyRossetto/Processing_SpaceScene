public class Vector3f {
  protected float x, y, z = 0;
  
  public Vector3f() {
  
  }
  
  public Vector3f(float pX, float pY, float pZ) {
     x = pX;
     y = pY;
     z = pZ;
  }
  
  public void set(float pX, float pY, float pZ) {
    x = pX;
    y = pY;
    z = pZ;
  }
  
  public float getX() {
    return x;
  }
  
  public float getY() {
    return y;
  }
  
  public float getZ() {
    return z;
  }
  
  public String toString() {
     return "{" + x + ", " + y + ", " + z + "}";
  }
}

public class Vector4f {
  protected float w, x, y, z = 0;
  
  public Vector4f() {
  
  }
  
  public Vector4f(float pW, float pX, float pY, float pZ) {
    w = pW;
    x = pX;
    y = pY;
    z = pZ;
  }
  
  public float getW() {
    return w; 
  }
  
  public float getX() {
    return x;
  }
  
  public float getY() {
    return y;
  }
  
  public float getZ() {
    return z;
  }
}
