Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA91552A65
	for <lists+linux-edac@lfdr.de>; Tue, 21 Jun 2022 07:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344794AbiFUFIc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 21 Jun 2022 01:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243284AbiFUFI1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 21 Jun 2022 01:08:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50F220F56;
        Mon, 20 Jun 2022 22:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655788106; x=1687324106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=okitOvPYmnWiWxNrowvVr/Wz4wPde4s/6xq0EI+i8N4=;
  b=DMpfWXT6pDQ6Tcx11jSjRQkL1dKmpoNxvXVLZAKI03rIeO2VlxpQlUlB
   Pqy4AOhkhTsw1zggTCTf5jovBM++IKotnYGSRXcxYgIOsYRJCboRnCyop
   xBhyhiCanN6X+NjCL6chBlnpRMJ1ev9gIoqppd3dSQx3f9bgrMKOhvM7n
   djuK6T71M5gg38gPcwSxNMxWhcxnL8pC4uY4NjXMRfG9qE3vZuyjM+jYm
   MvbR5eQLVoehZ/HljrJhCt6DW/RqIOqvCq04+01TV7Te13IrEJTXwRIw/
   CdlvKze0adwvKQRFn5sVJm6fRcHuCGQACUy3AmYMIHvB63jtXbll6v1D+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="280076187"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="280076187"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 22:08:26 -0700
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="833408152"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 22:08:26 -0700
Date:   Mon, 20 Jun 2022 22:08:25 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, hpa@zytor.com,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 4/5] x86/mce: Move storm handling to core.
Message-ID: <YrFSSZqjtWlm9rUr@agluck-desk3.sc.intel.com>
References: <20220406063542.183946-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220406063542.183946-5-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406063542.183946-5-Smita.KoralahalliChannabasappa@amd.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Apr 06, 2022 at 01:35:41AM -0500, Smita Koralahalli wrote:
> +	/*
> +	 * When a bank is in storm mode, the history mask covers about
> +	 * one second of elapsed time. Check how long it has been since
> +	 * this bank was last polled, and compute a shift value to update
> +	 * the history bitmask.  When not in storm mode, each consecutive
> +	 * poll of the bank is logged in the next history bit, so shift
> +	 * is kept at "1".
> +	 */
> +	if (this_cpu_read(bank_storm[bank])) {
> +		delta = now - this_cpu_read(bank_time_stamp[bank]);
> +		shift = (delta + HZBITS) / HZBITS;
> +	}

Apologies for the long delay in following up on this.

I tested out your patches on an Intel system, and they "work"
in that storms are detected, mitigations applied, and then the
storm end is detected and the system returns to regular mode.

But the storm end happens far more quickly than I expected (in
just over a second).  So I stared again at the code above, and
realized it doesn't do what I expected.  Not your fault, you
just copied from my patches ... which means that my comment
didn't help explain what I was trying to do ... and so it wasn't
obvious that:
1) the test is backwards (need to adjust when the bank is NOT in
storm mode ... in storm mode we poll every second).
2) I can't even remember what I was trying to do with HZBITS, but
it seems wrong too. Just need to use HZ.

Patch below to be merged back into the series. This lets things
run for just over 30 seconds without finding a logged error while
polling in storm mode. Which is what I wanted.

[  111.486306] mce: CPU48 BANK7 CMCI storm detected
[  111.486394] mce: [Hardware Error]: Machine check events logged
[  111.486401] mce: [Hardware Error]: Machine check events logged
[  142.861874] mce: CPU48 BANK7 CMCI storm subsided

-Tony

---

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 74254f15f5db..8e6b77349911 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -655,16 +655,16 @@ void track_cmci_storm(int bank, u64 status)
 	u64 history;
 
 	/*
-	 * When a bank is in storm mode, the history mask covers about
-	 * one second of elapsed time. Check how long it has been since
-	 * this bank was last polled, and compute a shift value to update
-	 * the history bitmask.  When not in storm mode, each consecutive
-	 * poll of the bank is logged in the next history bit, so shift
-	 * is kept at "1".
+	 * When a bank is in storm mode it is polled once per second and
+	 * the history mask will record about the last minute of poll results.
+	 * If it is not in storm mode, then the bank is only checked when
+	 * there is a CMCI interrupt. Check how long it has been since
+	 * this bank was last checked, and adjust the amount of "shift"
+	 * to apply to history.
 	 */
-	if (this_cpu_read(bank_storm[bank])) {
+	if (!this_cpu_read(bank_storm[bank])) {
 		delta = now - this_cpu_read(bank_time_stamp[bank]);
-		shift = (delta + HZBITS) / HZBITS;
+		shift = (delta + HZ) / HZ;
 	}
 
 	/* If has been a long time since the last poll, clear history */
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index b9e8c8155c66..b88773a212cf 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -79,13 +79,6 @@ DECLARE_PER_CPU(unsigned long [MAX_NR_BANKS], bank_time_stamp);
  */
 #define STORM_END_POLL_THRESHOLD	30
 
-/*
- * When there is no storm each "bit" in the history represents
- * this many jiffies. When there is a storm every poll() takes
- * one history bit.
- */
-#define HZBITS (HZ / 64)
-
 #ifdef CONFIG_ACPI_APEI
 int apei_write_mce(struct mce *m);
 ssize_t apei_read_mce(struct mce *m, u64 *record_id);
