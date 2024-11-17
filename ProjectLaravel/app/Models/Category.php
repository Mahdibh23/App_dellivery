<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    use HasFactory;

    protected $table = 'categorie';

    protected $fillable = ['name', 'icon'];

    public function foods()
    {
        return $this->hasMany(Food::class);
    }
}
