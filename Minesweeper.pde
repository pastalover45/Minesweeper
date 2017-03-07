
import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
int NUM_ROWS = 20;
int NUM_COLS = 20; 
int NUM_MINES = 40;

private MSButton[][] buttons; //2d array of minesweeper buttons
 //initialize bombs to be a new empty ArrayList of type MSButton
private ArrayList <MSButton> bombs = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
      buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r=0; r<NUM_ROWS; r++){

        for(int c=0; c<NUM_COLS; c++){

            buttons[r][c]= new MSButton(r,c);
        }
    }
    
    
    
    
    setBombs();
}
public void setBombs()
{
    //your code
   int row,col;

    while (bombs.size() < NUM_MINES+1) {
    //random row and column number
     row = (int)(Math.random()*20);
     col = (int)(Math.random()*20);
       // Use the contains() function to check to see if buttons[row][col] is already in bombs. 
     if(!bombs.contains(buttons[row][col])){

      bombs.add(buttons[row][col]);
     }
   }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
    for(int r = 0; r < NUM_ROWS; r++){
        for(int c = 0; c < NUM_COLS; c++){
            buttons[r][c].setLabel("x_x");
         }
    }
}
public void displayWinningMessage()
{
    //your code here
    for(int r = 0; r < NUM_ROWS; r++){
        for(int c = 0; c < NUM_COLS; c++){
            buttons[r][c].setLabel("^_^");
         }
    }
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if (keyPressed == true){
            marked = true; 
        }
        else if(bombs.contains(this)){
//else if bombs contains this button display the losing message
                 displayLosingMessage();
             }
//else if countBombs returns a number of neighboring mines greater than zero, set the label to that number
     else if(countBombs(r,c)>0){

                setLabel(""+countBombs(r,c));
                  }
                   if(isValid(r-1,c)==true&&buttons[r-1][c].isClicked()==false){

                    buttons[r-1][c].mousePressed();
                }
                   if(isValid(r+1,c)==true&&buttons[r+1][c].isClicked()==false){

                    buttons[r+1][c].mousePressed();
                 }

                if(isValid(r,c-1)==true&&buttons[r][c-1].isClicked()==false){

                   buttons[r][c-1].mousePressed();
                 }

                if(isValid(r,c+1)==true&&buttons[r][c+1].isClicked()==false){

                    buttons[r][c+1].mousePressed();
                        }

                 if(isValid(r+1,c+1)==true&&buttons[r+1][c+1].isClicked()==false){

                    buttons[r+1][c+1].mousePressed();
                }

                if(isValid(r-1,c-1)==true&&buttons[r-1][c-1].isClicked()==false){

                    buttons[r-1][c-1].mousePressed();
                }

                if(isValid(r-1,c+1)==true&&buttons[r-1][c+1].isClicked()==false){

                    buttons[r-1][c+1].mousePressed();
                }
                 if(isValid(r+1,c-1)==true&&buttons[r+1][c-1].isClicked()==false){

                    buttons[r+1][c-1].mousePressed();
                }



    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        //cells with a mine turn red when clicked
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        //returns true if (row,col) is a valid location on the grid and false otherwise

          if(r < NUM_ROWS && c < NUM_COLS && r >=0 && c>=0){
          return true;  
        }
        else
        {

            return false;

        }
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        //remember to check to see if the neighboring button is valid before checking to see if it's a mine)
         // 8 neighbors
         if(isValid(r-1,c)&& bombs.contains(buttons[r-1][c])){

            numBombs++;
        }
         if(isValid(r+1,c)&& bombs.contains(buttons[r+1][c])){

            numBombs++;
        }
        if(isValid(r,c-1)&& bombs.contains(buttons[r][c-1])){

            numBombs++;
        }
         if(isValid(r,c+1)&& bombs.contains(buttons[r][c+1])){

            numBombs++;
        }
        if(isValid(r-1,c-1)&& bombs.contains(buttons[r-1][c-1])){

            numBombs++;
        }
         if(isValid(r+1,c+1)&& bombs.contains(buttons[r+1][c+1])){

            numBombs++;
        }
        if(isValid(r+1,c-1)&& bombs.contains(buttons[r+1][c-1])){

            numBombs++;
        }
         if(isValid(r-1,c+1)&& bombs.contains(buttons[r-1][c+1])){

            numBombs++;
        }

        return numBombs;
    }
}







