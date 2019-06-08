Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 358403A223
	for <lists+linux-edac@lfdr.de>; Sat,  8 Jun 2019 23:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfFHVZi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 8 Jun 2019 17:25:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49715 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbfFHVZi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 8 Jun 2019 17:25:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x58LPMCZ3145335
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 8 Jun 2019 14:25:23 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x58LPMCZ3145335
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560029123;
        bh=MMmHenzU+5IrNoyGGBxCHHd2b5T4fMqT4M2UFQgsUWE=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=R9ysOLn1veKpgtbyY89MViR+qwzM6YXuQQFBlRlZotJ5BZhSJjyT11x9iwFSwyJhB
         NUjV5lVBzmqEFudN+Hu+Owag9/5YSf8rtBOtEg8RX2hqZwL5rVe6diZS8FqiMkTQTl
         PXOhGcAH8hrBIjrl14Fnq2o8Tnzpp9Yyh+49Gbc0/m7y4dPBr6RjZVHjIwiCTkbxeS
         Xl+JzSrxa5VdeHSXMM4tbg6Rm4dgVrOrgL7P+eVCC5o0XWZ9Ex3zgAxOyn5LrtyQMk
         kZimnqpsRaMYsFlzz5fe2P8/qBtMnISBYFikJO8v3O7ZvH5XzeES6WHaS8U1N92Yy6
         SqCxbXUtJIkUQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x58LPM3D3145332;
        Sat, 8 Jun 2019 14:25:22 -0700
Date:   Sat, 8 Jun 2019 14:25:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-6d8e294bf5f0e85c34e8b14b064e2965f53f38b0@git.kernel.org>
Cc:     tony.luck@intel.com, hpa@zytor.com, bp@suse.de, tglx@linutronix.de,
        mingo@kernel.org, linux-edac@vger.kernel.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, bp@suse.de,
          tglx@linutronix.de, tony.luck@intel.com, mingo@kernel.org,
          linux-edac@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] RAS/CEC: Fix pfn insertion
Git-Commit-ID: 6d8e294bf5f0e85c34e8b14b064e2965f53f38b0
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

Commit-ID:  6d8e294bf5f0e85c34e8b14b064e2965f53f38b0
Gitweb:     https://git.kernel.org/tip/6d8e294bf5f0e85c34e8b14b064e2965f53f38b0
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Sat, 20 Apr 2019 12:53:05 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 8 Jun 2019 17:32:00 +0200

RAS/CEC: Fix pfn insertion

When inserting random PFNs for debugging the CEC through
(debugfs)/ras/cec/pfn, depending on the return value of pfn_set(),
multiple values get inserted per a single write.

That is because simple_attr_write() interprets a retval of 0 as
success and claims the whole input. However, pfn_set() returns the
cec_add_elem() value, which, if > 0 and smaller than the whole input
length, makes glibc continue issuing the write syscall until there's
input left:

  pfn_set
  simple_attr_write
  debugfs_attr_write
  full_proxy_write
  vfs_write
  ksys_write
  do_syscall_64
  entry_SYSCALL_64_after_hwframe

leading to those repeated calls.

Return 0 to fix that.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
---
 drivers/ras/cec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 673f8a128397..f5795adc5a6e 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -369,7 +369,9 @@ static int pfn_set(void *data, u64 val)
 {
 	*(u64 *)data = val;
 
-	return cec_add_elem(val);
+	cec_add_elem(val);
+
+	return 0;
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(pfn_ops, u64_get, pfn_set, "0x%llx\n");
