Return-Path: <linux-edac+bounces-1401-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E55791A7D7
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 15:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310CB1C20B12
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 13:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D8319409E;
	Thu, 27 Jun 2024 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2upjU3x"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B773C194081;
	Thu, 27 Jun 2024 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719494918; cv=none; b=C5br2KuL5shRZ5AFWs+C+q+CZHccJ/Vxkcj34Spst3b1/F41tUMX6VAOtqJtI8YdoANyhfWFV5vEL4TuzWGFW4jjvI2iMwcCapMqXO1uNJAVHBglL39JNU5EHwa2n01Q22kQgFAUP8fqukrg2XUP3IpfPUs/Zm6zgW0mizRPsck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719494918; c=relaxed/simple;
	bh=+045qnTXBH8+G9rW6kXmFWaJL7epAnf4z+AkvHv0WsE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UL7vsJUBez7/fox92eUsXsImO6r+C5bYlHRH4Sd+bUbOPRIbBSv2UcwBxOARL8z7iQ1Za7YYHnZZlcQiNvbizA0WZAjIZ31T+gvwiGuSvLLaupZ4hTcUaZ71RC17WOPvde/qP+aH8YQDHqlyFV/ITLO+RFW/3n0HFjttWG6wKUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2upjU3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9B2C2BBFC;
	Thu, 27 Jun 2024 13:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719494918;
	bh=+045qnTXBH8+G9rW6kXmFWaJL7epAnf4z+AkvHv0WsE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j2upjU3xjS9SUSWtv9T+LW79+Lvx1Id7q/oxurQEPr5zPVdMmttqAlyM9DHk7EakU
	 bXILn4NegpXLyv5Rc19H5zzAK6LbKnW79TYrzuCkrkt6MYsZvnBb1509zhmOMFkd4Z
	 0Kw46xvqetXD4qaSrWrZ1cHRBaPnWp29B6zfUIpnoW2CSmMGunNSsr6l11MVNmgGeX
	 6tN4P8fT6q7MHndkeVCasF4+M7xBQKGXH1nI+v9gTuyvkQgXAnj+TZPP02NB0+c7mc
	 PLxgT2G3Ch9GCKh2PqIFl2aWwTPLyFXLEmoXibZyExNOo3IyYxT6+GXCuF+913f386
	 QF2tOrAMQ7NwA==
Date: Thu, 27 Jun 2024 15:28:30 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Shengwei Luo <luoshengwei@huawei.com>, "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Shiju Jose" <shiju.jose@huawei.com>, Dan Williams
 <dan.j.williams@intel.com>, Daniel Ferguson
 <danielf@os.amperecomputing.com>, Dave Jiang <dave.jiang@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, James Morse <james.morse@arm.com>, Len Brown
 <lenb@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, Steven Rostedt
 <rostedt@goodmis.org>, Tony Luck <tony.luck@intel.com>, Tyler Baicar
 <tbaicar@codeaurora.org>, Will Deacon <will@kernel.org>, Xie XiuQi
 <xiexiuqi@huawei.com>, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, Jason Tian
 <jason@os.amperecomputing.com>
Subject: Re: [PATCH v2 2/2] RAS: Report all ARM processor CPER information
 to userspace
Message-ID: <20240627152830.3c6f5853@coco.lan>
In-Reply-To: <75b5c9a47c9caf9490c5eedd85e201b7bdb8bf57.1719484498.git.mchehab+huawei@kernel.org>
References: <cover.1719484498.git.mchehab+huawei@kernel.org>
	<75b5c9a47c9caf9490c5eedd85e201b7bdb8bf57.1719484498.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 27 Jun 2024 12:36:08 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> From: Shengwei Luo <luoshengwei@huawei.com>
> 
> The ARM processor CPER record was added at UEFI 2.6, and hasn't
> any changes up to UEFI 2.10 on its struct.
> 

Heh, I over-cleanup this patch. This type cast is needed:
@@ -70,7 +70,7 @@ void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
 
 	err_info = (struct cper_arm_err_info *)(err + 1);
 	ctx_info = (struct cper_arm_ctx_info *)(err_info + err->err_info_num);
-	ctx_err = ctx_info;
+	ctx_err = (u8 *)ctx_info;
 	for (n = 0; n < err->context_info_num; n++) {
 		sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
 		ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);

Full patch with this small fix enclosed.

Thanks,
Mauro

[PATCH v2.1 2/2] RAS: Report all ARM processor CPER information to userspace

The ARM processor CPER record was added at UEFI 2.6, and hasn't
any changes up to UEFI 2.10 on its struct.

Yet, the original arm_event trace code added on changeset
e9279e83ad1f ("trace, ras: add ARM processor error trace event") is
incomplete, as it only traces some fields of UAPI 2.6 table N.16,
not exporting at all any information from tables N.17 to N.29 of
the record.

This is not enough for user to take appropriate action or to log
what exactly happened.

According to UEFI_2_9 specification chapter N2.4.4, the ARM processor
error section includes:

- several (ERR_INFO_NUM) ARM processor error information structures
  (Tables N.17 to N.20);
- several (CONTEXT_INFO_NUM) ARM processor context information
  structures (Tables N.21 to N.29);
- several vendor specific error information structures. The
  size is given by Section Length minus the size of the other
  fields.

In addition to those data, it also exports two fields that are
parsed by the GHES driver when firmware reports it, e. g.:

- error severity
- cpu logical index

Report all of these information to userspace via trace uAPI, So that
userspace can properly record the error and take decisions related
to cpu core isolation according to error severity and other info.

After this patch, all the data from ARM Processor record from table
N.16 are directly or indirectly visible on userspace:

======================================	=============================
UEFI field on table N.16		ARM Processor trace fields
======================================	=============================
Validation				handled when filling data for
					affinity MPIDR and running
					state.
ERR_INFO_NUM				pei_len
CONTEXT_INFO_NUM			ctx_len
Section Length				indirectly reported by
					pei_len, ctx_len and oem_len
Error affinity level			affinity
MPIDR_EL1				mpidr
MIDR_EL1				midr
Running State				running_state
PSCI State				psci_state
Processor Error Information Structure	pei_err - count at pei_len
Processor Context			ctx_err- count at ctx_len
Vendor Specific Error Info		oem - count at oem_len
======================================	=============================

It should be noticed that decoding of tables N.17 to N.29, if needed,
will be handled on userspace. That gives more flexibility, as there
won't be any need to flood the Kernel with micro-architecture specific
error decoding).
Also, decoding the other fields require a complex logic, and should
be done for each of the several values inside the record field.
So, let userspace daemons like rasdaemon decode them, parsing such
tables and having vendor-specific micro-architecture-specific decoders.

[mchehab: modified patch description and fix coding style]
Fixes: e9279e83ad1f ("trace, ras: add ARM processor error trace event")
Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>
Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>
Tested-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Link: https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-section

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 2589a3536d91..90efca025d27 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -538,9 +538,8 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 	int sec_sev, i;
 	char *p;
 
-	log_arm_hw_error(err);
-
 	sec_sev = ghes_severity(gdata->error_severity);
+	log_arm_hw_error(err, sec_sev);
 	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
 		return false;
 
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 5d94ab79c8c3..b515659cc8cc 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -52,10 +52,51 @@ void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
 	trace_non_standard_event(sec_type, fru_id, fru_text, sev, err, len);
 }
 
-void log_arm_hw_error(struct cper_sec_proc_arm *err)
+void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
 {
 #if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
-	trace_arm_event(err);
+	struct cper_arm_err_info *err_info;
+	struct cper_arm_ctx_info *ctx_info;
+	u8 *ven_err_data;
+	u32 ctx_len = 0;
+	int n, sz, cpu;
+	s32 vsei_len;
+	u32 pei_len;
+	u8 *pei_err;
+	u8 *ctx_err;
+
+	pei_len = sizeof(struct cper_arm_err_info) * err->err_info_num;
+	pei_err = (u8 *)err + sizeof(struct cper_sec_proc_arm);
+
+	err_info = (struct cper_arm_err_info *)(err + 1);
+	ctx_info = (struct cper_arm_ctx_info *)(err_info + err->err_info_num);
+	ctx_err = ctx_info;
+	for (n = 0; n < err->context_info_num; n++) {
+		sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
+		ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
+		ctx_len += sz;
+	}
+
+	vsei_len = err->section_length - (sizeof(struct cper_sec_proc_arm) +
+					  pei_len + ctx_len);
+	if (vsei_len < 0) {
+		pr_warn(FW_BUG
+			"section length: %d\n", err->section_length);
+		pr_warn(FW_BUG
+			"section length is too small\n");
+		pr_warn(FW_BUG
+			"firmware-generated error record is incorrect\n");
+		vsei_len = 0;
+	}
+	ven_err_data = (u8 *)ctx_info;
+
+	cpu = GET_LOGICAL_INDEX(err->mpidr);
+	/* when return value is invalid, set cpu index to -1 */
+	if (cpu < 0)
+		cpu = -1;
+
+	trace_arm_event(err, pei_err, pei_len, ctx_err, ctx_len,
+			ven_err_data, (u32)vsei_len, sev, cpu);
 #endif
 }
 
diff --git a/include/linux/ras.h b/include/linux/ras.h
index a64182bc72ad..6025afe5736a 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -24,8 +24,7 @@ int __init parse_cec_param(char *str);
 void log_non_standard_event(const guid_t *sec_type,
 			    const guid_t *fru_id, const char *fru_text,
 			    const u8 sev, const u8 *err, const u32 len);
-void log_arm_hw_error(struct cper_sec_proc_arm *err);
-
+void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev);
 #else
 static inline void
 log_non_standard_event(const guid_t *sec_type,
@@ -33,7 +32,7 @@ log_non_standard_event(const guid_t *sec_type,
 		       const u8 sev, const u8 *err, const u32 len)
 { return; }
 static inline void
-log_arm_hw_error(struct cper_sec_proc_arm *err) { return; }
+log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev) { return; }
 #endif
 
 struct atl_err {
@@ -52,5 +51,14 @@ static inline void amd_retire_dram_row(struct atl_err *err) { }
 static inline unsigned long
 amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err) { return -EINVAL; }
 #endif /* CONFIG_AMD_ATL */
-
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+#include <asm/smp_plat.h>
+/*
+ * Include ARM specific SMP header which provides a function mapping mpidr to
+ * cpu logical index.
+ */
+#define GET_LOGICAL_INDEX(mpidr) get_logical_index(mpidr & MPIDR_HWID_BITMASK)
+#else
+#define GET_LOGICAL_INDEX(mpidr) -EINVAL
+#endif /* CONFIG_ARM || CONFIG_ARM64 */
 #endif /* __RAS_H__ */
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 7c47151d5c72..ce5214f008eb 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -168,11 +168,24 @@ TRACE_EVENT(mc_event,
  * This event is generated when hardware detects an ARM processor error
  * has occurred. UEFI 2.6 spec section N.2.4.4.
  */
+#define APEIL "ARM Processor Err Info data len"
+#define APEID "ARM Processor Err Info raw data"
+#define APECIL "ARM Processor Err Context Info data len"
+#define APECID "ARM Processor Err Context Info raw data"
+#define VSEIL "Vendor Specific Err Info data len"
+#define VSEID "Vendor Specific Err Info raw data"
 TRACE_EVENT(arm_event,
 
-	TP_PROTO(const struct cper_sec_proc_arm *proc),
+	TP_PROTO(const struct cper_sec_proc_arm *proc, const u8 *pei_err,
+			const u32 pei_len,
+			const u8 *ctx_err,
+			const u32 ctx_len,
+			const u8 *oem,
+			const u32 oem_len,
+			u8 sev,
+			int cpu),
 
-	TP_ARGS(proc),
+	TP_ARGS(proc, pei_err, pei_len, ctx_err, ctx_len, oem, oem_len, sev, cpu),
 
 	TP_STRUCT__entry(
 		__field(u64, mpidr)
@@ -180,6 +193,14 @@ TRACE_EVENT(arm_event,
 		__field(u32, running_state)
 		__field(u32, psci_state)
 		__field(u8, affinity)
+		__field(u32, pei_len)
+		__dynamic_array(u8, buf, pei_len)
+		__field(u32, ctx_len)
+		__dynamic_array(u8, buf1, ctx_len)
+		__field(u32, oem_len)
+		__dynamic_array(u8, buf2, oem_len)
+		__field(u8, sev)
+		__field(int, cpu)
 	),
 
 	TP_fast_assign(
@@ -199,12 +220,29 @@ TRACE_EVENT(arm_event,
 			__entry->running_state = ~0;
 			__entry->psci_state = ~0;
 		}
+		__entry->pei_len = pei_len;
+		memcpy(__get_dynamic_array(buf), pei_err, pei_len);
+		__entry->ctx_len = ctx_len;
+		memcpy(__get_dynamic_array(buf1), ctx_err, ctx_len);
+		__entry->oem_len = oem_len;
+		memcpy(__get_dynamic_array(buf2), oem, oem_len);
+		__entry->sev = sev;
+		__entry->cpu = cpu;
 	),
 
-	TP_printk("affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
-		  "running state: %d; PSCI state: %d",
+	TP_printk("cpu: %d; error: %d; affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
+		  "running state: %d; PSCI state: %d; "
+		  "%s: %d; %s: %s; %s: %d; %s: %s; %s: %d; %s: %s",
+		  __entry->cpu,
+		  __entry->sev,
 		  __entry->affinity, __entry->mpidr, __entry->midr,
-		  __entry->running_state, __entry->psci_state)
+		  __entry->running_state, __entry->psci_state,
+		  APEIL, __entry->pei_len, APEID,
+		  __print_hex(__get_dynamic_array(buf), __entry->pei_len),
+		  APECIL, __entry->ctx_len, APECID,
+		  __print_hex(__get_dynamic_array(buf1), __entry->ctx_len),
+		  VSEIL, __entry->oem_len, VSEID,
+		  __print_hex(__get_dynamic_array(buf2), __entry->oem_len))
 );
 
 /*

