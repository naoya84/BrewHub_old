package jp.hasshi.api

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.status
import org.springframework.test.web.servlet.setup.MockMvcBuilders

class SpyReportService(): ReportService{
    var create_wasCalled = false
    override fun create(): Report {
        create_wasCalled = true
        return Report(id = 1, text = "test")
    }
}

class ReportControllerTests {
    private var spyReportService: SpyReportService = SpyReportService()
    private var mockMvc: MockMvc = MockMvcBuilders.standaloneSetup(
        ReportController(reportService = spyReportService)
    ).build()

    @Nested
    inner class `post_request` {
        @Test
        fun `status code OKを返す`() {
            mockMvc
                .perform(post("/api/report/create"))
                .andExpect(status().isOk)
        }

        @Test
        fun `createが呼ばれる`() {
            mockMvc
                .perform(post("/api/report/create"))

            assertEquals(spyReportService.create_wasCalled,true)
        }

        @Test
        fun `正しいReportを返す`() {
            val expectedResponseBody =
                """
                    {"id":1,"text":"test"}
                """.trimIndent()

            val resultValue = mockMvc
                .perform(post("/api/report/create"))
                .andReturn()
            assertEquals(resultValue.response.contentAsString,expectedResponseBody)
        }
    }
}