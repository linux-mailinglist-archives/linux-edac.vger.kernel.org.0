Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BB722E6BB
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jul 2020 09:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgG0Hjm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jul 2020 03:39:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40334 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726183AbgG0Hjm (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 27 Jul 2020 03:39:42 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5E7071EE6494508FE3F1;
        Mon, 27 Jul 2020 15:39:40 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Mon, 27 Jul 2020 15:39:33 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <mchehab+huawei@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <shiju.jose@huawei.com>,
        <jonathan.cameron@huawei.com>, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH rasdaemon 2/3] rasdaemon: delete the code of non-standard error decoder for hip07
Date:   Mon, 27 Jul 2020 15:38:38 +0800
Message-ID: <1595835519-32039-3-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1595835519-32039-1-git-send-email-tanxiaofei@huawei.com>
References: <1595835519-32039-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Delete the code of non-standard error decoder for hip07 that was never
used. Because the corresponding code in Linux kernel wasn't accepted.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 Makefile.am               |   2 +-
 non-standard-hisi_hip07.c | 151 ----------------------------------------------
 2 files changed, 1 insertion(+), 152 deletions(-)
 delete mode 100644 non-standard-hisi_hip07.c

diff --git a/Makefile.am b/Makefile.am
index f4822b9..2b38e4b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -52,7 +52,7 @@ if WITH_ABRT_REPORT
    rasdaemon_SOURCES += ras-report.c
 endif
 if WITH_HISI_NS_DECODE
-   rasdaemon_SOURCES += non-standard-hisi_hip07.c non-standard-hisi_hip08.c
+   rasdaemon_SOURCES += non-standard-hisi_hip08.c
 endif
 if WITH_MEMORY_CE_PFA
    rasdaemon_SOURCES += rbtree.c ras-page-isolation.c
diff --git a/non-standard-hisi_hip07.c b/non-standard-hisi_hip07.c
deleted file mode 100644
index 09ddcb2..0000000
--- a/non-standard-hisi_hip07.c
+++ /dev/null
@@ -1,151 +0,0 @@
-/*
- * Copyright (c) 2017 Hisilicon Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include "ras-record.h"
-#include "ras-logger.h"
-#include "ras-report.h"
-#include "ras-non-standard-handler.h"
-
-/* common definitions */
-
-/* HISI SAS definitions */
-#define HISI_SAS_VALID_PA             BIT(0)
-#define HISI_SAS_VALID_MB_ERR         BIT(1)
-#define HISI_SAS_VALID_ERR_TYPE       BIT(2)
-#define HISI_SAS_VALID_AXI_ERR_INFO   BIT(3)
-
-struct hisi_sas_err_sec {
-	uint64_t   val_bits;
-	uint64_t   physical_addr;
-	uint32_t   mb;
-	uint32_t   type;
-	uint32_t   axi_err_info;
-};
-
-/* Common Functions */
-static char *err_bit_type(int etype)
-{
-	switch (etype) {
-	case 0x0: return "single-bit ecc";
-	case 0x1: return "multi-bit ecc";
-	}
-	return "unknown error";
-}
-
-/* SAS Functions */
-static char *sas_err_type(int etype)
-{
-	switch (etype) {
-	case 0x0001: return "hgc_dqe ecc";
-	case 0x0002: return "hgc_iost ecc";
-	case 0x0004: return "hgc_itct ecc";
-	case 0x0008: return "hgc_iostl ecc";
-	case 0x0010: return "hgc_itctl ecc";
-	case 0x0020: return "hgc_cqe ecc";
-	case 0x0040: return "rxm_mem0 ecc";
-	case 0x0080: return "rxm_mem1 ecc";
-	case 0x0100: return "rxm_mem2 ecc";
-	case 0x0200: return "rxm_mem3 ecc";
-	case 0x0400: return "wp_depth";
-	case 0x0800: return "iptt_slot_no_match";
-	case 0x1000: return "rp_depth";
-	case 0x2000: return "axi err";
-	case 0x4000: return "fifo err";
-	case 0x8000: return "lm_add_fetch_list";
-	case 0x10000: return "hgc_abt_fetch_lm";
-	}
-	return "unknown error";
-}
-
-static char *sas_axi_err_type(int etype)
-{
-	switch (etype) {
-	case 0x0001: return "IOST_AXI_W_ERR";
-	case 0x0002: return "IOST_AXI_R_ERR";
-	case 0x0004: return "ITCT_AXI_W_ERR";
-	case 0x0008: return "ITCT_AXI_R_ERR";
-	case 0x0010: return "SATA_AXI_W_ERR";
-	case 0x0020: return "SATA_AXI_R_ERR";
-	case 0x0040: return "DQE_AXI_R_ERR";
-	case 0x0080: return "CQE_AXI_W_ERR";
-	case 0x0100: return "CQE_WINFO_FIFO";
-	case 0x0200: return "CQE_MSG_FIFIO";
-	case 0x0400: return "GETDQE_FIFO";
-	case 0x0800: return "CMDP_FIFO";
-	case 0x1000: return "AWTCTRL_FIFO";
-	}
-	return "unknown error";
-}
-
-static int decode_hip07_sas_error(struct ras_events *ras,
-				  struct ras_ns_dec_tab *dec_tab,
-				  struct trace_seq *s,
-				  struct ras_non_standard_event *event)
-{
-	char buf[1024];
-	char *p = buf;
-	const struct hisi_sas_err_sec *err =
-			(struct hisi_sas_err_sec *)event->error;
-
-	if (err->val_bits == 0) {
-		trace_seq_printf(s, "%s: no valid error data\n",
-				 __func__);
-		return -1;
-	}
-	p += sprintf(p, "[");
-	if (err->val_bits & HISI_SAS_VALID_PA)
-		p += sprintf(p, "phy addr = 0x%p: ",
-			     (void *)err->physical_addr);
-
-	if (err->val_bits & HISI_SAS_VALID_MB_ERR)
-		p += sprintf(p, "%s: ", err_bit_type(err->mb));
-
-	if (err->val_bits & HISI_SAS_VALID_ERR_TYPE)
-		p += sprintf(p, "error type = %s: ",
-			     sas_err_type(err->type));
-
-	if (err->val_bits & HISI_SAS_VALID_AXI_ERR_INFO)
-		p += sprintf(p, "axi error type = %s",
-			     sas_axi_err_type(err->axi_err_info));
-
-	p += sprintf(p, "]");
-
-	trace_seq_printf(s, "\nHISI HIP07: SAS error: %s\n", buf);
-	return 0;
-}
-
-static int decode_hip07_hns_error(struct ras_events *ras,
-				  struct ras_ns_dec_tab *dec_tab,
-				  struct trace_seq *s,
-				  struct ras_non_standard_event *event)
-{
-	return 0;
-}
-
-struct ras_ns_dec_tab hisi_ns_dec_tab[] = {
-	{
-		.sec_type = "daffd8146eba4d8c8a91bc9bbf4aa301",
-		.decode = decode_hip07_sas_error,
-	},
-	{
-		.sec_type = "fbc2d923ea7a453dab132949f5af9e53",
-		.decode = decode_hip07_hns_error,
-	},
-	{ /* sentinel */ }
-};
-
-__attribute__((constructor))
-static void hip07_init(void)
-{
-	register_ns_dec_tab(hisi_ns_dec_tab);
-}
-- 
2.8.1

