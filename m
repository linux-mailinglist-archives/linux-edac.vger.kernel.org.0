Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07208E67CF
	for <lists+linux-edac@lfdr.de>; Sun, 27 Oct 2019 22:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732524AbfJ0VYd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 27 Oct 2019 17:24:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732534AbfJ0VYc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 27 Oct 2019 17:24:32 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8BCC21783;
        Sun, 27 Oct 2019 21:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211471;
        bh=+9jZZGeI7w6970cSzL2GnY+5H/WDdvxEd0GZbvc3oaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ChvKMzfBeWdcS63/aRH0G2THLmFDINW5sFUObdsrITpuxpvTpA6GizIBeVnUN3ltU
         SUf9Y1JNrWKzctjxyVrDC8E5NxVwbd6xmp/tWvcoKZlfyTSXpX3eYws8qko41HiBU7
         i6h0hQKyPsEy5WLe2H8cKraWAuKIN/1XJClLSS8c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Garry <john.garry@huawei.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        linux-edac <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 5.3 162/197] EDAC/ghes: Fix Use after free in ghes_edac remove path
Date:   Sun, 27 Oct 2019 22:01:20 +0100
Message-Id: <20191027203402.547589321@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: James Morse <james.morse@arm.com>

commit 1e72e673b9d102ff2e8333e74b3308d012ddf75b upstream.

ghes_edac models a single logical memory controller, and uses a global
ghes_init variable to ensure only the first ghes_edac_register() will
do anything.

ghes_edac is registered the first time a GHES entry in the HEST is
probed. There may be multiple entries, so subsequent attempts to
register ghes_edac are silently ignored as the work has already been
done.

When a GHES entry is unregistered, it calls ghes_edac_unregister(),
which free()s the memory behind the global variables in ghes_edac.

But there may be multiple GHES entries, the next call to
ghes_edac_unregister() will dereference the free()d memory, and attempt
to free it a second time.

This may also be triggered on a platform with one GHES entry, if the
driver is unbound/re-bound and unbound. The re-bind step will do
nothing because of ghes_init, the second unbind will then do the same
work as the first.

Doing the unregister work on the first call is unsafe, as another
CPU may be processing a notification in ghes_edac_report_mem_error(),
using the memory we are about to free.

ghes_init is already half of the reference counting. We only need
to do the register work for the first call, and the unregister work
for the last. Add the unregister check.

This means we no longer free ghes_edac's memory while there are
GHES entries that may receive a notification.

This was detected by KASAN and DEBUG_TEST_DRIVER_REMOVE.

 [ bp: merge into a single patch. ]

Fixes: 0fe5f281f749 ("EDAC, ghes: Model a single, logical memory controller")
Reported-by: John Garry <john.garry@huawei.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Robert Richter <rrichter@marvell.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: <stable@vger.kernel.org>
Link: https://lkml.kernel.org/r/20191014171919.85044-2-james.morse@arm.com
Link: https://lkml.kernel.org/r/304df85b-8b56-b77e-1a11-aa23769f2e7c@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/edac/ghes_edac.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -553,7 +553,11 @@ void ghes_edac_unregister(struct ghes *g
 	if (!ghes_pvt)
 		return;
 
+	if (atomic_dec_return(&ghes_init))
+		return;
+
 	mci = ghes_pvt->mci;
+	ghes_pvt = NULL;
 	edac_mc_del_mc(mci->pdev);
 	edac_mc_free(mci);
 }


