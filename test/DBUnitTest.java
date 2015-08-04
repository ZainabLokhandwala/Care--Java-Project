/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.sql.ResultSet;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import zainab.DB;

/**
 *
 * @author Zainab
 */
public class DBUnitTest {
    
    public DBUnitTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }

    /**
     * Test of SQLSafe method, of class DB.
     */
    @Test
    public void testSQLSafe() {
        System.out.println("SQLSafe");
        String str = "Bad'\\x00 ;SQL' String";

        String expResult = "Bad'' ;SQL'' String";
        String result = DB.getC().SQLSafe(str);
        assertEquals(expResult, result);
        if(result.equalsIgnoreCase(expResult)){
            System.out.println("SQLSafeTest Passed");
        }else{
            fail("SQLSafe test failed");
        }
    }
    
     /**
     * Test of query method, of class DB.
     */
    @Test
    public void testQuery() throws Exception {
        System.out.println("query");
        String query = "select 1";
        int expResult = 1;
        ResultSet result = DB.getC().query(query);
        //assertEquals(result, 1);
        // TODO review the generated test code and remove the default call to fail.
        if(result.next()){
            if(1==result.getInt(1)){
                System.out.println("testQuery Passed");
            }else{
                fail("MySQL Problem");
            }
        }else{
             fail("DB Class Error");
        }
    }
}
