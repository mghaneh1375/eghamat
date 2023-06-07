<?php

namespace App\Http\Controllers;

use App\models\UserAsset;
use Illuminate\Http\Request;

class ReportController extends Controller {

    public function index() {
        return view('report.userAssets', ['userAssets' => UserAsset::all()]);
    }


}
