#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <iostream>

int main() {
//  cv::VideoCapture capture(0, 0);
  cv::Mat frame;
//
//  if (!capture.isOpened()) {
//    std::cout << "open camera error!" << std::endl;
//    return -1;
//  }
//
//  cv::Mat frame;
//  while (1) {
//    capture >> frame;
//    if (frame.empty()) {
//      std::cout << "capture empty frame" << std::endl;
//      continue;
//    }
//
//    cv::Mat shrink_frame;
//    cv::resize(frame, shrink_frame,
//               cv::Size(frame.cols / 2, frame.rows / 2),
//               0, 0, 3);
//
//    cv::imshow("detect", shrink_frame);
//
//    int key = cv::waitKey(1);
//    if (key == 'q') {
//      break;
//    }
//  }
  return 0;
}


//#include <opencv2/core.hpp>
//#include <opencv2/imgcodecs.hpp>
//#include <opencv2/highgui.hpp>
//#include <iostream>
//#include <string>
//using namespace cv;
//using namespace std;
//int main( int argc, char** argv )
//{
//  String imageName( "../data/HappyFish.jpg" ); // by default
//  if( argc > 1)
//  {
//    imageName = argv[1];
//  }
//  Mat image;
//  image = imread( imageName, IMREAD_COLOR ); // Read the file
//  if( image.empty() )                      // Check for invalid input
//  {
//    cout <<  "Could not open or find the image" << std::endl ;
//    return -1;
//  }
//  namedWindow( "Display window", WINDOW_AUTOSIZE ); // Create a window for display.
//  imshow( "Display window", image );                // Show our image inside it.
//  waitKey(0); // Wait for a keystroke in the window
//  return 0;
//}