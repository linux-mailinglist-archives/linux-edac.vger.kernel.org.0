Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67E99180FAF
	for <lists+linux-edac@lfdr.de>; Wed, 11 Mar 2020 06:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgCKFRD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 11 Mar 2020 01:17:03 -0400
Received: from smtprelay0197.hostedemail.com ([216.40.44.197]:57984 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726821AbgCKFRD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 11 Mar 2020 01:17:03 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id E486518353718
        for <linux-edac@vger.kernel.org>; Wed, 11 Mar 2020 05:07:34 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 0AD4410194079;
        Wed, 11 Mar 2020 05:07:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:800:960:967:973:982:988:989:1260:1311:1314:1345:1359:1437:1515:1534:1541:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2859:2902:2904:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3865:3866:3867:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6261:9025:9592:10004:10848:11026:11473:11657:11658:11914:12043:12297:12438:12555:12679:12895:12986:13069:13311:13357:13894:14181:14384:14394:14721:14877:21080:21324:21433:21451:21627:21811:21939:30045:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:0,LUA_SUMMARY:none
X-HE-Tag: flag51_245cc6c4f8053
X-Filterd-Recvd-Size: 2301
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Mar 2020 05:07:29 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next 022/491] X86 MCE INFRASTRUCTURE: Use fallthrough;
Date:   Tue, 10 Mar 2020 21:51:36 -0700
Message-Id: <1dbc36979b08577a2d589b7fe572f83aadf7b5ef.1583896349.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1583896344.git.joe@perches.com>
References: <cover.1583896344.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/x86/kernel/cpu/mce/inject.c | 2 +-
 arch/x86/kernel/cpu/mce/intel.c  | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 3413b41..b5e3bab 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -199,7 +199,7 @@ static int raise_local(void)
 			 * calling irq_enter, but the necessary
 			 * machinery isn't exported currently.
 			 */
-			/*FALL THROUGH*/
+			fallthrough;
 		case MCJ_CTX_PROCESS:
 			raise_exception(m, NULL);
 			break;
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index d8f9230..5be647 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -192,9 +192,7 @@ unsigned long cmci_intel_adjust_timer(unsigned long interval)
 		__this_cpu_write(cmci_storm_state, CMCI_STORM_SUBSIDED);
 		if (!atomic_sub_return(1, &cmci_storm_on_cpus))
 			pr_notice("CMCI storm subsided: switching to interrupt mode\n");
-
-		/* FALLTHROUGH */
-
+		fallthrough;
 	case CMCI_STORM_SUBSIDED:
 		/*
 		 * We wait for all CPUs to go back to SUBSIDED state. When that
-- 
2.24.0

