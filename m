Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9163B2F07EE
	for <lists+linux-edac@lfdr.de>; Sun, 10 Jan 2021 16:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbhAJPMj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 10 Jan 2021 10:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbhAJPMj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 10 Jan 2021 10:12:39 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FDEC061794
        for <linux-edac@vger.kernel.org>; Sun, 10 Jan 2021 07:11:58 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id i5so10958057pgo.1
        for <linux-edac@vger.kernel.org>; Sun, 10 Jan 2021 07:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=vfmSFVEfFGMuJleaYTTOOLiMug5JiXuwkgC0xfOM9O0=;
        b=yff3LLcVwSeBy+qKsXbsktMnsCx/FoJUsFAYS2axxg0KESehwnqvWK6Z1qNMgysQVl
         /HVomSq4o0tvTsJtz/Un5iweNRM5hBbWVI8l4lCMp73MnP/VMb2ohqlUkx4NYRgCtFxF
         Wg1xZF47vVMICyAY48s+aI8jRpYcBO/BJHQmtKzAbGBurDBLgiv9zRJlW+hOrytBL2lI
         lAEIGQ9pf6va5+yD23MpA/Rv7iAMJthFIF28fqdnE2puLg1fygG/FMEtOowpRapgKtx9
         8g8yWEobr0j0EOD08TFdzTNdAQdT2eUNuxiGhGLkB2Urlo0uzyizoMUoWnAl2mu6paXj
         ugMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=vfmSFVEfFGMuJleaYTTOOLiMug5JiXuwkgC0xfOM9O0=;
        b=o8r7uq2/3+9rPLsIUHy6WI4o5L7rBkWNOQlxTfAZOtd8Bk32ltisRenenJ+xhGf/Od
         2Lb2XlS86zvhHA2e6K6NrA5y3cRdzO2lXY9nLsBVakGG/U0wW0jYfOk0cTKBU8luVmb+
         vKdHlaGnm5G1aJrQr7iZ7Ria806UpqoW/3KIL+xXYpZY5f9SbgUgYvSViaAqxYoGoo2w
         UXxJ3cmjAEczTs+oQEABgP27Swra3v/lU7wbF/6SesAfAVfJGvC9nGeoJqDjLa+YuBuW
         bjn4nAWrjaIpbkw1Hqs7/07VGKgCc+rLxm3k1sM1bNRsKlv5Y2fkJR/lHnOl3E31VW2o
         dt2Q==
X-Gm-Message-State: AOAM530gsrxMZnpa0nhgwrynO7jCu1XrNJ4cr53j3F4C2Ryp+ntYX8S+
        6VjSdy9Jz5Yz4JIT5bA6TlkR
X-Google-Smtp-Source: ABdhPJwqC/3gggFFfzy/GFaEz25QbRLtmOvMPhVCXuzwHWUVEHEA1fsxphv+co7z60UpAmAb9ybhQQ==
X-Received: by 2002:a63:e442:: with SMTP id i2mr15449633pgk.12.1610291518382;
        Sun, 10 Jan 2021 07:11:58 -0800 (PST)
Received: from thinkpad ([2409:4072:6d1d:b3a0:54f0:7e43:912d:37b2])
        by smtp.gmail.com with ESMTPSA id t15sm16046192pfc.12.2021.01.10.07.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 07:11:57 -0800 (PST)
Date:   Sun, 10 Jan 2021 20:41:49 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        baicar@os.amperecomputing.com, saiprakash.ranjan@codeaurora.org,
        bjorn.andersson@linaro.org
Subject: EDAC driver for ARMv8 RAS extension is being worked on
Message-ID: <20210110151149.GA15624@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello,

This is just a headsup that I've been working on the EDAC driver based on the
ARMv8 RAS extensions. AFAIK, there were 3 attempts [1][2][3] on getting this
merged in different forms.

I've collected the feedback on those submissions and came up with the idea of
a single "armv8_ras_edac" driver which will work for both Devicetree and ACPI
systems. The core part of the driver will be platform agnostic, such that it
will get the information for RAS error nodes from either ACPI or DT whichever
available.

As per the suggestion by James, I've taken the "ACPI platform design doc for
ARMv8 RAS Extensions v1.1" [4] as the reference and working on the devicetree
design. Apart from ACPI specific properties such as headers etc,.. most of the
content will be the same in devicetree.

But my submission will be only focused on DT and not ACPI. This is due to my
limitation on getting an ACPI supported RAS platform for development/testing.
If anyone is willing to collaborate on this part, please let me know.

I will submit the RFC series once it available!

Thanks,
Mani

[1] https://lkml.org/lkml/2019/7/2/781
[2] https://patchwork.kernel.org/project/linux-arm-kernel/patch/1515804626-21254-1-git-send-email-kyan@codeaurora.org/
[3] https://lore.kernel.org/linux-arm-kernel/312fc8b8-7019-0c74-6a92-c6740cab5dad@arm.com/T/
[4] https://developer.arm.com/documentation/den0085/0101/
