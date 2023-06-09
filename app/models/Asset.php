<?php

namespace App\models;

use App\User;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use phpDocumentor\Reflection\Types\Null_;

/**
 * App\Asset
 *
 * @property int $id
 * @property string $name
 * @property string|null $pic
 * @property string $mode
 * @property int $super_id
 * @property int $view_index
 * @property boolean $hidden
 * @property string|null $create_pic
 * @method static Builder|Asset newModelQuery()
 * @method static Builder|Asset newQuery()
 * @method static Builder|Asset query()
 * @method static Builder|Asset whereId($value)
 * @method static Builder|Asset whereSuperId($value)
 * @method static Builder|Asset whereViewIndex($value)
 * @method static Builder|Asset whereHidden($value)
 * @property-read \Illuminate\Database\Eloquent\Collection|\App\models\Form[] $forms
 * @property-read \Illuminate\Database\Eloquent\Collection|\App\models\UserAsset[] $user_assets
 * @property-read \Illuminate\Database\Eloquent\Collection|\App\models\UserSubAsset[] $user_sub_assets
 * @property-read int|null $user_assets_count
 * @property-read int|null $user_sub_assets_count
 * @property-read int|null $forms_count
 * @mixin \Eloquent
 */
class Asset extends Model
{
    use HasFactory;

    protected $fillable = ['name'];
    public $timestamps = false;

    public function forms() {
        return $this->hasMany(Form::class);
    }

    public function user_assets() {
        return $this->hasMany(UserAsset::class);
    }

    public function user_sub_assets() {
        return $this->hasMany(UserSubAsset::class);
    }
}
