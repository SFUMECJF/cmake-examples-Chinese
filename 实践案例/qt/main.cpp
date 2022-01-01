#include <iostream>
#include "mainwindow.h"
#include <QApplication>
#include <QWidget>
#include <QDebug>
#include <thread>
#include <QTime>

using namespace std;
//using namespace cv;

int main(int argc, char *argv[])
{
   cout << "Hello Qt-CMake!" << endl;

   QApplication a(argc, argv);

   MainWindow mainWin;
   mainWin.show();

//   Mat image = Mat.ones(20, 20);
//   imshow("black",image);

   return a.exec();
}
