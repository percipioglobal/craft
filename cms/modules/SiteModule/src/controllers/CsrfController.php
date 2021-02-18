<?php

namespace modules\sitemodule\controllers;

use Craft;
use craft\web\Controller;

use yii\web\Response;

class CsrfController extends Controller
{
    // Constants
    // =========================================================================

    const GQL_TOKEN_NAME = 'API Token';

    // Protected Properties
    // =========================================================================

    protected $allowAnonymous = [
        'get-csrf',
        'get-gql-token',
        'get-field-options',
    ];

    // Public Methods
    // =========================================================================

    /**
     * @inheritdoc
     */
    public function beforeAction($action): bool
    {
        // Disable CSRF validation for get-csrf POST requests
        if ($action->id === 'get-csrf') {
            $this->enableCsrfValidation = false;
        }

        return parent::beforeAction($action);
    }

    /**
     * @return Response
     */
    // get the cur­rent CSRF token to val­i­date POST request submissions
    public function actionGetCsrf(): Response
    {
        return $this->asJson([
            'name' => Craft::$app->getConfig()->getGeneral()->csrfTokenName,
            'value' => Craft::$app->getRequest()->getCsrfToken(),
        ]);
    }

    /**
     * @return Response
     */
    // get a par­tic­u­lar GraphQL token for access permissions
    public function actionGetGqlToken(): Response
    {
        $result = null;
        $tokens = Craft::$app->getGql()->getTokens();
        foreach ($tokens as $token) {
            if ($token->name === self::GQL_TOKEN_NAME) {
                $result = $token->accessToken;
            }
        }

        return $this->asJson([
            'token' => $result,
        ]);
    }

    /**
     * Return all of the field options from the passed in array of $fieldHandles
     *
     * @return Response
     */
    // get the options in a Drop­down field in Craft CMS
    public function actionGetFieldOptions(): Response
    {
        $result = [];
        $request = Craft::$app->getRequest();
        $fieldHandles = $request->getBodyParam('fieldHandles');
        foreach ($fieldHandles as $fieldHandle) {
            $field = Craft::$app->getFields()->getFieldByHandle($fieldHandle);
            if ($field) {
                $result[$fieldHandle] = $field->options;
            }
        }

        return $this->asJson($result);
    }
}