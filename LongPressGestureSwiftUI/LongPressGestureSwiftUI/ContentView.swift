//
//  ContentView.swift
//  LongPressGestureSwiftUI
//
//  Created by Michael Parekh on 2/9/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var isComplete: Bool = false
    @State var isSuccess: Bool = false
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                // Determines the progress of the blue bar.
                .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
            
            HStack {
                Text("CLICK HERE")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) { (isPressing) in
                        // Called from start of press => minimumDuration.
                        if isPressing {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                // Move the blue bar to the right as we are pressing.
                                isComplete = true
                            }
                        } else {
                            // If we stop pressing the button, then move the bar back.
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                // Run the DispatchQueue with delay because 'perform' may run at the same time.
                                if !isSuccess {
                                    withAnimation(.easeInOut) {
                                        isComplete = false
                                    }
                                }
                            }
                        }
                    } perform: {
                        // Called at the minimumDuration.
                        withAnimation(.easeInOut) {
                            // Change the color of the bar to green when successful.
                            isSuccess = true
                        }
                    }

                Text("RESET")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        isComplete = false
                        isSuccess = false
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
