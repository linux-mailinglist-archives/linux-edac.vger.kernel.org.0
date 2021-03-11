Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2850F3377A4
	for <lists+linux-edac@lfdr.de>; Thu, 11 Mar 2021 16:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbhCKP2K (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Mar 2021 10:28:10 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34336 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbhCKP1u (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 Mar 2021 10:27:50 -0500
Received: from mail-lj1-f199.google.com ([209.85.208.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lKNE5-0005lY-F0
        for linux-edac@vger.kernel.org; Thu, 11 Mar 2021 15:27:49 +0000
Received: by mail-lj1-f199.google.com with SMTP id x11so8667256ljm.5
        for <linux-edac@vger.kernel.org>; Thu, 11 Mar 2021 07:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xL1edBPIXb5EtPx7dtqi4BTArR+ixt/89Ez9ALjb7AY=;
        b=n17RUgVaEqBiIhxFcP+u7VJ1UxpIbWIc0GW+18AJbBsgeIVaLgemsyFgKfMw13pBJ4
         Xh8w4KLzKIkIDryKF7mjL3gXg7yXMJwEpnl8cY9NJbDiH+hce9Bg1xdQltbPCNj4wnOH
         MkY3nqoaPnfoKK/ZtJoLq6YkP1zbNOdaGDF4eIvViN5Rn02ZjjRiwyw7qGsrM1oU7lhD
         zYjeZenxb5y3QBdRgzez4agQ70pfy++julKESL7jLFEwurcX1B5yFSmeDq3U+TXFxVea
         4uJ7rjtHZLAylCf2Bdot8yYH6KLWvdWXWb75AeaDYM6G+MmPjP1j0bdHmzOzmjWT2A67
         1w+Q==
X-Gm-Message-State: AOAM533tsTFyDw0EpzjeCQ3iY5gdapGDze5w/9If6UV7GTUFnmYZtHD9
        vfBN5drE2BFTB+qASKT9ChBHVemXR4BWE28o3VIFVCwvWRhTq3z71EoaU5h9CCcjxiO7RmaIk23
        RrUynyraay0U17DyQP0P5kaPWM5oAMv9oSJqLLH8=
X-Received: by 2002:a05:6402:10c8:: with SMTP id p8mr8958388edu.144.1615476457313;
        Thu, 11 Mar 2021 07:27:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwym688lccoWS0vQKon5fsVW74N9HWG5xLsZvi1pg+uqrC83DObGrD7/MK6ibsjBN6gGqRDFQ==
X-Received: by 2002:a05:6402:10c8:: with SMTP id p8mr8958352edu.144.1615476457175;
        Thu, 11 Mar 2021 07:27:37 -0800 (PST)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id eo22sm1528960ejc.0.2021.03.11.07.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 07:27:36 -0800 (PST)
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
Subject: [PATCH v3 12/15] fpga: altera: use ARCH_INTEL_SOCFPGA also for 32-bit ARM SoCs
Date:   Thu, 11 Mar 2021 16:27:35 +0100
Message-Id: <20210311152735.1318487-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311152545.1317581-1-krzysztof.kozlowski@canonical.com>
References: <20210311152545.1317581-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

ARCH_SOCFPGA is being renamed to ARCH_INTEL_SOCFPGA so adjust the
32-bit ARM drivers to rely on new symbol.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/fpga/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index fd325e9c5ce6..b1026c6fb119 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -14,13 +14,13 @@ if FPGA
 
 config FPGA_MGR_SOCFPGA
 	tristate "Altera SOCFPGA FPGA Manager"
-	depends on ARCH_SOCFPGA || COMPILE_TEST
+	depends on ARCH_INTEL_SOCFPGA || COMPILE_TEST
 	help
 	  FPGA manager driver support for Altera SOCFPGA.
 
 config FPGA_MGR_SOCFPGA_A10
 	tristate "Altera SoCFPGA Arria10"
-	depends on ARCH_SOCFPGA || COMPILE_TEST
+	depends on ARCH_INTEL_SOCFPGA || COMPILE_TEST
 	select REGMAP_MMIO
 	help
 	  FPGA manager driver support for Altera Arria10 SoCFPGA.
@@ -99,7 +99,7 @@ config FPGA_BRIDGE
 
 config SOCFPGA_FPGA_BRIDGE
 	tristate "Altera SoCFPGA FPGA Bridges"
-	depends on ARCH_SOCFPGA && FPGA_BRIDGE
+	depends on ARCH_INTEL_SOCFPGA && FPGA_BRIDGE
 	help
 	  Say Y to enable drivers for FPGA bridges for Altera SOCFPGA
 	  devices.
-- 
2.25.1

