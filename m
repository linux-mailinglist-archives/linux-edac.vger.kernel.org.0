Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 870752E102
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2019 17:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfE2P0r (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 May 2019 11:26:47 -0400
Received: from foss.arm.com ([217.140.101.70]:48154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfE2P0r (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 29 May 2019 11:26:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3034341;
        Wed, 29 May 2019 08:26:46 -0700 (PDT)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FA653F5AF;
        Wed, 29 May 2019 08:26:45 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-edac@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH] EDAC, ghes: Fix grain calculation
Date:   Wed, 29 May 2019 16:22:32 +0100
Message-Id: <20190529152232.187580-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

ghes_edac_report_mem_error() attempts to calculate the 'grain' or
granule affected by the error from the firmware-provided 'physical address
mask'. This mask tells us which bits of the physical address are valid.

The current calculation:
| e->grain = ~(mem_err->physical_addr_mask & ~PAGE_MASK);
will always cause the top bits to be set as they are cleared by &,
then set again by ~. For a hypervisor reporting its page-size as the
region affected by the error:
| {1}[Hardware Error]:   physical_address: 0x00000000deadbeef
| {1}[Hardware Error]:   physical_address_mask: 0xfffffffffffff000
| {1}[Hardware Error]:   error_type: 6, master abort
| EDAC MC0: 1 CE Master abort on unknown label ( page:0xdead offset:0xbeef
| grain:-61441 syndrome:0x0 - status(0x0000000000000001): reserved)

Here the grain has been miscalculated as the hypervisor reported a 4K
size granule, due to its page size, whereas the guest kernel uses 64K.
This gives us e->grain of 0xffffffffffff0fff

Fix this, calculating grain_bits directly from ~physical_address_mask,
and setting e->grain from that. In the same example we now get:
| EDAC MC0: 1 CE Master abort on unknown label ( page:0xdead offset:0xbeef
| grain:4096 syndrome:0x0 - status(0x0000000000000001): reserved)

Cc: Robert Richter <rrichter@marvell.com>
Cc: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
This has always been broken, so I suspect no-one cares about this, it was
added by:
Fixes: f04c62a7036a ("ghes_edac: add support for reporting errors via EDAC")

I've only tested this with firmware I've written.

 drivers/edac/ghes_edac.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 49396bf6ad88..fac96ff45b7e 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -202,8 +202,8 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 	struct mem_ctl_info *mci;
 	struct ghes_edac_pvt *pvt = ghes_pvt;
 	unsigned long flags;
+	u8 grain_bits = 0;
 	char *p;
-	u8 grain_bits;
 
 	if (!pvt)
 		return;
@@ -318,8 +318,10 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 	}
 
 	/* Error grain */
-	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
-		e->grain = ~(mem_err->physical_addr_mask & ~PAGE_MASK);
+	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK) {
+		grain_bits = fls_long(~mem_err->physical_addr_mask);
+		e->grain = 1UL<<grain_bits;
+	}
 
 	/* Memory error location, mapped on e->location */
 	p = e->location;
@@ -436,7 +438,6 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 		*(p - 1) = '\0';
 
 	/* Generate the trace event */
-	grain_bits = fls_long(e->grain);
 	snprintf(pvt->detail_location, sizeof(pvt->detail_location),
 		 "APEI location: %s %s", e->location, e->other_detail);
 	trace_mc_event(type, e->msg, e->label, e->error_count,
-- 
2.20.1

