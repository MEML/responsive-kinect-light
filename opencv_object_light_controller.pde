/* --------------------------------------------------------------------------
 * SimpleOpenNI DepthImage Test
 * --------------------------------------------------------------------------
 * Processing Wrapper for the OpenNI/Kinect 2 library
 * http://code.google.com/p/simple-openni
 * --------------------------------------------------------------------------
 * prog:  Max Rheiner / Interaction Design / Zhdk / http://iad.zhdk.ch/
 * date:  12/12/2012 (m/d/y)
 * ----------------------------------------------------------------------------
 */

import SimpleOpenNI.*;
import gab.opencv.*;


import java.util.List;

import org.opencv.core.MatOfKeyPoint;
import org.opencv.features2d.FeatureDetector;
import org.opencv.features2d.KeyPoint;




OpenCV opencv;

int screen_w = 640;
int screen_h = 480;

SimpleOpenNI  context;
FeatureDetector detector;

void setup()
{
  size(640, 480);
  
  opencv = new OpenCV(this, 640, 480);
  
  detector = FeatureDetector.create(FeatureDetector.BRISK);
  //detector = FeatureDetector.create(FeatureDetector.DenseFeatureDetector);
  
  opencv.startBackgroundSubtraction(5, 3, 0.5);
  
  context = new SimpleOpenNI(this);
  if (context.isInit() == false)
  {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }

  // mirror is by default enabled
  context.setMirror(true);
  
  //context.enableScene();

  // enable depthMap generation 
  context.enableDepth();

  //depthImage = context.depthImage();

  // enable ir generation
  //context.enableRGB();
}

PImage depthImage;


void draw()
{
  // update the cam
  context.update();

  //int[] depthValues = context.depthMap();
  
  //System.out.println(depthValues.length);
  
 
  depthImage = context.depthImage();
  //image(depthImage, 0, 0);
  opencv.loadImage(depthImage);
    opencv.updateBackground();
  
  opencv.dilate();
  opencv.erode();
  opencv.erode();
  opencv.erode();
  
  
  MatOfKeyPoint points = new MatOfKeyPoint();
  detector.detect(opencv.matGray, points);
  
  image(opencv.getOutput(), 0, 0);
  
  println(points.toArray().length);
  for (KeyPoint point : points.toArray()) {
      ellipse((float)point.pt.x, (float)point.pt.y, point.size, point.size);
//      point((float)point.pt.x, (float)point.pt.y);
      //((float)point.pt.x, (float)point.pt.y);
  }
  
  //for (MatOfKeyPoints point : points){ 
    
  //}
  

   

  

  noFill();
  stroke(255, 0, 0);
  strokeWeight(3);
  for (Contour contour : opencv.findContours()) {
//    contour.draw();
  }
  
}


void mousePressed() {
  ellipse(mouseX, mouseY, 100, 100);
  System.out.println("{" + mouseX +"," + mouseY+",200,80}");
  
  
}
