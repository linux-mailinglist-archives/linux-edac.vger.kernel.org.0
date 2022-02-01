Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BB04A63E8
	for <lists+linux-edac@lfdr.de>; Tue,  1 Feb 2022 19:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238583AbiBASdF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Feb 2022 13:33:05 -0500
Received: from foss.arm.com ([217.140.110.172]:57678 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238536AbiBASdF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 1 Feb 2022 13:33:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2AA311B3;
        Tue,  1 Feb 2022 10:33:04 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.8.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8E8B3F40C;
        Tue,  1 Feb 2022 10:33:03 -0800 (PST)
Date:   Tue, 1 Feb 2022 18:33:02 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     lostway@zju.edu.cn
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        bp@alien8.de, tony.luck@intel.com
Subject: Re: [PATCH v2] RAS: Report ARM processor information to userspace
Message-ID: <Yfl83r+gPOe9vzed@FVFF77S0Q05N>
References: <20220126030906.56765-1-lostway@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126030906.56765-1-lostway@zju.edu.cn>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 26, 2022 at 11:09:06AM +0800, lostway@zju.edu.cn wrote:
> From: Shengwei Luo <luoshengwei@huawei.com>
> 
> The ARM processor error section includes several ARM processor error
> information, several ARM processor context information and several
> vendor specific error information structures. In addition to these
> info, there are error severity and cpu logical index about the event.
> Report all of these information to userspace via perf i/f.
> 
> Original-Author: Jason Tian <jason@os.amperecomputing.com>
> Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>

In addition to Boris's comments, "Original-Author" is not a proper tag, and so
this patch cannot be accepted as-is.

Please see:

  https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

Either:

* The original patch had a "Signed-off-by" tag, which you should have kept
  as-is, and added your own.

* The original patch did not have a "Signed-off-by" tag, and we cannot accept
  the patch.

It would be good to provide a link to the prior patch, ideally via
lore.kernel.org. For reference, this patch is:

  https://lore.kernel.org/lkml/20220126030906.56765-1-lostway@zju.edu.cn/

It would also be good to Cc the relevant arm maintainers here (e.g James
Morse), since they're more likely to know about the arm side of things...

Thanks,
Mark.

> ---
> v1->v2: Cleaned up ci warnings
> ---
>  drivers/acpi/apei/ghes.c |  3 +--
>  drivers/ras/ras.c        | 46 ++++++++++++++++++++++++++++++++++++--
>  include/linux/ras.h      | 15 +++++++++++--
>  include/ras/ras_event.h  | 48 +++++++++++++++++++++++++++++++++++-----
>  4 files changed, 101 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 0c5c9acc6254..f824c26057b1 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -490,9 +490,8 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int s
>  	int sec_sev, i;
>  	char *p;
>  
> -	log_arm_hw_error(err);
> -
>  	sec_sev = ghes_severity(gdata->error_severity);
> +	log_arm_hw_error(err, sec_sev);
>  	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
>  		return false;
>  
> diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
> index 95540ea8dd9d..2a7f424d59b9 100644
> --- a/drivers/ras/ras.c
> +++ b/drivers/ras/ras.c
> @@ -21,9 +21,51 @@ void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
>  	trace_non_standard_event(sec_type, fru_id, fru_text, sev, err, len);
>  }
>  
> -void log_arm_hw_error(struct cper_sec_proc_arm *err)
> +void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
>  {
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
>  }
>  
>  static int __init ras_init(void)
> diff --git a/include/linux/ras.h b/include/linux/ras.h
> index 1f4048bf2674..4529775374d0 100644
> --- a/include/linux/ras.h
> +++ b/include/linux/ras.h
> @@ -24,7 +24,7 @@ int __init parse_cec_param(char *str);
>  void log_non_standard_event(const guid_t *sec_type,
>  			    const guid_t *fru_id, const char *fru_text,
>  			    const u8 sev, const u8 *err, const u32 len);
> -void log_arm_hw_error(struct cper_sec_proc_arm *err);
> +void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev);
>  #else
>  static inline void
>  log_non_standard_event(const guid_t *sec_type,
> @@ -32,7 +32,18 @@ log_non_standard_event(const guid_t *sec_type,
>  		       const u8 sev, const u8 *err, const u32 len)
>  { return; }
>  static inline void
> -log_arm_hw_error(struct cper_sec_proc_arm *err) { return; }
> +log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev) { return; }
>  #endif
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
>  #endif /* __RAS_H__ */
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index d0337a41141c..92cfb61bdb20 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -168,11 +168,24 @@ TRACE_EVENT(mc_event,
>   * This event is generated when hardware detects an ARM processor error
>   * has occurred. UEFI 2.6 spec section N.2.4.4.
>   */
> +#define APEIL "ARM Processor Err Info data len"
> +#define APEID "ARM Processor Err Info raw data"
> +#define APECIL "ARM Processor Err Context Info data len"
> +#define APECID "ARM Processor Err Context Info raw data"
> +#define VSEIL "Vendor Specific Err Info data len"
> +#define VSEID "Vendor Specific Err Info raw data"
>  TRACE_EVENT(arm_event,
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
>  	TP_STRUCT__entry(
>  		__field(u64, mpidr)
> @@ -180,6 +193,14 @@ TRACE_EVENT(arm_event,
>  		__field(u32, running_state)
>  		__field(u32, psci_state)
>  		__field(u8, affinity)
> +		__field(u32, pei_len)
> +		__dynamic_array(u8, buf, pei_len)
> +		__field(u32, ctx_len)
> +		__dynamic_array(u8, buf1, ctx_len)
> +		__field(u32, oem_len)
> +		__dynamic_array(u8, buf2, oem_len)
> +		__field(u8, sev)
> +		__field(int, cpu)
>  	),
>  
>  	TP_fast_assign(
> @@ -199,12 +220,29 @@ TRACE_EVENT(arm_event,
>  			__entry->running_state = ~0;
>  			__entry->psci_state = ~0;
>  		}
> +		__entry->pei_len = pei_len;
> +		memcpy(__get_dynamic_array(buf), pei_err, pei_len);
> +		__entry->ctx_len = ctx_len;
> +		memcpy(__get_dynamic_array(buf1), ctx_err, ctx_len);
> +		__entry->oem_len = oem_len;
> +		memcpy(__get_dynamic_array(buf2), oem, oem_len);
> +		__entry->sev = sev;
> +		__entry->cpu = cpu;
>  	),
>  
> -	TP_printk("affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
> -		  "running state: %d; PSCI state: %d",
> +	TP_printk("cpu: %d; error: %d; affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
> +		  "running state: %d; PSCI state: %d; "
> +		  "%s: %d; %s: %s; %s: %d; %s: %s; %s: %d; %s: %s",
> +		  __entry->cpu,
> +		  __entry->sev,
>  		  __entry->affinity, __entry->mpidr, __entry->midr,
> -		  __entry->running_state, __entry->psci_state)
> +		  __entry->running_state, __entry->psci_state,
> +		  APEIL, __entry->pei_len, APEID,
> +		  __print_hex(__get_dynamic_array(buf), __entry->pei_len),
> +		  APECIL, __entry->ctx_len, APECID,
> +		  __print_hex(__get_dynamic_array(buf1), __entry->ctx_len),
> +		  VSEIL, __entry->oem_len, VSEID,
> +		  __print_hex(__get_dynamic_array(buf2), __entry->oem_len))
>  );
>  
>  /*
> -- 
> 2.27.0
> 
