Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A4862C0F6
	for <lists+linux-edac@lfdr.de>; Wed, 16 Nov 2022 15:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiKPOeH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Nov 2022 09:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbiKPOeE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 16 Nov 2022 09:34:04 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C851159
        for <linux-edac@vger.kernel.org>; Wed, 16 Nov 2022 06:34:02 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso2549073pjc.2
        for <linux-edac@vger.kernel.org>; Wed, 16 Nov 2022 06:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+/SHZcrxN5eQeobSyOJvg3Ur+b277t0vco7kXHtgdjI=;
        b=rlSBeNwhXWAL/1If07zkKwLTQAz2Zzm0OsE/tksZey5KqQuR4+mGvciN7sgZlqa4cy
         al3Wcfb9LILwBKj5XamR3dC/9Y2QHnAvECOwyK6tz8dNSIyplIBsLd8SJXCEsoEDgsWA
         zrnIqDD/XunC5SHCKyKGn19DlwR6YqrEUJ9jZJNx/0kzr3GQ3Qp66cD66loAbzRixrXC
         rHvMHC8k31n637V+HNyFwLDLoH8OhUvdlGQj5wOgsrWDOnPHID0JibaMLFH3ZDTSTYQl
         rez7A6Hs8F00yoXDm1GNuPIIMlC3lgyHRY9eUHDzpN10TOdkPpJ5HNWOeox1yHnNwaqx
         NLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/SHZcrxN5eQeobSyOJvg3Ur+b277t0vco7kXHtgdjI=;
        b=jXZZo3mPEf26GUiIHmqgotL3S13VLbfaom/CY03Zvhy/b0SgBvpps21umbEcn17jMv
         Pgj6vo5Ztt42ylxYxbblietvn5OrQpOE9ZaRtgHkx1V3O7BWMrCuLKfAiKmtLP7xerXY
         NhbylKWpfiih/ch/Yno/3SpqjBcCIc+In3B+47CS/9ZusuOVEfl9S7wCgESD9Gs60sqH
         SZWZ867SX6w3of870gYUipTZq4Lpmb5ad1J+IanCJ8QduiHkHP7NlwvMA2/kSfeHqqOn
         peSDVklneihtjBwQPQgdW8HdCrpMeME3q047g0nI68RYO+qGy+BUwBQYEna0aXdWxNeS
         G5Pw==
X-Gm-Message-State: ANoB5pk02by3np/4/FpOGT+cEI4bb/iPFsXFDCT5hb0Sduvq8MUsfJFj
        WDsJ1YOXS8s+R8gNyKTc1ZK9
X-Google-Smtp-Source: AA0mqf4Sihej52LGqgAbJCIBVvCjfpw7x4oR05cKcDlEDXxTX3MzZprcWoUQ3FfYrf3okdBqT38XeQ==
X-Received: by 2002:a17:90b:1217:b0:213:36b7:1b77 with SMTP id gl23-20020a17090b121700b0021336b71b77mr4031415pjb.94.1668609241810;
        Wed, 16 Nov 2022 06:34:01 -0800 (PST)
Received: from localhost.localdomain ([59.92.100.153])
        by smtp.gmail.com with ESMTPSA id e8-20020a63e008000000b0043c732e1536sm9560974pgh.45.2022.11.16.06.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:34:00 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org, bp@alien8.de, mchehab@kernel.org
Cc:     james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_saipraka@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 0/2] Fix crash when using Qcom LLCC/EDAC drivers
Date:   Wed, 16 Nov 2022 20:03:50 +0530
Message-Id: <20221116143352.289303-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
  EDAC/qcom: Get rid of hardcoded register offsets
  EDAC/qcom: Remove extra error no assignment in qcom_llcc_core_setup()

 drivers/edac/qcom_edac.c           | 119 ++++++++++++++---------------
 include/linux/soc/qcom/llcc-qcom.h |   6 --
 2 files changed, 59 insertions(+), 66 deletions(-)

-- 
2.25.1

