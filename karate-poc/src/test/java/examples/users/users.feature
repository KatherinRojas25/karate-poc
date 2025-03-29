@UsersAllTags
Feature: Users

  Background:
    * url 'https://reqres.in/'

  @ListarUsuariosPages
  Scenario: Get All users
    Given   path 'api/users?page=2'
    When    method get
    Then    status 200

  @SingleUser
  Scenario Outline: <cp>. Obtener un usuario de la lista - cuando <descripcion>
    * def randomId = <randomId>
    Given path '/api/users/' + randomId
    When method get
    Then status <status>
    * print response
    * print randomId
    Examples:
      | cp | randomId | status | descripcion     |  |
      | 1  | 4        | 200    | caso exitoso    |  |
      | 2  | 15       | 404    | caso no exitoso |  |

  @ListResource
  Scenario: Visualizar la lista cuando no se le pasa valor ID
    Given path 'api/unknown'
    When method get
    Then status 200

  @SingleResources
  Scenario Outline: <cp>. Validar la respuesta del servicio SINGLE cuando <descripcion>
    * def randomId = <randomId>
    Given path 'api/unknown/' + randomId
    When method get
    Then status <status>
    Examples:
      | cp | randomId | status | descripcion                             |  |
      | 1  | 2        | 200    | envia un ID valido (Caso Exitoso)       |  |
      | 2  | 53       | 404    | envia un ID no valido (caso no exitoso) |  |

  @CrearUsuario
  Scenario: Create a user
    * def create_user_request =
    """
    {
      "name": "Katherin",
      "job": "leader"
    }
    """
    Given path '/api/users'
    And request create_user_request
    When method post
    Then status 201
    * def expectedName = create_user_request.name
    * def expectedJob = create_user_request.job
    And match response.name == expectedName
    And match response.job == expectedJob

  @ModificacionUserPut #PUT: reemplaza completo el registro del ID
  Scenario Outline: <cp>. Validar la actualizacion del registro del usuario - <descripcion>
    * def randomId = <randomId>
    Given path 'api/users/' + randomId
    And request <requestBody>
    When method put
    Then status <status>
    Examples:
      | cp | requestBody                                   | randomId | status | descripcion                       |  |
      | 1  | { "name": "morpheus", "job": "zion resident"} | 2        | 200    | envia un ID valido (Caso Exitoso) |  |

  @ModificacionUserPatch #PATCH: reemplaza pacialmente el registro del ID
  Scenario Outline: <cp>. Validar la actualizacion del registro del usuario - <descripcion> - PATCH
    * def randomId = <randomId>
    Given path 'api/users/' + randomId
    And request <requestBody>
    When method patch
    Then status <status>
    Examples:
      | cp | requestBody           | randomId | status | descripcion                       |  |
      | 1  | { "name": "morpheus"} | 2        | 200    | envia un ID valido (Caso Exitoso) |  |

  @EliminarRegistroDelete #DELETE
  Scenario Outline: <cp>. Validar la eliminacion del registro del usuario - <descripcion>
    * def randomId = <randomId>
    Given path 'api/users/' + randomId
    And request <requestBody>
    When method delete
    Then status <status>
    Examples:
      | cp | requestBody           | randomId | status | descripcion  |  |
      | 1  | { "name": "morpheus"} | 2        | 204    | Caso Exitoso |  |

  @CreacionRegistro #POSTRegister
  Scenario Outline: <cp>. Validar el registro del usuario - <descripcion> - POST - Register
    Given path '/api/register'
    And request <requestBody>
    When method POST
    Then status <status>
    Examples:
      | cp | requestBody                                          | status | descripcion     |
      | 1  | {"email": "sydney@fife"}                             | 400    | Caso No Exitoso |
      | 2  | {"email": "eve.holt@reqres.in","password": "pistol"} | 200    | Caso Exitoso    |

  @CreacionLogin #POST_Login
  Scenario Outline: <cp>. Validar el Login del usuario - <descripcion> - POST - Login
    Given path '/api/login'
    And request <requestBody>
    When method POST
    Then status <status>
    Examples:
      | cp | requestBody                                              | status | descripcion     |
      | 1  | {"email": "sydney@fife"}                                 | 400    | Caso No Exitoso |
      | 2  | {"email": "eve.holt@reqres.in","password": "cityslicka"} | 200    | Caso Exitoso    |

  @CreacionLogin #GET_DELAYED
  Scenario Outline: <cp>. Validar la lista del ID delay <descripcion> - GET DELAYED
    * def randomId = <randomId>
    Given path '/api/users?delay=' + randomId
    When method GET
    Then status <status>
    Examples:
      | cp | randomId | status | descripcion  |
      | 1  | 2        | 200    | Caso Exitoso |
