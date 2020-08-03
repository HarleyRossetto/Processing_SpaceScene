public class Text extends SceneObject {
 
  protected char[] message = {'N', 'U', 'L', 'L'};
  protected int fillColor = 255;
  protected ITextAnimation textAnimation;
  protected int horizontalAlignment = LEFT;
  protected int verticalAlignment = TOP;
  
  public Text(String pText) {
    setText(pText);
  }
  
  public Text setFillColor(int pColor) {
     this.fillColor = pColor;
     return this;
  }
  
  public Text setTextAnimation(ITextAnimation pTextAnimation) {
     this.textAnimation = pTextAnimation;
     return this;
  }
  
  public Text setAlignment(int pHorizontal, int pVertical) {
    this.horizontalAlignment = pHorizontal;
    this.verticalAlignment = pVertical;
    return this;
  }
  
  public void setText(String pText) {
    message = new char[pText.length()];
    for (int i = 0; i < pText.length(); i++) {
      message[i] = pText.charAt(i);    
    }
  }
  
  public void setText(char[] pText) {
    message = pText; 
  }
  
  public void update() {
    if (textAnimation != null) {
       setText(textAnimation.updateText()); 
    }
  }
  
  public void draw() {
    blendMode(blendingMode);
    pushMatrix();
    fill(fillColor);     
    textAlign(horizontalAlignment, verticalAlignment);
    text(message, 0, message.length, position.getX(), position.getY(), position.getZ());
    popMatrix();
  }
}

public class TextFPSAnimation implements ITextAnimation {
   public String updateText() {
     return str(round(frameRate)); 
   }
}
