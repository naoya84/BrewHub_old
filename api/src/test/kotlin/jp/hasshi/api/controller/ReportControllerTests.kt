package jp.hasshi.api

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test
import org.springframework.http.MediaType
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.status
import org.springframework.test.web.servlet.setup.MockMvcBuilders

class SpyReportService() : ReportService {
    var getAll_wasCalled = false
    var getAll_returnValue = listOf(Report(id = 0, text = ""))

    var create_wasCalled = false
    var create_returnValue = Report(id = 0, text = "")
    var create_argument: String? = null

    override fun getAll(): List<Report> {
        getAll_wasCalled = true
        return getAll_returnValue
    }

    override fun create(text: String): Report {
        create_wasCalled = true
        create_argument = text
        return create_returnValue
    }
}

class ReportControllerTests {
    private var spyReportService: SpyReportService = SpyReportService()
    private var mockMvc: MockMvc = MockMvcBuilders.standaloneSetup(
        ReportController(reportService = spyReportService)
    ).build()

    @Nested
    @DisplayName("GET: /api/report")
    inner class GetAll {
        @Test
        fun `status code OKを返す`() {
            mockMvc
                .perform(get("/api/report/"))
                .andExpect(status().isOk)
        }

        @Test
        fun `getAllが呼ばれる`() {
            mockMvc
                .perform(get("/api/report/"))

            assertEquals(spyReportService.getAll_wasCalled, true)
        }

        @Test
        fun `保存された全てのReport一覧を返す`() {
            spyReportService.getAll_returnValue = listOf(Report(1, "aaa"), Report(2, "bbb"))

            mockMvc
                .perform(get("/api/report/"))
                .andExpect(jsonPath("$[0].id").value(1))
                .andExpect(jsonPath("$[0].text").value("aaa"))
                .andExpect(jsonPath("$[1].id").value(2))
                .andExpect(jsonPath("$[1].text").value("bbb"))
        }
    }

    @Nested
    @DisplayName("POST: /api/report/create")
    inner class `Create` {
        @Test
        fun `status code CREATEDを返す`() {
            mockMvc
                .perform(post("/api/report/create")
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(
                        """
                                "aaa"
                            """.trimIndent()
                    ))
                .andExpect(status().isCreated)
        }

        @Test
        fun `createが呼ばれる`() {
            mockMvc
                .perform(post("/api/report/create")
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(
                        """
                                "aaa"
                            """.trimIndent()
                    ))

            assertEquals(spyReportService.create_wasCalled, true)
        }

        @Test
        fun `RequestBodyを渡すとidを付与してReportを返す`() {
            spyReportService.create_returnValue = Report(1, "aaa")

            mockMvc
                .perform(
                    post("/api/report/create")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(
                            """
                                "aaa"
                            """.trimIndent()
                        )
                )
                .andExpect(jsonPath("$.id").value(1))
                .andExpect(jsonPath("$.text").value("aaa"))
        }
    }
}