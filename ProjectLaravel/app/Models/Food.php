<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Food extends Model
{
    use HasFactory;

    protected $table = 'food';

    protected $fillable = [
        'title', 'description', 'image', 'rating', 'price', 'isFavourite', 'isPopular', 'categorieId'
    ];

    public function category()
    {
        return $this->belongsTo(Category::class);
    }
}
