import SwiftUI

struct ResultsView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: ResultsViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                HStack(spacing: 10) {
                    Image("fingerTap")
                        .resizable()
                        .frame(width: isIpadDevice ? 36 : 28, height: isIpadDevice ? 36 : 28)
                        .foregroundStyle(.primaryGray)
                    
                    Text("Tap on the todo to change status ")
                        .font(.system(size: isIpadDevice ? 18 : 14, weight: isIpadDevice ? .bold : .medium, design: .default))
                        .foregroundStyle(.primaryGray)
                    
                    Spacer()
                }
                .padding(16)
                .background(.grayBlack.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .padding(.bottom, 24)
                
                VStack {
                    Text("Not completed")
                        .font(.system(size: isIpadDevice ? 18 : 12, weight: isIpadDevice ? .bold : .regular, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.primaryGray)
                    
                    Divider()
                        .background(.div.opacity(0.65))
                        .frame(height: 0.5)
                    
                    
                    ForEach(viewModel.todos.filter {!$0.completed }) { todo in
                        Button {
                            viewModel.toggleCompletion(for: todo)
                        } label: {
                            HStack {
                                Image(systemName: "multiply")
                                    .foregroundStyle(.primaryGray)
                                    .font(.system(size: isIpadDevice ? 30 : 20))
                                    .padding()
                                    .background(
                                        Circle()
                                            .fill(.grayBlack)
                                            .frame(width:  isIpadDevice ? 50 : 40, height:  isIpadDevice ? 50 : 40)
                                    )
                                    .clipShape(Circle())
                                
                                Text(todo.title)
                                    .font(.system(size: isIpadDevice ? 24 : 16, weight: .medium, design: .default))
                                    .foregroundStyle(.white)
                                
                                Spacer()
                                
                                Circle()
                                    .fill(.red)
                                    .frame(width: isIpadDevice ? 14 : 8)
                            }
                        }
                    }
                }
                .padding(.top, isIpadDevice ? 30 : 24)
                
                VStack {
                    Text("Completed")
                        .font(.system(size: isIpadDevice ? 18 : 12, weight: isIpadDevice ? .bold : .regular, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.primaryGray)
                    
                    Divider()
                        .background(.div.opacity(0.65))
                        .frame(height: 0.5)
                    
                    ForEach(viewModel.todos.filter {$0.completed }) { todo in
                        Button {
                            viewModel.toggleCompletion(for: todo)
                        } label: {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(.primaryGreen)
                                    .font(.system(size: isIpadDevice ? 30 : 20))
                                    .padding()
                                    .background(
                                        Circle()
                                            .fill(.grayBlack)
                                            .frame(width: isIpadDevice ? 50 : 40, height:  isIpadDevice ? 50 : 40)
                                    )
                                    .clipShape(Circle())
                                
                                Text(todo.title)
                                    .font(.system(size: isIpadDevice ? 24 : 16, weight: .medium, design: .default))
                                    .foregroundStyle(.white)
                                
                                Spacer()
                                
                                Circle()
                                    .fill(.green)
                                    .frame(width: isIpadDevice ? 14 : 8)
                            }
                        }
                    }
                }
                .padding(.top, isIpadDevice ? 30 : 24)
                
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Done")
                        .font(.system(size: isIpadDevice ? 18 : 14, weight: isIpadDevice ? .bold : .medium, design: .default))
                        .foregroundStyle(.black)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(.primaryGreen)
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                }
            }
        }
        .padding(isIpadDevice ? 24 : 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .navigationBarTitle("Todos", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                }
            }
                        
            
            ToolbarItem(placement: .principal) {
                Text("Todos")
                    .font(.custom("Helvetica Neue", size: isIpadDevice ? 32 : 24))
                    .foregroundColor(.white)
            }
        }
    }
}

//#Preview {
//    ResultsView()
//}
