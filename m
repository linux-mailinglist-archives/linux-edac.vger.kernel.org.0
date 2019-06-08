Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1CF3A228
	for <lists+linux-edac@lfdr.de>; Sat,  8 Jun 2019 23:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfFHV1j (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 8 Jun 2019 17:27:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43449 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbfFHV1j (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 8 Jun 2019 17:27:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x58LRVXO3145700
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 8 Jun 2019 14:27:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x58LRVXO3145700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560029252;
        bh=NFzuBwTDRGe4YyWmom5QRb9DTpqofUFsUJTSlurXxKY=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=FFR9dnjPXFOUzy4WBQslH43uC+gIlQRYzylZL/8/Qx+5AiQ74KbTyd4/WivT+ghf5
         Q4VVrA0dvQi7T6tLQyYiW3leyuHnmspU1beshplWqK2yImaZyzGrZbjaVHpoz8VuSh
         rzVYukzhxc/OImi/WEjRNYj3fL6H8rjt10o1+wEpUXBxMUVOjkU3UrpebvxDywMzIA
         +0gIsTNHPd7/94EtJLzqbtuVnxLkrstNfG4/OBVg7t2p+SrdVOWr2C689BckjdA1od
         2FHLwUgUjke8Eg0/fWEj+4rjQtBgVQQ1eRwlYYu5hKbzfhe3nfVKael8hPtTxI/LXn
         Tlazqu/fCnDxw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x58LRVbI3145697;
        Sat, 8 Jun 2019 14:27:31 -0700
Date:   Sat, 8 Jun 2019 14:27:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-d0e375e8f26edd2e577e3afa9d952f91037cbd87@git.kernel.org>
Cc:     bp@suse.de, mingo@kernel.org, tony.luck@intel.com, hpa@zytor.com,
        tglx@linutronix.de, linux-edac@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, tony.luck@intel.com,
          tglx@linutronix.de, hpa@zytor.com, linux-edac@vger.kernel.org,
          bp@suse.de, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] RAS/CEC: Fix potential memory leak
Git-Commit-ID: d0e375e8f26edd2e577e3afa9d952f91037cbd87
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

Commit-ID:  d0e375e8f26edd2e577e3afa9d952f91037cbd87
Gitweb:     https://git.kernel.org/tip/d0e375e8f26edd2e577e3afa9d952f91037cbd87
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Sat, 20 Apr 2019 21:39:24 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 8 Jun 2019 17:35:04 +0200

RAS/CEC: Fix potential memory leak

Free the array page if a failure is encountered while creating the
debugfs nodes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
---
 drivers/ras/cec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 31868bd99e8d..f57e869dfea2 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -504,8 +504,10 @@ void __init cec_init(void)
 		return;
 	}
 
-	if (create_debugfs_nodes())
+	if (create_debugfs_nodes()) {
+		free_page((unsigned long)ce_arr.array);
 		return;
+	}
 
 	INIT_DELAYED_WORK(&cec_work, cec_work_fn);
 	schedule_delayed_work(&cec_work, CEC_DECAY_DEFAULT_INTERVAL);
