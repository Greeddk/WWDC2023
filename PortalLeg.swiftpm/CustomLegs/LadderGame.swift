import SwiftUI

struct LadderGame: View {
    @EnvironmentObject var data : Data
    
    @State var LadderArr : [[Int]] = [[0,1,0,1,0,1,0,1,0,1,0,1,0,1,0],
                                      [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0],
                                      [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0],
                                      [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0],
                                      [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0],
                                      [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0],
                                      [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0]]
    
    @State var RedLadder : [[Int]] = []
    
    @State var atLeastOneHorizontal : Bool = true
    @State private var showInfoModal: Bool = false
    
    let LadderImg : [String] = ["Vertical", "Space", "Horizontal0","None", "VerticalRed", "HorizontalRed0"]
    let PlayerName : [String] = ["P1", "P2","P3", "P4", "P5", "P6", "P7", "P8"]
    
    @State var AnswerArr : [Int] = [0,0,1,0,0,0,0,0]
    let AnswerText : [String] = ["❌", "⭕️"]
    
    @State var LadderCoorDinatex : Int = 0
    @State var LadderCoorDinatey : Int = 0
    @State var LadderResult : String = "-"
    @State var numberOfWinner : Int = 0
    @State var numberOfLooser : Int = 0
    
    @State var ButtonClicked : Int = 0
    
    @State private var showingAlert = false
    
    
    var body: some View {
        VStack{
                HStack{
                    VStack {
                        Button(PlayerName[0]){
                            redLine(0)
                        }
                        ForEach(0..<7, id: \.self) { j in
                            Image(LadderImg[LadderArr[j][0]])
                                .resizable().aspectRatio(contentMode: .fit)
                        }
                        .padding(.top, -20)
                        Text("\(AnswerText[AnswerArr[0]])")
                    }
                    ForEach(1..<(data.numberOfPeople), id: \.self) { i in
                        VStack {
                            ForEach(0..<7, id: \.self) { j in
                                Image(LadderImg[LadderArr[j][(i * 2) - 1]])
                                    .resizable().aspectRatio(contentMode: .fit)
                            }
                            .padding([.leading, .trailing], -10)
                        }
                        VStack {
                            Button(PlayerName[i]){
                                redLine(i)
                            }
                            ForEach(0..<7, id: \.self) { j in
                                Image(LadderImg[LadderArr[j][i * 2]])
                                    .resizable().aspectRatio(contentMode: .fit)
                            }
                            .padding(.top, -20)
                            Text("\(AnswerText[AnswerArr[i]])")
                        }
                    }
                }//HStack
            
            Spacer().frame(height: 50)
            Button(action: {
                //사다리 생성을 위한 배열값 입력
                atLeastOneHorizontal = false
                for i in 0..<data.numberOfPeople*2-1{
                    if(i%2==0){
                        LadderArr[6][i] = 0
                    }
                    else{
                        LadderArr[6][i] = 1
                    }
                }
                while(!atLeastOneHorizontal){
                    for i in 1..<6{
                        for j in 0..<(data.numberOfPeople * 2)-1{
                            //사다리 세로줄 생성을 위한 배열값 입력
                            if(j%2 == 0){
                                LadderArr[i][j] = 0
                            }
                            //사다리 가로줄 생성을 위한 배열값 입력
                            else{
                                LadderArr[i][j] = Int.random(in:1...2)
                                //중복 안되게
                                if(j >= 3){
                                    if(LadderArr[i][j-2] == 2){
                                        LadderArr[i][j] = 1
                                    }
                                }
                            }//else
                        }
                    }//for
                    examineHorizontal()
                }//while
                for i in 0..<data.numberOfPeople*2-1{
                    if(i%2==0){
                        LadderArr[0][i] = 0
                    }
                    else{
                        LadderArr[0][i] = 1
                    }
                }
                LadderResult = result()
                ButtonClicked += 1
                print(LadderArr)
            }, label: {Text("MakeLadder").font(.largeTitle).foregroundColor(.blue)}
            )//.disabled(ButtonClicked == 1 ? true : false )
            Spacer().frame(height: 50)
                .onAppear{
                    randomAnswer()
                }
            //결과 보여주는 버튼
            Button {
                showInfoModal = true
            } label: {
                Text("Show Result")
            }
            .sheet(isPresented: $showInfoModal){
                Text(LadderResult)
                    .font(.title)
            }
        }//VStack
        .padding(.all, 20.0)
    }
    // MARK: - 빨간색 선
    func redLine(_ playerNumber : Int){
        //VerticalRed:4, HorizontalRed:5
        //dfs
        LadderCoorDinatex = 2*playerNumber
        LadderCoorDinatey = 0
        
        // 초기화 코드
        for i in 0..<7 {
            for j in 0..<data.numberOfPeople*2-1 {
                if(LadderArr[i][j] == 4){
                    LadderArr[i][j] = 0
                }
                else if(LadderArr[i][j] == 5) {
                    LadderArr[i][j] = 2
                }
            }
        }
        

        while(LadderCoorDinatey != 7){
            if(LadderCoorDinatex == 0){
                if(LadderArr[LadderCoorDinatey][LadderCoorDinatex+1] == 2){
                    LadderArr[LadderCoorDinatey][LadderCoorDinatex] = 4
                    LadderArr[LadderCoorDinatey][LadderCoorDinatex+1] = 5
                    LadderCoorDinatex += 2
                }else{
                    LadderArr[LadderCoorDinatey][LadderCoorDinatex] = 4
                }
            }
            else if(LadderCoorDinatex <= (data.numberOfPeople*2)-4){
                if(LadderArr[LadderCoorDinatey][LadderCoorDinatex+1] == 2){
                    LadderArr[LadderCoorDinatey][LadderCoorDinatex] = 4
                    LadderArr[LadderCoorDinatey][LadderCoorDinatex+1] = 5
                    LadderCoorDinatex += 2
                }
                else if(LadderArr[LadderCoorDinatey][LadderCoorDinatex-1] == 2){
                    LadderArr[LadderCoorDinatey][LadderCoorDinatex] = 4
                    LadderArr[LadderCoorDinatey][LadderCoorDinatex-1] = 5
                    LadderCoorDinatex -= 2
                }
                else{
                    LadderArr[LadderCoorDinatey][LadderCoorDinatex] = 4
                }
            }
            else{
                if(LadderArr[LadderCoorDinatey][LadderCoorDinatex-1] == 2){
                    LadderArr[LadderCoorDinatey][LadderCoorDinatex] = 4
                    LadderArr[LadderCoorDinatey][LadderCoorDinatex-1] = 5
                    LadderCoorDinatex -= 2
                }
                else{
                    LadderArr[LadderCoorDinatey][LadderCoorDinatex] = 4
                }
            }
            LadderCoorDinatey += 1
        }//while
    }//func
    
    func randomAnswer(){
        numberOfWinner = 0
        numberOfLooser = 0
        for i in 0..<data.numberOfPeople {
            AnswerArr[i] = Int.random(in:0...1)
            if(numberOfWinner >= data.numberOfWinner){
                AnswerArr[i] = 0
            } else if(numberOfLooser >= (data.numberOfPeople - data.numberOfWinner)) {
                AnswerArr[i] = 1
            } else if(AnswerArr[i] == 0) {
                numberOfLooser += 1
            } else if(AnswerArr[i] == 1) {
                numberOfWinner += 1
            }
        }
    }//func
    
    
    func examineHorizontal() {
        var spaceCount : Int = 0
        
        outer : for i in 1..<data.numberOfPeople{
            spaceCount = 0
            for j in 0..<5{
                if(LadderArr[j+1][(2*i)-1] == 2){
                    atLeastOneHorizontal = true
                    break
                } else if (LadderArr[j+1][(2*i)-1] == 1){
                    spaceCount += 1
                    if(spaceCount == 5){
                        atLeastOneHorizontal = false
                        break outer
                    }
                }
            }
        }
    }//func
    
    func findDestination(_ playerNumber : Int) -> Int {
        //dfs
        LadderCoorDinatex = 2*playerNumber
        LadderCoorDinatey = 0
            while(LadderCoorDinatey != 6){
            
            if(LadderCoorDinatex == 0){
                if(LadderArr[LadderCoorDinatey+1][LadderCoorDinatex+1] == 2){
                    LadderCoorDinatex += 2
                }
            }
            else if(LadderCoorDinatex <= (data.numberOfPeople*2)-4){
                if(LadderArr[LadderCoorDinatey+1][LadderCoorDinatex+1] == 2){
                    LadderCoorDinatex += 2
                }
                else if(LadderArr[LadderCoorDinatey+1][LadderCoorDinatex-1] == 2){
                    LadderCoorDinatex -= 2
                }
            }
            else{
                if(LadderArr[LadderCoorDinatey+1][LadderCoorDinatex-1] == 2){
                    LadderCoorDinatex -= 2
                }
            }
            LadderCoorDinatey += 1
        }//while
        return LadderCoorDinatex
    }//func
    
    func result() -> String {
        var ResultMessage :String = ""
        for i in 0..<data.numberOfPeople {
            let PlusString = "\(PlayerName[i]) -> \(AnswerText[AnswerArr[(findDestination(i) / 2)]]) \n"
            ResultMessage.append(PlusString)
        }
        
        return ResultMessage
    }//func
}


struct LadderGame_Previews: PreviewProvider {
    static var previews: some View {
        LadderGame()
            .environmentObject(Data())
            .previewInterfaceOrientation(.landscapeLeft)
            .previewDevice("iPad Pro (12.9-inch) (6th generation)")
    }
}
