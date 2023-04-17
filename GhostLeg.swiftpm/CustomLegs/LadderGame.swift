import SwiftUI

struct LadderGame: View {
    @EnvironmentObject var data : Data
    
    @State var LadderArr : [[Int]] = [[0,1,0,1,0,1,0,1,0,1,0,1,0,1,0],
                                      [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0],
                                      [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0],
                                      [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0],
                                      [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0]]
    
    @State var atLeastOneHorizontal : Bool = true
    
    let LadderImg : [String] = ["Vertical", "Space", "Horizontal","None"]
    let PlayerName : [String] = ["Player1", "Player2","Player3", "Player4", "Player5", "Player6", "Player7", "Player8"]
    
    @State var AnswerArr : [Int] = [1,0,0,0,0,0,0,0]
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
            
            //player name
            HStack{
                Spacer()
                ForEach(0..<data.numberOfPeople,id:\.self){i in
                    Text(PlayerName[i])
                    Spacer()
                }
            }
            
            //플레이어의 수 만큼 사다리 개수 증가시키기
            
            ForEach(0..<5, id: \.self){ i in
                HStack{
                    ForEach(0..<(data.numberOfPeople*2)-1,id:\.self){ j in
                        Image(LadderImg[LadderArr[i][j]])
                        .resizable().aspectRatio(contentMode: .fit)}
                }
                .padding(.top, -10.0)
            }
            
            
            //destination
            HStack{
                Spacer()
                ForEach(0..<data.numberOfPeople,id:\.self){i in
                    Text("\(AnswerText[AnswerArr[i]])")
                    Spacer()
                }
            }.onAppear{
                randomAnswer()
            }
            
            
            
            Button(action: {
                
                //사다리 생성을 위한 배열값 입력
                atLeastOneHorizontal = false
                while(!atLeastOneHorizontal){
                    for i in 0..<5{
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
                
                
                LadderResult = result()
                
                ButtonClicked += 1
                
            }, label: {Text("사다리 만들기").font(.largeTitle).foregroundColor(.blue)}
            )//.disabled(ButtonClicked == 1 ? true : false )
            
            Spacer()
            
            //결과 보여주는 버튼
            Button("Show Result") {
                showingAlert = true
            }
            .alert("Result", isPresented: $showingAlert) {
                Button("Ok") {}
            } message: {
                Text(LadderResult)
            }
            
            
            
        }
        .padding(.all, 100.0)
    }
    
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
                if(LadderArr[j][(2*i)-1] == 2){
                    atLeastOneHorizontal = true
                    break
                } else if (LadderArr[j][(2*i)-1] == 1){
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
        
        while(LadderCoorDinatey != 5){
            
            if(LadderCoorDinatex == 0){
                if(LadderArr[LadderCoorDinatey][LadderCoorDinatex+1] == 2){
                    LadderCoorDinatex += 2
                }
            }
            else if(LadderCoorDinatex <= (data.numberOfPeople*2)-4){
                if(LadderArr[LadderCoorDinatey][LadderCoorDinatex+1] == 2){
                    LadderCoorDinatex += 2
                }
                else if(LadderArr[LadderCoorDinatey][LadderCoorDinatex-1] == 2){
                    LadderCoorDinatex -= 2
                }
            }
            else{
                if(LadderArr[LadderCoorDinatey][LadderCoorDinatex-1] == 2){
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
