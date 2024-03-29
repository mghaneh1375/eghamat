<?php

namespace App\Http\Controllers;

use App\Http\Resources\AssetDigest;
use App\models\Asset;
use App\models\UserSubAsset;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Validation\Rule;

class AssetController extends Controller {

//    public function __construct()
//    {
//        $this->authorizeResource(Asset::class);
//    }

    public function getVillage(Request $request) {

        $request->validate([
            "param" => "required"
        ]);

        $res = DB::connection("mysql2")->select("select name from state where name like '%" . $request["param"] . "%'");

        if($res != null && count($res) > 0) {
            $res = $res[0];
            return response()->json([
                "status" => "0",
                "id" => $res->id,
                "name" => $res->name,
                "city" => $res->city
            ]);
        }
        else {
            return response()->json([
                "status" => "1"
            ]);
        }
    }

    public function setGeom(Request $request) {

        $request->validate([
            "id" => "required|integer",
            "lat" => "required",
            "lng" => "required"
        ]);

        DB::connection("mysql2")->update ("update cities set checked = true, x = " . $request["lat"] . ", y = " . $request["lng"] . " where id = " . $request["id"]);
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function indexAPI() {
        return response()->json([
            'status' => 0,
            'assets' => AssetDigest::collection(Asset::whereSuperId(-1)->orderBy('view_index', 'asc')->get())
        ]);
    }

    public function index() {
        return view('asset', ['assets' => Asset::whereSuperId(-1)->get()]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(Request $request) {

        $request->validate([
            'name' => 'required',
            "mode" => ['required', Rule::in(["FULL", "HALF", "2/3", "1/3"])],
            'pic' => 'image',
            'create_pic' => 'image',
            'view_index' => 'required|integer|min:1|unique:assets,view_index'
        ]);

        $asset = new Asset();
        $asset->name = $request["name"];
        $asset->mode = $request["mode"];
        $asset->view_index = $request["view_index"];
        $asset->hidden = ($request->has("hidden")) ? true : false;

        $t = time();

        $file = $request->file('pic');
        $Image = $t . '.' . $request->file('pic')->extension();
        $destenationpath = __DIR__ . '/../../../public/assets';
        $file->move($destenationpath, $Image);
        $asset->pic = $Image;

        $file = $request->file('create_pic');
        $Image = ($t + 200) . '.' . $request->file("create_pic")->extension();
        $destenationpath = __DIR__ . '/../../../public/assets';
        $file->move($destenationpath, $Image);
        $asset->create_pic = $Image;
        $asset->save();

        return Redirect::to('asset');
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\models\Asset  $asset
     * @return \Illuminate\Http\Response
     */
    public function show(Asset $asset)
    {

    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\models\Asset  $asset
     * @return \Illuminate\Http\RedirectResponse
     */
    public function edit(Request $request, Asset $asset) {

        $request->validate([
            'name' => 'required',
            "mode" => 'required|in:FULL,HALF,2/3,1/3',
            'view_index' => 'required|integer|min:1'
        ]);

        $asset->name = $request["name"];
        $asset->mode = $request["mode"];

        if($asset->view_index != $request["view_index"] &&
            Asset::whereViewIndex($request["view_index"])->count() > 0)
            dd("اولویت نمایش باید منحصر به فرد باشد");

        $asset->view_index = $request["view_index"];
        $asset->hidden = ($request->has("hidden")) ? true : false;

        if($request->has("pic") && !empty($_FILES["pic"]["name"])) {

            if(file_exists(__DIR__ . '/../../../public/assets/' . $asset->pic))
                unlink(__DIR__ . '/../../../public/assets/' . $asset->pic);

            $file = $request->file('pic');
            $Image = time() . '.' . $request->file('pic')->extension();
            $destenationpath = __DIR__ . '/../../../public/assets';
            $file->move($destenationpath, $Image);
            $asset->pic = $Image;
        }

        if($request->has("create_pic") && !empty($_FILES["create_pic"]["name"])) {

            if(file_exists(__DIR__ . '/../../../public/assets/' . $asset->create_pic))
                unlink(__DIR__ . '/../../../public/assets/' . $asset->create_pic);

            $file = $request->file('create_pic');
            $Image = time() . '.' . $request->file("create_pic")->extension();
            $destenationpath = __DIR__ . '/../../../public/assets';
            $file->move($destenationpath, $Image);
            $asset->create_pic = $Image;
        }

        $asset->save();
        return Redirect::to('asset');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\models\Asset  $asset
     * @return \Illuminate\Http\JsonResponse
     */
    public static function destroy(Asset $asset) {

        DB::transaction(function () use ($asset) {

            if (file_exists(__DIR__ . '/../../../public/assets/' . $asset->create_pic))
                unlink(__DIR__ . '/../../../public/assets/' . $asset->create_pic);

            if (file_exists(__DIR__ . '/../../../public/assets/' . $asset->pic))
                unlink(__DIR__ . '/../../../public/assets/' . $asset->pic);

            $forms = $asset->forms;
            foreach ($forms as $form)
                FormController::destroy($form);

            if ($asset->super_id == -1) {

                $userAssets = $asset->user_assets();
                foreach ($userAssets as $userAsset)
                    UserAssetController::destroy($userAsset);

                $subAssets = Asset::whereSuperId($asset->id)->get();
                foreach ($subAssets as $subAsset)
                    AssetController::destroy($subAsset);
            }
            else {
                $userSubAssets = UserSubAsset::whereAssetId($asset->id)->get();
                foreach ($userSubAssets as $userSubAsset)
                    UserSubAssetController::destroy($userSubAsset);
            }

            $asset->delete();

        });

        return response()->json([
            "status" => "0"
        ]);
    }

}
