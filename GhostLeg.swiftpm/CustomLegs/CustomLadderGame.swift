//
//  SwiftUIView.swift
//  
//
//  Created by Greed on 2023/04/18.
//

import SwiftUI

struct CustomLadderGame: View {
        @EnvironmentObject var data : Data
        
        @State var LadderArr : [[Int]] = [[1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1],
                                          [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1],
                                          [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1],
                                          [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1],
                                          [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1],
                                          [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1],
                                          [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1]]
        
        @State var atLeastOneHorizontal : Bool = true
        
        let LadderImg : [String] = ["Vertical", "Space", "Horizontal2","None"]
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
                        //가로 사다리
                        VStack {
                            ForEach(0..<7, id: \.self) { i in
                                Image(LadderImg[LadderArr[i][0]])
                                    .resizable().aspectRatio(contentMode: .fit)
                            }.padding([.leading, .trailing], 0)
                        }.onAppear{
                            randomAnswer()
                        }
                        ForEach(1..<(data.numberOfPeople)+1, id: \.self) { i in
                            //세로 사다리
                            VStack {
                                Text(PlayerName[i-1])
                                ForEach(0..<7, id: \.self) { j in
                                    Image(LadderImg[LadderArr[j][(i * 2) - 1]])
                                        .resizable().aspectRatio(contentMode: .fit)
                                }.padding(.top, -20)
                                Text("\(AnswerText[AnswerArr[i-1]])")
                            }
                            //가로 사다리
                            VStack {
                                ForEach(0..<7, id: \.self) { j in
                                    Image(LadderImg[LadderArr[j][i*2]])
                                        .resizable().aspectRatio(contentMode: .fit)
                                }.padding([.leading, .trailing], 0)
                            }
                        }
                }//HStack
                    Spacer().frame(height: 50)
                    Button(action: {
                        //사다리 생성을 위한 배열값 입력
                        atLeastOneHorizontal = false
                        while(!atLeastOneHorizontal){
                            for i in 0..<data.numberOfPeople*2 {
                                for j in 0..<7{
                                    //가로줄 생성을 위한 배열값 입력
                                    if(i%2==0){
                                        LadderArr[j][i] = Int.random(in: 1...2)
                                        if(i>=2){
                                            if(LadderArr[j][i-2] == 2){
                                                LadderArr[j][i] = 1
                                            } else if(LadderArr[j][i+2] == 2){
                                                LadderArr[j][i] = 1
                                            }
                                        }
                                    }
                                    //세로줄 생성을 위한 배열값 입력
                                    if(i%2==1){
                                        LadderArr[j][i] = 0
                                    }
                                    LadderArr[j][data.numberOfPeople*2] = LadderArr[j][0]
                                }//for j
                            }
                            examineHorizontal()
                        }//while
                        LadderResult = result()
                        ButtonClicked += 1
                    }, label: {Text("MakeLadder").font(.largeTitle).foregroundColor(.blue)}
                    )//.disabled(ButtonClicked == 1 ? true : false )
                    Spacer().frame(height: 50)
                    //결과 보여주는 버튼
                    Button("Show Result") {
                        showingAlert = true
                    }
                    .alert("Result", isPresented: $showingAlert) {
                        Button("Ok") {}
                    } message: {
                        Text(LadderResult)
                    }
            }//VStack
            .padding(.all, 20.0)
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
            AnswerArr.shuffle()
        }//func
        
        func examineHorizontal() {
            var spaceCount : Int = 0
            
            outer : for i in 0..<data.numberOfPeople{
                spaceCount = 0
                for j in 0..<7{
                    if(LadderArr[j][2*i] == 2){
                        atLeastOneHorizontal = true
                        break
                    } else if (LadderArr[j][2*i] == 1){
                        spaceCount += 1
                        if(spaceCount == 6){
                            atLeastOneHorizontal = false
                            break outer
                        }
                    }
                }
            }
        }//func
        
        func findDestination(_ playerNumber : Int) -> Int {
            //dfs
            LadderCoorDinatex = 2*playerNumber + 1
            LadderCoorDinatey = 0
            while(LadderCoorDinatey != 7){
                if(LadderCoorDinatex == 1){
                    if(LadderArr[LadderCoorDinatey][LadderCoorDinatex+1] == 2){
                        LadderCoorDinatex += 2
                    }
                    else if(LadderArr[LadderCoorDinatey][LadderCoorDinatex-1]==2){
                        LadderCoorDinatex = data.numberOfPeople*2-1
                    }
                }
                else if(LadderCoorDinatex >= (data.numberOfPeople*2)-1){
                    if(LadderArr[LadderCoorDinatey][LadderCoorDinatex+1] == 2){
                        LadderCoorDinatex = 1
                    }
                    else if(LadderArr[LadderCoorDinatey][LadderCoorDinatex-1] == 2){
                        LadderCoorDinatex -= 2
                    }
                }
                else{
                    if(LadderArr[LadderCoorDinatey][LadderCoorDinatex-1] == 2){
                        LadderCoorDinatex -= 2
                    }
                    else if(LadderArr[LadderCoorDinatey][LadderCoorDinatex+1] == 2){
                        LadderCoorDinatex += 2
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


struct CustomLadderGame_Previews: PreviewProvider {
    static var previews: some View {
        CustomLadderGame()
            .environmentObject(Data())
            .previewInterfaceOrientation(.landscapeLeft)
            .previewDevice("iPad Pro (12.9-inch) (6th generation)")
    }
}
