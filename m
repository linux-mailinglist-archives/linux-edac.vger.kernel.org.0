Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88CA337730
	for <lists+linux-edac@lfdr.de>; Thu, 11 Mar 2021 16:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbhCKP02 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Mar 2021 10:26:28 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33882 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbhCKPZ6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 Mar 2021 10:25:58 -0500
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lKNCH-0004q4-2M
        for linux-edac@vger.kernel.org; Thu, 11 Mar 2021 15:25:57 +0000
Received: by mail-ej1-f71.google.com with SMTP id kx22so768613ejc.17
        for <linux-edac@vger.kernel.org>; Thu, 11 Mar 2021 07:25:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iqBtdrPZUrIr273DOWXhTiFtzvKiycYDoohgxVay2ig=;
        b=iTkiDIR6RrPcMC0YA2CsJe12D+A7cE899lkgztxC3cGtqWmYAleKEhXVy9zhcsY/FF
         pn5icY9/mGqs+GuI3JjXU8ldhcYtUffEUuJywifLEmUzNt/WTS+KSH0jAB3v95b1gcMS
         LI2nRN+lrWPQoWU4V3ombwxC0FU3Hp3PNPyp6HuUi01zpVCNOMjnPGIU8yAyhysUfT+M
         cHnXz7T08o2NHDJoeAUxMk4SU6yQ4SW9CiIAc0jah8PU/4l8ywy7KWOjZNfZVIhjqEYX
         4WnCBh2IKmZXw5PWpOFmGStKM6vlIyyP0/IIhAIJWZsMncoIoBOryjLuG31sAK6hw5qy
         dZAw==
X-Gm-Message-State: AOAM530CWhWZtpZvmYZHT3zXXS0mIlCEPceNecv16a7zIAleNoWetAxN
        E4CnNA3QzuBy+AABDfH3dbqnNvoLpP204Vi2Gb15MTfUWggBU9lcKFSM+mFtu7AZirO3AMCxIhN
        TI/ifTnRemXrCr/hum5pf+QluyXAvqu2V8nwzu8Y=
X-Received: by 2002:a17:906:3e92:: with SMTP id a18mr3481201ejj.95.1615476356733;
        Thu, 11 Mar 2021 07:25:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBK+qKCuhZ0F3r9CfvieGjxQ0hczqfyfgEN1oKXCTHk7Irl87ZJGZ5ydURk3A6P7WXhh1OmQ==
X-Received: by 2002:a17:906:3e92:: with SMTP id a18mr3481161ejj.95.1615476356529;
        Thu, 11 Mar 2021 07:25:56 -0800 (PST)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id v25sm1517826edr.18.2021.03.11.07.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 07:25:56 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Lee Jones <lee.jones@linaro.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-i2c@vger.kernel.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v3 05/15] clk: socfpga: build together Stratix 10, Agilex and N5X clock drivers
Date:   Thu, 11 Mar 2021 16:25:35 +0100
Message-Id: <20210311152545.1317581-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311152545.1317581-1-krzysztof.kozlowski@canonical.com>
References: <20210311152545.1317581-1-krzysztof.kozlowski@canonical.com>
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
 drivers/clk/socfpga/Kconfig  | 6 +++---
 drivers/clk/socfpga/Makefile | 7 +++----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/socfpga/Kconfig b/drivers/clk/socfpga/Kconfig
index 3c30617169bf..bc102e0f0be0 100644
--- a/drivers/clk/socfpga/Kconfig
+++ b/drivers/clk/socfpga/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 config CLK_INTEL_SOCFPGA64
 	bool
-	# Intel Agilex / N5X clock controller support
-	default (ARCH_AGILEX || ARCH_N5X)
-	depends on ARCH_AGILEX || ARCH_N5X
+	# Intel Stratix / Agilex / N5X clock controller support
+	default (ARCH_AGILEX || ARCH_N5X || ARCH_STRATIX10)
+	depends on ARCH_AGILEX || ARCH_N5X || ARCH_STRATIX10
diff --git a/drivers/clk/socfpga/Makefile b/drivers/clk/socfpga/Makefile
index c6db8dd4ab35..ebd3538d12de 100644
--- a/drivers/clk/socfpga/Makefile
+++ b/drivers/clk/socfpga/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ARCH_SOCFPGA) += clk.o clk-gate.o clk-pll.o clk-periph.o
 obj-$(CONFIG_ARCH_SOCFPGA) += clk-pll-a10.o clk-periph-a10.o clk-gate-a10.o
-obj-$(CONFIG_ARCH_STRATIX10) += clk-s10.o
-obj-$(CONFIG_ARCH_STRATIX10) += clk-pll-s10.o clk-periph-s10.o clk-gate-s10.o
-obj-$(CONFIG_CLK_INTEL_SOCFPGA64) += clk-agilex.o
-obj-$(CONFIG_CLK_INTEL_SOCFPGA64) += clk-pll-s10.o clk-periph-s10.o clk-gate-s10.o
+obj-$(CONFIG_CLK_INTEL_SOCFPGA64) += clk-s10.o \
+				     clk-pll-s10.o clk-periph-s10.o clk-gate-s10.o \
+				     clk-agilex.o
-- 
2.25.1

