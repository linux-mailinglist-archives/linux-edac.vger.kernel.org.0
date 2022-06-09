Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E51545732
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jun 2022 00:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345498AbiFIWVc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 Jun 2022 18:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345533AbiFIWVa (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 9 Jun 2022 18:21:30 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52A953A73
        for <linux-edac@vger.kernel.org>; Thu,  9 Jun 2022 15:21:27 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id g129-20020a636b87000000b00401b8392ac8so478650pgc.4
        for <linux-edac@vger.kernel.org>; Thu, 09 Jun 2022 15:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+JW2n6LLjgkLeZpu0VrK7uVIniA8Omo9w9YQRrZ1ImQ=;
        b=i42901GYNhaxsHQ0DOGoOky9iCPlDaMMKrye+1S6wrdYfiDoHAZcC7HTQX/ufq8JDc
         FtLJH8ibG+4hcwJncrABH5MINqNlaiBQcg6AiUjnTwqlf664IuYPp0tvgNpDNS6s/GjQ
         Wjh2TOa/isNuXc04yhOdZrj9wIAtXkGMKkDBH370v2doh3glFP/6lvE9gZpbXECpN/zv
         UStKebGupQmmTtj2yMjnHwJiwJi/peKu25pYf9NTE11Ch6upWSa6FAa3CkIKEN5+Emo5
         3UDTgqdqaohZKI3Gp3XYmJjjv1YwnDPf8AUi3y1kFAWlFzS3PLERdXTH2sKpk0ltR6ij
         /vAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+JW2n6LLjgkLeZpu0VrK7uVIniA8Omo9w9YQRrZ1ImQ=;
        b=ahjbNMJngXfnLPa//0HHi+0Hq6oTeI4y8sGb0Xe6lQllIL0BkSkLxCnWjyg6Z/eUVI
         qrSZ6UioNP4bf5Bk0xWG2zJZDtaKmeT8qEz96U7/VG/3VGnwZUU5NEDFxN3QbT+ytLqx
         0wAHGgRPVYOcMgj/SgMtRh2PE1d/b9XyepcRNvE2hn2MRHYorwJIz3QuXZGQqWnoTVQt
         QX7UPDkC6BfrGYvVybrJOMnqcaV+VTsjkViM2XeXOos4bslLtRS6XcERvxUxp+bCUBfM
         RFQBjDd9YaFNCbey3AmoXxCHm5rP/0ZuYK+OHNGJs0wQNPfeWOtCfDrmjQaEclpyzmx2
         LxTQ==
X-Gm-Message-State: AOAM532RXyfGDGmihU17ReJpxQ8N4LrOwVnXz5+mwHn0yXTqqPJedYNZ
        q8sQiw+EootRuyPchangcG0ZyMY1
X-Google-Smtp-Source: ABdhPJxwIiVK0GwVN12g3ZMNH56OyPQzBgCjPEweYrbMYHqEsJdgXTONzisCGHUJLebHzTiLq5Vb6Q5FXg==
X-Received: from fawn.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5795])
 (user=morbo job=sendgmr) by 2002:a63:409:0:b0:3fd:77f0:9a75 with SMTP id
 9-20020a630409000000b003fd77f09a75mr25262295pge.149.1654813287223; Thu, 09
 Jun 2022 15:21:27 -0700 (PDT)
Date:   Thu,  9 Jun 2022 22:16:30 +0000
In-Reply-To: <20220609221702.347522-1-morbo@google.com>
Message-Id: <20220609221702.347522-12-morbo@google.com>
Mime-Version: 1.0
References: <20220609221702.347522-1-morbo@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 11/12] ALSA: control: use correct format characters
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

sound/core/control.c:2062:24: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
        return request_module(module_name);
                              ^~~~~~~~~~~

Use a string literal for the format string.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Bill Wendling <isanbard@gmail.com>
---
 sound/core/control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index a25c0d64d104..a1778137147d 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -2059,7 +2059,7 @@ int snd_ctl_request_layer(const char *module_name)
 	up_read(&snd_ctl_layer_rwsem);
 	if (lops)
 		return 0;
-	return request_module(module_name);
+	return request_module("%s", module_name);
 }
 EXPORT_SYMBOL_GPL(snd_ctl_request_layer);
 
-- 
2.36.1.255.ge46751e96f-goog

