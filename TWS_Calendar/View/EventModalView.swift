//
//  EventModalView.swift
//  TWS_Calendar
//
//  Created by 濱本洸多 on 2021/05/30.
//

import SwiftUI
import PartialSheet

struct EventModalView: View {
    private let sheetManager: PartialSheetManager = PartialSheetManager()
    @Binding var selectedDate: Date
    @Binding var eventTargetAry: [CalendarEvent]
    @Binding var eventIsOpenAry: [Bool]
    @State private var offsets = (top: CGFloat.zero, middle: CGFloat.zero, bottom: CGFloat.zero)
    @State private var offset: CGFloat = 1500
    @State private var lastOffset: CGFloat = .zero

    var body: some View {
        GeometryReader { geometry in
            VStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.gray)
                    .frame(width: 100, height: 10)
                Text(selectedDate, style: .date)
                    .font(.title)
                    .padding()
                if !eventTargetAry.isEmpty {
                    List {
                        ForEach(0 ..< eventTargetAry.count, id: \.self) { index in
                            Group {
                                Text("タイトル: \(eventTargetAry[index].title)")
                                if eventIsOpenAry[index] {
                                    Text("説明: \(eventTargetAry[index].description)")
                                }
                            }
                            .onTapGesture {
                                if !eventIsOpenAry[index] {
                                    eventIsOpenAry[index] = true
                                } else {
                                    eventIsOpenAry[index] = false
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: min(self.offset, 20))
                    .stroke(Color.black)
            )
            .clipShape(RoundedRectangle(cornerRadius: min(self.offset, 20) ))
            .animation(.interactiveSpring())
            .onAppear {
                self.offsets = (
                    top: .zero,
                    middle: geometry.size.height / 2,
                    bottom: geometry.size.height * 3 / 4
                )
                self.offset = self.offsets.middle
                self.lastOffset = self.offset
            }
            .offset(y: self.offset)
            .gesture(DragGesture(minimumDistance: 5)
                .onChanged { v in
                    let newOffset = self.lastOffset + v.translation.height
                    if (newOffset > self.offsets.top && newOffset < self.offsets.bottom) {
                        self.offset = newOffset
                    }
                }
                .onEnded{ v in
                    if (self.lastOffset == self.offsets.top && v.translation.height > 0) {
                        if (v.translation.height < geometry.size.height / 2) {
                            self.offset = self.offsets.middle
                        } else {
                            self.offset = self.offsets.bottom
                        }
                    } else if (self.lastOffset == self.offsets.middle) {
                        if (v.translation.height < 0) {
                            self.offset = self.offsets.top
                        } else {
                            self.offset = self.offsets.bottom
                        }
                    } else if (self.lastOffset == self.offsets.bottom && v.translation.height < 0) {
                        if (abs(v.translation.height) > geometry.size.height / 2) {
                            self.offset = self.offsets.top
                        } else {
                            self.offset = self.offsets.middle
                        }
                    }
                    self.lastOffset = self.offset
                }
            )
        }
        .edgesIgnoringSafeArea(.all)
    }
}

/*
 
 */

struct EventModalView_Previews: PreviewProvider {
    static var previews: some View {
        EventModalView(selectedDate: .constant(Date()), eventTargetAry: .constant([]), eventIsOpenAry: .constant([]))
    }
}
