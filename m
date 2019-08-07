Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D26B8563D
	for <lists+linux-edac@lfdr.de>; Thu,  8 Aug 2019 00:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfHGW7i (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 7 Aug 2019 18:59:38 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:59240 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729219AbfHGW7i (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 7 Aug 2019 18:59:38 -0400
Received: from mr5.cc.vt.edu (smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x77Mxaes029672
        for <linux-edac@vger.kernel.org>; Wed, 7 Aug 2019 18:59:36 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x77MxVau028721
        for <linux-edac@vger.kernel.org>; Wed, 7 Aug 2019 18:59:36 -0400
Received: by mail-qk1-f198.google.com with SMTP id l14so80497733qke.16
        for <linux-edac@vger.kernel.org>; Wed, 07 Aug 2019 15:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=4WYp0sFtiquOnD7XFesrru7HLnSgpz+A8nRbXA9HLg4=;
        b=pTeXJKsi17hlFNP6vU/o2FpxfkJaT06nkvGYijAhV9wq563A/MthMMl8vcjXGuERi6
         8/BFRTBKQP2ccIBFz7qscTZ2wCyM7GsrqUn53pVgaY3KJAfqN61LaZAkFMnyVi226stw
         V05GZOnZ5z9AetU8l2irNyVGRvRrcacYJChMzahZNJ04i/MmGrTHWNSTlFWcdpB+YssH
         OMKaQWRh7lJbA8i6wLJvRzJWyviZ6IUiQilbC/dZ3Afn9Fg4h+cW8tlLSsrYlhFayAO7
         zbTGqc3n9hVoy7RqV2pgrpNXNwdyUhUBKfbHEVx//LEsVDQzKjliidUSvIjpLXASJ7Qb
         wqog==
X-Gm-Message-State: APjAAAWGa5CT1FoMbvLFr3USqVqLr3aqrcQdtArfl6u6ODYyXZpcjoaA
        7Gk3spLM6ZukrZp/Fm/CPkcN93NVIa1SYFBS276bqWb495DkkKbwuT2KANoE2RmXi6CZpm80/Iu
        SisIj13aoxHL5WpMBH4clgyMnB8S/2IQn
X-Received: by 2002:a05:6214:10ea:: with SMTP id q10mr10566674qvt.4.1565218771722;
        Wed, 07 Aug 2019 15:59:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw7F2Hr9hT2NBDVe2YHVe7q0mBNo/npy18I5/nmkItyMv2lMne1h0RZ53W+4zzzlkquIcAqwg==
X-Received: by 2002:a05:6214:10ea:: with SMTP id q10mr10566668qvt.4.1565218771488;
        Wed, 07 Aug 2019 15:59:31 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id h4sm39655853qkk.39.2019.08.07.15.59.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 15:59:30 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drivers/ras/debugfs.c - fix prototype warnings
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 07 Aug 2019 18:59:29 -0400
Message-ID: <7168.1565218769@turing-police>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

When building with C=2 and/or W=1, legitimate warnings are issued
about missing prototypes.  Provide the proper includes.

  CHECK   drivers/ras/debugfs.c
drivers/ras/debugfs.c:4:15: warning: symbol 'ras_debugfs_dir' was not declared. Should it be static?
drivers/ras/debugfs.c:8:5: warning: symbol 'ras_userspace_consumers' was not declared. Should it be static?
drivers/ras/debugfs.c:38:12: warning: symbol 'ras_add_daemon_trace' was not declared. Should it be static?
drivers/ras/debugfs.c:54:13: warning: symbol 'ras_debugfs_init' was not declared. Should it be static?
  CC      drivers/ras/debugfs.o
drivers/ras/debugfs.c:8:5: warning: no previous prototype for 'ras_userspace_consumers' [-Wmissing-prototypes]
    8 | int ras_userspace_consumers(void)
      |     ^~~~~~~~~~~~~~~~~~~~~~~
drivers/ras/debugfs.c:38:12: warning: no previous prototype for 'ras_add_daemon_trace' [-Wmissing-prototypes]
   38 | int __init ras_add_daemon_trace(void)
      |            ^~~~~~~~~~~~~~~~~~~~
drivers/ras/debugfs.c:54:13: warning: no previous prototype for 'ras_debugfs_init' [-Wmissing-prototypes]
   54 | void __init ras_debugfs_init(void)
      |             ^~~~~~~~~~~~~~~~

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/drivers/ras/debugfs.c b/drivers/ras/debugfs.c
index 9c1b717efad8..0d4f985afbf3 100644
--- a/drivers/ras/debugfs.c
+++ b/drivers/ras/debugfs.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/debugfs.h>
+#include <linux/ras.h>
+#include "debugfs.h"
 
 struct dentry *ras_debugfs_dir;
 



