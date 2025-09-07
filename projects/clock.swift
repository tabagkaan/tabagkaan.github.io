import SwiftUI

struct ContentView: View {
    @State private var saat = 0
    @State private var dk = 0
    
    var minuteAngle: Angle{
        Angle.degrees((Double(dk) * 6))
    }
    var hourAngle: Angle {
        let base = Double(saat % 12) * 30.0
        let quarter = Double((dk) / 2)
        return Angle.degrees(base + quarter)
        
    }
    
    
    
    var body: some View {
      
       
        
        ZStack {
            Button("- Hour") {
                saat = (saat + 23) % 24  // 0 → 23, others -1
            }
                .font(.title)
                .offset(x: -70, y:250)
                .buttonStyle(.bordered)
            Button("+ Hour") { 
                if saat == 23{ 
                    saat = 0 
                } else  {   
                    saat = saat + 1 } }
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .offset(x: 70, y:250)
                .buttonStyle(.bordered)
            Button("+ Minute") { 
               if dk == 59{ 
                dk = 0 
                if saat == 23{ 
                       saat = 0 
                } else  {   
                       saat = saat + 1 } 
                   
             } else  {   
                dk = dk + 1 } }
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .offset(x: 81, y:330)
                .buttonStyle(.bordered)
            Button("- Minute") {
                if (dk + 59) % 60 == 59{
                    saat = (saat + 23) % 24
                    dk = (dk + 59) % 60
                } else { dk = dk - 1 }
                  // 0 → 23, others -1
             }
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .offset(x: -81, y:330)
                .buttonStyle(.bordered)
            
            if saat < 12 {
                    Circle()
                    .frame(width: 400)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .opacity(saat % 2 == 0 ? 0.5 : 1)
            } else {
                Circle()
                    .frame(width: 400)
                    .foregroundColor(.white)
                    .opacity(saat % 2 == 0 ? 0.5 : 1)                
                
            }
            Rectangle()
                .offset(y: -50)
                .frame(width: 20, height: 100)
                .foregroundColor(.pink)
                .rotationEffect(hourAngle)
            Rectangle()
                .offset(y: -75)
                .frame(width: 10, height: 150)
                .foregroundColor(.red)
                .opacity(0.8)
                .overlay(Circle().stroke(.black, lineWidth:50))
                .rotationEffect(minuteAngle)
            
            Text("Hour: \(saat):\(dk)")
                .offset(y:-400)
                .font(.largeTitle)
            
            

                
            
        }
        .onTapGesture {
            dk += 1
            if dk == 1 {dk = 0
                saat = (saat + 1) % 24
                
            }
        }
        .animation(.smooth(duration: 0.5), value: hourAngle)
        .animation(.smooth(duration: 0.5), value: minuteAngle)
    }
}

