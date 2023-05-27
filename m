Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6E5713249
	for <lists+linux-edac@lfdr.de>; Sat, 27 May 2023 05:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjE0D5C (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 26 May 2023 23:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjE0D47 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 26 May 2023 23:56:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6C2125;
        Fri, 26 May 2023 20:56:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3145364D9F;
        Sat, 27 May 2023 03:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EA1C433A1;
        Sat, 27 May 2023 03:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685159814;
        bh=tWN64kIF0t+cA+oVEY5wveVh5FHe12E2Y8s9FFl8jdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XZv4H5uQs+n/Y0utWjXQHpZ96O0CFFgch7BEwWO5RE36bSXdn/fdKzeeWJObAR6OV
         o+0nHaAmBiObru5rfNG/HN18qFvi0kuPjECQTTa5masleSq+Gvxj7wGG5KCep6QUtG
         VZHyt9kveBf6od2uP5G6vpfTWY9eqax8SgzjrYq+ynGM/boWGkWzlRT9VEdP/wI7Vd
         hqjJYYGzUjib2Zx+3Z4S6eQz1LD+unnuosh7YMnghZRPAb1DMGjafOaRRVSBTru4Eb
         XmS/8gwN8gxAt+irBPqEmEPrrdd+4lRaRdt/2a8dhPVP1JVe13NLJXWdg0fk+AKHrK
         K9RspCrR1ws3A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     bp@alien8.de, mchehab@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     dmitry.baryshkov@linaro.org, james.morse@arm.com, rric@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v8 0/2] Fix crash when using Qcom LLCC/EDAC drivers
Date:   Fri, 26 May 2023 21:00:36 -0700
Message-Id: <168516003598.405989.12832976179577504012.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230517114635.76358-1-manivannan.sadhasivam@linaro.org>
References: <20230517114635.76358-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, 17 May 2023 17:16:33 +0530, Manivannan Sadhasivam wrote:
> This series fixes the crash seen on the Qualcomm SM8450 chipset with the
> LLCC/EDAC drivers. The problem was due to the Qcom EDAC driver using the
> fixed LLCC register offsets for detecting the LLCC errors.
> 
> This seems to have worked for SoCs till SM8450. But in SM8450, the LLCC
> register offsets were changed. So accessing the fixed offsets causes the
> crash on this platform.
> 
> [...]

Applied, thanks!

[1/2] EDAC/qcom: Remove superfluous return variable assignment in qcom_llcc_core_setup()
      commit: 3d49f7406b5d9822c1411c6658bac2ae55ba19a2
[2/2] EDAC/qcom: Get rid of hardcoded register offsets
      commit: cbd77119b6355872cd308a60e99f9ca678435d15

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
