import controlP5.*;
import beads.*;
import org.jaudiolibs.beads.*;

//declare global variables at the top of your sketch
//AudioContext ac; is declared in helper_functions


//end global variables
ControlP5 p5;
SamplePlayer music;
SamplePlayer buttonClick;
Glide rateValue;
String selectedButton = "";
//runs once when the Play button above is pressed
void setup() {
  size(400, 400); //size(width, height) must be the first line in setup()
  ac = new AudioContext(); //AudioContext ac; is declared in helper_functions 
  music = getSamplePlayer("19899__jfbsauve__musical-box.wav");
  music.pause(true);
  rateValue = new Glide(ac,1,-1);
  music.setRate(rateValue);
  
  buttonClick = getSamplePlayer("204715__michaelkoehler__knob-button-tapedeck-cassette-recorder-mechanical.wav");
  buttonClick.pause(true);
  
    buttonClick.setEndListener(new Bead() {
    public void messageReceived(Bead mess) {
    buttonClick.setToLoopStart();
    buttonClick.pause(true);
    println("buttonDone");
    if (selectedButton.equals("stop") | selectedButton.equals("reset")){
      music.pause(true);
      if(selectedButton.equals("reset")) {
        music.setToLoopStart();
      }
    }
    else {
      music.start();
    }
   }
  });
  
  
  p5 = new ControlP5(this);
  p5.addButton("play")
  .setPosition(75,250)
  .setSize(50,50);
  
  p5.addButton("stop")
  .setPosition(125,250)
  .setSize(50,50);
  
  p5.addButton("fastFwd")
  .setPosition(175,250)
  .setSize(50,50);
  
  p5.addButton("rewind")
  .setPosition(225,250)
  .setSize(50,50);
  
  p5.addButton("reset")
  .setPosition(275,250)
  .setSize(50,50);
  
  ac.out.addInput(music);
  ac.out.addInput(buttonClick);
  ac.start();
  
                  
}


void draw() {
  background(255);  //fills the canvas with black (0) each frame
  //Drawing Cassette body
  rect(50,100, 300, 200,7);
  rect(100,120,200,100,7);
  ellipse(150,175,50,50);
  ellipse(250,175,50,50);
}

void play() {
  selectedButton = "play";
  pressButton();
  rateValue.setValue(1.0);
}

void stop() {
  selectedButton = "stop";
  pressButton();
}

void fastFwd() {
  selectedButton = "fastfwd";
  pressButton();
  rateValue.setValue(1.25);
}

void rewind() {
  selectedButton = "rewind";
  pressButton();
  rateValue.setValue(-1.25);
}

void reset() {
  selectedButton = "reset";
  pressButton();
}

public void pressButton() {
  buttonClick.setToLoopStart();
  buttonClick.start();
}