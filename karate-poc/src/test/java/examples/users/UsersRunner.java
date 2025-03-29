package examples.users;

import com.intuit.karate.junit5.Karate;

public class UsersRunner{

    @Karate.Test
    Karate searchPet(){
//        return Karate.run("users").relativeTo(getClass()); -- se usa cuando se quiera ejecutar todos los escenarios del feature
        return Karate.run().tags("@UsersAllTags").relativeTo(getClass()); //se usa cuando se quiera ejecutar por tags indicado en el archivo feature
    }
}