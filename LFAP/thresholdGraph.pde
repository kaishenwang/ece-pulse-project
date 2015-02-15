/*
*  
*  This class draws a grid with a value scale and 
*  color rectangles acording to sensor input.
*
*/

class ThresholdGraph{

// variables of DisplayItems object 
PFont font;
int fontsize = 12;
String fontname = "Monaco-14.vlw";
String inputName = "";
float gridSpacing = width/42.0;
int gridValues = 25;
float potiHeight = height/6.0;
int potiWidth = 30;
int poti_ID = 0;
float scaleValue = width/1050.0;
float[] highest = {0,0,0,0,0,0};
float powerthreshold = 300;
float resttime = 0;
float maxresttime = 1000;
float timetrack = 0;
float timeset = 1000;
float flashfrequency = 50;
float flashtimetrack = 50;
float goal = 20000;
//float scaleValueY = height/400.0;

// constructor
ThresholdGraph(){
  font = loadFont(fontname);
  textFont(font, fontsize);
  }//end ThresholdGraph
 
  // draws grid and value scale
  void update(){
    //refresh background
    
    background(backgroundimg);
    //background(173,244,248);
    //scale(scaleValueX, scaleValueY);  //scale everything to fit window size
   
    for (int i = 0; i < xPosArr.length; i++){
      // draw thresholds in light(min) and dark(max) grey
      noStroke();
      //fill(150);
      //rect(threshMin[i]*scaleValue-potiWidth/4, i*potiHeight, potiWidth/2, potiHeight);
      
      //fill(100);
      //rect(threshMax[i]*scaleValue-potiWidth/4, i*potiHeight, potiWidth/2, potiHeight); 
      
       fill(255,0,0);
       textSize(36);
       text("Your Goal Today is "+goal,width*0.3,height*0.7);
       textSize(12);
      timetrack = timetrack + 1;
      if(timetrack < timeset)
      {
        if(timetrack < timeset - 100)
        {
          fill(255,0,0);
          textSize(36);
          text("set up threshold",width*0.3,height*0.5);
          text("slowly lift up your arm",width*0.3,height*0.3);
          textSize(12);
          if(timetrack > 300)
          {
            if(powerthreshold <= xPosArr[i] - 40)
            {
               powerthreshold = xPosArr[i] - 40;
            }
          }
        }
        else
        {
          fill(255,0,0);
          textSize(36);
          text("Start!",width*0.3,height*0.5);
          textSize(12);
        }
      }
      else
      {
        fill(255,0,0);
        textSize(36);
        text("Hotness of Your New Girlfriend",width*0.3,height*0.5);
        fill(0);
        text(score/10000,width*0.6,height*0.6);
        textSize(12);
      }
      
      //rect(width*0.8,height*0.2,width/6,height/12);
      // poti colours and names
      /*
      if (i == 0){ fill(255, 107, 39); inputName = "one";}
      if (i == 1){ fill(29, 224, 109); inputName = "two";}
      if (i == 2){ fill(29, 141, 224); inputName = "three";}
      if (i == 3){ fill(211, 82, 232); inputName = "four";}
      if (i == 4){ fill(100, 141, 224); inputName = "five";}
      if (i == 5){ fill(2, 82, 232); inputName = "six";}*/
      fill(255);
      // draw poti at xpos 
      rect(0, i*potiHeight+potiHeight/3-3, xPosArr[i]*scaleValue-potiWidth/2+potiWidth, potiHeight/3+6);
      
      if (i == 0){ fill(255, 107, 39); inputName = "one";}
      if (i == 1){ fill(29, 224, 109); inputName = "two";}
      if (i == 2){ fill(29, 141, 224); inputName = "three";}
      if (i == 3){ fill(211, 82, 232); inputName = "four";}
      if (i == 4){ fill(100, 141, 224); inputName = "five";}
      if (i == 5){ fill(2, 82, 232); inputName = "six";}
      rect(0, i*potiHeight+potiHeight/3, xPosArr[i]*scaleValue-potiWidth/2+potiWidth-3, potiHeight/3);
      
      if(highest[i] <= xPosArr[i])
        {
           highest[i] = xPosArr[i];
        }
      if((xPosArr[i] - powerthreshold)>0)
      {
        score = score + (xPosArr[i] - powerthreshold)*(xPosArr[i] - powerthreshold);
        resttime = 0;
      }
      else
      {
        resttime = resttime + 1;
      }
      
      if(resttime > maxresttime)
      {
        if(flashtimetrack < 0)
          flashtimetrack = flashfrequency;
        else
          flashtimetrack = flashtimetrack - 1;   
        if(flashtimetrack < flashfrequency/2)
        {
          fill(255,0,0);
          textSize(36);
          text("FASTER!!!",width*0.5,height*0.3);
          textSize(12);
        }
        else
        {
          fill(255,0,0);
          textSize(44);
          text("FASTER!!!",width*0.5,height*0.3);
          textSize(12);
        }
        if((score - (resttime - maxresttime) * 10) < 0)
          score = 0;
        else
          score = score - (resttime - maxresttime) * 3;
      }
        
      rect(highest[i]+potiWidth, i*potiHeight+potiHeight/3, 10, potiHeight/3);
      fill(60,255,60);
      rect(powerthreshold, i*potiHeight+potiHeight/3, 10, potiHeight/3);
      // draw xpos as text
      fill(0);
      text(highest[i]+inputName, highest[i]+potiWidth+15, i*potiHeight+potiHeight/2);
      textSize(12);
      }//end for
    
    // draw grid to fit window size
    stroke(0);
    strokeWeight(1);
    
    // vertical lines
    /*for (int i=0; i<width/gridSpacing; i++){
      line(i*gridSpacing, 0, i*gridSpacing, height);
      textAlign(LEFT);
      text(i*gridValues, i*gridSpacing+2, fontsize);
      }//end for*/

  }// end update
}// end class Display
