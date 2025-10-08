//  Created by MaicolZZAA on 30/09/25.
//

import SwiftUI

struct IMCView: View {
    @State var gender:Int = 0
    @State var height:Double = 150
    @State var age:Int = 0
    @State var weight:Int = 0
    
    var body: some View {
        VStack {
            HStack{
                ToggleButton(text: "Men ♂️", imageName: "person.circle", gender: 0, selectedGender: $gender)
                ToggleButton(text: "Woman ♀️", imageName: "person.circle.fill", gender: 1, selectedGender: $gender)
            }
            HeightCalculator(selectedHeight: $height)
            HStack{
                ageSelect(selectAge: $age)
                weightSelect(selectWeight: $weight)
            }
            calculateDate(weight: weight, height: height, gender: gender, age: age)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundApp"))
            //.navigationBarBackButtonHidden()
            .toolbar{
            ToolbarItem(placement: .principal){
                Text("IMC Calculator")
                    .foregroundColor(.white)
                    .bold()
            }
        }
    }
}

struct ToggleButton: View {
    let text: String
    let imageName: String
    let gender: Int
    @Binding var selectedGender: Int
    
    var body: some View {
        let color = gender == selectedGender
            ? Color("BackgroundCSelect")
            : Color("BackgroundComponent")
        
        Button(action: {
            withAnimation {
                selectedGender = gender
            }
        }) {
            VStack {
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFit()
                    .foregroundColor(.white)
                InformationText(text: text)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(color)
            .transition(.opacity)
            .cornerRadius(20)
        }
    }
}

struct InformationText:View{
    let text:String
    var body: some View{
        Text(text)
            .font(.largeTitle)
            .bold()
            .foregroundColor(.white)
    }
}

struct TitleText:View{
    let text:String
    var body: some View{
        Text(text)
            .font(.title)
            .foregroundColor(.gray)
    }
}

struct HeightCalculator:View{
    @Binding var selectedHeight:Double
    var body: some View{
        VStack{
            TitleText(text: "Height")
            InformationText(text: "\(Int(selectedHeight)) cm")
            Slider(value: $selectedHeight, in:80...220, step: 1)
                .accentColor(.purple)
                .padding(.horizontal, 20)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundComponent"))
            .cornerRadius(20)
    }
}

struct ageSelect:View{
    @Binding var selectAge:Int
    var body: some View{
        VStack{
            TitleText(text: "Age")
            InformationText(text: String(selectAge))
            HStack{
                Button(action: {
                    if(selectAge<100)
                    {
                        selectAge += 1
                    }}) {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 25, height: 25)
                }.frame(maxWidth: .infinity, maxHeight: 85)
                    .background(.purple)
                    .cornerRadius(100)
                    .foregroundColor(.white)
                    .padding(10)
                
                Button(action: {
                    if(selectAge>0)
                    {
                        selectAge -= 1
                    }}) {
                    Image(systemName: "minus")
                        .resizable()
                        .frame(width: 20, height: 7)
                }.frame(maxWidth: .infinity, maxHeight: 85)
                    .background(.purple)
                    .cornerRadius(100)
                    .foregroundColor(.white)
                    .padding(10)

            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundComponent"))
            .cornerRadius(20)
    }
}

struct weightSelect:View{
    @Binding var selectWeight:Int
    var body: some View{
        VStack{
            TitleText(text: "Weight")
            InformationText(text: String(selectWeight))
            HStack{
                Button(action: {
                    if(selectWeight<200)
                    {
                        selectWeight += 1
                    }}) {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 25, height: 25)
                }.frame(maxWidth: .infinity, maxHeight: 85)
                    .background(.purple)
                    .cornerRadius(100)
                    .foregroundColor(.white)
                    .padding(10)
                
                Button(action: {
                    if(selectWeight>0)
                    {
                        selectWeight -= 1
                    }}) {
                    Image(systemName: "minus")
                        .resizable()
                        .frame(width: 20, height: 7)
                }.frame(maxWidth: .infinity, maxHeight: 85)
                    .background(.purple)
                    .cornerRadius(100)
                    .foregroundColor(.white)
                    .padding(10)

            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundComponent"))
            .cornerRadius(20)
    }
}

struct calculateDate: View {
    var weight: Int
    var height: Double
    var gender: Int
    var age: Int
    
    @State private var mostrarResultado = false
    
    var body: some View {
        VStack {
            if mostrarResultado {
                calculateResult(weight: weight, height: height)
            } else {
                Button(action: {
                    mostrarResultado = true
                }) {
                    Text("Calculate")
                        .frame(maxWidth: .infinity, maxHeight: 70)
                        .foregroundColor(.white)
                        .background(Color("BackgroundCSelect"))
                        .cornerRadius(50)
                }
            }
        }
        //Every time you change any of these values, the button is reset.
        .onChange(of: weight) { _ in mostrarResultado = false }
        .onChange(of: height) { _ in mostrarResultado = false }
        .onChange(of: gender) { _ in mostrarResultado = false }
        .onChange(of: age) { _ in mostrarResultado = false }
    }
}


struct calculateResult: View {
    var weight: Int
    var height: Double
    
    var imc: Double {
        let heightMeters = height / 100
        return Double(weight) / (heightMeters * heightMeters)
    }
    
    var body: some View {
        VStack {
            Text("Your IMC is \(String(format: "%.2f", imc))")
                .frame(maxWidth: .infinity, maxHeight: 70)
                .foregroundColor(.white)
                .background(Color("BackgroundCSelect"))
                .cornerRadius(50)
        }
    }
}

struct IMCView_Previews: PreviewProvider {
    static var previews: some View {
        IMCView()
    }
}
