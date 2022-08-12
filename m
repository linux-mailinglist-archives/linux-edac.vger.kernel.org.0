Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC42590BC3
	for <lists+linux-edac@lfdr.de>; Fri, 12 Aug 2022 08:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbiHLGGY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 12 Aug 2022 02:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbiHLGGX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 12 Aug 2022 02:06:23 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E2961D48
        for <linux-edac@vger.kernel.org>; Thu, 11 Aug 2022 23:06:21 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gj1so141338pjb.0
        for <linux-edac@vger.kernel.org>; Thu, 11 Aug 2022 23:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=CcWM54NC4cl7AlznbSLkB1kM/j9fV93ZW750WKkazeE=;
        b=gz+I8WhRONQJki5/VFx4USGMCSR5kSLOXdmElkDPF5EQvizMr0C4bqcvJzc4+8qGOx
         j6mjuSUhRdTpX0hYcFnEyq5LBRbuOCTVkgqSEwV877eTB+4dXV1+Z004s6uBf/feb/2x
         WGEFr4Qq4T+eqrmP2KO0T8G2Fr3J6fcewJWdFPEg+HfBiFhEZjT5qTL+JedKCs7g9xu6
         iZ5E7m2et3hOMbCyWRUQE/kjmdubcAIReKWT/9zaNGIfmx9Xiipz1EoFzrXFOyZ6xvBl
         8pHQfzbqN+gumEzSYCQtEJVHOeAfAISS2Z18u/uEkW+HGWHNjy+czHs8MZYET9YCnxpI
         TYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=CcWM54NC4cl7AlznbSLkB1kM/j9fV93ZW750WKkazeE=;
        b=VtDYG4Of5ium3OJ8WoKmz/kUL/w41KtmSOK7PPd/k2VY7UxKh2+ttYn/b901pu7XoW
         e5Jj0v5lw7ZpHfXchWoZvmnkixUJ1I4ePUdiT4gSfXq7vcAaskpOzXBXip813eEYVLdp
         LYNGVOgbPV2unDUHAsC0N40uCV9yVOz35BX0ZFndqHZCntxeeSqMvP+4FebiMraryQVD
         Uigothlc4VbMjb/EJ6SDcmCaf37DTa6O/yOCdhHukYTYGCYwIlHbe31VmnB1WmAtwfgP
         fTx+c2phOx2Q8ldnRro+/XBoCt22TffCobiifZnaY30srtsPlbWoNrfhCh+HwIoGaI7M
         0uIw==
X-Gm-Message-State: ACgBeo1S3aBKHe3fUWXNhaJE8QJ7hyyWxrD9XyZEsrA3bVbuZ4filycE
        nbK7ZyLoFXL2XzoynqAu5AZk
X-Google-Smtp-Source: AA6agR7djnIXswjqpcAUI3pmfD/jJMhqJxaoq8ta7AuLkJl5Hbj/RJREwAoS0k+8am8UEBR3rtQFcw==
X-Received: by 2002:a17:903:1205:b0:171:4f8d:22a8 with SMTP id l5-20020a170903120500b001714f8d22a8mr2566362plh.11.1660284380481;
        Thu, 11 Aug 2022 23:06:20 -0700 (PDT)
Received: from localhost.localdomain ([59.92.103.103])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b0016c4147e48asm732395pln.219.2022.08.11.23.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 23:06:20 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org, bp@alien8.de, mchehab@kernel.org
Cc:     james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/3] Fix crash when using Qcom LLCC/EDAC drivers
Date:   Fri, 12 Aug 2022 11:35:59 +0530
Message-Id: <20220812060602.7672-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello,

This series fixes the crash seen on the Qualcomm SM8450 chipset with the
LLCC/EDAC drivers. The problem was due to the Qcom EDAC driver using the
fixed LLCC register offsets for detecting the LLCC errors.

This seems to have worked for SoCs till SM8450. But in SM8450, the LLCC
register offsets were changed. So accessing the fixed offsets causes the
crash on this platform.

So for fixing this issue, and also to make it work on future SoCs, let's
pass the LLCC offsets from the Qcom LLCC driver based on the individual
SoCs and let the EDAC driver make use of them.

This series has been tested on SM8450 based dev board.

Thanks,
Mani

Changes in v2:

* Volunteered myself as a maintainer for the EDAC driver since the current
  maintainers have left Qualcomm and I couldn't get hold of them.

Manivannan Sadhasivam (3):
  soc: qcom: llcc: Pass SoC specific EDAC register offsets to EDAC
    driver
  EDAC/qcom: Get rid of hardcoded register offsets
  MAINTAINERS: Add myself as the maintainer for qcom_edac driver

 MAINTAINERS                        |   3 +-
 drivers/edac/qcom_edac.c           | 112 ++++++++++++++---------------
 drivers/soc/qcom/llcc-qcom.c       |  64 +++++++++++++++++
 include/linux/soc/qcom/llcc-qcom.h |  35 +++++++--
 4 files changed, 148 insertions(+), 66 deletions(-)

-- 
2.25.1

