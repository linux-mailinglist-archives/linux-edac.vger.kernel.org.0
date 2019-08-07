Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A490F85639
	for <lists+linux-edac@lfdr.de>; Thu,  8 Aug 2019 00:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbfHGW4F (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 7 Aug 2019 18:56:05 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:58912 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730038AbfHGW4F (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 7 Aug 2019 18:56:05 -0400
Received: from mr1.cc.vt.edu (mr1.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:31:1732:8aa4])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x77Mu3i1029246
        for <linux-edac@vger.kernel.org>; Wed, 7 Aug 2019 18:56:03 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x77MtwLC021438
        for <linux-edac@vger.kernel.org>; Wed, 7 Aug 2019 18:56:03 -0400
Received: by mail-qk1-f199.google.com with SMTP id x1so80562882qkn.6
        for <linux-edac@vger.kernel.org>; Wed, 07 Aug 2019 15:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=mY0KIEoA+H50LCkSAaCYNb72lFtyJPKWzTHzZKe658s=;
        b=Vp9VJv1GhdxNB9k+ZFTdLoKbYDtaXGX8YWfq5u6U3lk9PgMyHMJ9yfADUy6P+9k5r8
         LUG4eS7/6L0vKughEqTTxI3SjuiQ+OjvECTLvWXZBhgXcx8xLY+kLQClr8S3+p3YErjD
         ZlG7TnCtB408LCuZ/n5x9yWojiAGFTV3LQS0JONYAtCFnPECQO0sGg+E7KSxJBidIU+Y
         TJouGLbTkvtqmtn+zOJmJqZQq3qQPcmCJ62kGEJ8+eQC/0PdA9kaowdMdfIEQYCqhqVL
         e+B8DGh/xUHH2oGX+P2h7zGontAeO0f+lrr9mLt5yCreZYM8Ost4lq7OEjbIkXR99fF7
         ihIg==
X-Gm-Message-State: APjAAAXJzrmaVNkWkIBYTAtPbCNPqpw93XgPlKqMzhfnz4VZ7jQ/eJQN
        XO4gramgA3M+Glo/tq4Ybb9qf5zDvCStaXKo+GEnfGOzywIG+gehQ6ViNOeID9SPDGUofv/VKQL
        0QRhPcC1rzjc0F5Zqqx2BgfbAOqKPKGba
X-Received: by 2002:a05:620a:14ab:: with SMTP id x11mr10762401qkj.186.1565218558225;
        Wed, 07 Aug 2019 15:55:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxo+wivpeIKtcorCbZv7bt2gnfdh9d45AId0kEQ3TBxvHsC4lJ0Y1WuyHd7gVVWtPTSaoxsPQ==
X-Received: by 2002:a05:620a:14ab:: with SMTP id x11mr10762390qkj.186.1565218558020;
        Wed, 07 Aug 2019 15:55:58 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id p23sm36395103qkm.55.2019.08.07.15.55.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 15:55:57 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drivers/ras: Don't build debugfs.o if no debugfs in config
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 07 Aug 2019 18:55:56 -0400
Message-ID: <7053.1565218556@turing-police>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

There's no reason to build the debugfs.o if the kernel config doesn't
even include CONFIG_DEBUG_FS

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
index ef6777e14d3d..07a5c391cc23 100644
--- a/drivers/ras/Makefile
+++ b/drivers/ras/Makefile
@@ -1,3 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_RAS)	+= ras.o debugfs.o
+obj-$(CONFIG_RAS)	+= ras.o
+ifeq ($(CONFIG_DEBUG_FS),y)
+obj-$(CONFIG_RAS)	+= debugfs.o
+endif
 obj-$(CONFIG_RAS_CEC)	+= cec.o

