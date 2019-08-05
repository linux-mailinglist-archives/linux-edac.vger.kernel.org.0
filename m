Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28A74813A5
	for <lists+linux-edac@lfdr.de>; Mon,  5 Aug 2019 09:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfHEHrs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Aug 2019 03:47:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44745 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfHEHrs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Aug 2019 03:47:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x757l1eF1629313
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 5 Aug 2019 00:47:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x757l1eF1629313
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564991221;
        bh=XE9h3RcCYOMwSuLRzzlKCzMgMSixjMCVWUaG8IYiZWA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=rmpBMccs6rFtd4/gz0DfZtJRAeJXsq1smw8aAt9xsz6euBCHVcMOGk5QQgKLe8rVH
         RQcHROlS8CL6vNfjDuUO4FzxJvhZGFrsnSKBboX7TMiEWKvubzUyo67lL9LHFhXFNW
         VOTEDgRO/tneFNuHMCy682SI3IvqU53QqjjiwM6LoWZU8GXeXZYbXf6/vVDTwe/MzZ
         9QPBHLoAt15FXzOdcp3HQGg76OiSG9mAwDkFGO1vT1O5TRVmLo03xtXr943x5Dzls5
         ftNyQS6OBFX6P8AV1rMmrp93mN+B950l7+ka5gRnTz1/+LV8bOpZyFV/SWeuVVWwWx
         +aSSzYl31Cplw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x757kxqr1629307;
        Mon, 5 Aug 2019 00:46:59 -0700
Date:   Mon, 5 Aug 2019 00:46:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Luck <tipbot@zytor.com>
Message-ID: <tip-aaefca8e30d9df7a4ca13c9c8e135dd227b8ff19@git.kernel.org>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org, mingo@redhat.com,
        tony.luck@intel.com, tglx@linutronix.de, bp@suse.de,
        linux-kernel@vger.kernel.org, yongkaiwu@tencent.com,
        mingo@kernel.org, hpa@zytor.com
Reply-To: mingo@redhat.com, tony.luck@intel.com, tglx@linutronix.de,
          linux-edac@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
          bp@suse.de, linux-kernel@vger.kernel.org, yongkaiwu@tencent.com,
          mingo@kernel.org
In-Reply-To: <20190718182920.32621-1-tony.luck@intel.com>
References: <20190718182920.32621-1-tony.luck@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce: Don't check for the overflow bit on action
 optional machine checks
Git-Commit-ID: aaefca8e30d9df7a4ca13c9c8e135dd227b8ff19
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.3 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Commit-ID:  aaefca8e30d9df7a4ca13c9c8e135dd227b8ff19
Gitweb:     https://git.kernel.org/tip/aaefca8e30d9df7a4ca13c9c8e135dd227b8ff19
Author:     Tony Luck <tony.luck@intel.com>
AuthorDate: Thu, 18 Jul 2019 11:29:20 -0700
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 5 Aug 2019 09:34:02 +0200

x86/mce: Don't check for the overflow bit on action optional machine checks

We currently do not process SRAO (Software Recoverable Action Optional)
machine checks if they are logged with the overflow bit set to 1 in the
machine check bank status register. This is overly conservative.

There are two cases where we could end up with an SRAO+OVER log based
on the SDM volume 3 overwrite rules in "Table 15-8. Overwrite Rules for
UC, CE, and UCR Errors"

1) First a corrected error is logged, then the SRAO error overwrites.
   The second error overwrites the first because uncorrected errors
   have a higher severity than corrected errors.
2) The SRAO error was logged first, followed by a correcetd error.
   In this case the first error is retained in the bank.

So in either case the machine check bank will contain the address
of the SRAO error. So we can process that even if the overflow bit
was set.

Reported-by: Yongkai Wu <yongkaiwu@tencent.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190718182920.32621-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/severity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 210f1f5db5f7..87bcdc6dc2f0 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -107,11 +107,11 @@ static struct severity {
 	 */
 	MCESEV(
 		AO, "Action optional: memory scrubbing error",
-		SER, MASK(MCI_STATUS_OVER|MCI_UC_AR|MCACOD_SCRUBMSK, MCI_STATUS_UC|MCACOD_SCRUB)
+		SER, MASK(MCI_UC_AR|MCACOD_SCRUBMSK, MCI_STATUS_UC|MCACOD_SCRUB)
 		),
 	MCESEV(
 		AO, "Action optional: last level cache writeback error",
-		SER, MASK(MCI_STATUS_OVER|MCI_UC_AR|MCACOD, MCI_STATUS_UC|MCACOD_L3WB)
+		SER, MASK(MCI_UC_AR|MCACOD, MCI_STATUS_UC|MCACOD_L3WB)
 		),
 
 	/* ignore OVER for UCNA */
