<?php

use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Auth\PasswordResetController;
use App\Http\Controllers\AttachmentController;
use Illuminate\Support\Facades\Route;

Route::prefix('v1')->group(function () {

    Route::prefix('webhooks')->group(function () {
        //
    });

    Route::post('/login', [AuthController::class, 'login']);
    Route::post('/register', [AuthController::class, 'register']);
    Route::post('/forgot-password', [AuthController::class, 'startPasswordReset']);
    Route::post('/reset-password', [PasswordResetController::class, 'apiUpdatePassword']);

    Route::middleware('auth:sanctum')->group(function () {
        Route::get('/check-bearer-token', function () {
            return response()->json('User exists and Bearer token is valid');
        });

        Route::post('attachment', [AttachmentController::class, 'addAttachment']);
        Route::delete('attachment', [AttachmentController::class, 'destroyAllAttachment']);

        Route::apiResources([
            //
        ]);
    });
});
