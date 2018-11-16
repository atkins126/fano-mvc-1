(*!------------------------------------------------------------
 * Fano Web Framework Skeleton Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-app
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-app/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit UserListingView;

interface

uses

    fano;

type

    (*!-----------------------------------------------
     * View instance for user listing page
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *------------------------------------------------*)
    TUserListingView = class(TInterfacedObject, IView)
    private
        userModel : IModelReader;
    public
        constructor create(const usr : IModelReader);
        destructor destroy(); override;

        (*!------------------------------------------------
         * render view
         *------------------------------------------------
         * @param viewParams view parameters
         * @param response response instance
         * @return response
         *-----------------------------------------------*)
        function render(
            const viewParams : IViewParameters;
            const response : IResponse
        ) : IResponse;
    end;

implementation

    constructor TUserListingView.create(const usr : IModelReader);
    begin
        userModel := usr;
    end;

    destructor TUserListingView.destroy();
    begin
        inherited destroy();
        userModel := nil;
    end;

    (*!------------------------------------------------
     * render view
     *------------------------------------------------
     * @param viewParams view parameters
     * @param response response instance
     * @return response
     *-----------------------------------------------*)
    function TUserListingView.render(
        const viewParams : IViewParameters;
        const response : IResponse
    ) : IResponse;
    var userData : IModelData;
        respBody : IResponseStream;
        numOfUser : integer;
    begin
        userData := userModel.data();
        respBody := response.body();
        numOfUser := userData.count();
        if (numOfUser > 0) then
        begin
            respBody.write(
                '<div class="container has-text-centered">' +
                '<div class="column is-6 is-offset-3">' +
                '<table>'
            );
            while userData.next() do
            begin
                respBody.write(
                    '<tr>' +
                    '<td>' + userData.readString('id') + '</td>' +
                    '<td>' + userData.readString('name') + '</td>' +
                    '<td>' + userData.readString('address') + '</td>' +
                    '</tr>'
                );
            end;
            respBody.write('</table></div></div>');
        end;
        result := response;
    end;

end.
