public class SpotLight extends SceneObject {

  protected int lightColor;
  protected int red, green, blue = 0;

  protected Vector4fAnimation positionAnimation = new Vector4fAnimation();
  protected Vector4fAnimation colorAnimation = new Vector4fAnimation();

  protected Vector3f lightDirection = new Vector3f(1.0f, 0.0f, 0.0f);

  protected float angle = PI / 8;

  protected float concentration = 2;

  public SpotLight() { 
    super();
  }

  public SpotLight(int pRed, int pGreen, int pBlue) {
    red = pRed;
    green = pGreen;
    blue = pBlue;
    position = new Vector3f();
  }

  public SpotLight(int pRed, int pGreen, int pBlue, Vector3f pPosition) {
    red = pRed;
    green = pGreen;
    blue = pBlue;
    position = pPosition;
  }

  public SpotLight(int pRed, int pGreen, int pBlue, Vector3f pPosition, Vector3f pDirection) {
    red = pRed;
    green = pGreen;
    blue = pBlue;
    position = pPosition;
    lightDirection = pDirection;
  }

  public void update() {
    Vector4f cAnimation = colorAnimation.update(new Vector4f(0.0f, (float)red, (float)green, (float)blue));
    Vector4f tAnimation = positionAnimation.update(new Vector4f(0.0f, position.getX(), position.getY(), position.getZ()));

    red = (int)cAnimation.getX() > 255 ? 0 : (int)cAnimation.getX();
    green = (int)cAnimation.getY() > 255 ? 0 : (int)cAnimation.getY();
    blue = (int)cAnimation.getZ() > 255 ? 0 : (int)cAnimation.getZ();

    position.set(tAnimation.getX(), tAnimation.getY(), tAnimation.getZ());
  }

  public SpotLight setColorAnimation(Vector4f v4fAnimation) {
    this.colorAnimation.setVector4fComponent(v4fAnimation);
    return this;
  }

  public SpotLight setConcentration(float pConcentration) {
    this.concentration = pConcentration;
    return this;
  }

  public SpotLight setAngle(float pAngle) {
    this.angle = pAngle;
    return this;
  }
  
  public SpotLight setDirection(Vector3f pDirection) {
    this.lightDirection = pDirection;
    return this;
  }
  
  public SpotLight setDirection(float x, float y, float z) {
    this.lightDirection = new Vector3f(x, y, z);
    return this;
  }

  public void draw() {
    // red, green, blue, x, y, z, direction x, direction y, direction z, cone angle, concentration
    spotLight(red, green, blue, 
      position.getX(), position.getY(), position.getZ(), 
      lightDirection.getX(), lightDirection.getY(), lightDirection.getZ(), 
      angle, 
      concentration);
  }
}
