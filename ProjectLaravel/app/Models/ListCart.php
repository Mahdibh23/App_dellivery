<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ListCart extends Model
{
    use HasFactory;
    protected $fillable = ['foods', 'total_price'];

    protected $casts = [
        'foods' => 'array',
    ];
}
