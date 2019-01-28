int N_CELLS = 100;
boolean grid[][] = new boolean[N_CELLS][N_CELLS];
int neighbours[][] = new int[N_CELLS][N_CELLS];
boolean continous = false;
int step = 0;
void setup()
{
   size(900,900);
}

void blacken()
{
  for (int i = 0; i < N_CELLS; i++){
    for (int j = 0; j < N_CELLS; j++){
      grid[i][j] = false;  
  }}
}
void randomizeGrid()
{
  for (int i = 0; i < N_CELLS; i++){
    for (int j = 0; j < N_CELLS; j++){
      grid[i][j] = true; if(random(1) > 0.49) grid[i][j] = false;  
  }}
}

void drawGrid()
{
  float w = width/N_CELLS;
  float h = height/N_CELLS;
  for (int i = 0; i < N_CELLS; i++){
    for (int j = 0; j < N_CELLS; j++){
      fill(0,0,0); if(grid[i][j]) fill(255,255,255);
      rect(i*w,j*w,w,h);  
  }}
}

void updateGrid()
{
  countNeighbours();
  for (int i = 0; i < N_CELLS; i++){
    for (int j = 0; j < N_CELLS; j++){
      int n = neighbours[i][j];
      boolean live = grid[i][j];
      if(live && (n != 2 && n != 3)) grid[i][j] = false;
      if(!live && n == 3) grid[i][j] = true;
    }}
}
void countNeighbours()
{
  for( int x = 0; x < N_CELLS; x++){
  for( int y = 0; y < N_CELLS; y++){
    int count = 0;
    for(int i = -1; i < 2; i++){
      for(int j = -1; j < 2; j++){
        if ( i == 0 & j == 0)
          continue;
        int c_x = (N_CELLS + i + x)%N_CELLS;
        int c_y = (N_CELLS + j + y)%N_CELLS;
        if(grid[c_x][c_y])
          count++;
      }}
    neighbours[x][y] = count;
  }}
}
void draw()
{
  if (step == 0){
    if(continous)
      updateGrid();
    drawGrid();
  }
  if (step == 1){
    blacken();
    step = 0;
  }
  if (step == 2){
    randomizeGrid();
    step = 0;
  }
  if (step == 3){
    updateGrid();
    step = 0;
  }
  if (step == 4){
    updateGrid();
    drawGrid();
  }
}

void keyPressed()
{
  if(key == 'c' || key == 'C')
    step = 1;
  if(key == 'r' || key == 'R')
    step = 2;
  if(key == 'g' || key == 'G')
    continous = !continous;
  if(key == ' '){ 
    continous = false;
    step = 3;
  }
}

void mousePressed()
{
  float w = float(mouseX)/width * N_CELLS;
  float h = float(mouseY)/height * N_CELLS;
  grid[int(w)][int(h)] = !grid[int(w)][int(h)]; 
}
