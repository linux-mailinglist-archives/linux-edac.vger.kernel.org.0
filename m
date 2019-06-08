Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEEB3A22B
	for <lists+linux-edac@lfdr.de>; Sat,  8 Jun 2019 23:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfFHV3t (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 8 Jun 2019 17:29:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45273 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbfFHV3t (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 8 Jun 2019 17:29:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x58LTfcb3145827
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 8 Jun 2019 14:29:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x58LTfcb3145827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560029381;
        bh=ggyYlir8gcf2gj4AxkHQrSsF3ZyY4XSgxOjurYhU5y4=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=v/tqO/DvuVKh9dhDD3bv8Cca7z6QjxnYiMUd5Jxu414OakKe54tmYIwPt1/uqsmq4
         GaUV3hUO8e83+4UxLQQ+4JkduWWm7qm59CPQ5uFT+fGaKNYGBt7pNqanUcVyH/bfW/
         z1AIm4PV0YYcP6TE8U9S6W+/jQkqlHtNe98jazi+zVjD1oL0aqrGHRZ6eEIVx2m3cb
         rrDUPNxffbesRqL8WCH4HRooo3mQGK8nBTJCORHSY2L/Tt3JY33vMB2CC69ZpKvje0
         CJIErOgodKSZDfhABJqf7T55cx4GVRgJTrJkrWf4ISlr0cW504jWeiro8JROiVoX1k
         O92UwQzNkp3Ow==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x58LTfcE3145824;
        Sat, 8 Jun 2019 14:29:41 -0700
Date:   Sat, 8 Jun 2019 14:29:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-f57518cd56e2919afbcef3839122a75e291c7f85@git.kernel.org>
Cc:     bp@suse.de, mingo@kernel.org, tglx@linutronix.de,
        tony.luck@intel.com, linux-edac@vger.kernel.org, hpa@zytor.com
Reply-To: bp@suse.de, mingo@kernel.org, tglx@linutronix.de,
          tony.luck@intel.com, linux-edac@vger.kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] RAS/CEC: Dump the different array element sections
Git-Commit-ID: f57518cd56e2919afbcef3839122a75e291c7f85
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

Commit-ID:  f57518cd56e2919afbcef3839122a75e291c7f85
Gitweb:     https://git.kernel.org/tip/f57518cd56e2919afbcef3839122a75e291c7f85
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Sat, 20 Apr 2019 23:01:03 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 8 Jun 2019 17:39:11 +0200

RAS/CEC: Dump the different array element sections

When dumping the array elements, print them in the following format:

  [ PFN | generation in binary | count ]

to be perfectly clear what all those sections are.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
---
 drivers/ras/cec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 364f7e1a6bad..dc08c705b493 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -429,6 +429,8 @@ static int action_threshold_set(void *data, u64 val)
 }
 DEFINE_DEBUGFS_ATTRIBUTE(action_threshold_ops, u64_get, action_threshold_set, "%lld\n");
 
+static const char * const bins[] = { "00", "01", "10", "11" };
+
 static int array_dump(struct seq_file *m, void *v)
 {
 	struct ce_array *ca = &ce_arr;
@@ -440,7 +442,8 @@ static int array_dump(struct seq_file *m, void *v)
 	for (i = 0; i < ca->n; i++) {
 		u64 this = PFN(ca->array[i]);
 
-		seq_printf(m, " %03d: [%016llx|%03llx]\n", i, this, FULL_COUNT(ca->array[i]));
+		seq_printf(m, " %3d: [%016llx|%s|%03llx]\n",
+			   i, this, bins[DECAY(ca->array[i])], COUNT(ca->array[i]));
 	}
 
 	seq_printf(m, "}\n");
