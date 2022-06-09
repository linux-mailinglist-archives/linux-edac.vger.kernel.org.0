Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49256545709
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jun 2022 00:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345522AbiFIWRU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 Jun 2022 18:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344443AbiFIWRS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 9 Jun 2022 18:17:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B0740909
        for <linux-edac@vger.kernel.org>; Thu,  9 Jun 2022 15:17:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k73-20020a25244c000000b0065ca88b381aso21339714ybk.2
        for <linux-edac@vger.kernel.org>; Thu, 09 Jun 2022 15:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ig5mQ0gyC0oce1d/Zy8bEsqqFhtDY79w4cUoB0YUJhk=;
        b=V05U+x4LNh+To0zL8TXuNjeoTipGUWzS4C+mJRGY7QgduElSX56iUMHvUvLMhzjI09
         E+x7NCxoYFqVyFXI1TlmbTkoG0K6EXcMKlrYySH1QuvGlP37jlNn3/LNPCdiYeEd0GEX
         LIv1t4Su+H6fvGFvlkkmP2vDMIKlG+WobBu9nm/V5Y5/3H69sLKj+5cEln+2znKR6SCR
         fC2/3m/sX6SBfZ7eQ1UCfi6CIHJU4yas6UeLgZ+2cIhzSthWxwnpXo5pPTasAbA9B0Xs
         rfxKIB3w7yzCPfuUTDB83U0KP/M39tuXj5LkDncm21ZIAnPkSh3VMh/A84ECTFd7kj87
         IbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ig5mQ0gyC0oce1d/Zy8bEsqqFhtDY79w4cUoB0YUJhk=;
        b=liq7Big4utW4DQS0oJ4rkcoRMWkJ0kUWPphlRaQfuV45Rvp9E2xukrnAJ/mFAM5hbG
         I7NNN+Lac1WwklemjpFHqN1nvKcfr9H6+zBfu/PKKkXpx7Rcc0E27HEo1kvtHO6DyB+x
         Q+t8Qpi/U56ZipncKMDFZKMAP8SeCg+PPaZwYJ56JUo68I4oTwL7rNE0g9+Pcbx5TOZi
         Pbk9ptVKcE13fxrddFXgcxhuW6FPtinVsl+5WmphUWDNACSi9M4gC8PmL6MCX5D1s0nq
         yqtO9eAVhToHZY6Rslg9Ek5b3FLh/XBgt3bTuPbJ9CCgGjjQFbSj1nKdbGds3OOrxngi
         bMJQ==
X-Gm-Message-State: AOAM533ucqWysTj9hGMxlCkVi1OpZRXRUrSXsL8Q6Lmk41kikSrSZns3
        2+oSz1yleKMQgFftbI6VOiusJZoK
X-Google-Smtp-Source: ABdhPJzwx5X0ZE/nM+u+DgO5va7z203Jwou06sjKdU0c0pt2CnSBxfb1v768IuoKgsISspKmOdai1Wxx4w==
X-Received: from fawn.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5795])
 (user=morbo job=sendgmr) by 2002:a25:2985:0:b0:663:ec6a:4ff2 with SMTP id
 p127-20020a252985000000b00663ec6a4ff2mr14049602ybp.166.1654813036265; Thu, 09
 Jun 2022 15:17:16 -0700 (PDT)
Date:   Thu,  9 Jun 2022 22:16:19 +0000
Message-Id: <20220609221702.347522-1-morbo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 00/12] Clang -Wformat warning fixes
From:   Bill Wendling <morbo@google.com>
To:     isanbard@gmail.com
Cc:     Bill Wendling <morbo@google.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
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
        Ross Philipson <ross.philipson@oracle.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
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

This patch set fixes some clang warnings when -Wformat is enabled.

Bill Wendling (12):
  x86/mce: use correct format characters
  x86/CPU/AMD: use correct format characters
  x86/e820: use correct format characters
  blk-cgroup: use correct format characters
  fs: quota: use correct format characters
  PNP: use correct format characters
  driver/char: use correct format characters
  cdrom: use correct format characters
  ALSA: seq: use correct format characters
  ALSA: seq: use correct format characters
  ALSA: control: use correct format characters
  netfilter: conntrack: use correct format characters

 arch/x86/kernel/cpu/mce/amd.c       | 9 +++++----
 arch/x86/kernel/cpu/mce/core.c      | 2 +-
 arch/x86/kernel/e820.c              | 4 ++--
 drivers/cdrom/cdrom.c               | 2 +-
 drivers/char/mem.c                  | 2 +-
 drivers/pnp/interface.c             | 2 +-
 fs/quota/dquot.c                    | 2 +-
 mm/backing-dev.c                    | 2 +-
 net/netfilter/nf_conntrack_helper.c | 2 +-
 scripts/Makefile.extrawarn          | 4 ++--
 sound/core/control.c                | 2 +-
 sound/core/seq/seq_clientmgr.c      | 2 +-
 sound/core/sound.c                  | 2 +-
 13 files changed, 19 insertions(+), 18 deletions(-)

-- 
2.36.1.255.ge46751e96f-goog

