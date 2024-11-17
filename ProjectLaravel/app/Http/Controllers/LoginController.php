<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class LoginController extends Controller
{
    public function login(Request $request)
    {
        // Validation des données d'entrée
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 422);
        }

        $credentials = $request->only('email', 'password');

        // Tentative d'authentification de l'utilisateur
        if (Auth::attempt($credentials)) {
            $user = Auth::user();
            // Générer un jeton (considérez l'utilisation de Laravel Sanctum pour JWT)
            $token = $user->createToken('MyAppToken');

            return response()->json([
                'message' => 'Connexion réussie',
                'user' => $user,
                'token' => $token->plainTextToken, // Utiliser plainTextToken au lieu de plainText
            ]);
        } else {
            return response()->json(['error' => 'Identifiants invalides'], 401);
        }
        print(response);
    }
}

