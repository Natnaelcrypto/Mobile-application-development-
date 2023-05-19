#### In this API we used ``MongoDB`` as database and ``nestjs`` as framework.
- ##### we used ``nestjs ``because it helps as to write our code in modular way.
- ##### we used ``MongoDB `` database because it help us to stor dynamic data since it is flexibility, in addition it is easly scalable.

#### API Structure
- ``src``
    - ``auth``
        - this directory contain the code for the authtication of user.
        - it uses jwt authtication.
        - we used it to secure the API by looking the the access token send from the request.
              
            #### ``for example`` in the **api/v1/herds/:id** Get request we called our guard @UseGuards(AuthGuard('jwt')) so every time a request come it lookes the access token and validat it. if it fail it will respond with status code of ``401 Unauthorized``.
            --------------------------------------------
                      @UseGuards(AuthGuard('jwt'))
                      @Get(':id')
                      find_herd(@Param('id') id: any, @Request() req: any) {
                        const find_user = req.user;
                        return this.herdService.find_herd(id);
                      }
               
               
            
    
