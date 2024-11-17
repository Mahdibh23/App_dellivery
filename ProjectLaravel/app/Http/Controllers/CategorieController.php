<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\Category;

class CategorieController extends Controller
{
    public function index()
    {
        $categories = Category::all();
        return response()->json($categories);
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string',
            'icon' => 'required|string',
        ]);

        $category = new Category();
        $category->name = $request->name;
        $category->icon = $request->icon;

        $category->save();

        return response()->json($category, 201);
    }
    public function destroy($id)
    {
        $category = Category::find($id);

        if ($category) {
            $category->delete();
            return response()->json(['message' => 'Category deleted successfully']);
        }

        return response()->json(['message' => 'Category not found'], 404);
    }
}
