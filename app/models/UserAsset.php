<?php

namespace App\models;

use App\User;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

/**
 * App\UserAsset
 *
 * @property int $id
 * @property int $user_id
 * @property int $asset_id
 * @property string $status
 * @property string $title
 * @property string $pic
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \App\models\Asset $asset
 * @property-read \App\User $user
 * @property-read \Illuminate\Database\Eloquent\Collection|\App\models\UserFormsData[] $user_forms_data
 * @property-read int|null $user_forms_data_count
 * @method static Builder|UserAsset newModelQuery()
 * @method static Builder|UserAsset newQuery()
 * @method static Builder|UserAsset query()
 * @method static Builder|UserAsset whereAssetId($value)
 * @method static Builder|UserAsset whereUserId($value)
 * @method static Builder|UserAsset whereStatus($value)
 * @method static Builder|UserAsset whereId($value)
 * @method static Builder|UserAsset whereCreatedAt($value)
 * @method static Builder|UserAsset whereUpdatedAt($value)
 * @mixin \Eloquent
 */
class UserAsset extends Model
{
    use HasFactory;

    protected $fillable = ['user_id', 'asset_id', 'status'];
    public $table = "user_assets";

    public function asset()
    {
        return $this->belongsTo(Asset::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function user_forms_data() {
        return $this->hasMany(UserFormsData::class);
    }

    public function is_in_form($form_field_id, $is_pic = false, $gallery = false) {

        $uId = Auth::user()->id;
        if($is_pic)
            return (DB::select("select count(*) as countNum from user_assets u, forms f, form_fields ff where u.asset_id = f.asset_id " .
                    "and u.user_id = " . $uId . " and f.id = ff.form_id and ff.type = 'FILE' and ff.id = " . $form_field_id)[0]->countNum > 0);

        if($gallery)
            return (DB::select("select count(*) as countNum from user_assets u, forms f, form_fields ff where u.asset_id = f.asset_id " .
                    "and u.user_id = " . $uId . " and f.id = ff.form_id and ff.type = 'GALLERY' and ff.id = " . $form_field_id)[0]->countNum > 0);

        return (DB::select("select count(*) as countNum from user_assets u, forms f, form_fields ff where u.asset_id = f.asset_id " .
            "and u.user_id = " . $uId . " and f.id = ff.form_id and ff.id = " . $form_field_id)[0]->countNum > 0);
    }

}
