Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7B2337791
	for <lists+linux-edac@lfdr.de>; Thu, 11 Mar 2021 16:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbhCKP2I (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Mar 2021 10:28:08 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34220 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbhCKP1f (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 Mar 2021 10:27:35 -0500
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lKNDp-0005aV-P8
        for linux-edac@vger.kernel.org; Thu, 11 Mar 2021 15:27:33 +0000
Received: by mail-ed1-f70.google.com with SMTP id w16so10055637edc.22
        for <linux-edac@vger.kernel.org>; Thu, 11 Mar 2021 07:27:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UjkBHzEIXy3Qt0KfyB8W+UTqTimKf+/Z4F2P3MBYO1k=;
        b=T0G8qJ1Onlg+1j5zMIkYaGn1MZptypM0rmpQK/5OqLgRtnLvIXSME1rYpAZt+fcxzk
         hw2MsXPltJA+00pGEhJHiWjHauRfV6YapVecfvW+yUvPUjcJglRvRB+D9lHNmmxto6/v
         Ib/oO2KbpHkedEOEQASEpKh7jaHiOQHl77V6lselmP8Bdotym1gJ/NOOjHuvyz5QdFrE
         Mu2Zb3lyiCcUhjX9kd8b5AlhaQVVfvt7+MzqrC3MIU540nkcOf5bAM8o2TxkukLHMQB9
         rrZOiD9PYY3Nm0tnZaKXaEzcVct0pCi1ww7ifZLSMpWspC5uhMkbsGvDWXnqOcMu6RQj
         O16Q==
X-Gm-Message-State: AOAM531VdRCbmDekvgvUk+nsj38ZI66TgeESeYcsfhSb/boaPbB4RPMm
        S1vbRENEkaJcpQ9SJ1hrle0aaGa2cKeU/xaph+8VH/G8Ky3MsVRybwfvJofngRtcAxXtuUbErLU
        WFFYuaWlkNOTin/zwdwVLzXDgYNElD6maKGDheRc=
X-Received: by 2002:a05:6402:149:: with SMTP id s9mr9105104edu.247.1615476453452;
        Thu, 11 Mar 2021 07:27:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9JEFJOCs9xlVCDjG2l3JIb1sIqxzKP3KekIDHOJltUt18JZjWfClKITi/qC3i9sP0ViNxqQ==
X-Received: by 2002:a05:6402:149:: with SMTP id s9mr9105059edu.247.1615476453282;
        Thu, 11 Mar 2021 07:27:33 -0800 (PST)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id t15sm1552389edw.84.2021.03.11.07.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 07:27:32 -0800 (PST)
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
Subject: [PATCH v3 11/15] dmaengine: socfpga: use ARCH_INTEL_SOCFPGA also for 32-bit ARM SoCs
Date:   Thu, 11 Mar 2021 16:27:31 +0100
Message-Id: <20210311152731.1318428-1-krzysztof.kozlowski@canonical.com>
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
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 0c2827fd8c19..a0836ffc22e0 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -100,7 +100,7 @@ config AT_XDMAC
 
 config AXI_DMAC
 	tristate "Analog Devices AXI-DMAC DMA support"
-	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_SOCFPGA || COMPILE_TEST
+	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	select REGMAP_MMIO
-- 
2.25.1

