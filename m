Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BFC70600C
	for <lists+linux-edac@lfdr.de>; Wed, 17 May 2023 08:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjEQG3R (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 May 2023 02:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjEQG3Q (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 17 May 2023 02:29:16 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0683586
        for <linux-edac@vger.kernel.org>; Tue, 16 May 2023 23:29:14 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-510b56724caso6426230a12.1
        for <linux-edac@vger.kernel.org>; Tue, 16 May 2023 23:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684304953; x=1686896953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6xI3hUbCW+FwBwOTtLOPQqL67ArdQOyuoW/lXxNMjQ4=;
        b=QhBxL6hMCl1Ud6Amha9FLCu88o5zRWYcXHY07Og7YJJmKKLxqIf51jgzoy7GlXYQFV
         f3mESbwL3yivp3PgaQAahI6wqjZJDBNf3SPjeyE9v/i/+ORg1dSIFhdy2lZC7hMrMwJO
         sIXNvses9J2PlqQEtzGGDoijnrBZM+SQrLLjAfZ5eQ2A3unoXihRNuRbM5gf3L5cli2e
         9i/t8F5usYel9g/57AGQghkuu1yhRQ08EfeCAyzIAk4bFsYkP6xea2Dzl1IbYib5obwt
         V9J4Yt+R2ntKqXviGWxYPa6AFkxbtVlaFoFpMhVOZSilbhN4RsCnpUY79+h8/+MJjqAn
         oD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684304953; x=1686896953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6xI3hUbCW+FwBwOTtLOPQqL67ArdQOyuoW/lXxNMjQ4=;
        b=ZMYNm93jCpLlWKGybTofQ3wPOA4oDWe1EX7MGnha7VK0UQL4ha02mZkuDLN6cg8Zk9
         gxWrhciWBW4vq2YV6zYdIlmTyXUOx3u/rX4ayB6w1F87noRvvOsf+yRUuEAx7KDA/bLy
         F9zhRPsO4MOE+FV2m/YG8aKdxBFNKmXxrNyBLibk7eq+2Ly2csOhCxHhY9LmlnovMqG6
         hQ5y0A7I7Qw1Ww0KCVYHFaQ63/9e4yCafSe8ejiv6qHornGOD/X7ToJ32oULtJvNw55V
         7Wca3iVfyKfoDXgXY0NKFS7hvLg2JIxDPXrPlbHrWYzVv6fDqvKMqw807wTuqhLzcLzi
         eRtA==
X-Gm-Message-State: AC+VfDxX+zjTs0RaW2pNIQbPVQztuidywsv/+HlilRfjFCY1nR+Mzph1
        ecu5of/SsFVcpjeLRfmbxTEK
X-Google-Smtp-Source: ACHHUZ42czu2IBgJGeY9QoEvbOwAYlFWVCvDL8R1Dq4JP2iduNUihBHafbmWDfP3n8G4Ls7VKC8RsA==
X-Received: by 2002:a17:907:2d27:b0:969:ed36:12ab with SMTP id gs39-20020a1709072d2700b00969ed3612abmr1091538ejc.23.1684304952764;
        Tue, 16 May 2023 23:29:12 -0700 (PDT)
Received: from localhost.localdomain ([59.92.102.59])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906648900b0094f3d700868sm11859273ejm.80.2023.05.16.23.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 23:29:12 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, bp@alien8.de, mchehab@kernel.org
Cc:     james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH v7 0/2] Fix crash when using Qcom LLCC/EDAC drivers
Date:   Wed, 17 May 2023 11:58:57 +0530
Message-Id: <20230517062859.57371-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

[1] https://lore.kernel.org/linux-arm-msm/20230314053725.13623-1-manivannan.sadhasivam@linaro.org/

Changes in v7:

* Rebased on top of v6.4-rc1

Changes in v6:

* Rebased on top of v6.3-rc1
* Dropped the Kconfig patch that got applied

Changes in v5:

* Added fixes tag and CCed stable mentioning the dependency
* Added a patch to fix the build error with COMPILE_TEST

Changes in v4:

* Dropped the patches that were already applied
* Rebased on top of v6.1-rc5

Changes in v3:

* Instead of using SoC specific register offset naming convention, used
  LLCC version based as suggested by Sai
* Fixed the existing reg_offset naming convention to clearly represent
  the LLCC version from which the offsets were changed
* Added Sai's Acked-by to MAINTAINERS patch
* Added a new patch that removes an extra error no assignment

Changes in v2:

* Volunteered myself as a maintainer for the EDAC driver since the current
  maintainers have left Qualcomm and I couldn't get hold of them.

Manivannan Sadhasivam (2):
  EDAC/qcom: Remove extra error no assignment in qcom_llcc_core_setup()
  EDAC/qcom: Get rid of hardcoded register offsets

 drivers/edac/qcom_edac.c           | 119 ++++++++++++++---------------
 include/linux/soc/qcom/llcc-qcom.h |   6 --
 2 files changed, 59 insertions(+), 66 deletions(-)

-- 
2.25.1

