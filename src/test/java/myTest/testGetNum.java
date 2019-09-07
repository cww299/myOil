package myTest;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

 

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:springMVC.xml","classpath:applicationContext.xml"})
@WebAppConfiguration
public class testGetNum {
	protected MockMvc mockMvc;

    @Autowired
    protected WebApplicationContext wac;

    @Before()
    public void setup()
    {
        mockMvc = MockMvcBuilders.webAppContextSetup(wac).build();  //初始化MockMvc对象
    }

    @Test
    public void listUser() throws Exception {
        String response = mockMvc.perform(
                get("/get")   //请求的url,请求的方法是get
                .contentType( MediaType.APPLICATION_FORM_URLENCODED ) //请求数据的格式是URL
                .param( "nowPage","2" )    //URL中的参数
                .param( "category","economics" ) 
            
        ).andExpect(status().isOk())  //返回的状态是200
                .andDo(print())  //打印出请求和相应的内容
                .andReturn().getResponse().getContentAsString(); //将相应的数据转换为字符串
        System.out.println(response);
    }
}
