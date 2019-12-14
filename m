Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F49911F1AF
	for <lists+linux-edac@lfdr.de>; Sat, 14 Dec 2019 13:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfLNMOB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 14 Dec 2019 07:14:01 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38134 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbfLNMOB (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 14 Dec 2019 07:14:01 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 562DCE84751F3EE19914;
        Sat, 14 Dec 2019 20:13:59 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Sat, 14 Dec 2019 20:13:55 +0800
From:   Xie XiuQi <xiexiuqi@huawei.com>
To:     <tony.luck@intel.com>, <bp@alien8.de>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] trace: ras: print the raw data of arm processor error info
Date:   Sat, 14 Dec 2019 20:11:09 +0800
Message-ID: <20191214121109.8349-1-xiexiuqi@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

User space tools such as rasdaemon need the complete error
information from trace event. So, we print the raw data of
error information in arm_event.

In the past, I try to parse them in trace event, but it's
hard to deal the dynamic error item. And in commit 301f55b1a917
("efi: Parse ARM error information value"), the error information
already been parsed to syslog.

So, just print the raw data in trace event for simpler.

Cc: Borislav Petkov <bp@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tyler Baicar <tbaicar@codeaurora.org>
Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 include/ras/ras_event.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 36c5c5e38c1d..2023ba9206b3 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -180,6 +180,9 @@ TRACE_EVENT(arm_event,
 		__field(u32, running_state)
 		__field(u32, psci_state)
 		__field(u8, affinity)
+		__field(u32, count)
+		__field(u32, len)
+		__dynamic_array(u8, err_info, proc->err_info_num * sizeof(struct cper_arm_err_info))
 	),
 
 	TP_fast_assign(
@@ -199,12 +202,18 @@ TRACE_EVENT(arm_event,
 			__entry->running_state = ~0;
 			__entry->psci_state = ~0;
 		}
+
+		__entry->count = proc->err_info_num;
+		__entry->len = __entry->count * sizeof(struct cper_arm_err_info);
+		memcpy(__get_dynamic_array(err_info), proc + 1, __entry->len);
 	),
 
 	TP_printk("affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
-		  "running state: %d; PSCI state: %d",
+		  "running state: %d; PSCI state: %d; error count: %d; "
+		  "raw data: %s",
 		  __entry->affinity, __entry->mpidr, __entry->midr,
-		  __entry->running_state, __entry->psci_state)
+		  __entry->running_state, __entry->psci_state, __entry->count,
+		  __print_hex(__get_dynamic_array(err_info), __entry->len))
 );
 
 /*
-- 
2.20.1

