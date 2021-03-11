Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D9333779A
	for <lists+linux-edac@lfdr.de>; Thu, 11 Mar 2021 16:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbhCKP2M (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Mar 2021 10:28:12 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34381 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbhCKP17 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 Mar 2021 10:27:59 -0500
Received: from mail-lj1-f198.google.com ([209.85.208.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lKNEE-0005q0-0H
        for linux-edac@vger.kernel.org; Thu, 11 Mar 2021 15:27:58 +0000
Received: by mail-lj1-f198.google.com with SMTP id v9so8680409ljc.9
        for <linux-edac@vger.kernel.org>; Thu, 11 Mar 2021 07:27:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LkS1dLaLUNf0Tu13eWfZQBLP6fiimg7+EWMMMS6XyYM=;
        b=fHQgcqYEDpcrkux9Sx4g8da7GJcYA9fPlNgtfrPMEasy5NtrPzhbzoeE5lIIjn3P2M
         Hvx9NzzUunmDzCcbfBd2CVcUn1DRScPNyPM2FsjeQBVhfXZCo9XLXRczw7StCNVKELWj
         OxEoN3zG0fQ6l7Ht82odARFT9SKzeA3+vrvbGvn592x7U6ZpWFTWylAcwv9UXXOZqK3C
         QS9bS3ABYXvGxxVz62FprM86u7QwUxX8tLRxLRgs8JpsPV1rLZ2JTHttcF1bw63iEKSQ
         rtX2F2UAALIlJEwgGlOYaU+i65YlsBlIlG0KyPV+Pihs5gCFUYQ4JLRjEBDhkPJrx91u
         uv1g==
X-Gm-Message-State: AOAM531cDi7ft9+IVGl+uwHGIyVXVG0vqwG2b5NzrQpFw/JzfXnXxCZR
        sFg+4pXF9KHLIamCXXteSJkY9MamZrvHIP6Zfi8ho9eUXv75s7pK+XNbHpeZaTeVLg4D5q+et6i
        HXtV/S2Sad7iBEIRJguQeldMful2t3cFCXDv9z+E=
X-Received: by 2002:a05:6402:10c9:: with SMTP id p9mr9186808edu.268.1615476466826;
        Thu, 11 Mar 2021 07:27:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwiRng9hU7KaBQ9hI2y61WSuJDlIqArf08ScSxAu55vb9/puMamEp/Rnnmw5+yqMGNTUgkwAA==
X-Received: by 2002:a05:6402:10c9:: with SMTP id p9mr9186761edu.268.1615476466574;
        Thu, 11 Mar 2021 07:27:46 -0800 (PST)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id t15sm1518545edc.34.2021.03.11.07.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 07:27:46 -0800 (PST)
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
Subject: [PATCH v3 15/15] ARM: socfpga: drop ARCH_SOCFPGA
Date:   Thu, 11 Mar 2021 16:27:44 +0100
Message-Id: <20210311152744.1318653-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311152545.1317581-1-krzysztof.kozlowski@canonical.com>
References: <20210311152545.1317581-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Simplify 32-bit and 64-bit Intel SoCFPGA Kconfig options by having only
one for both of them.  After conversion of all
drivers to use the new ARCH_INTEL_SOCFPGA, the remaining ARM option can
be removed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 arch/arm/configs/socfpga_defconfig  | 2 +-
 arch/arm/mach-socfpga/Kconfig       | 8 ++------
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 3823da605430..591b15164e3d 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -79,7 +79,7 @@ CONFIG_ARCH_MSM8960=y
 CONFIG_ARCH_MSM8974=y
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_ARCH_RENESAS=y
-CONFIG_ARCH_SOCFPGA=y
+CONFIG_ARCH_INTEL_SOCFPGA=y
 CONFIG_PLAT_SPEAR=y
 CONFIG_ARCH_SPEAR13XX=y
 CONFIG_MACH_SPEAR1310=y
diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 0c60eb382c80..2d9404ea52c6 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -9,7 +9,7 @@ CONFIG_NAMESPACES=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EMBEDDED=y
 CONFIG_PROFILING=y
-CONFIG_ARCH_SOCFPGA=y
+CONFIG_ARCH_INTEL_SOCFPGA=y
 CONFIG_ARM_THUMBEE=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index e43ed0ca6860..43ddec677c0b 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -1,8 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
-menuconfig ARCH_SOCFPGA
+menuconfig ARCH_INTEL_SOCFPGA
 	bool "Altera SOCFPGA family"
 	depends on ARCH_MULTI_V7
-	select ARCH_INTEL_SOCFPGA
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
 	select ARM_GIC
@@ -20,10 +19,7 @@ menuconfig ARCH_SOCFPGA
 	select PL310_ERRATA_753970 if PL310
 	select PL310_ERRATA_769419
 
-if ARCH_SOCFPGA
-config ARCH_INTEL_SOCFPGA
-	bool
-
+if ARCH_INTEL_SOCFPGA
 config SOCFPGA_SUSPEND
 	bool "Suspend to RAM on SOCFPGA"
 	help
-- 
2.25.1

