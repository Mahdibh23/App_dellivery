<?php
namespace App\Http\Controllers;

use App\Models\ListCart;
use Illuminate\Http\Request;

class ListCartController extends Controller
{
    public function index()
    {
        return response()->json(ListCart::all());
    }

    public function store(Request $request)
    {
        $request->validate([
            'foods' => 'required|array',
            'total_price' => 'required|numeric',
        ]);

        $listCart = ListCart::create($request->all());
        return response()->json($listCart, 201);
    }

    public function show($id)
    {
        $listCart = ListCart::findOrFail($id);
        return response()->json($listCart);
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'foods' => 'sometimes|array',
            'total_price' => 'sometimes|numeric',
        ]);

        $listCart = ListCart::findOrFail($id);
        $listCart->update($request->all());
        return response()->json($listCart);
    }

    public function destroy($id)
    {
        ListCart::findOrFail($id)->delete();
        return response()->json(null, 204);
    }
}
