Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BD250D5C5
	for <lists+linux-edac@lfdr.de>; Mon, 25 Apr 2022 00:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239820AbiDXWft (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 24 Apr 2022 18:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239595AbiDXWfs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 24 Apr 2022 18:35:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD6C3EB9B;
        Sun, 24 Apr 2022 15:32:46 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 979E71EC04CB;
        Mon, 25 Apr 2022 00:32:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650839561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=E3tWFCCoZ4AqC9DN7Y36E9oH45r+IOFCKmGU4NaYoGM=;
        b=XMn87LB2mAo98qtdX6vdUPFXOY0zkGDkJj+9g0wTKuCI/t9Kn+5QHvcrJiFr1+sHlSQ/v/
        QlwYLTWF33nxbzBdfw7XMKEZsd6EA1kOJ93tunwcm1+firf5cHvD7SNaf/L9dt7ds9wLAe
        qOEc5jHoOxrJrSfBfyCgLRQ10RBha4s=
Date:   Mon, 25 Apr 2022 00:32:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v4 1/2] x86/mce: Check for writes ignored in MCA_STATUS
 register
Message-ID: <YmXQBbCz2T/Opv5+@zn.tnic>
References: <20220214233640.70510-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220214233640.70510-2-Smita.KoralahalliChannabasappa@amd.com>
 <Yk267A1MKOo2AlXQ@zn.tnic>
 <6cda2827-af75-589d-3e43-a287d6683e7a@amd.com>
 <Yl/PupT3bAfc4IBW@zn.tnic>
 <5512261e-085b-65fa-605b-38692769f89c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5512261e-085b-65fa-605b-38692769f89c@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Apr 21, 2022 at 12:10:07PM -0700, Smita Koralahalli wrote:
> Also, should we move this slightly before? In inj_bank_set() after we check
> for sw injection and before reading IPID value?

If anything, the proper place for this would be to do the check in
flags_write() where you set the injection type and bail out if one of
the !sw types is chosen.

However, you must do the prepare_mca_status() dance first in order to do
the check.

Which means, you'd have to poke at the STATUS MSR of some bank and
carefully restore it to its original value so that you leave no changes
after the check. And I thought about it but it sounded kinda yucky, thus
the setting of hw_injection_possible at injection time.

That doesn't mean you can't check that variable in flags_write() *after*
the first injection has happened and it has been set properly, but the
first injection needs to get attempted first.

At least this is my idea, maybe you have a better one...

Btw, we'd need some error messaging when the hw injection fails:

---
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 0fd1eea2f754..5ea1d603b124 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -345,6 +345,9 @@ static int __set_inj(const char *buf)
 
 	for (i = 0; i < N_INJ_TYPES; i++) {
 		if (!strncmp(flags_options[i], buf, strlen(flags_options[i]))) {
+			if (i > SW_INJ && !hw_injection_possible)
+				continue;
+
 			inj_type = i;
 			return 0;
 		}
@@ -382,7 +385,11 @@ static ssize_t flags_write(struct file *filp, const char __user *ubuf,
 
 	err = __set_inj(__buf);
 	if (err) {
-		pr_err("%s: Invalid flags value: %s\n", __func__, __buf);
+		pr_err("%s: Invalid flags value%s: %s\n", __func__,
+			(!hw_injection_possible
+			  ? " (SW-only injection possible on this platform)"
+			  : ""),
+			__buf);
 		return err;
 	}
 
-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
