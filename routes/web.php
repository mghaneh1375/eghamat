<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

use App\Http\Controllers\AdminController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ReportController;
use App\Http\Controllers\UserAssetController;
use Illuminate\Support\Facades\Route;

Route::get('login', [AuthController::class, 'signIn'])->name("login");
Route::post('doLogin', [AuthController::class, 'doLogin'])->name("doLogin");
Route::get('home', [AuthController::class, 'signIn'])->name("home");
Route::get('/', [AuthController::class, 'signIn']);

Route::get('notifications', [AdminController::class, 'notifications'])->name("notifications");

Route::resource('asset', AssetController::class)->except('update', "edit", "create");
Route::post("asset/{asset}/edit", [AssetController::class, 'edit']);

Route::resource('asset.form', FormController::class)->shallow()->except('update', 'create');
Route::resource('form.form_field', FormFieldController::class)->shallow()->except('show', 'create');
Route::resource('asset.subAsset', SubAssetController::class)->shallow()->except('update', 'create');

Route::group(["prefix" => "report", "middleware" => ['auth', 'admin']], function () {

    Route::get('/', [ReportController::class, 'index']);

});

Route::group(["prefix" => "user_asset/{userAsset}", "middleware" => ['auth', 'admin']], function () {

    Route::get('/', [UserAssetController::class, 'show']);
    Route::delete('/', [UserAssetController::class, 'destroy']);

});

Route::group(["middleware" => ['auth', 'admin']], function () {

    Route::post('setAssetStatus/{userAsset}', [AdminController::class, 'setAssetStatus']);
    Route::get('logout', [AuthController::class, 'signOut'])->name('logout');

});