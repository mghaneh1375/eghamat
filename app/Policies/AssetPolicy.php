<?php

namespace App\Policies;

use App\models\Asset;
use App\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class AssetPolicy
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
    public function viewAny(?User $user) {
        return true;
    }

    /**
     * Determine whether the user can view the model.
     *
     * @param \App\User $user
     * @param Asset $asset
     * @return mixed
     */
    public function view(?User $user, Asset $asset) {
        return true;
    }

    /**
     * Determine whether the user can create models.
     *
     * @param  \App\User  $user
     * @return mixed
     */
    public function create(User $user) {

        if ($user->type == 'admin')
            return true;

        return false;
    }

    /**
     * Determine whether the user can update the model.
     *
     * @param \App\User $user
     * @param Asset $asset
     * @return mixed
     */
    public function update(User $user, Asset $asset)
    {
        if ($user->type == 'admin')
            return true;

        return false;
    }

    /**
     * Determine whether the user can delete the model.
     *
     * @param \App\User $user
     * @param Asset $asset
     * @return mixed
     */
    public function delete(User $user, Asset $asset)
    {
        if ($user->type == 'admin')
            return true;

        return false;
    }

    /**
     * Determine whether the user can restore the model.
     *
     * @param \App\User $user
     * @param Asset $asset
     * @return mixed
     */
    public function restore(User $user, Asset $asset)
    {
        if ($user->type == 'admin')
            return true;

        return false;
    }

    /**
     * Determine whether the user can permanently delete the model.
     *
     * @param \App\User $user
     * @param Asset $asset
     * @return mixed
     */
    public function forceDelete(User $user, Asset $asset)
    {
        return false;
    }
}
