Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18BA54573F
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jun 2022 00:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345774AbiFIWUT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 Jun 2022 18:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345671AbiFIWUP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 9 Jun 2022 18:20:15 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E000CA308B
        for <linux-edac@vger.kernel.org>; Thu,  9 Jun 2022 15:19:56 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id b9-20020a656689000000b003f672946300so12307512pgw.16
        for <linux-edac@vger.kernel.org>; Thu, 09 Jun 2022 15:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qfaKip6DwFGW+guGsE2/HUgOUCf7B/ryBL2HyFI8yyY=;
        b=rmDrQmu6i0rMhVWryy+1sSregBQbx8EzAhxguI/zyywENeaveJeync1WHxdDli/I7V
         XVFwNwX1LL/Eb2t1qJzoo+LZL4V651eslhmMESIosQ4CzFZqJ/XMZIcgfWh+ijuJ9S4U
         DE9dfzo5xGMJQHKyVBlVHIJPFhw5ayon8gNdeY1wYxrm/5naZOHI7yvxx4lN8IU/5Vsd
         Jrf74AJMKR+h5WOopQkEY05HkO30nH18xX4D85TjTMQIbL0iAHDhYHUPur2amaBP1CL6
         RS8eMppIKQevbuQilaLP804yNxwZ9Wuv+YrNiMwDfjRjNIKBMBVfcgDhrLJV95/xQEbr
         74gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qfaKip6DwFGW+guGsE2/HUgOUCf7B/ryBL2HyFI8yyY=;
        b=PvMiiFz5IjxaJVtjhKP9TZB9GqRZJj4Zn+pndWjCTWDpDZ8+VYelIr9S0KRTnv+77b
         oHhCE2oBdl9P+yY7ItyuuPO/MYOv0SHUiU9smN6wqAv4aBKQc2HHbEMZyOm5SInxgUIE
         yX1ygx3cD8why+QQYPlTh//yryafGQdzAGyC5wqbdxEAU8X2rChTA9tHStjoZx/LYJiO
         4TiQn9GvUHSyrrMf+c1Zj+bz6ffyvlkmzyBHQ/7uu+fd6vMjAdPYR25+FA6Kf+RpJYkX
         b3BFJ5n/Wv3MAGoUqbmwLl0v+IkIBlaqEAqt4WwspVT2f+YSDXPVpKLs8ujBPHwKk0m7
         G7Ng==
X-Gm-Message-State: AOAM532VY2ZLUrMAzqQuPQ0XWkwR8Wsa57MzrZbgmcZW0bSzR4don+MI
        1gSlWuF3eVBJBxbUbY93FBafFQOq
X-Google-Smtp-Source: ABdhPJzfxk5qZb5y/5tpnB1EFv7CAi9wKZuC1KM7/pyahvYM5X1dHlQAhdkQ2HW7pda2hCN2ocO+yxStMQ==
X-Received: from fawn.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5795])
 (user=morbo job=sendgmr) by 2002:a62:1687:0:b0:50d:3364:46d4 with SMTP id
 129-20020a621687000000b0050d336446d4mr42409947pfw.74.1654813195848; Thu, 09
 Jun 2022 15:19:55 -0700 (PDT)
Date:   Thu,  9 Jun 2022 22:16:26 +0000
In-Reply-To: <20220609221702.347522-1-morbo@google.com>
Message-Id: <20220609221702.347522-8-morbo@google.com>
Mime-Version: 1.0
References: <20220609221702.347522-1-morbo@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 07/12] driver/char: use correct format characters
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

drivers/char/mem.c:775:16: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
                              NULL, devlist[minor].name);
                                    ^~~~~~~~~~~~~~~~~~~

Use a string literal for the format string.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Bill Wendling <isanbard@gmail.com>
---
 drivers/char/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 84ca98ed1dad..32d821ba9e4d 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -772,7 +772,7 @@ static int __init chr_dev_init(void)
 			continue;
 
 		device_create(mem_class, NULL, MKDEV(MEM_MAJOR, minor),
-			      NULL, devlist[minor].name);
+			      NULL, "%s", devlist[minor].name);
 	}
 
 	return tty_init();
-- 
2.36.1.255.ge46751e96f-goog

