PImage img;
Table  dataTable;
Table  table;
Table  locationTable;

int currentRow =-1;
PrintWriter  writter;
int rowCount;

float dataMin=MAX_FLOAT;
float dataMax=MIN_FLOAT;

float dataMin2=MAX_FLOAT;
float dataMax2=MIN_FLOAT;


float dataMin3=MAX_FLOAT;
float dataMax3=MIN_FLOAT;
void setup(){
 size(900,900); 
   img=loadImage("data//polska.png");
   dataTable= new Table("data//wojewodztwa.tsv");
   //writter=createWriter("data//location.tsv");
   locationTable= new Table("data//location.tsv");
   
    rowCount=locationTable.getRowCount();
    
     for(int row=0; row<rowCount; row++){
        float value=dataTable.getFloat(row,1);
        
        if(value >dataMax){
          dataMax=value;
        }
        if(value < dataMin){
          dataMin=value;
        }
   }
     
    
}

void draw(){
   background(255);
 image(img,0,0); 
    smooth();
 
   noStroke();
    for(int row=0; row<rowCount; row++){
    String abbrev= locationTable.getRowName(row);
    float x = locationTable.getFloat(row,1);
   float y = locationTable.getFloat(row,2);

   drawData(x,y,abbrev);
  
  }
   
}

void mousePressed(){
 // wczytajKoordynaty(); //<>//
}
void drawData(float x, float y,String abbrev){
    float value=dataTable.getFloat(abbrev,1);
    float value2=dataTable.getFloat(abbrev,2);
    float value3=dataTable.getFloat(abbrev,3);
    fill(192,0,0);
    float mapped=map(value,dataMin,dataMax,2,50);
    ellipse(x,y,mapped,mapped);
    fill(#ffffff);
    text(abbrev, x-35, y+20);
 
    fill(#000000);
    
    if(dist(mouseX, mouseY,x,y) < 7){
      
     text("XY: "+(value2/1000)+"K", x-30, y+35);
     text("XX: "+(value3/1000)+"K", x-30, y+55);
    }
    
    
}

void wczytajKoordynaty(){
 
  
   if(currentRow == -1){
     currentRow++;
     String abbrev=table.getRowName(currentRow); 
     println("Wpisz : "+abbrev); 
   }else { 
     
        
          println(currentRow);
          String abbrev=table.getRowName(currentRow); 
          String strTosave=abbrev+"\t"+mouseX + "\t" + mouseY;
          writter.println(strTosave);   
          println("Zapisano: "+  currentRow +"-"+strTosave);
         if(table.getRowCount() == currentRow+1){
            writter.flush(); 
            writter.close(); 
            exit();  
          }else{
            currentRow++;
            abbrev=table.getRowName(currentRow); 
            println("Wpisz : "+  currentRow +"-"+abbrev);
          }
   }
  
}