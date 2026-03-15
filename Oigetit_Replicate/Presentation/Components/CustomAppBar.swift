//
//  CustomAppBar.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 15/03/26.
//

import SwiftUI

struct CustomAppBar: View {
    var body: some View {
        VStack{
            ZStack{
                VStack(alignment: .center){
                    Image(ImageSet.oigetitLogo)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 90)
                    Text("Fake News Filter")
                        .font(Font.caption2.bold())
                }
                .foregroundStyle(Color.white)
                
                HStack{
                    HStack(spacing: 24){
                        Button(
                            action: {}, // need implementation
                            label: {
                                Image(systemName: IconSet.menu)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width:20)
                                    .foregroundStyle(Color.white)
                            }
                        )
                        
                        Button(
                            action: {}, // need implementation
                            label: {
                                Text("P")
                                    .font(.default.bold())
                                    .foregroundStyle(ColorSet.red)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal,9)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(ColorSet.red, lineWidth: 1)
                                    )
                            }
                        )
                    }
                    
                    Spacer()
                    
                    HStack{
                        Button(
                            action: {}, // need implementation
                            label: {
                                HStack(spacing: 2){
                                    Image(IconSet.global)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20)
                                    Text("Global")
                                        .font(.footnote)
                                        .fontWeight(Font.Weight.heavy)
                                    Image(systemName: IconSet.chevronDown)
                                        .font(Font.caption2)
                                        .fontWeight(.semibold)
                                }
                                .foregroundStyle(Color.white)
                            }
                        )
                        
                        Button(
                            action: {}, // need implementation
                            label: {
                                Image(systemName: IconSet.profile)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20)
                                    .foregroundStyle(Color.white)
                                    .fontWeight(Font.Weight.light)
                                
                            }
                        )
                    }
                }
            }
            
            // search section
            HStack{
                HStack{
                    Image(systemName: IconSet.magnifyingGlass)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15)
                        .foregroundStyle(ColorSet.red)
                    
                    TextField("What News are you looking for?", text: .constant(""))
                        .font(.subheadline)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 10)
                .background(Color.white)
                .clipShape(Capsule())
                
                Spacer()
                
                Button(
                    action: {}, // need implementation
                    label: {
                        Image(systemName: IconSet.video)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                            .fontWeight(Font.Weight.light)
                            .foregroundStyle(Color.white)
                    }
                )
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 8)
        .background(ColorSet.blue.ignoresSafeArea(edges: .top))
        
    }
}


#Preview {
    CustomAppBar()
}
