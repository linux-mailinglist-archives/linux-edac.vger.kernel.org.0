Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC1712EFA0
	for <lists+linux-edac@lfdr.de>; Thu,  2 Jan 2020 23:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgABW33 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 2 Jan 2020 17:29:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:60504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730048AbgABW31 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 2 Jan 2020 17:29:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADD0F20866;
        Thu,  2 Jan 2020 22:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004167;
        bh=Cx/xZ2CdBultJ1QQYrebdLtgIDl5PklKrm8PpPvqR0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P3H8pw/JyDAJ/SKVbJOCQMj6y74xb8dwAOza2SY/4VbsCZplymYMvFZ1c8kCd0Uhf
         a5MytjlElslrx6/InlWL7mbIzNxoZJSUczhoWSkeEUiLVDlR+ANofNv0NYlFAkF0IH
         3gJ9WPkh+P/qn0AVY6YQXMer01ISAPNVPrIVzFFw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        Borislav Petkov <bp@suse.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 065/171] EDAC/ghes: Fix grain calculation
Date:   Thu,  2 Jan 2020 23:06:36 +0100
Message-Id: <20200102220555.906743841@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.960200039@linuxfoundation.org>
References: <20200102220546.960200039@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Robert Richter <rrichter@marvell.com>

[ Upstream commit 7088e29e0423d3195e09079b4f849ec4837e5a75 ]

The current code to convert a physical address mask to a grain
(defined as granularity in bytes) is:

	e->grain = ~(mem_err->physical_addr_mask & ~PAGE_MASK);

This is broken in several ways:

1) It calculates to wrong grain values. E.g., a physical address mask
of ~0xfff should give a grain of 0x1000. Without considering
PAGE_MASK, there is an off-by-one. Things are worse when also
filtering it with ~PAGE_MASK. This will calculate to a grain with the
upper bits set. In the example it even calculates to ~0.

2) The grain does not depend on and is unrelated to the kernel's
page-size. The page-size only matters when unmapping memory in
memory_failure(). Smaller grains are wrongly rounded up to the
page-size, on architectures with a configurable page-size (e.g. arm64)
this could round up to the even bigger page-size of the hypervisor.

Fix this with:

	e->grain = ~mem_err->physical_addr_mask + 1;

The grain_bits are defined as:

	grain = 1 << grain_bits;

Change also the grain_bits calculation accordingly, it is the same
formula as in edac_mc.c now and the code can be unified.

The value in ->physical_addr_mask coming from firmware is assumed to
be contiguous, but this is not sanity-checked. However, in case the
mask is non-contiguous, a conversion to grain_bits effectively
converts the grain bit mask to a power of 2 by rounding it up.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Robert Richter <rrichter@marvell.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20191106093239.25517-11-rrichter@marvell.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/ghes_edac.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index e3fa4390f846..4ddbf6604e2a 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -189,6 +189,7 @@ void ghes_edac_report_mem_error(struct ghes *ghes, int sev,
 	/* Cleans the error report buffer */
 	memset(e, 0, sizeof (*e));
 	e->error_count = 1;
+	e->grain = 1;
 	strcpy(e->label, "unknown label");
 	e->msg = pvt->msg;
 	e->other_detail = pvt->other_detail;
@@ -284,7 +285,7 @@ void ghes_edac_report_mem_error(struct ghes *ghes, int sev,
 
 	/* Error grain */
 	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
-		e->grain = ~(mem_err->physical_addr_mask & ~PAGE_MASK);
+		e->grain = ~mem_err->physical_addr_mask + 1;
 
 	/* Memory error location, mapped on e->location */
 	p = e->location;
@@ -391,8 +392,13 @@ void ghes_edac_report_mem_error(struct ghes *ghes, int sev,
 	if (p > pvt->other_detail)
 		*(p - 1) = '\0';
 
+	/* Sanity-check driver-supplied grain value. */
+	if (WARN_ON_ONCE(!e->grain))
+		e->grain = 1;
+
+	grain_bits = fls_long(e->grain - 1);
+
 	/* Generate the trace event */
-	grain_bits = fls_long(e->grain);
 	snprintf(pvt->detail_location, sizeof(pvt->detail_location),
 		 "APEI location: %s %s", e->location, e->other_detail);
 	trace_mc_event(type, e->msg, e->label, e->error_count,
-- 
2.20.1



