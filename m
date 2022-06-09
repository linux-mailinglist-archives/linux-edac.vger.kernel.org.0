Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE56C545717
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jun 2022 00:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbiFIWSH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 Jun 2022 18:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345563AbiFIWSE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 9 Jun 2022 18:18:04 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AAF3BF85
        for <linux-edac@vger.kernel.org>; Thu,  9 Jun 2022 15:18:02 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id l5-20020a170902f68500b00167654aeba1so8391090plg.2
        for <linux-edac@vger.kernel.org>; Thu, 09 Jun 2022 15:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SFFjvyZvefpU9NrWWzQ0TAmvQ8SzfCLTau1AjR7El54=;
        b=Kr2RYZFWYOeNjzG0DXVZ1PIX9XZMzBF03Z569egSujYX+SETM8BM22isVSs7ZYg0je
         vtmIi51QjRTMj1fwLrkgjqNVlwKBP1pP5HLG5JFnMd4QeQYx2K01nU1Ejrc/H0elX0dB
         xVMAEAznym96CzfG/aOkwGNw3H9g+blFPI7HqqKYy6VdsppoXnWpV0WmljI7FHufbK83
         ON+xFi3394AkXlTQEdIEaihpVBJQ8PGsd812EFScZ5x0FGwt1QmokUw/eccZEX97Itvg
         V6YGaLMc68zBNDG7tvYESM8uNaTijhm4Fewwwm5H2YtyjsN07CoVm9f4qHoqAerZAXZJ
         XTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SFFjvyZvefpU9NrWWzQ0TAmvQ8SzfCLTau1AjR7El54=;
        b=DBle3IcMy/1PmXwFhMKA6/cJ0YW07vh8UU2NVEJRUV9S6v98xPXuaMGbWt7Ivg/rCN
         l1c0vSO/3Oyfb91RH56XtLavbIKNQ4flBc72jzc4lj3yeGTOaEOgVdr5OPW3g1kWPQUw
         NvhPxhMsMas0orotnKqtv4l+WDDhXWHDtPNH/3he+e3m6ktB2G7RUuldBLpS+JISX4ab
         ifIWpThZ+GKntLEUl8u+gjjUie/qOUiOgAg9IbK6WJX78PpkXkrjxwIr7BD+pFR5To1A
         ZVnRDrnGcVUapin1x9XqkQWOUlnFS+lEJRYklOs4YVP7N7okQeedpg0kD5KECZMxOK0X
         aZ/Q==
X-Gm-Message-State: AOAM530nrNP3jR0GXPerAX8SmyDUFS7P/ycpZ094wiXREZcxpcWS1xmj
        StMG7YU3YGOo5rruFQhTKfnQvAYs
X-Google-Smtp-Source: ABdhPJweUcyR1bJf/XiwDrAaJ+hZ/VGm1qzwS+oRhWzjXi1BAcLnFDZIdAsYxk3A8uUCFP+evw6wWgyl2Q==
X-Received: from fawn.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5795])
 (user=morbo job=sendgmr) by 2002:a63:35ce:0:b0:3fd:fb5a:a1c3 with SMTP id
 c197-20020a6335ce000000b003fdfb5aa1c3mr15000208pga.85.1654813082090; Thu, 09
 Jun 2022 15:18:02 -0700 (PDT)
Date:   Thu,  9 Jun 2022 22:16:21 +0000
In-Reply-To: <20220609221702.347522-1-morbo@google.com>
Message-Id: <20220609221702.347522-3-morbo@google.com>
Mime-Version: 1.0
References: <20220609221702.347522-1-morbo@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 02/12] x86/CPU/AMD: use correct format characters
From:   Bill Wendling <morbo@google.com>
To:     isanbard@gmail.com
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jan Kara <jack@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, alsa-devel@alsa-project.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Bill Wendling <isanbard@gmail.com>

When compiling with -Wformat, clang emits the following warnings:

arch/x86/kernel/cpu/mce/amd.c:1119:67: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
        err = kobject_init_and_add(&b->kobj, &threshold_ktype, tb->kobj, get_name(cpu, bank, b));
                                                                         ^~~~~~~~~~~~~~~~~~~~~~
arch/x86/kernel/cpu/mce/amd.c:1151:47: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
        err = kobject_add(&b->blocks->kobj, b->kobj, b->blocks->kobj.name);
                                                     ^~~~~~~~~~~~~~~~~~~~
arch/x86/kernel/cpu/mce/amd.c:1157:42: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
                err = kobject_add(&pos->kobj, b->kobj, pos->kobj.name);
                                                       ^~~~~~~~~~~~~~
arch/x86/kernel/cpu/mce/amd.c:1187:43: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
                        err = kobject_add(b->kobj, &dev->kobj, name);
                                                               ^~~~
                                                               "%s",

Use a string literal for the format string.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Bill Wendling <isanbard@gmail.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 1c87501e0fa3..d19bf0eb0abe 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1116,7 +1116,8 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 	else
 		tb->blocks = b;
 
-	err = kobject_init_and_add(&b->kobj, &threshold_ktype, tb->kobj, get_name(cpu, bank, b));
+	err = kobject_init_and_add(&b->kobj, &threshold_ktype, tb->kobj, "%s",
+				   get_name(cpu, bank, b));
 	if (err)
 		goto out_free;
 recurse:
@@ -1148,13 +1149,13 @@ static int __threshold_add_blocks(struct threshold_bank *b)
 	struct threshold_block *tmp = NULL;
 	int err = 0;
 
-	err = kobject_add(&b->blocks->kobj, b->kobj, b->blocks->kobj.name);
+	err = kobject_add(&b->blocks->kobj, b->kobj, "%s", b->blocks->kobj.name);
 	if (err)
 		return err;
 
 	list_for_each_entry_safe(pos, tmp, head, miscj) {
 
-		err = kobject_add(&pos->kobj, b->kobj, pos->kobj.name);
+		err = kobject_add(&pos->kobj, b->kobj, "%s", pos->kobj.name);
 		if (err) {
 			list_for_each_entry_safe_reverse(pos, tmp, head, miscj)
 				kobject_del(&pos->kobj);
@@ -1184,7 +1185,7 @@ static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
 		if (nb && nb->bank4) {
 			/* yes, use it */
 			b = nb->bank4;
-			err = kobject_add(b->kobj, &dev->kobj, name);
+			err = kobject_add(b->kobj, &dev->kobj, "%s", name);
 			if (err)
 				goto out;
 
-- 
2.36.1.255.ge46751e96f-goog

