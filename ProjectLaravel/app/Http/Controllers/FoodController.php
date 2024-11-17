<?php

namespace App\Http\Controllers;

use App\Models\Food;
use App\Models\Category;
use Illuminate\Http\Request;

class FoodController extends Controller
{
    // Fetch all food items
    public function index()
    {
        return Food::with('category')->get();
    }

    // Store a new food item
    public function store(Request $request)
{
    // Validate the incoming request
    $validatedData = $request->validate([
        'title' => 'required|string|max:255',
        'description' => 'required|string',
        'image' => 'required|string',
        'rating' => 'required|numeric|min:0|max:5',
        'price' => 'required|numeric|min:0',
        'isFavourite' => 'required|boolean',
        'isPopular' => 'required|boolean',
        'categorieId' => 'required|numeric',
    ]);

    $food = new Food();
    $food->title = $validatedData['title'];
    $food->description = $validatedData['description'];
    $food->image = $validatedData['image'];
    $food->rating = $validatedData['rating'];
    $food->price = $validatedData['price'];
    $food->isFavourite = $validatedData['isFavourite'];
    $food->isPopular = $validatedData['isPopular'];
    $food->categorieId = $validatedData['categorieId'];

    // Enregistre le nouvel aliment
    $food->save();

    // Retourne la réponse JSON avec le nouvel aliment créé
    return response()->json($food, 201);
}

    // Show a specific food item by ID
    public function show($id)
    {
        $food = Food::with('category')->find($id); // Eager load the category

        if (!$food) {
            return response()->json(['message' => 'Food not found'], 404);
        }

        return response()->json($food);
    }

    // Update an existing food item
    public function update(Request $request, $id)
    {
        // Validate the incoming request
        $validatedData = $request->validate([
            'title' => 'sometimes|required|string|max:255',
            'description' => 'sometimes|required|string',
            'image' => 'sometimes|required|string',
            'rating' => 'sometimes|required|numeric|min:0|max:5',
            'price' => 'sometimes|required|numeric|min:0',
            'isFavourite' => 'sometimes|required|boolean',
            'isPopular' => 'sometimes|required|boolean',
            'category_id' => 'sometimes|required|exists:categorie,id',
        ]);

        $food = Food::find($id);

        if (!$food) {
            return response()->json(['message' => 'Food not found'], 404);
        }

        // Update the food item with validated data
        $food->update($validatedData);

        return response()->json($food);
    }

    // Delete a food item
    public function destroy($id)
    {
        $food = Food::find($id);

        if (!$food) {
            return response()->json(['message' => 'Food not found'], 404);
        }

        $food->delete();

        return response()->json(['message' => 'Food deleted successfully']);
    }
}
