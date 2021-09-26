Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8551E4189CD
	for <lists+linux-edac@lfdr.de>; Sun, 26 Sep 2021 17:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbhIZPNW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 26 Sep 2021 11:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbhIZPNQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 26 Sep 2021 11:13:16 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55E0C061604;
        Sun, 26 Sep 2021 08:11:39 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k23so10583809pji.0;
        Sun, 26 Sep 2021 08:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ARrVj/pNBG29JUx0xG9pwjT9myavydgB1VWgMFtaDGg=;
        b=qb+i6qqpIhCN382R2WgdUxLkw1cUUvKtfER/RLH6vVF372M6HtnbRUOLrBcJSYU+15
         82i4eC/W0N3N6Qf7aeMdpQ4Cw9Fl3zTXlUan5DqHhLckVQERkUBuR7do+t6Op5QegySP
         rj6c2wOBf0asLmZD9SdNU3GuLlU4gc4k3xnVDVxH6eSW3xRkvcKiG1EZTXjSCk0W6lb7
         UER8DEsT3ZseUc+0pts8cBIgP+xbumvRJ/d5CEpXnGrXEMUQSeO7GwcHGAKlbIQDnu1f
         Yb3fqAhLfemugk6krSWVm5dg7oT0z5v0mzIgbIvzd8KUSC+ZW5+6MRd2ycvYbW1pjL5X
         Hbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ARrVj/pNBG29JUx0xG9pwjT9myavydgB1VWgMFtaDGg=;
        b=MSCPkRwLF3DNP5wd7qkt/SyaXjr8/EDKMPc5as7DgsNomgFwEChzBGH9+Ji4cvekym
         rjPofxTjg8pXiH9GvFd5qhIPnw6rFk6Ppg4WAuUTC7qDAlqURE6v5QJN1GRwsmXzPSuD
         2eo0i+eUfzv1eQ96J6zBmnO8zqcbIKbowqRuy/0r603EK8WWN1dG1CyX2IjpEbXbw2yL
         mzhdNgM9BORklzWGhSp4Z0aVuxHWnwMpFEMuOEa01vMyBmo3rlEqk10AZUS7U2nyErgw
         1/XodxY7oalMuOoBO/iFKsEkYJgCaZ5VIbpp5dZvRb3ylgQWNN9cUJ+zTJgyA3PTNLfP
         iBQA==
X-Gm-Message-State: AOAM532dx3zLuErFLnLWjTFj0wY0lG/bXS1HNNP8ssm8ltxkalc7CjT9
        whgLeOVLlRgc+D1kMNeGFhzu/goFhPQTvA==
X-Google-Smtp-Source: ABdhPJzjA6IZHrGdgElT85IxkyreQing57xfYyIn80eUve5Mwx37sChBiHmfwMZUDO10CE+Zk/y5RQ==
X-Received: by 2002:a17:90a:4b4d:: with SMTP id o13mr13985237pjl.236.1632669099122;
        Sun, 26 Sep 2021 08:11:39 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id n205sm14851454pfd.38.2021.09.26.08.11.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:11:38 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-edac@vger.kernel.org
Subject: [PATCH V2 27/41] x86/mce: Remove stack protector from mce/core.c
Date:   Sun, 26 Sep 2021 23:08:24 +0800
Message-Id: <20210926150838.197719-28-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

mce/core.c is going to contain __entry_code which can not be instrumented
by stack protector.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/kernel/cpu/mce/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/Makefile b/arch/x86/kernel/cpu/mce/Makefile
index 015856abdbb1..ce192c5344fc 100644
--- a/arch/x86/kernel/cpu/mce/Makefile
+++ b/arch/x86/kernel/cpu/mce/Makefile
@@ -1,4 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
+
+CFLAGS_REMOVE_core.o		= -fstack-protector -fstack-protector-strong
+CFLAGS_core.o			+= -fno-stack-protector
+
 obj-y				=  core.o severity.o genpool.o
 
 obj-$(CONFIG_X86_ANCIENT_MCE)	+= winchip.o p5.o
-- 
2.19.1.6.gb485710b

