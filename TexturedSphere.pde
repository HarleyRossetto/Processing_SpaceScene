

public class TexturedSphere extends SceneObject {
   protected PShape geometry;
   protected PImage texture;
   protected boolean enableLights = false;
   
   protected Vector4fAnimation rotationAnimation = new Vector4fAnimation();
   protected Vector4fAnimation positionAnimation = new Vector4fAnimation();
 
   public TexturedSphere(String pPath, float radius, int pDefaultColor, boolean pDrawStroke) {    
     if (loadTexture(pPath)) {
       if (pDrawStroke)
         stroke(color((int)random(255), (int)random(255), (int)random(255)));
       else
         noStroke();
       
       geometry = createShape(SPHERE, radius);
       geometry.setTexture(texture);
     } else {
       fill(pDefaultColor);
       geometry = createShape(SPHERE, radius);
     }   
   }
   
   protected boolean loadTexture(String pPath) {
      try {
        texture = loadImage(pPath);
      } catch (Exception ex) {}
      
      if (texture != null)
      {
        println("Texture: '" + pPath + " loaded");
        return true;
      } else {
        println("Texture: '" + pPath + " could not be loaded");
        return false;
      }
   }
           
   public void update() {
     Vector4f rAnimation = rotationAnimation.update(new Vector4f(0.0f, rotation.getX(), rotation.getY(), rotation.getZ()));
     Vector4f tAnimation = positionAnimation.update(new Vector4f(0.0f, position.getX(), position.getY(), position.getZ()));
          
     rotation.set(rAnimation.getX(), rAnimation.getY(), rAnimation.getZ());
     position.set(tAnimation.getX(), tAnimation.getY(), tAnimation.getZ());
   }
   
   public void draw() {     
     blendMode(blendingMode);
     pushMatrix();
     
     translate(position.getX(), position.getY(), position.getZ());
     rotateX(radians(rotation.getX()));
     rotateY(radians(rotation.getY()));
     //Dont rotate Z because it causes crash
     //rotateZ(rotation.getZ());
     
     shape(geometry);
     
     popMatrix();
   }
   
   public TexturedSphere setTranslationAnimation(Vector4f v4fAnimation) {
     this.positionAnimation.setVector4fComponent(v4fAnimation);
     return this;
   }
   
   public TexturedSphere setRotationAnimation(Vector4f v4fAnimation) {
     this.rotationAnimation.setVector4fComponent(v4fAnimation); 
     return this;
   }
   
    public TexturedSphere setRotationAnimationObj(Vector4fAnimation v4fAnimation) {
     this.rotationAnimation = v4fAnimation; 
     return this;
   }
}
