Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C0732434A
	for <lists+linux-edac@lfdr.de>; Wed, 24 Feb 2021 18:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbhBXRoe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Wed, 24 Feb 2021 12:44:34 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2605 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbhBXRod (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 24 Feb 2021 12:44:33 -0500
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dm36d6Wp3z67rmp;
        Thu, 25 Feb 2021 01:38:17 +0800 (CST)
Received: from lhreml713-chm.china.huawei.com (10.201.108.64) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 24 Feb 2021 18:43:45 +0100
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml713-chm.china.huawei.com (10.201.108.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 24 Feb 2021 17:43:45 +0000
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.2106.006;
 Wed, 24 Feb 2021 17:43:45 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Jason Tian <jason@os.amperecomputing.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "baicar@os.amperecomputing.com" <baicar@os.amperecomputing.com>
CC:     "zwang@amperecomputing.com" <zwang@amperecomputing.com>
Subject: RE: [PATCH v2] arm64/ras: Update code to trace out more data for ARM
 processor
Thread-Topic: [PATCH v2] arm64/ras: Update code to trace out more data for ARM
 processor
Thread-Index: AQHW+2YRmWqbc46jJECSbt+Gj84YlapnsViA
Date:   Wed, 24 Feb 2021 17:43:44 +0000
Message-ID: <fa62e22307374cc1a269750ffc1862f5@huawei.com>
References: <20210205022229.313030-1-jason@os.amperecomputing.com>
In-Reply-To: <20210205022229.313030-1-jason@os.amperecomputing.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.94.46]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

>-----Original Message-----
>From: linux-arm-kernel [mailto:linux-arm-kernel-bounces@lists.infradead.org]
>On Behalf Of Jason Tian
>Sent: 05 February 2021 02:22
>To: linux-kernel@vger.kernel.org; linux-edac@vger.kernel.org; linux-arm-
>kernel@lists.infradead.org; james.morse@arm.com;
>baicar@os.amperecomputing.com
>Cc: zwang@amperecomputing.com; jason@os.amperecomputing.com
>Subject: [PATCH v2] arm64/ras: Update code to trace out more data for ARM
>processor
>
>The original arm_event trace code only traces out ARM processor error
>information data. According to UEFI_2_8_A_Feb14 specification chapter
>N2.4.4, the ARM processor error section includes several ARM processor
>error information, several ARM processor context information and several
>vendor specific error information structures.
>
>Add code to trace out all ARM processor context information and vendor
>specific error information with raw hex format.
>
>Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
>---
> drivers/ras/ras.c       | 22 +++++++++++++++++++++-
> include/ras/ras_event.h | 41 +++++++++++++++++++++++++++++++++++---
>---
> 2 files changed, 56 insertions(+), 7 deletions(-)
>

Tested-by: Shiju Jose <shiju.jose@huawei.com>

>diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c index
>95540ea8dd9d..6f3269da9476 100644
>--- a/drivers/ras/ras.c
>+++ b/drivers/ras/ras.c
>@@ -23,7 +23,27 @@ void log_non_standard_event(const guid_t
>*sec_type, const guid_t *fru_id,
>
> void log_arm_hw_error(struct cper_sec_proc_arm *err)  {
>-	trace_arm_event(err);
>+	u32 pei_len;
>+	u32 ctx_len;
>+	u32 vsei_len;
>+	u8 *pei_err;
>+	u8 *ctx_err;
>+	u8 *ven_err_data;
>+
>+	pei_len = sizeof(struct cper_arm_err_info) * err->err_info_num;
>+	pei_err = (u8 *) err + sizeof(struct cper_sec_proc_arm);
>+
>+	ctx_len = sizeof(struct cper_arm_ctx_info) * err->context_info_num;
>+	ctx_err = pei_err + sizeof(struct cper_arm_err_info) *
>+		err->err_info_num;
>+
>+	vsei_len = err->section_length - (sizeof(struct cper_sec_proc_arm) +
>+					  pei_len + ctx_len);
>+	ven_err_data = ctx_err + sizeof(struct cper_arm_ctx_info) *
>+					  err->context_info_num;
>+
>+	trace_arm_event(err, pei_err, pei_len, ctx_err, ctx_len,
>+			ven_err_data, vsei_len);
> }
>
> static int __init ras_init(void)
>diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h index
>0bdbc0d17d2f..fd9201214be8 100644
>--- a/include/ras/ras_event.h
>+++ b/include/ras/ras_event.h
>@@ -168,11 +168,22 @@ TRACE_EVENT(mc_event,
>  * This event is generated when hardware detects an ARM processor error
>  * has occurred. UEFI 2.6 spec section N.2.4.4.
>  */
>+ #define APEIL "ARM Processor Err Info data len"
>+ #define APEID "ARM Processor Err Info raw data"
>+ #define APECIL "ARM Processor Err Context Info data len"
>+ #define APECID "ARM Processor Err Context Info raw data"
>+ #define VSEIL "Vendor Specific Err Info data len"
>+ #define VSEID "Vendor Specific Err Info raw data"
> TRACE_EVENT(arm_event,
>
>-	TP_PROTO(const struct cper_sec_proc_arm *proc),
>+	TP_PROTO(const struct cper_sec_proc_arm *proc, const u8 *pei_err,
>+		const u32 pei_len,
>+		const u8 *ctx_err,
>+		const u32 ctx_len,
>+		const u8 *oem,
>+		const u32 oem_len),
>
>-	TP_ARGS(proc),
>+	TP_ARGS(proc, pei_err, pei_len, ctx_err, ctx_len, oem, oem_len),
>
> 	TP_STRUCT__entry(
> 		__field(u64, mpidr)
>@@ -180,6 +191,12 @@ TRACE_EVENT(arm_event,
> 		__field(u32, running_state)
> 		__field(u32, psci_state)
> 		__field(u8, affinity)
>+		__field(u32, pei_len)
>+		__dynamic_array(u8, buf, pei_len)
>+		__field(u32, ctx_len)
>+		__dynamic_array(u8, buf1, ctx_len)
>+		__field(u32, oem_len)
>+		__dynamic_array(u8, buf2, oem_len)
> 	),
>
> 	TP_fast_assign(
>@@ -199,12 +216,24 @@ TRACE_EVENT(arm_event,
> 			__entry->running_state = ~0;
> 			__entry->psci_state = ~0;
> 		}
>+		__entry->pei_len = pei_len;
>+		memcpy(__get_dynamic_array(buf), pei_err, pei_len);
>+		__entry->ctx_len = ctx_len;
>+		memcpy(__get_dynamic_array(buf1), ctx_err, ctx_len);
>+		__entry->oem_len = oem_len;
>+		memcpy(__get_dynamic_array(buf2), oem, oem_len);
> 	),
>
>-	TP_printk("affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
>-		  "running state: %d; PSCI state: %d",
>-		  __entry->affinity, __entry->mpidr, __entry->midr,
>-		  __entry->running_state, __entry->psci_state)
>+	TP_printk("affinity level: %d; MPIDR: %016llx; MIDR: %016llx;
>running state: %d; "
>+		"PSCI state: %d; %s: %d; %s: %s; %s: %d; %s: %s; %s: %d; %s:
>%s",
>+		__entry->affinity, __entry->mpidr, __entry->midr,
>+		__entry->running_state, __entry->psci_state,
>+		APEIL, __entry->pei_len, APEID,
>+		__print_hex(__get_dynamic_array(buf), __entry->pei_len),
>+		APECIL, __entry->ctx_len, APECID,
>+		__print_hex(__get_dynamic_array(buf1), __entry->ctx_len),
>+		VSEIL, __entry->oem_len, VSEID,
>+		__print_hex(__get_dynamic_array(buf2), __entry-
>>oem_len))
> );
>
> /*
>--
>2.25.1
>
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Thanks,
Shiju
