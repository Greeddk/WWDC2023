import SwiftUI

struct LadderView: View {
    @State var LadderArr : [[Int]] = [[0,1,0,1,0],
                                      [0,1,0,1,0],
                                      [0,1,0,1,0],
                                      [0,1,0,1,0],
                                      [0,1,0,1,0]]
    
    @State var atLeastOneHorizontal : Bool = true
    
    let LadderImg : [String] = ["Vertical", "Space", "Horizontal","None"]
    let Quest : [String] = ["홍길동", "","김길동", "", "박길동"]
    let Answer : [String] = ["O", "","O", "", "X"]
    
    @State var LadderCoorDinatex : Int = 0
    @State var LadderCoorDinatey : Int = 0
    @State var AnsAnnounce : String = "아직 사다리를 돌리지 않았습니다!"
    @State var LadderResult : String = "-"
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                ForEach(0..<5,id:\.self){i in
                    Text(Quest[i])
                    Spacer()
                }
            }
            HStack{
                ForEach(0..<5,id:\.self){i in
                    Image(LadderImg[LadderArr[0][i]])
                    .resizable().aspectRatio(contentMode: .fit)}
            }
            .padding(.top, -10.0)
            
            HStack{
                ForEach(0..<5,id:\.self){i in
                    Image(LadderImg[LadderArr[1][i]])
                    .resizable().aspectRatio(contentMode: .fit)}
            }
            .padding(.top, -10.0)
            
            HStack{
                ForEach(0..<5,id:\.self){i in
                    Image(LadderImg[LadderArr[2][i]])
                    .resizable().aspectRatio(contentMode: .fit)}
            }
            .padding(.top, -10.0)
            
            HStack{
                ForEach(0..<5,id:\.self){i in
                    Image(LadderImg[LadderArr[3][i]])
                    .resizable().aspectRatio(contentMode: .fit)}
            }
            .padding(.top, -10.0)
            
            HStack{
                ForEach(0..<5,id:\.self){i in
                    Image(LadderImg[LadderArr[4][i]])
                    .resizable().aspectRatio(contentMode: .fit)}
            }
            .padding(.top, -10.0)
            
            HStack{
                Spacer()
                ForEach(0..<5,id:\.self){i in
                    Text(Answer[i])
                    Spacer()
                }
            }
            
            Button(action: {
                atLeastOneHorizontal = true
                LadderCoorDinatex = 0
                LadderCoorDinatey = 0
                
                while(atLeastOneHorizontal){
                    //사다리 생성을 위한 배열값 입력
                    for i in 0..<5{
                        for j in 0..<5{
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
                }
                
                
                
                
                
                //dfs
                while(LadderCoorDinatey != 4){
                    if(LadderCoorDinatex == 0){
                        if(LadderArr[LadderCoorDinatey][LadderCoorDinatex+1] == 2){
                            LadderCoorDinatex += 2
                        }
                    }
                    else if(LadderCoorDinatex <= 3){
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
                }
                AnsAnnounce = "홍길동," + Answer[LadderCoorDinatex] + "입니다."
            }, label: {Text("사다리 만들기").font(.largeTitle).foregroundColor(.blue)})
            Text(AnsAnnounce)
        }
    }
    
    
    func examineHorizontal() {
        var spaceCount : Int = 0
        
        outer : for i in 1..<3{
            
            spaceCount = 0
            
            for j in 0..<5{
                if(LadderArr[j][(2*i)-1] == 2){
                    //false일땐 while문이 돌지 않아서 사다리 재생성x
                    atLeastOneHorizontal = false
                    break
                } else if (LadderArr[j][(2*i)-1] == 1){
                    spaceCount += 1
                    if(spaceCount == 5){
                        atLeastOneHorizontal = true
                        break outer
                    }
                }
            }
        }
    }//func
}
    
struct LadderView_Previews: PreviewProvider {
    static var previews: some View {
        LadderView()
            .previewInterfaceOrientation(.landscapeLeft)
            .previewDevice("iPad Pro (12.9-inch) (6th generation)")
    }
}
