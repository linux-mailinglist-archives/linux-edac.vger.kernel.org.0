Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981BF4804C4
	for <lists+linux-edac@lfdr.de>; Mon, 27 Dec 2021 22:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbhL0VP7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Dec 2021 16:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhL0VP6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 27 Dec 2021 16:15:58 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858C6C06173E;
        Mon, 27 Dec 2021 13:15:58 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 83A6C1EC0136;
        Mon, 27 Dec 2021 22:15:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640639752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=v89L9YrJVb3sx+iZgfHzW+0wtMeZVlTyazLamFsjbXw=;
        b=dOsOj1SyKWdxG+yORljCuoUxeC7qOlw5X4AVLrYbrN9HSyOnBDgKGse8hz/MmHJ3AVOogI
        9EFlR+1pm5vXBx16RO/9jH9kOWmpk0/RgpD4LA5H5NebihZex2t/Gc0/Bac5RY0i1N9iCt
        VkbKmKamSEaC25+CKyzWfCp9IzVc5lE=
Date:   Mon, 27 Dec 2021 22:15:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     =?utf-8?B?5byg5a2Q5YuLKFpoYW5nIFppeHVuKQ==?= <zhangzixun1@oppo.com>
Cc:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: A stack overflow found in flags_write()
Message-ID: <YcotC4QE29+GGUey@zn.tnic>
References: <TY2PR02MB2815A59F6B963F9C068CBB8A8E429@TY2PR02MB2815.apcprd02.prod.outlook.com>
 <YcnePfF1OOqoQwrX@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YcnePfF1OOqoQwrX@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

As to the issue at hand, that was a good catch - I was just able to
trigger it so I wrote a proper patch for you.

Lemme know if you're ok with it - I'll queue it soon.

Thx.

---
From: Zhang Zixun <zhang133010@icloud.com>
Date: Mon, 27 Dec 2021 22:02:49 +0100
Subject: [PATCH] x86/mce/inject: Avoid out-of-bounds write when setting flags

A contrived zero-length write, for example, by using write(2):

  ...
  ret = write(fd, str, 0);
  ...

to the "flags" file causes:

  BUG: KASAN: stack-out-of-bounds in flags_write
  Write of size 1 at addr ffff888019be7ddf by task writefile/3787

  CPU: 4 PID: 3787 Comm: writefile Not tainted 5.16.0-rc7+ #12
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014

due to accessing buf one char before its start.

Prevent such out-of-bounds access.

  [ bp: Productize into a proper patch. ]

Fixes: 0451d14d0561 ("EDAC, mce_amd_inj: Modify flags attribute to use string arguments")
Signed-off-by: Zhang Zixun <zhang133010@icloud.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/TY2PR02MB2815A59F6B963F9C068CBB8A8E429@TY2PR02MB2815.apcprd02.prod.outlook.com
---
 arch/x86/kernel/cpu/mce/inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 6eac840c64bb..5fbd7ffb3233 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -363,7 +363,7 @@ static ssize_t flags_write(struct file *filp, const char __user *ubuf,
 	char buf[MAX_FLAG_OPT_SIZE], *__buf;
 	int err;
 
-	if (cnt > MAX_FLAG_OPT_SIZE)
+	if (!cnt || cnt > MAX_FLAG_OPT_SIZE)
 		return -EINVAL;
 
 	if (copy_from_user(&buf, ubuf, cnt))
-- 
2.29.2


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
