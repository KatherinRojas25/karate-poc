package examples.users;

import com.intuit.karate.junit5.Karate;

public class UsersRunner{

    @Karate.Test
    Karate searchPet(){
//        return Karate.run("users").relativeTo(getClass());
        return Karate.run().tags("@UsersAllTags").relativeTo(getClass());
    }
}