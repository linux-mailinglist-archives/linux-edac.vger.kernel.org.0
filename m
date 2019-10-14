Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE8B0D6845
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2019 19:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388277AbfJNRTd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Oct 2019 13:19:33 -0400
Received: from foss.arm.com ([217.140.110.172]:49600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387802AbfJNRTd (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 14 Oct 2019 13:19:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBE4A1576;
        Mon, 14 Oct 2019 10:19:32 -0700 (PDT)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3DDD3F6C4;
        Mon, 14 Oct 2019 10:19:31 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-edac@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Robert Richter <rrichter@marvell.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/2] EDAC, ghes: Reference count GHES users of ghes_edac
Date:   Mon, 14 Oct 2019 18:19:19 +0100
Message-Id: <20191014171919.85044-3-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014171919.85044-1-james.morse@arm.com>
References: <20191014171919.85044-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

ghes_edac only does work for the first GHES entry that registers it.
The same is true for unregister: first come first served. This lack
of symmetry is problematic if we have more than one GHES entry, as
ghes_edac_register() can only be called once, nothing decrements
ghes_init.

Doing the unregister work on the first call is unsafe, as another
CPU may be processing a notification in ghes_edac_report_mem_error(),
using the memory we are about to free.

ghes_init is already half of the reference counting. We only need
to do the register work for the first call, and the unregister work
for the last. Add the unregister check.

This means we no longer free ghes_edac's memory while there are
GHES entries that may receive a notification.

Signed-off-by: James Morse <james.morse@arm.com>
Fixes: 0fe5f281f749 ("EDAC, ghes: Model a single, logical memory controller")
---
 drivers/edac/ghes_edac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 955b59b6aade..0bb62857ffb2 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -553,6 +553,9 @@ void ghes_edac_unregister(struct ghes *ghes)
 	if (!ghes_pvt)
 		return;
 
+	if (atomic_dec_return(&ghes_init))
+		return;
+
 	mci = ghes_pvt->mci;
 	ghes_pvt = NULL;
 	edac_mc_del_mc(mci->pdev);
-- 
2.20.1

