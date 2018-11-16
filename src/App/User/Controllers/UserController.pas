(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit UserController;

interface

uses

    fano;

type

    (*!-----------------------------------------------
     * controller that handle route :
     * /user
     *
     * See Routes/User/routes.inc
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TUserController = class(TController, IDependency)
    private
        userList : IModelReader;
    public
        constructor create(
            const beforeMiddlewares : IMiddlewareCollection;
            const afterMiddlewares : IMiddlewareCollection;
            const viewInst : IView;
            const viewParamsInst : IViewParameters;
            const userListModel : IModelReader
        );
        destructor destroy(); override;

        function handleRequest(
            const request : IRequest;
            const response : IResponse
        ) : IResponse; override;
    end;

implementation

    constructor TUserController.create(
        const beforeMiddlewares : IMiddlewareCollection;
        const afterMiddlewares : IMiddlewareCollection;
        const viewInst : IView;
        const viewParamsInst : IViewParameters;
        const userListModel : IModelReader
    );
    begin
        inherited create(beforeMiddlewares, afterMiddlewares, viewInst, viewParamsInst);
        userList := userListModel;
    end;

    destructor TUserController.destroy();
    begin
        inherited destroy();
        userList := nil;
    end;

    function TUserController.handleRequest(
          const request : IRequest;
          const response : IResponse
    ) : IResponse;
    begin
        userList.read();
        result := inherited handleRequest(request, response);
    end;

end.
