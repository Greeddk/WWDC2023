//
//  Description.swift
//  GhostLeg
//
//  Created by Greed on 2023/04/16.
//

import SwiftUI

struct Description: View {
    
    @State var leftOpacity : Double = 0
    @State var rightOpacity : Double = 100
    
    let maintext : [String] = [" One of the many ways to bet with people in Korea is to play ladder games, which gives people a sense of urgency because of the non-overlapping nature of the outcomes. So you might think that you have the same odds no matter which number you choose, but that's not the case. Ladder games are the most unfair games because the odds are different at the start and end points, and there are ways to use this to increase your chances of winning."," In fact, a simulation of 1000 randomized ladders showed that there was a 21% chance that P4 would be the winner when the winner was on the 4th position, and only a 3.3% chance that P8 would be the winner. According to the law of large numbers, the probability of being a winner should be 12.5% regardless of the number, since more trials should approach the probability, but this was not the case. Similarly, if the first arrival was a winner, you were more likely to be a winner if you chose P1, and if the eighth arrival was a winner, you were more likely to be a winner if you chose P8."," The reason for this is that the first player's ladder and the last player's ladder are not connected. \n If you start on P1, there's a 100% chance that you'll move to P2's vertical row because there's at least one horizontal row in the middle. If there was only one horizontal row in the middle of P1, you would have a 0% chance of reaching the first destination when you picked P1. This is where the ladder already runs into trouble: if you start at P2, you have a 50% chance of moving to the ladder at P1 or P3.  In other words, the ladder is an unfair game by design."," The ladder game also determines your destination based on how many times you go through the horizontal rungs. If you go through the rungs an even number of times, you will land on an odd number of rungs, including yourself. For example, if you choose P1 and go through the rungs an even number of times, you will only reach the first destination, the third destination two spaces away, the fifth destination four spaces away, and the seventh destination six spaces away."," But that doesn't mean the ladder is always unfair: the more horizontal lines you draw, the closer the odds are to 12.5%. The number of horizontal lines needed depends on the number of vertical lines, and if n is the number of vertical lines, the formula is n(n-1)^2, which means that a ladder with 8 people will be fair when 392 horizontal lines are drawn. But that's not a realistic way to do it. And that's if you know where the winnings are. So what's the solution? \n  The easiest way to fix this is to connect the lines at both ends. Hit the NEXT button below and let's go play some more fair ladder games."]
    
    let imgnames : [String] = ["","","","",""]
    
    @State var textidx : Int = 0
    
    var body: some View {
        NavigationView{
            ZStack {
                RoundedRectangle(cornerRadius:15)
                    .fill(Color.white)
                VStack(alignment: .center) {
                    Image(imgnames[textidx])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.vertical,8.0)
                        .padding(.top,2.7)
                        .frame(height: 165)
                    Divider()
                        .padding(.top, -3.5)
                    Spacer()
                    CardView{
                        Text(maintext[textidx])
                            .foregroundColor(.black)
                            .font(.title)
                            .padding(.horizontal)
                            .padding()
                            .padding([.top, .bottom], 30)
                    }
                    Spacer()
                    HStack{
                        Button(action:{rightOpacity=100.0
                            if(textidx != 0){textidx = textidx - 1
                                if(textidx == 0){leftOpacity = 0.0}}}, label:{ Text("<").font(.largeTitle).foregroundColor(.black)})
                        .padding(.trailing)
                        .opacity(leftOpacity)
                        
                        HStack {
                            Text(String(textidx+1)).font(.title).foregroundColor(.black)
                        }.frame(width: 16.5)
                        Text(" / ").font(.title).foregroundColor(.black)
                        HStack {
                            Text("5").font(.title).foregroundColor(.black)
                        }.frame(width: 16.5)
                        
                        Button(action:{leftOpacity = 100.0
                            if(textidx != 4){textidx = textidx + 1
                                if(textidx == 4){rightOpacity = 0.0}}}, label:{Text(">").font(.largeTitle).foregroundColor(.black)})
                        .padding(.leading)
                        .opacity(rightOpacity)
                    }
                    .padding(.bottom)
                }
            }.padding([.top,.leading,.trailing])
                .padding(.bottom,35.0)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}


struct DetailDescription1: View {
    var body: some View {
        
        VStack {
            Text(" One of the many ways to bet with people in Korea is to play ladder games, which gives people a sense of urgency because of the non-overlapping nature of the outcomes. So you might think that you have the same odds no matter which number you choose, but that's not the case. Ladder games are the most unfair games because the odds are different at the start and end points, and there are ways to use this to increase your chances of winning." )
                .lineSpacing(10)
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}

struct DetailDescription2: View {
    var body: some View {
        
        VStack {
            Text(" In fact, a simulation of 1000 randomized ladders showed that there was a 21% chance that P4 would be the winner when the winner was on the 4th position, and only a 3.3% chance that P8 would be the winner. According to the law of large numbers, the probability of being a winner should be 12.5% regardless of the number, since more trials should approach the probability, but this was not the case. Similarly, if the first arrival was a winner, you were more likely to be a winner if you chose P1, and if the eighth arrival was a winner, you were more likely to be a winner if you chose P8." )
                .lineSpacing(20)
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}

struct DetailDescription3: View {
    var body: some View {
        
        VStack {
            Text(" The reason for this is that the first player's ladder and the last player's ladder are not connected. \n If you start on P1, there's a 100% chance that you'll move to P2's vertical row because there's at least one horizontal row in the middle. If there was only one horizontal row in the middle of P1, you would have a 0% chance of reaching the first destination when you picked P1. This is where the ladder already runs into trouble: if you start at P2, you have a 50% chance of moving to the ladder at P1 or P3.  In other words, the ladder is an unfair game by design." )
                .lineSpacing(20)
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}

struct DetailDescription4: View {
    var body: some View {
        
        VStack {
            Text(" The ladder game also determines your destination based on how many times you go through the horizontal rungs. If you go through the rungs an even number of times, you will land on an odd number of rungs, including yourself. For example, if you choose P1 and go through the rungs an even number of times, you will only reach the first destination, the third destination two spaces away, the fifth destination four spaces away, and the seventh destination six spaces away." )
                .lineSpacing(20)
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}

struct DetailDescription5: View {
    var body: some View {
        
        VStack {
            Text(" But that doesn't mean the ladder is always unfair: the more horizontal lines you draw, the closer the odds are to 12.5%. The number of horizontal lines needed depends on the number of vertical lines, and if n is the number of vertical lines, the formula is n(n-1)^2, which means that a ladder with 8 people will be fair when 392 horizontal lines are drawn. But that's not a realistic way to do it. And that's if you know where the winnings are. So what's the solution?" )
                .lineSpacing(20)
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}

struct DetailDescription6: View {
    var body: some View {
        
        VStack {
            Text(" The easiest way to fix this is to connect the lines at both ends. Hit the NEXT button below and let's go play some more fair ladder games." )
                .lineSpacing(20)
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}

struct Description_Previews: PreviewProvider {
    static var previews: some View {
        Description()
    }
}


