Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D56857301B
	for <lists+linux-edac@lfdr.de>; Wed, 13 Jul 2022 10:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbiGMIKQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 Jul 2022 04:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiGMIKP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 13 Jul 2022 04:10:15 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CB1E9211;
        Wed, 13 Jul 2022 01:10:04 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LjVbK2b8Qz1L95Y;
        Wed, 13 Jul 2022 16:07:25 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Jul 2022 16:09:46 +0800
Received: from [10.67.100.236] (10.67.100.236) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Jul 2022 16:09:45 +0800
Message-ID: <767e9981-721a-f298-220c-4fd8bf3e9c70@huawei.com>
Date:   Wed, 13 Jul 2022 16:09:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3] RAS: Report ARM processor information to userspace
To:     <james.morse@arm.com>
References: <20220214030813.135766-1-lostway@zju.edu.cn>
CC:     <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <bp@alien8.de>, <tony.luck@intel.com>,
        <jason@os.amperecomputing.com>, <mchehab@kernel.org>,
        <lostway@zju.edu.cn>, <mark.rutland@arm.com>, <rjw@rjwysocki.net>
From:   tanxiaofei <tanxiaofei@huawei.com>
In-Reply-To: <20220214030813.135766-1-lostway@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.100.236]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


Hi James,

This patch is necceary for error collection of rasdaemon, and also cpu 
core error  prediction feature . Please help to give some comment when 
you are free. thanks.


在 2022/2/14 11:08, lostway@zju.edu.cn 写道:
> From: Shengwei Luo <luoshengwei@huawei.com>
> 
> The original arm_event trace code only traces out ARM processor error
> information data. It's not enough for user to take appropriate action.
> 
> According to UEFI_2_9 specification chapter N2.4.4, the ARM processor
> error section includes several ARM processor error information, several
> ARM processor context information and several vendor specific error
> information structures. In addition to these info, there are error
> severity and cpu logical index about the event. Report all of these
> information to userspace via perf i/f. So that the user can do cpu core
> isolation according to error severity and other info.
> 
> Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>
> Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
> ---
> Links:
> https://lore.kernel.org/lkml/20220126030906.56765-1-lostway@zju.edu.cn/
> https://lore.kernel.org/lkml/20210205022229.313030-1-jason@os.amperecomputing.com/
> 
> v2->v3:
> Add signed-off of original author.
> Fix commit message to explain why a change is being done.
> 
> v1->v2:
> Cleaned up ci warnings.
> ---
>   drivers/acpi/apei/ghes.c |  3 +--
>   drivers/ras/ras.c        | 46 ++++++++++++++++++++++++++++++++++++--
>   include/linux/ras.h      | 15 +++++++++++--
>   include/ras/ras_event.h  | 48 +++++++++++++++++++++++++++++++++++-----
>   4 files changed, 101 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 0c5c9acc6254..f824c26057b1 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -490,9 +490,8 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int s
>   	int sec_sev, i;
>   	char *p;
>   
> -	log_arm_hw_error(err);
> -
>   	sec_sev = ghes_severity(gdata->error_severity);
> +	log_arm_hw_error(err, sec_sev);
>   	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
>   		return false;
>   
> diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
> index 95540ea8dd9d..2a7f424d59b9 100644
> --- a/drivers/ras/ras.c
> +++ b/drivers/ras/ras.c
> @@ -21,9 +21,51 @@ void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
>   	trace_non_standard_event(sec_type, fru_id, fru_text, sev, err, len);
>   }
>   
> -void log_arm_hw_error(struct cper_sec_proc_arm *err)
> +void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
>   {
> -	trace_arm_event(err);
> +	u32 pei_len;
> +	u32 ctx_len = 0;
> +	s32 vsei_len;
> +	u8 *pei_err;
> +	u8 *ctx_err;
> +	u8 *ven_err_data;
> +	struct cper_arm_err_info *err_info;
> +	struct cper_arm_ctx_info *ctx_info;
> +	int n, sz;
> +	int cpu;
> +
> +	pei_len = sizeof(struct cper_arm_err_info) * err->err_info_num;
> +	pei_err = (u8 *)err + sizeof(struct cper_sec_proc_arm);
> +
> +	err_info = (struct cper_arm_err_info *)(err + 1);
> +	ctx_info = (struct cper_arm_ctx_info *)(err_info + err->err_info_num);
> +	ctx_err = (u8 *)ctx_info;
> +	for (n = 0; n < err->context_info_num; n++) {
> +		sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
> +		ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
> +		ctx_len += sz;
> +	}
> +
> +	vsei_len = err->section_length - (sizeof(struct cper_sec_proc_arm) +
> +						pei_len + ctx_len);
> +	if (vsei_len < 0) {
> +		pr_warn(FW_BUG
> +			"section length: %d\n", err->section_length);
> +		pr_warn(FW_BUG
> +			"section length is too small\n");
> +		pr_warn(FW_BUG
> +			"firmware-generated error record is incorrect\n");
> +		vsei_len = 0;
> +	}
> +	ven_err_data = (u8 *)ctx_info;
> +
> +	cpu = GET_LOGICAL_INDEX(err->mpidr);
> +	/* when return value is invalid, set cpu index to -1 */
> +	if (cpu < 0)
> +		cpu = -1;
> +
> +	trace_arm_event(err, pei_err, pei_len, ctx_err, ctx_len,
> +			ven_err_data, (u32)vsei_len, sev, cpu);
>   }
>   
>   static int __init ras_init(void)
> diff --git a/include/linux/ras.h b/include/linux/ras.h
> index 1f4048bf2674..4529775374d0 100644
> --- a/include/linux/ras.h
> +++ b/include/linux/ras.h
> @@ -24,7 +24,7 @@ int __init parse_cec_param(char *str);
>   void log_non_standard_event(const guid_t *sec_type,
>   			    const guid_t *fru_id, const char *fru_text,
>   			    const u8 sev, const u8 *err, const u32 len);
> -void log_arm_hw_error(struct cper_sec_proc_arm *err);
> +void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev);
>   #else
>   static inline void
>   log_non_standard_event(const guid_t *sec_type,
> @@ -32,7 +32,18 @@ log_non_standard_event(const guid_t *sec_type,
>   		       const u8 sev, const u8 *err, const u32 len)
>   { return; }
>   static inline void
> -log_arm_hw_error(struct cper_sec_proc_arm *err) { return; }
> +log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev) { return; }
>   #endif
>   
> +#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
> +#include <asm/smp_plat.h>
> +/*
> + * Include ARM specific SMP header which provides a function mapping mpidr to
> + * cpu logical index.
> + */
> +#define GET_LOGICAL_INDEX(mpidr) get_logical_index(mpidr & MPIDR_HWID_BITMASK)
> +#else
> +#define GET_LOGICAL_INDEX(mpidr) -EINVAL
> +#endif /* CONFIG_ARM || CONFIG_ARM64 */
> +
>   #endif /* __RAS_H__ */
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index d0337a41141c..92cfb61bdb20 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -168,11 +168,24 @@ TRACE_EVENT(mc_event,
>    * This event is generated when hardware detects an ARM processor error
>    * has occurred. UEFI 2.6 spec section N.2.4.4.
>    */
> +#define APEIL "ARM Processor Err Info data len"
> +#define APEID "ARM Processor Err Info raw data"
> +#define APECIL "ARM Processor Err Context Info data len"
> +#define APECID "ARM Processor Err Context Info raw data"
> +#define VSEIL "Vendor Specific Err Info data len"
> +#define VSEID "Vendor Specific Err Info raw data"
>   TRACE_EVENT(arm_event,
>   
> -	TP_PROTO(const struct cper_sec_proc_arm *proc),
> +	TP_PROTO(const struct cper_sec_proc_arm *proc, const u8 *pei_err,
> +			const u32 pei_len,
> +			const u8 *ctx_err,
> +			const u32 ctx_len,
> +			const u8 *oem,
> +			const u32 oem_len,
> +			u8 sev,
> +			int cpu),
>   
> -	TP_ARGS(proc),
> +	TP_ARGS(proc, pei_err, pei_len, ctx_err, ctx_len, oem, oem_len, sev, cpu),
>   
>   	TP_STRUCT__entry(
>   		__field(u64, mpidr)
> @@ -180,6 +193,14 @@ TRACE_EVENT(arm_event,
>   		__field(u32, running_state)
>   		__field(u32, psci_state)
>   		__field(u8, affinity)
> +		__field(u32, pei_len)
> +		__dynamic_array(u8, buf, pei_len)
> +		__field(u32, ctx_len)
> +		__dynamic_array(u8, buf1, ctx_len)
> +		__field(u32, oem_len)
> +		__dynamic_array(u8, buf2, oem_len)
> +		__field(u8, sev)
> +		__field(int, cpu)
>   	),
>   
>   	TP_fast_assign(
> @@ -199,12 +220,29 @@ TRACE_EVENT(arm_event,
>   			__entry->running_state = ~0;
>   			__entry->psci_state = ~0;
>   		}
> +		__entry->pei_len = pei_len;
> +		memcpy(__get_dynamic_array(buf), pei_err, pei_len);
> +		__entry->ctx_len = ctx_len;
> +		memcpy(__get_dynamic_array(buf1), ctx_err, ctx_len);
> +		__entry->oem_len = oem_len;
> +		memcpy(__get_dynamic_array(buf2), oem, oem_len);
> +		__entry->sev = sev;
> +		__entry->cpu = cpu;
>   	),
>   
> -	TP_printk("affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
> -		  "running state: %d; PSCI state: %d",
> +	TP_printk("cpu: %d; error: %d; affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
> +		  "running state: %d; PSCI state: %d; "
> +		  "%s: %d; %s: %s; %s: %d; %s: %s; %s: %d; %s: %s",
> +		  __entry->cpu,
> +		  __entry->sev,
>   		  __entry->affinity, __entry->mpidr, __entry->midr,
> -		  __entry->running_state, __entry->psci_state)
> +		  __entry->running_state, __entry->psci_state,
> +		  APEIL, __entry->pei_len, APEID,
> +		  __print_hex(__get_dynamic_array(buf), __entry->pei_len),
> +		  APECIL, __entry->ctx_len, APECID,
> +		  __print_hex(__get_dynamic_array(buf1), __entry->ctx_len),
> +		  VSEIL, __entry->oem_len, VSEID,
> +		  __print_hex(__get_dynamic_array(buf2), __entry->oem_len))
>   );
>   
>   /*
> 
