<?php

namespace App\Policies;

use App\models\UserSubAsset;
use App\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class UserSubAssetPolicy
{
    use HandlesAuthorization;

    public function before($user, $ability) {
        if ($user->type == 'admin')
            return true;
    }

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
     * @param  \App\models\UserSubAsset  $userSubAsset
     * @return mixed
     */
    public function view(User $user, UserSubAsset $userSubAsset) {
        return ($user->id == $userSubAsset->user_id);
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
     * @param  \App\models\UserSubAsset  $userSubAsset
     * @return mixed
     */
    public function update(User $user, UserSubAsset $userSubAsset) {
        return ($user->id == $userSubAsset->user_id);
    }

    /**
     * Determine whether the user can delete the model.
     *
     * @param  \App\User  $user
     * @param  \App\models\UserSubAsset  $userSubAsset
     * @return mixed
     */
    public function delete(User $user, UserSubAsset $userSubAsset) {
        return ($user->id == $userSubAsset->user_id);
    }

    /**
     * Determine whether the user can restore the model.
     *
     * @param  \App\User  $user
     * @param  \App\models\UserSubAsset  $userSubAsset
     * @return mixed
     */
    public function restore(User $user, UserSubAsset $userSubAsset) {
        return false;
    }

    /**
     * Determine whether the user can permanently delete the model.
     *
     * @param  \App\User  $user
     * @param  \App\models\UserSubAsset  $userSubAsset
     * @return mixed
     */
    public function forceDelete(User $user, UserSubAsset $userSubAsset) {
        return false;
    }
}
