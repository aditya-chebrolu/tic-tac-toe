import SwiftUI

struct Heading:View {
    var body: some View {
        HStack {
            Text("Tic")
                .foregroundStyle(Color.custom.red)
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Text("Tac")
                .foregroundStyle(.white)
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Text("Toe")
                .foregroundStyle(Color.custom.blue)
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
        }
        
    }
}

struct ResetButton:View {
    var onReset:() -> Void
    var body: some View {
        Text("Reset")
            .foregroundStyle(.blue)
            .onTapGesture {
                onReset()
            }
    }
}

struct Box:View {
    var row: Int
    var col: Int
    var val: Int
    var updateGrid:(_:Int,_:Int) -> Void
    
    var body: some View {
        let bgColor = {
            if val == 1 {
                return Color.custom.blue
            } else if val == 0 {
                return Color.custom.red
            }
            return Color.custom.gray
        }()
        return Rectangle()
            .fill(bgColor)
            .frame(width: 50,height:50)
            .onTapGesture {
                if val == -1 {
                    updateGrid(row,col)
                }
            }
        
    }
}

struct ContentView: View {
    @State var player:Int = 0
    @State var spacing:CGFloat = 4
    @State var grid:[[Int]] = [[-1,-1,-1],[-1,-1,-1],[-1,-1,-1]]
    
    func checkWon() -> Bool {
        if [grid[0][0],grid[0][1],grid[0][2]].allSatisfy({ $0 == player}) ||
             [grid[1][0],grid[1][1],grid[1][2]].allSatisfy({ $0 == player}) ||
             [grid[2][0],grid[2][1],grid[2][2]].allSatisfy({ $0 == player}) ||
             [grid[0][0],grid[1][0],grid[2][0]].allSatisfy({ $0 == player}) ||
             [grid[0][1],grid[1][1],grid[2][1]].allSatisfy({ $0 == player}) ||
             [grid[0][2],grid[1][2],grid[2][2]].allSatisfy({ $0 == player}) ||
             [grid[2][0],grid[1][1],grid[0][2]].allSatisfy({ $0 == player}) ||
             [grid[0][0],grid[1][1],grid[2][2]].allSatisfy({ $0 == player}) {
            
             return true;
         }
         return false
    }
    
    func updateGrid(_ row:Int,_ col:Int) -> Void {
        grid[row][col] =  player
        if checkWon() {
            withAnimation(.easeInOut(duration: 0.4)) {
                spacing = 0
                grid = [[player,player,player],[player,player,player],[player,player,player]]
            }
        } else {
            player = player == 0 ? 1 : 0
        }
    }
    
    func onReset() {
        withAnimation(.easeInOut(duration: 0.4)) {
            spacing = 4
            player = 0
            grid = [[-1,-1,-1],[-1,-1,-1],[-1,-1,-1]]
        }
    }
    
    var body: some View {
        VStack(spacing : 40) {
            Heading()
            Grid(horizontalSpacing: spacing, verticalSpacing: spacing) {
                ForEach(0..<3) { row in
                    GridRow {
                        ForEach(0..<3) { col in
                            Box(row:row,col:col,val:grid[row][col],updateGrid:updateGrid)
                        }
                    }
                }
            }
            ResetButton(onReset:onReset)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
        .background(.black)
    }
}

#Preview {
    ContentView()
}
