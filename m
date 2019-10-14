Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1652D6841
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2019 19:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388111AbfJNRTb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Oct 2019 13:19:31 -0400
Received: from foss.arm.com ([217.140.110.172]:49590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387802AbfJNRTb (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 14 Oct 2019 13:19:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2C231000;
        Mon, 14 Oct 2019 10:19:30 -0700 (PDT)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB9F03F6C4;
        Mon, 14 Oct 2019 10:19:29 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-edac@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Robert Richter <rrichter@marvell.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 1/2] EDAC, ghes: Fix Use after free in ghes_edac remove path
Date:   Mon, 14 Oct 2019 18:19:18 +0100
Message-Id: <20191014171919.85044-2-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014171919.85044-1-james.morse@arm.com>
References: <20191014171919.85044-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

ghes_edac models a single logical memory controller, and uses a global
ghes_init variable to ensure only the first ghes_edac_register() will
do anything.

ghes_edac is registered the first time a GHES entry in the HEST is probed.
There may be multiple entries, so subsequent attempts to register
ghes_edac are silently ignored as the work has already been done.

When a GHES entry is unregistered, it calls ghes_edac_unregister(), which
free()s the memory behind the global variables in ghes_edac.

... but there may be multiple GHES entries, the next call to
ghes_edac_unregister() will dereference the free()d memory, and
attempt to free it a second time.

This may also be triggered on a platform with one GHES entry, if the
driver is unbound/re-bound and unbound. The re-bind step will do
nothing because of ghes_init, the second unbind will then do the same
work as the first.

This was detected by KASAN and DEBUG_TEST_DRIVER_REMOVE.

Reported-by: John Garry <john.garry@huawei.com>
Link: lore.kernel.org/r/304df85b-8b56-b77e-1a11-aa23769f2e7c@huawei.com
Signed-off-by: James Morse <james.morse@arm.com>
Fixes: 0fe5f281f749 ("EDAC, ghes: Model a single, logical memory controller")
---
 drivers/edac/ghes_edac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index d413a0bdc9ad..955b59b6aade 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -554,6 +554,7 @@ void ghes_edac_unregister(struct ghes *ghes)
 		return;
 
 	mci = ghes_pvt->mci;
+	ghes_pvt = NULL;
 	edac_mc_del_mc(mci->pdev);
 	edac_mc_free(mci);
 }
-- 
2.20.1

