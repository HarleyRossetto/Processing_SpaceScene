public static class IDAllocator {
  private static int latestIdAllocated = 0;
  
  public static int allocateId() {
    return  ++latestIdAllocated;
  }
  
  public static void resetAllocator() {
    latestIdAllocated = 0; 
  }
}
