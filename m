Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7462E3377A5
	for <lists+linux-edac@lfdr.de>; Thu, 11 Mar 2021 16:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbhCKP2L (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Mar 2021 10:28:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34352 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbhCKP1w (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 Mar 2021 10:27:52 -0500
Received: from mail-lj1-f200.google.com ([209.85.208.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lKNE7-0005my-JQ
        for linux-edac@vger.kernel.org; Thu, 11 Mar 2021 15:27:51 +0000
Received: by mail-lj1-f200.google.com with SMTP id v9so8680324ljc.9
        for <linux-edac@vger.kernel.org>; Thu, 11 Mar 2021 07:27:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lXB/iL6vA5+sCIUzf2o2vRh/ni0zGUa9h57FfrwufeA=;
        b=k3hYKUhOtIron00QUYNDTJ89GroyKRgnxZ0u2TYq5ARZLEyAMSmKFy6FDj95DK0hOJ
         fZcRTkCyGVj0sgbpNlhzjwjRPlpIjGn8/pXrn8k+FChVDKi0Y/gAQpKk9P9ZoGyna74z
         hGL89g2ax4aVh8HA5fv4qavS1Se7zc+4bC7o+U8Rfc804gcaRIRrn7Ig9gJB4Kzi++c7
         YKuOyJt8u+LypsnpOocSPdDsHX90d14yaDi3FpSUpjh7X4Iuz3UJ5QfiuOn0kq3KtC/b
         L/Vkli7J8Y/7QB/Ja/nE4Jvx7fYtDIA4IJrhaD2NSLOoITxL44eIdMRDPTFe7YAeR+u8
         3cCQ==
X-Gm-Message-State: AOAM531jpdQ6fZSR4qA5FgYeLIm4pd8iDRioVl5hZM52S3CKqe2PynRW
        v2+j3TH+pLB/1ZoL7t4EtG9o+YtBZJQ7kk9JPuE5sL5LAq2LMsQFPlQlP7XTK+DG8t8UM3cBRuh
        MXSiw0GB8huBfe45CNdb+BDiTuDbxkI87kgh6UX8=
X-Received: by 2002:a17:906:753:: with SMTP id z19mr3596696ejb.447.1615476460419;
        Thu, 11 Mar 2021 07:27:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwn2V3fXBoj0gUy8DLvmPZgdZVpI4oNbBPuRpgJS86sHTABegOHS6FeUR0VFJ6Dqnh8S7uUpw==
X-Received: by 2002:a17:906:753:: with SMTP id z19mr3596661ejb.447.1615476460220;
        Thu, 11 Mar 2021 07:27:40 -0800 (PST)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id g1sm1497413edh.31.2021.03.11.07.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 07:27:39 -0800 (PST)
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
Subject: [PATCH v3 13/15] i2c: altera: use ARCH_INTEL_SOCFPGA also for 32-bit ARM SoCs
Date:   Thu, 11 Mar 2021 16:27:38 +0100
Message-Id: <20210311152738.1318541-1-krzysztof.kozlowski@canonical.com>
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

The side effect is that the I2C_ALTERA will now be available for both
32-bit and 64-bit Intel SoCFPGA, even though it is used only for 32-bit.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 05ebf7546e3f..3eec59f1fed3 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -369,7 +369,7 @@ comment "I2C system bus drivers (mostly embedded / system-on-chip)"
 
 config I2C_ALTERA
 	tristate "Altera Soft IP I2C"
-	depends on ARCH_SOCFPGA || NIOS2 || COMPILE_TEST
+	depends on ARCH_INTEL_SOCFPGA || NIOS2 || COMPILE_TEST
 	depends on OF
 	help
 	  If you say yes to this option, support will be included for the
-- 
2.25.1

