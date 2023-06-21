program kr;

type
  mass = array of array of integer;
  TVisited = array of boolean;

var
  Graph: mass;
  GraphSm: mass;
  Visited: TVisited;

procedure InitGraph(var Graph: mass; count_ver, count_edge: integer);
var
  i: integer;
begin
  SetLength(Graph, count_ver);
  for i := 0 to count_ver - 1 do
    SetLength(Graph[i], count_edge);
end;

procedure RandFill(var Graph: mass);
var
  ran1, ran2, i: integer;
begin
  for i := 1 to Length(Graph[0]) - 1 do
  begin
    ran1 := 0;
    ran2 := 0;
    while ran1 = ran2 do
    begin
      ran1 := Random(0, Length(Graph) - 1);
      ran2 := Random(0, Length(Graph) - 1);
    end;
    Graph[ran1, i] := 1;
    Graph[ran2, i] := 1;
  end;
end;

procedure PrintMatrix(Graph: mass);
var
  i, j: integer;
begin
  for i := 0 to Length(Graph) - 1 do
  begin
    for j := 0 to Length(Graph[i]) - 1 do
    begin
      if Graph[i, j] = 1 then
        Write('1 ')
      else
        Write('0 ');
    end;
    Writeln;
  end;
end;

procedure IncidenceToAdjacency(var Graph: mass; var GraphSm: mass);
var
  i, j, k: integer;
begin
  SetLength(GraphSm, Length(Graph));
  for i := 0 to Length(Graph) - 1 do
    SetLength(GraphSm[i], Length(Graph));

  for i := 0 to Length(Graph) - 1 do
  begin
    for j := 0 to Length(GraphSm) - 1 do
      GraphSm[i, j] := 0;

    for j := 0 to Length(Graph[i]) - 1 do
    begin
      if Graph[i, j] = 1 then
      begin
        for k := 0 to Length(Graph) - 1 do
        begin
          if (Graph[k, j] = 1) and (k <> i) then
            GraphSm[i, k] := 1;
        end;
      end;
    end;
  end;
end;

procedure DepthFirstSearch(GraphSm: mass; var Visited: TVisited; vertex: integer);
var
  i: integer;
begin
  Visited[vertex] := true;
  Write(vertex, ' ');

  for i := 0 to Length(GraphSm) - 1 do
  begin
    if (GraphSm[vertex, i] = 1) and (not Visited[i]) then
      DepthFirstSearch(GraphSm, Visited, i);
  end;
end;

var
  count_vert, count_edge: integer;
  i: integer;
begin
  Readln(count_vert, count_edge);
  InitGraph(Graph, count_vert, count_edge);
  RandFill(Graph);
  PrintMatrix(Graph);

  Writeln('---');
  IncidenceToAdjacency(Graph, GraphSm);
  PrintMatrix(GraphSm);

  SetLength(Visited, count_vert);
  for i := 0 to count_vert - 1 do
    Visited[i] := false;

  Writeln('Depth-First Search:');
  for i := 0 to count_vert - 1 do
  begin
    if not Visited[i] then
      DepthFirstSearch(GraphSm, Visited, i);
  end;
end.
