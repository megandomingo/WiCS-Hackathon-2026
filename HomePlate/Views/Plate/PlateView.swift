import SwiftUI
import PhotosUI
import UIKit

let cuisineOptions = [
    "Italian", "Japanese", "Mexican", "Thai", "Indian", "French", "Chinese", "Mediterranean",
    "Korean", "American", "Vietnamese", "Greek", "Spanish", "Lebanese", "Other"
]

enum RecipeType: String, CaseIterable {
    case none = "None"
    case link = "Link"
    case custom = "Custom"
}

struct PlateView: View {
    @State private var imageDataList: [Data] = []
    @State private var title = ""
    @State private var cuisine = ""
    @State private var description = ""
    @State private var recipeType: RecipeType = .none
    @State private var recipeLink = ""
    @State private var customRecipe = ""
    @State private var isPosting = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var selectedItems: [PhotosPickerItem] = []

    private func post() async {
        guard !imageDataList.isEmpty, !title.isEmpty, !cuisine.isEmpty, !description.isEmpty else {
            alertMessage = "Please fill in all required fields and add at least one image!"
            showAlert = true
            return
        }
        isPosting = true
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        imageDataList = []
        title = ""
        cuisine = ""
        description = ""
        recipeType = .none
        recipeLink = ""
        customRecipe = ""
        selectedItems = []
        isPosting = false
        alertMessage = "🎉 Meal posted successfully! Check for new achievements!"
        showAlert = true
    }

    private func loadSelectedPhotos() async {
        var loaded: [Data] = []
        for item in selectedItems {
            if let data = try? await item.loadTransferable(type: Data.self) {
                loaded.append(data)
            }
        }
        imageDataList = loaded
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Photos
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Photos *")
                            .font(.subheadline.weight(.semibold))
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 12) {
                            ForEach(Array(imageDataList.enumerated()), id: \.offset) { index, data in
                                ZStack(alignment: .topTrailing) {
                                    if let uiImage = UIImage(data: data) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                    }
                                    Button {
                                        imageDataList.remove(at: index)
                                        if selectedItems.count > index {
                                            selectedItems.remove(at: index)
                                        }
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundStyle(.white)
                                            .background(Circle().fill(.red))
                                    }
                                    .offset(x: 4, y: -4)
                                }
                            }
                            PhotosPicker(
                                selection: $selectedItems,
                                maxSelectionCount: 9 - imageDataList.count,
                                matching: .images
                            ) {
                                VStack(spacing: 8) {
                                    Image(systemName: "camera")
                                        .font(.title)
                                        .foregroundStyle(.secondary)
                                    Text("Add Photos")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                .frame(width: 100, height: 100)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [6]))
                                        .foregroundStyle(Color(.systemGray3))
                                )
                            }
                            .onChange(of: selectedItems) { _, _ in
                                Task { await loadSelectedPhotos() }
                            }
                        }
                    }

                    // Dish name
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Dish Name *")
                            .font(.subheadline.weight(.semibold))
                        TextField("e.g., Homemade Sushi Rolls", text: $title)
                            .textFieldStyle(.roundedBorder)
                    }

                    // Cuisine
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Cuisine Type *")
                            .font(.subheadline.weight(.semibold))
                        Picker("Cuisine", selection: $cuisine) {
                            Text("Select a cuisine").tag("")
                            ForEach(cuisineOptions, id: \.self) { option in
                                Text(option).tag(option)
                            }
                        }
                        .pickerStyle(.menu)
                    }

                    // Description
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Description *")
                            .font(.subheadline.weight(.semibold))
                        TextField("Tell us about your dish...", text: $description, axis: .vertical)
                            .lineLimit(4...8)
                            .textFieldStyle(.roundedBorder)
                    }

                    // Recipe (optional)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Recipe (Optional)")
                            .font(.subheadline.weight(.semibold))
                        Picker("Recipe type", selection: $recipeType) {
                            ForEach(RecipeType.allCases, id: \.self) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }
                        .pickerStyle(.segmented)

                        if recipeType == .link {
                            HStack(spacing: 8) {
                                Image(systemName: "link")
                                    .foregroundStyle(.secondary)
                                TextField("https://example.com/recipe", text: $recipeLink)
                                    .textFieldStyle(.roundedBorder)
                                    .keyboardType(.URL)
                            }
                        }
                        if recipeType == .custom {
                            TextField("Write your recipe here...", text: $customRecipe, axis: .vertical)
                                .lineLimit(6...12)
                                .textFieldStyle(.roundedBorder)
                        }
                    }

                    Button {
                        Task { await post() }
                    } label: {
                        Text(isPosting ? "Posting..." : "Share Your Plate")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(isPosting ? Color.gray : Color.orange)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .disabled(isPosting)
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Share Your Plate")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack(spacing: 2) {
                        Text("Share Your Plate")
                        Text("Document your home cooking journey")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .alert("HomePlate", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }
}
