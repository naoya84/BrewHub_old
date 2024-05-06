package jp.hasshi.api.controller

import jp.hasshi.api.demo.HelloController
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.status
import org.springframework.test.web.servlet.setup.MockMvcBuilders

// class SpyHelloService: HelloService{
//    var sayHello_wasCalled = false
//
//    override fun sayHello(): String {
//        sayHello_wasCalled = true
//        return ""
//    }
//
// }

class HelloControllerTest {
//    private var spyHelloService: SpyHelloService = SpyHelloService()
    private var mockMvc: MockMvc =
        MockMvcBuilders.standaloneSetup(
//        HelloController(helloService = spyHelloService)
            HelloController(),
        ).build()

    @Nested
    inner class `get_request` {
        // 【目的】api/helloのget apiが正しく動くかテストする
        @Test
        fun `status code OKを返す`()  {
            mockMvc
                .perform(get("/api/hello"))
                .andExpect(status().isOk)
        }

        // [目的] api/helloのget apiが"Hello"を返す
        @Test
        fun `helloを返す`()  {
            val resultValue =
                mockMvc
                    .perform(get("/api/hello"))
                    .andReturn()
            assertEquals(resultValue.response.contentAsString, "hello")
        }
    }
}
