Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5548263BA64
	for <lists+linux-edac@lfdr.de>; Tue, 29 Nov 2022 08:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiK2HND (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 29 Nov 2022 02:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiK2HNA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 29 Nov 2022 02:13:00 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A86E27CEC
        for <linux-edac@vger.kernel.org>; Mon, 28 Nov 2022 23:12:59 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so1566255pjp.1
        for <linux-edac@vger.kernel.org>; Mon, 28 Nov 2022 23:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwut+5qPNDsd1iiRIVzy1Jj8CkYNxLtclAHL7fg4d/Q=;
        b=tfKjddDHjI1zuql538gz2AIdccGIZenGDzvlieLzvHpEza+Kn0DpG/2/e1etYzQyaD
         EqT5otQR6xAxl0lZx73OD3jJ0sX50DlWF6ABUb8fTXOFbzRPJBVrcss77k0o1ny5EIdh
         vLRKJYUd45CW+Qp7nYujjaN6s3CM2H3DimEAIbzV9VmHas41yYtCdZaZxOwxfIO9tAQ4
         QDzuBTYxnbK6u1razdIjQ/2CuxU340eIGaZTyb9UVue2UzU54OiKPUHMm4/cVpbRJTv4
         MLIpxc7bjzrO6k/E+p90/PZXzuVw0hEf8ajqd9cm/5P03RBymVX7RBd78I3NgXc1Q83z
         N3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwut+5qPNDsd1iiRIVzy1Jj8CkYNxLtclAHL7fg4d/Q=;
        b=rsHYK/xpLedFgJBvxGLlXdOUYYU8dryuhF53GAXxoBslsWZovPtrRydLJYbOjIIXf+
         MSg0c8ME9tou3O0QpUAUeDFLJ+/UOsqqtwomwBZ4Ln75IKtWxqMQy0T9K/4wETvTMgIk
         2xwDCUKEzYr6zarlcRfRJRcC2R1eK5DraXS5YK9WDC9DGChWv6tFZBBKjnagzS2s/LxD
         Xug8s36radSG0qlp0z1QGvprVOxFPeH3ecashZI3LM0sbae6PGJ2lJgNWvcmfpl38Ypw
         Lc7kL/PUJLgeOujMYQRMijEGpAMr1OMj4Jbhi+mpRLUWI3yjWM2f9xfLgOwSng3orivj
         uteg==
X-Gm-Message-State: ANoB5pkgTlx27fy0Esenk++Arw5sLsOnAOnswgBd775TWc+NCAu8uP1J
        11yMFXLHArlBzOfAg4vZ7cDN
X-Google-Smtp-Source: AA0mqf5dIL9XBKXsN/yojSbWwOleGPPnMHQbA0BiXERFWMHKD0IGGfo4geKrt/acpvblKsQ3P4O2Dg==
X-Received: by 2002:a17:902:e849:b0:186:dd96:ce45 with SMTP id t9-20020a170902e84900b00186dd96ce45mr35804981plg.73.1669705978631;
        Mon, 28 Nov 2022 23:12:58 -0800 (PST)
Received: from localhost.localdomain ([117.248.1.95])
        by smtp.gmail.com with ESMTPSA id u6-20020a170903124600b00188fc6766d6sm10009264plh.219.2022.11.28.23.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 23:12:57 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, bp@alien8.de, mchehab@kernel.org
Cc:     james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_saipraka@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH v5 1/3] soc: qcom: Select REMAP_MMIO for LLCC driver
Date:   Tue, 29 Nov 2022 12:41:59 +0530
Message-Id: <20221129071201.30024-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221129071201.30024-1-manivannan.sadhasivam@linaro.org>
References: <20221129071201.30024-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

LLCC driver uses REGMAP_MMIO for accessing the hardware registers. So
select the dependency in Kconfig. Without this, there will be errors
while building the driver with COMPILE_TEST only:

ERROR: modpost: "__devm_regmap_init_mmio_clk" [drivers/soc/qcom/llcc-qcom.ko] undefined!
make[1]: *** [scripts/Makefile.modpost:126: Module.symvers] Error 1
make: *** [Makefile:1944: modpost] Error 2

Cc: <stable@vger.kernel.org> # 4.19
Fixes: a3134fb09e0b ("drivers: soc: Add LLCC driver")
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 024e420f1bb7..a6164b2d7b25 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -63,6 +63,7 @@ config QCOM_GSBI
 config QCOM_LLCC
 	tristate "Qualcomm Technologies, Inc. LLCC driver"
 	depends on ARCH_QCOM || COMPILE_TEST
+	select REGMAP_MMIO
 	help
 	  Qualcomm Technologies, Inc. platform specific
 	  Last Level Cache Controller(LLCC) driver for platforms such as,
-- 
2.25.1

