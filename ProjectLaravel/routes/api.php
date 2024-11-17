<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\RegisterController;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\CategorieController;
use App\Http\Controllers\FoodController;
use App\Http\Controllers\ListCartController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::group(['middleware' => []], function () {
  // Registration and Login routes here (without middleware)
  Route::post('/register', [RegisterController::class, 'register']);
  Route::post('/login', [LoginController::class, 'login']);
  Route::get('/food', [FoodController::class, 'index']);
  Route::post('/insertFood', [FoodController::class, 'store']);
  Route::get('/categorie', [CategorieController::class, 'index']);
  Route::post('/insertCategorie', [CategorieController::class, 'store']);
  Route::get('/carts', [ListCartController::class, 'index']);
  Route::post('/saveCarts', [ListCartController::class, 'store']);
  Route::delete('/categorie/{id}', [CategorieController::class, 'destroy']);
    Route::delete('/food/{id}', [FoodController::class, 'destroy']);
});


Route::group(['middleware' => ['auth:api']], function () {
  // Protected API routes here...
});

