<?php

namespace App\Policies;

use App\State;
use App\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class StatePolicy
{
    use HandlesAuthorization;

    public function before($user, $ability)
    {
        if ($user->type == 'admin')
            return true;
    }

    /**
     * Determine whether the user can view any models.
     *
     * @param User $user
     * @return mixed
     */
    public function viewAny(?User $user)
    {
        return true;
    }

    /**
     * Determine whether the user can view the model.
     *
     * @param User $user
     * @param  \App\State  $state
     * @return mixed
     */
    public function view(?User $user, State $state)
    {
        return true;
    }

    /**
     * Determine whether the user can create models.
     *
     * @param User $user
     * @return mixed
     */
    public function create(User $user)
    {
        return false;
    }

    /**
     * Determine whether the user can update the model.
     *
     * @param User $user
     * @param  \App\State  $state
     * @return mixed
     */
    public function update(User $user, State $state)
    {
        return false;
    }

    /**
     * Determine whether the user can delete the model.
     *
     * @param User $user
     * @param  \App\State  $state
     * @return mixed
     */
    public function delete(User $user, State $state)
    {
        return false;
    }

    /**
     * Determine whether the user can restore the model.
     *
     * @param User $user
     * @param  \App\State  $state
     * @return mixed
     */
    public function restore(User $user, State $state)
    {
        return false;
    }

    /**
     * Determine whether the user can permanently delete the model.
     *
     * @param User $user
     * @param  \App\State  $state
     * @return mixed
     */
    public function forceDelete(User $user, State $state)
    {
        return false;
    }
}
