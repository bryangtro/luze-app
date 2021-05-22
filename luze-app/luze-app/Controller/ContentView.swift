//
//  ContentView.swift
//  luze-app
//
//  Created by Bryan Guntoro on 20/5/21.
//

import Foundation
import SwiftUICharts
import SwiftUI

struct ContentView: View {

    
    let palette1 = Color(hex: "#FFAEBC")
    var productivityArr: [Double] {return getProductivityList()}
    var completionArr: [Double] {return getCompletionList()}


    
    var body: some View {
        VStack {
            Text("Luze Statistics")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.custom("Helevetica Nueu", size: 25))
                .foregroundColor(palette1)
                .padding()
        }
        VStack {
            // Line Chart
            LineChartView(data: [productivityArr[4], productivityArr[3] , productivityArr[2], productivityArr[1], productivityArr[0]], title: "Productivity View", legend: "Last 5 Days", form: ChartForm.large, rateValue: 0)
                .padding()
        }
        VStack {
            // Line Chart
            LineChartView(data: [completionArr[4], completionArr[3], completionArr[2], completionArr[1], completionArr[0]], title: "Task Completion", legend: "Last 5 Days", form: ChartForm.large, rateValue: 0)
                .padding()
        }
        Spacer()
        
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




