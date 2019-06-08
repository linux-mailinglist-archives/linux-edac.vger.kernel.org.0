Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8885C3A225
	for <lists+linux-edac@lfdr.de>; Sat,  8 Jun 2019 23:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfFHV04 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 8 Jun 2019 17:26:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38447 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbfFHV04 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 8 Jun 2019 17:26:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x58LQlos3145401
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 8 Jun 2019 14:26:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x58LQlos3145401
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560029208;
        bh=Li539FWuRHtIQmBZ9m/rWGKt7iOjh+Jy+OQa3lbrGD4=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=mcrnjnZ4y0/KQJaYiNIRspZkTwQqedt+VlLnSi4WIoKwtXVoGxRUttEdJTnCErbGj
         Te/NSeujMAb6R4HRKXb+hzN9O+joRiJEutZXiuvUX4NGfdFdB5LBQD6FA6AfPFgc0k
         4gcKaeXh9KdwTgfbisedBZccpQiVvWpviMtb0y2bA8vGxbxRQHRLkEVvD4YKTZwQos
         g/IM0PPinCCtIaXNkxt3sFZT9r+iSvsmSip3UxriedYtMiH9PWfRUcte8P5XpYHHaK
         Ew3sSM2VoMAQDz1hiEwLqb2m6uLbR/k9/RvuMDYxcv3J/V+36HRjLP5fo8Dwcbowe2
         u1prrlsQRlF/g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x58LQlDd3145398;
        Sat, 8 Jun 2019 14:26:47 -0700
Date:   Sat, 8 Jun 2019 14:26:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-5cc6b16ea1313d05956b55e83a1f753c604282a8@git.kernel.org>
Cc:     tony.luck@intel.com, mingo@kernel.org, tglx@linutronix.de,
        linux-edac@vger.kernel.org, bp@suse.de, hpa@zytor.com
Reply-To: bp@suse.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, tony.luck@intel.com, tglx@linutronix.de,
          linux-edac@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] RAS/CEC: Do not set decay value on error
Git-Commit-ID: 5cc6b16ea1313d05956b55e83a1f753c604282a8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.4 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Commit-ID:  5cc6b16ea1313d05956b55e83a1f753c604282a8
Gitweb:     https://git.kernel.org/tip/5cc6b16ea1313d05956b55e83a1f753c604282a8
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Sat, 20 Apr 2019 21:33:08 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 8 Jun 2019 17:34:36 +0200

RAS/CEC: Do not set decay value on error

When the value requested doesn't match the allowed (min,max) range,
the @data buffer should not be modified with the invalid value because
reading "decay_interval" shows it otherwise as if the previous write
succeeded.

Move the data write after the check.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
---
 drivers/ras/cec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 73a975c26f9f..31868bd99e8d 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -371,17 +371,17 @@ DEFINE_DEBUGFS_ATTRIBUTE(pfn_ops, u64_get, pfn_set, "0x%llx\n");
 
 static int decay_interval_set(void *data, u64 val)
 {
-	*(u64 *)data = val;
-
 	if (val < CEC_DECAY_MIN_INTERVAL)
 		return -EINVAL;
 
 	if (val > CEC_DECAY_MAX_INTERVAL)
 		return -EINVAL;
 
+	*(u64 *)data   = val;
 	decay_interval = val;
 
 	cec_mod_work(decay_interval);
+
 	return 0;
 }
 DEFINE_DEBUGFS_ATTRIBUTE(decay_interval_ops, u64_get, decay_interval_set, "%lld\n");
