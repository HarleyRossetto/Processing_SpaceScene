public class PointLight extends SceneObject {

  protected int lightColor;
  protected int red, green, blue = 0;

  protected Vector4fAnimation positionAnimation = new Vector4fAnimation();
  protected Vector4fAnimation colorAnimation = new Vector4fAnimation();

  public PointLight() { 
    super();
  }

  public PointLight(int pRed, int pGreen, int pBlue) {
    red = pRed;
    green = pGreen;
    blue = pBlue;
    position = new Vector3f();
  }

  public PointLight(int pRed, int pGreen, int pBlue, Vector3f pPosition) {
    red = pRed;
    green = pGreen;
    blue = pBlue;
    position = pPosition;
  }

  public void update() {
    Vector4f cAnimation = colorAnimation.update(new Vector4f(0.0f, (float)red, (float)green, (float)blue));
    Vector4f tAnimation = positionAnimation.update(new Vector4f(0.0f, position.getX(), position.getY(), position.getZ()));

    red = (int)cAnimation.getX() > 255 ? 0 : (int)cAnimation.getX();
    green = (int)cAnimation.getY() > 255 ? 0 : (int)cAnimation.getY();
    blue = (int)cAnimation.getZ() > 255 ? 0 : (int)cAnimation.getZ();

    position.set(tAnimation.getX(), tAnimation.getY(), tAnimation.getZ());
  }

  public PointLight setColorAnimation(Vector4f v4fAnimation) {
    this.colorAnimation.setVector4fComponent(v4fAnimation);
    return this;
  }
  
  public PointLight setColor(int pRed, int pGreen, int pBlue) {
    this.red = pRed;
    this.green = pGreen;
    this.blue = pBlue;
    return this;
  }
  
  public void draw() {
    pointLight(red, green, blue, position.getX(), position.getY(), position.getZ());
  }
}
