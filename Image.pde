public class Image extends SceneObject {
  
  protected PImage texture;
  protected int blendingMode = NORMAL;
  protected float imageWidth, imageHeight = 0;
  
  public Image() {
    super();
    imageWidth = width;
    imageHeight = height;
  }
  
  public Image(String pPath) {
    super();
    
    try {
      texture = loadImage(pPath);
    } catch (Exception ex) {
      
    }
  }
  
  public Image setBlendMode(int pBlendMode) {
    this.blendingMode = pBlendMode;
    return this;
  }
  
  public void draw() {
    blendMode(blendingMode);
    pushMatrix();
    rotateX(radians(rotation.getX()));
    image(texture, position.getX(), position.getY(), imageWidth, imageHeight);
    popMatrix();
  }
}
