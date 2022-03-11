//
//  SwiftUI+Extension.swift
//  XMusic
//
//  Created by teenloong on 2022/3/12.
//

import SwiftUI
import CoreData

#if DEBUG
struct SwiftUI_Extension: View {
    let data = ["Albemarle", "Brandywine", "Chesapeake", "asdsad", "sfdgd", "dfgd", "fbnbvb"]//Array(repeating: "asdasdasd", count: 50)
    var body: some View {
        VStack {
            MultilineHStack(data) { item in
                Text(item)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .background(Color.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            .background(Color.blue)
            MultilineHStack(data) { item in
                Text(item)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .background(Color.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            .background(Color.green)
            Text("testest")
            Spacer()
        }
    }
}

struct SwiftUI_Extension_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_Extension()
    }
}
#endif

//参考 https://stackoverflow.com/questions/62102647/swiftui-hstack-with-wrap-and-dynamic-height
struct MultilineHStack<Data: RandomAccessCollection,  Content: View>: View where Data.Element: Hashable {
    let data: Data
    let HSpacing: CGFloat
    let VSpacing: CGFloat
    let content: (Data.Element) -> Content
    @State private var totalHeight = CGFloat.zero
    
    init(_ data: Data, HSpacing: CGFloat = 10, VSpacing: CGFloat = 10, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.HSpacing = HSpacing
        self.VSpacing = VSpacing
        self.content = content
    }
    
    var body: some View {
        var width: CGFloat = .zero
        var height: CGFloat = .zero
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                ForEach(data, id: \.self) { item in
                    content(item)
                        .alignmentGuide(.leading, computeValue: { dimension in
                            if abs(width + dimension.width) > geometry.size.width {
                                width = 0
                                height += dimension.height + VSpacing
                            }
                            let result = width
                            if item == data.last {
                                width = 0
                            }else {
                                width += dimension.width + HSpacing
                            }
                            return -result
                        })
                        .alignmentGuide(.top, computeValue: { dimension in
                            let result = height
                            if item == data.last {
                                height = 0
                            }
                            return -result
                        })
                }
            }
            .background(viewHeightReader($totalHeight))
        }
        .frame(height: totalHeight)
    }
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

//参考 https://stackoverflow.com/questions/62102647/swiftui-hstack-with-wrap-and-dynamic-height
struct MultilineHStackScrollable<Data: RandomAccessCollection,  Content: View>: View where Data.Element: Hashable {
    let data: Data
    let geometry: GeometryProxy
    let HSpacing: CGFloat
    let VSpacing: CGFloat
    let content: (Data.Element) -> Content

    init(_ data: Data, geometry: GeometryProxy, HSpacing: CGFloat = 10, VSpacing: CGFloat = 10, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.geometry = geometry
        self.HSpacing = HSpacing
        self.VSpacing = VSpacing
        self.content = content
    }
    var body: some View {
        var width: CGFloat = 0
        var height: CGFloat = 0
        
        ZStack(alignment: .topLeading) {
            ForEach(data, id: \.self) { item in
                content(item)
                    .alignmentGuide(.leading, computeValue: { dimension in
                        if abs(width + dimension.width) > geometry.size.width {
                            width = 0
                            height += dimension.height + VSpacing
                        }
                        let result = width
                        if item == data.last {
                            width = 0
                        }else {
                            width += dimension.width + HSpacing
                        }
                        return -result
                    })
                    .alignmentGuide(.top, computeValue: { dimension in
                        let result = height
                        if item == data.last {
                            height = 0
                        }
                        return -result
                    })
            }
        }
    }
}

struct FetchedResultsView<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    let content: (FetchedResults<T>) -> Content

    var body: some View {
        content(fetchRequest.wrappedValue)
    }

    init(entity: NSEntityDescription, sortDescriptors: [NSSortDescriptor] = [], predicate: NSPredicate? = nil, @ViewBuilder content: @escaping (FetchedResults<T>) -> Content) {
        self.fetchRequest = FetchRequest<T>(entity: entity, sortDescriptors: sortDescriptors, predicate: predicate)
        self.content = content
    }
}

struct VGridView<Data: RandomAccessCollection,  Content: View>: View where Data.Element: Identifiable {
    let data: Data
    let content: (Data.Element) -> Content
    let gridColumns: Int
    init(_ data: Data, gridColumns: Int, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.gridColumns = gridColumns
        self.content = content
    }
    var body: some View {
        ScrollView {
            let columns: [GridItem] = Array<GridItem>(repeating: .init(.flexible()), count: gridColumns)
            LazyVGrid(columns: columns) /*@START_MENU_TOKEN@*/{
                ForEach(data) { item in
                    content(item)
                }
            }/*@END_MENU_TOKEN@*/
        }
    }
}
