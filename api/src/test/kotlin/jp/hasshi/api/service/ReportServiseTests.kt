package jp.hasshi.api

import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest
import org.assertj.core.api.Assertions.assertThat


@DataJpaTest
class ReportServiseTests{
    @Autowired
    lateinit var reportRepository: ReportRepository
    lateinit var reportService: ReportService

    @BeforeEach
    fun setup(){
        reportService = ReportServiceImpl(reportRepository = reportRepository)
    }

    @Test
    fun `getAllを呼ぶとReport一覧を返す`(){
        //given
        val reportEntity = ReportEntity(text = "aaaa")
        reportRepository.save(reportEntity)

        //when
        val report = reportService.getAll()

        //then
        assertThat(report).hasSize(1)
        assertThat(report[0].id).isEqualTo(reportEntity.id)
        assertThat(report[0].text).isEqualTo("aaaa")
    }
    @Test
    fun `createを呼ぶとReportを保存する`(){
        //when
        val report = reportService.create("bbbb")

        //then
        assertThat(report.id).isEqualTo(1)
        assertThat(report.text).isEqualTo("bbbb")
    }
}