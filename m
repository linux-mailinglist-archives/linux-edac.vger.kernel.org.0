Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546B65A598B
	for <lists+linux-edac@lfdr.de>; Tue, 30 Aug 2022 04:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiH3CvA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 29 Aug 2022 22:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiH3CvA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 29 Aug 2022 22:51:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D027F79A51;
        Mon, 29 Aug 2022 19:50:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5F7A614B0;
        Tue, 30 Aug 2022 02:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDE8C433D7;
        Tue, 30 Aug 2022 02:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661827857;
        bh=PPqjBhvn46Hkm76cYyLvjuRU14QzJZ5o5PYhgRQmu1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F4fiX5cH0HKMupdUcwGYj8IfGolTp3gbzVneLrLDKDajTNDpD2yrwjxgChcgDrtiS
         rB17TmVEsZpBoGw63XVfgczZ6LaX9Tkgepwv/FV4DsUU2poRFMRZP9W0qrZKJRS/ZB
         pNrS2HMq8W97++2jFKfTEJdxQX7hDcGMLy+ueG43mocLwehBODGivTkIRSNF1MW5+s
         Pmm04uSya5yWtotdx+qWyBQecfneDPutGTkYvK7awYZ9PCHmfCgA0VLvW0Ee7c7yPQ
         v1B8XRsXOBfhJQSY2dAElsMjEG1R2fY1TpEgJlI2XNR8sD/NMWudWgkgnGf8HJnQTP
         4w0JxItdPq+NQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>, mchehab@kernel.org,
        Bjorn Andersson <andersson@kernel.org>, bp@alien8.de
Cc:     linux-edac@vger.kernel.org, rric@kernel.org,
        quic_tsoni@quicinc.com, linux-arm-msm@vger.kernel.org,
        james.morse@arm.com, quic_saipraka@quicinc.com,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/5] Fix crash when using Qcom LLCC/EDAC drivers
Date:   Mon, 29 Aug 2022 21:50:55 -0500
Message-Id: <166182784427.333703.15037180707046189221.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220825043859.30066-1-manivannan.sadhasivam@linaro.org>
References: <20220825043859.30066-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, 25 Aug 2022 10:08:54 +0530, Manivannan Sadhasivam wrote:
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

[1/5] soc: qcom: llcc: Rename reg_offset structs to reflect LLCC version
      commit: 5365cea199c70d6abedc2e1be850c03e990f1829
[2/5] soc: qcom: llcc: Pass LLCC version based register offsets to EDAC driver
      commit: c13d7d261e361dbaf5adbdc216ee4a1204c48001

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
