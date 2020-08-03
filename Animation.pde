//IAnimation interface
public interface IAnimation {
  public Vector4f update(Vector4f pInput);
}

//ITextAnimation interface
public interface ITextAnimation {
  public String updateText();
}

//Vector4F Animation class
//Uses a 4 float vector with update deltas/steps to run the basic animation.
//Each update call will accumulate the update deltas with the input vector.
public class Vector4fAnimation implements IAnimation {
  protected Vector4f updateTranslationComponent = new Vector4f();

  public Vector4fAnimation() {
  }

  public Vector4fAnimation(Vector4f pVector4f) {
    updateTranslationComponent = pVector4f;
  }

  public void setVector4fComponent(Vector4f pV4f) {
    this.updateTranslationComponent = pV4f;
  }

  public Vector4f update(Vector4f pInput) {
    return new 
      Vector4f(pInput.getW() + updateTranslationComponent.getW(), 
      pInput.getX() + updateTranslationComponent.getX(), 
      pInput.getY() + updateTranslationComponent.getY(), 
      pInput.getZ() + updateTranslationComponent.getZ());
  }
}
