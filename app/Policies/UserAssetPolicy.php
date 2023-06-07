<?php

namespace App\Policies;

use App\models\UserAsset;
use App\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class UserAssetPolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the user can view any models.
     *
     * @param  \App\User  $user
     * @return mixed
     */
    public function viewAny(User $user) {
        return true;
    }

    /**
     * Determine whether the user can view the model.
     *
     * @param  \App\User  $user
     * @param  \App\models\UserAsset  $userAsset
     * @return mixed
     */
    public function view(User $user, UserAsset $userAsset) {
        return true;
    }

    /**
     * Determine whether the user can create models.
     *
     * @param  \App\User  $user
     * @return mixed
     */
    public function create(User $user) {
        return true;
    }

    /**
     * Determine whether the user can update the model.
     *
     * @param  \App\User  $user
     * @param  \App\models\UserAsset  $userAsset
     * @return mixed
     */
    public function update(User $user, UserAsset $userAsset) {
        return ($user->id == $userAsset->user_id);
    }

    /**
     * Determine whether the user can delete the model.
     *
     * @param  \App\User  $user
     * @param  \App\models\UserAsset  $userAsset
     * @return mixed
     */
    public function delete(User $user, UserAsset $userAsset) {
        return ($user->id == $userAsset->user_id);
    }

    /**
     * Determine whether the user can restore the model.
     *
     * @param  \App\User  $user
     * @param  \App\models\UserAsset  $userAsset
     * @return mixed
     */
    public function restore(User $user, UserAsset $userAsset)
    {
        return false;
    }

    /**
     * Determine whether the user can permanently delete the model.
     *
     * @param  \App\User  $user
     * @param  \App\models\UserAsset  $userAsset
     * @return mixed
     */
    public function forceDelete(User $user, UserAsset $userAsset)
    {
        return false;
    }
}
