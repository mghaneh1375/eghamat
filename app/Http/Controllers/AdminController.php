<?php

namespace App\Http\Controllers;

use App\models\Notification;
use App\models\UserAsset;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class AdminController extends Controller {

    public function setAssetStatus(Request $request, UserAsset $userAsset) {

        $request->validate([
            'status' => ['required', Rule::in(['PENDING', 'REJECT', 'CONFIRM'])],
        ]);

        if($userAsset->status == "INIT") {
            return response()->json([
                "status" => -1,
                "msg" => "در حال حاضر مجاز به انجام چنین عملیاتی نیستید."
            ]);
        }

        $userAsset->status = $request["status"];
        $userAsset->save();
        return response()->json([
            "status" => 0
        ]);

    }

    public function notifications() {
        \DB::update("update notifications set seen = true where 1");
        return view('notifications', ['notifications' => Notification::orderBy('id', 'desc')->get()]);
    }
}
