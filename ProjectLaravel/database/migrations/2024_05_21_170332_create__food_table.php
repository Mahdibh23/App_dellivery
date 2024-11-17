<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateFoodTable extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        if (!Schema::hasTable('food')) {
            Schema::create('food', function (Blueprint $table) {
                $table->id();
                $table->string('title');
                $table->text('description')->nullable();
                $table->string('image')->nullable();
                $table->decimal('rating', 5, 2)->default(0.0);
                $table->decimal('price', 8, 2);
                $table->boolean('isFavourite')->default(false);
                $table->boolean('isPopular')->default(false);
                $table->unsignedBigInteger('categorieId');
                $table->foreign('categorieId')->references('id')->on('categorie');
                $table->timestamps();
            });
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('food');
    }
}
