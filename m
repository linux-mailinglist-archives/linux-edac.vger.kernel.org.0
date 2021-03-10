Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7453333771
	for <lists+linux-edac@lfdr.de>; Wed, 10 Mar 2021 09:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbhCJIgo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 10 Mar 2021 03:36:44 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41097 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbhCJIgM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 10 Mar 2021 03:36:12 -0500
Received: from mail-lj1-f199.google.com ([209.85.208.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lJuKB-0003TX-L1
        for linux-edac@vger.kernel.org; Wed, 10 Mar 2021 08:36:11 +0000
Received: by mail-lj1-f199.google.com with SMTP id q20so6795250lja.20
        for <linux-edac@vger.kernel.org>; Wed, 10 Mar 2021 00:36:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i/6qc/RQ930gzKXWVvSB83Vp2NSZq1QHYNGd1Chw3/w=;
        b=HNRun7zSijJMmo3DxUqbaeU06nuh4yki2jqbMRFi8yuotJEc5vSbGl99DL0D7lD4eK
         6z2fFnq/Uv9IYj/qLE3P3mEhzjzLIXUJ08UFOhrFbxeAVQUrMrWVpEOnPxRRKm7OWBsc
         EAAChSLW3NR1mr5QLQVRDCpgk28jvDvP9VcZbYcd+TOvCtJEfQn0/Ck6FwAsvdMzVPU8
         wPO57XDli8MjClay1gYSmaTN7w57pfh3L7Wr8k9BPFFCIHlZr6bJRbOwuPa425Bu5NN/
         foUA10Zwxey1PrHgzGTXz/t3kVRPoa6x7EF/PlpOQFXhs1Om3Yo5AretZqgaCTCcxep7
         QpnA==
X-Gm-Message-State: AOAM5304+3zI2QUZg/oDJmbiGmDQRLGgV1bNh08eVcfUI/9Xp7f4BqgO
        IIykWtSCou7Dvsa4myCZdzVae7LzLUcI4s8qsP6zoiTwGJlJ2tLmQxfjg3nS9tQof4mjGklsIfB
        tu59IM3XVEpHtXgr99WlosQTasfiojWelRq5QxjE=
X-Received: by 2002:adf:e94a:: with SMTP id m10mr2234010wrn.55.1615365368471;
        Wed, 10 Mar 2021 00:36:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEUpvv8HqbunwmpgW9dLuMjI8TkFCOSyoEzksFOj0CUbMMkau9T5AdEKH6IN5MAnbjxKn6TA==
X-Received: by 2002:adf:e94a:: with SMTP id m10mr2233978wrn.55.1615365368280;
        Wed, 10 Mar 2021 00:36:08 -0800 (PST)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id m17sm28675495wrx.92.2021.03.10.00.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 00:36:08 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-fpga@vger.kernel.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [RFC v2 2/5] clk: socfpga: build together Stratix 10, Agilex and N5X clock drivers
Date:   Wed, 10 Mar 2021 09:33:24 +0100
Message-Id: <20210310083327.480837-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210310083327.480837-1-krzysztof.kozlowski@canonical.com>
References: <20210310083327.480837-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On a multiplatform kernel there is little benefit in splitting each
clock driver per platform because space savings are minimal.  Such split
also complicates the code, especially after adding compile testing.

Build all arm64 Intel SoCFPGA clocks together with one entry in
Makefile.  This also removed duplicated line in the Makefile (selecting
common part of clocks per platform).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/clk/socfpga/Kconfig  | 8 ++++----
 drivers/clk/socfpga/Makefile | 7 +++----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/socfpga/Kconfig b/drivers/clk/socfpga/Kconfig
index cae6fd9fac64..7d4772faf93d 100644
--- a/drivers/clk/socfpga/Kconfig
+++ b/drivers/clk/socfpga/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-config COMMON_CLK_AGILEX
+config COMMON_CLK_SOCFPGA64
 	bool
-	# Intel Agilex / N5X clock controller support
-	default y if ARCH_AGILEX || ARCH_N5X
-	depends on ARCH_AGILEX || ARCH_N5X
+	# Intel Stratix / Agilex / N5X clock controller support
+	default y if ARCH_AGILEX || ARCH_N5X || ARCH_STRATIX10
+	depends on ARCH_AGILEX || ARCH_N5X || ARCH_STRATIX10
diff --git a/drivers/clk/socfpga/Makefile b/drivers/clk/socfpga/Makefile
index e3614f758184..0446240162cf 100644
--- a/drivers/clk/socfpga/Makefile
+++ b/drivers/clk/socfpga/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ARCH_SOCFPGA) += clk.o clk-gate.o clk-pll.o clk-periph.o
 obj-$(CONFIG_ARCH_SOCFPGA) += clk-pll-a10.o clk-periph-a10.o clk-gate-a10.o
-obj-$(CONFIG_ARCH_STRATIX10) += clk-s10.o
-obj-$(CONFIG_ARCH_STRATIX10) += clk-pll-s10.o clk-periph-s10.o clk-gate-s10.o
-obj-$(CONFIG_COMMON_CLK_AGILEX) += clk-agilex.o
-obj-$(CONFIG_COMMON_CLK_AGILEX) += clk-pll-s10.o clk-periph-s10.o clk-gate-s10.o
+obj-$(CONFIG_COMMON_CLK_SOCFPGA64) += clk-s10.o \
+				      clk-pll-s10.o clk-periph-s10.o clk-gate-s10.o \
+				      clk-agilex.o
-- 
2.25.1

