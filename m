Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0301B26E0A1
	for <lists+linux-edac@lfdr.de>; Thu, 17 Sep 2020 18:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgIQQZv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 17 Sep 2020 12:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbgIQQZr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 17 Sep 2020 12:25:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB52C06174A;
        Thu, 17 Sep 2020 09:25:46 -0700 (PDT)
Received: from zn.tnic (p200300ec2f105300c872f9f06eecfc48.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:5300:c872:f9f0:6eec:fc48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2F3811EC037C;
        Thu, 17 Sep 2020 18:25:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600359945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+LoOB6O795sdQOwvXn5Msv1mKnfAxL78Pj3P3gZOa8A=;
        b=TXX+aC8JzokMkgVgVmzKsSntV5nSge0boT3mFFkGdBn+XUdVECmAIOpcKh2ik8JX9O2vOG
        ekYiANhXFnhBeTFhcm3oe9sUGXv6o6WNI07nMVU3E1uxdOflQEoCNsBZANO11UHOTPxu+1
        xSbWlRCG3Npr/V0wu+SitdDrZxKzKD0=
Date:   Thu, 17 Sep 2020 18:25:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     mchehab@kernel.org, tony.luck@intel.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/mc_sysfs: Add missing newlines when printing
 {max,dimm}_location
Message-ID: <20200917162537.GL31960@zn.tnic>
References: <1600051734-8993-1-git-send-email-wangxiongfeng2@huawei.com>
 <20200916170052.GO2643@zn.tnic>
 <591e613e-0b53-028f-08fd-3d62a35b8c4f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <591e613e-0b53-028f-08fd-3d62a35b8c4f@huawei.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 17, 2020 at 07:38:57PM +0800, Xiongfeng Wang wrote:
> I am not sure if snprintf will return a value larger than its second input
> paramter 'size'.

The comment over snprintf() says

 * The return value is the number of characters which would be
 * generated for the given input, excluding the trailing null,
 * as per ISO C99.  If the return is greater than or equal to
 * @size, the resulting string is truncated.

And let's try it, see diff at the end. Now look what that produces:

[    2.594796] kernel_init: len: 16, str: [A lo]

it returns 16 for len even though the buffer is 5 chars long. So in our
patch, we'd increment by 16 which would be wrong.

Now let's use scnprintf():

[    2.700142] kernel_init: len: 4, str: [A lo]

Much better. Lemme do that.

> Not sure whether we need to check 'len' equals to 0.
> if (len <= 0) ?

Yeah, lemme fix that too, so we have now incrementally ontop:

---
diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index fa0551c81e63..c56e0004b39e 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -822,18 +822,17 @@ static ssize_t mci_max_location_show(struct device *dev,
 	int i, n;
 
 	for (i = 0; i < mci->n_layers; i++) {
-		n = snprintf(p, len, "%s %d ",
-			     edac_layer_name[mci->layers[i].type],
-			     mci->layers[i].size - 1);
-
+		n = scnprintf(p, len, "%s %d ",
+			      edac_layer_name[mci->layers[i].type],
+			      mci->layers[i].size - 1);
 		len -= n;
-		if (len < 0)
+		if (len <= 0)
 			goto out;
 
 		p += n;
 	}
 
-	p += snprintf(p, len, "\n");
+	p += scnprintf(p, len, "\n");
 out:
 	return p - data;
 }
---

Test diff:

---
diff --git a/init/main.c b/init/main.c
index ae78fb68d231..e2d6110d3a3d 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1397,7 +1397,8 @@ void __weak free_initmem(void)
 
 static int __ref kernel_init(void *unused)
 {
-	int ret;
+	char str[5];
+	int ret, len;
 
 	kernel_init_freeable();
 	/* need to finish all async __init code before freeing the memory */
@@ -1419,6 +1420,11 @@ static int __ref kernel_init(void *unused)
 
 	do_sysctl_args();
 
+	len = snprintf(str, 5, "A longer string\n");
+
+	pr_info("%s: len: %d, str: [%s]\n",
+		__func__, len, str);
+
 	if (ramdisk_execute_command) {
 		ret = run_init_process(ramdisk_execute_command);
 		if (!ret)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
