import SwiftUI

let isIpadDevice: Bool = UIDevice.current.userInterfaceIdiom == .pad

enum StateFetcher {
    case loading
    case downloaded
    case none
}

struct FetcherView: View {
    @StateObject private var fetchViewModel = FetcherViewModel()
    @State private var isAllFetched: Bool = false
    @State private var isFetchedState: StateFetcher = .none
    
//    private var isIpadDevice: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    //                            .stroke(isFetchedState != StateFetcher.none ? .primaryGreen.opacity(0.1) : .grayBlack.opacity(0.2), lineWidth: 60)
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Color.black.edgesIgnoringSafeArea(.all)
                    
                    ForEach(0..<3) { index in
                        if isFetchedState != .downloaded {
                            Circle()
                                .fill(isFetchedState != StateFetcher.none ? .primaryGreen.opacity(0.1) : .grayBlack.opacity(0.2))
                                .frame(width: CGFloat(isIpadDevice ? 270 + index * 60 : 200 + index * 60), height: CGFloat(isIpadDevice ? 270 + index * 60 : 200 + index * 60))
                                .scaleEffect(isFetchedState == .loading ? 1.5 : 1.0)
                                .opacity(isFetchedState == .loading ? 0 : 1)
                                .animation(
                                    isFetchedState == .loading ? Animation.linear(duration: 3).repeatForever(autoreverses: true) : .default,
                                    value: isFetchedState
                                )
                                .zIndex(1)
                        } else {
                            Circle()
                                .fill(.primaryGreen.opacity(0.1))
                                .frame(width: CGFloat(isIpadDevice ? 270 + index * 60 : 200 + index * 60), height: CGFloat(isIpadDevice ? 270 + index * 60 : 200 + index * 60))
                                .zIndex(1)
                        }
                    }
                    
                    Button {
                        if isFetchedState != .none {
                            isFetchedState = .none
                        }
                        
                        Task {
                            isFetchedState = .loading
                            await fetchViewModel.fetchTodos(isAll: isAllFetched)
                            isFetchedState = .downloaded
                        }
                    } label: {
                        Image(systemName: "wifi")
                            .font(.system(size:  isIpadDevice ? 140 : 100))
                            .foregroundColor(isFetchedState != StateFetcher.none ? .primaryGreen : .white)
                            .padding(isIpadDevice ? 40 : 30)
                            .background {
                                Circle()
                                    .foregroundStyle(isFetchedState != StateFetcher.none ? .primaryGreen.opacity(0.15) : .grayBlack)
                            }
                    }
                    .zIndex(2)
                }
                
                HStack(spacing: 10) {
                    switch isFetchedState {
                    case .none:
                        Image("fingerTap")
                            .resizable()
                            .frame(width: isIpadDevice ? 36 : 28, height: isIpadDevice ? 36 : 28)
                            .foregroundStyle(.primaryGray)
                        
                        Text("Tap on the button to fetch todos")
                            .font(.system(size: isIpadDevice ? 18 : 14, weight: isIpadDevice ? .bold : .medium, design: .default))
                            .foregroundStyle(.primaryGray)
                    case .loading:
                        ProgressView()
                            .frame(width: isIpadDevice ? 36 : 28, height: isIpadDevice ? 36 : 28)
                            .tint(.primaryGray)
                        
                        Text("It’ll take a couple of seconds")
                            .font(.system(size: isIpadDevice ? 18 : 14, weight: isIpadDevice ? .bold : .medium, design: .default))
                            .foregroundStyle(.primaryGray)
                        
                    case .downloaded:
                        Image(systemName: "exclamationmark.circle.fill")
                            .resizable()
                            .frame(width: isIpadDevice ? 36 : 28, height: isIpadDevice ? 36 : 28)
                            .foregroundStyle(.primaryGray)
                        
                        Text("The fetch successfully completed.")
                            .font(.system(size: isIpadDevice ? 18 : 14, weight: isIpadDevice ? .bold : .medium, design: .default))
                            .foregroundStyle(.primaryGray)
                    }
                    
                    Spacer()
                }
                .padding(16)
                .background(.grayBlack.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .padding(.bottom, 24)
                                
                HStack {
                    NavigationLink(destination: ResultsView(viewModel: ResultsViewModel(todos: fetchViewModel.todos))) {
                        Text("Show Results")
                            .foregroundStyle(.black)
                            .font(.system(size: isIpadDevice ? 18 : 14, weight: isIpadDevice ? .bold : .medium, design: .default))
                            .padding(.horizontal, 36)
                            .padding(.vertical, 16)
                            .background(.primaryGreen.opacity(isFetchedState == StateFetcher.downloaded ? 1 : 0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                            .layoutPriority(1)
                    }
                    .disabled(isFetchedState == StateFetcher.downloaded ? false : true)
                    
                    Spacer()
                    
                    Toggle("", isOn: $isAllFetched)
                        .toggleStyle(PersonToggleStyle())
                        .disabled(isFetchedState == StateFetcher.loading ? true : false)
                }
                .padding(12)
                .background(.grayBlack.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 50))
            }
            .padding(.horizontal, isIpadDevice ? 24 : 16)
            .background(.black)
            .onDisappear {
                isFetchedState = .none
            }
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    FetcherView()
}


struct PersonToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Rectangle()
                .foregroundColor(configuration.isOn ? .green : .gray)
                .frame(width: isIpadDevice ? 80 : 50, height: isIpadDevice ? 40 : 30, alignment: .center)
                .overlay(
                    Circle()
                        .foregroundColor(.white)
                        .padding(.all, 3)
                        .offset(x: configuration.isOn ? isIpadDevice ? 20 : 11 : isIpadDevice ? -20 : -11, y: 0)
                )
                .overlay(
                    Image(systemName: configuration.isOn ? "person.fill" : "person")
                        .resizable()
                        .frame(width: isIpadDevice ? 20 : 16, height: isIpadDevice ? 20 : 16, alignment: .center)
                        .foregroundColor(.grayBlack)
                        .foregroundColor(configuration.isOn ? .green : .gray)
                        .offset(x: configuration.isOn ? isIpadDevice ? -20 : -11 : isIpadDevice ? 20 : 11, y: 0)
                )
                .cornerRadius(isIpadDevice ? 30 : 20)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}
