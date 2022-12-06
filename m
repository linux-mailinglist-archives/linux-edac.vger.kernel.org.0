Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9E3644B85
	for <lists+linux-edac@lfdr.de>; Tue,  6 Dec 2022 19:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiLFSWU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 6 Dec 2022 13:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiLFSV3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 6 Dec 2022 13:21:29 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7DD40465;
        Tue,  6 Dec 2022 10:20:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 91732CE1AC8;
        Tue,  6 Dec 2022 18:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCA3C4347C;
        Tue,  6 Dec 2022 18:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350818;
        bh=lF/pA8su9j+6/5IZJi6uHIRUwlpskclPP3jlJj4IpDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VG5kXQ5FLLkVE+7geQ6tgyEwtzBxvAnp/eE+E3btI5OoGxGVX5QAC9EXcS6OL/08q
         mPVvbiOUAfuaUPgsVlDDcs92qEz5B4ngBCvRYG7yKabhXz2qC3vF5N8R8AXsn2PsAo
         8JJUfUE6adMjukLhs4YVS99t2ElvCeMeSGUrPTaUkI+mPaOG49emPlUj3pKoZVnDpj
         asjciy8V4vM9xqzTy8fITkXu9NqHgq9MhDu+a93t3TK/8u07DLaxmsIOLVHeZxeWlu
         UF/YOTvzPtUweIjDVHb54ZjnFbQLgUngC2XK2mlBScfnqgaNiSER1FCypo8rn6LGep
         NlqRDi1stGHoA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     mchehab@kernel.org, bp@alien8.de,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     james.morse@arm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rric@kernel.org,
        quic_saipraka@quicinc.com, linux-edac@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/3] Fix crash when using Qcom LLCC/EDAC drivers
Date:   Tue,  6 Dec 2022 12:19:24 -0600
Message-Id: <167035076349.3155086.8546378936650702679.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221129071201.30024-1-manivannan.sadhasivam@linaro.org>
References: <20221129071201.30024-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 29 Nov 2022 12:41:58 +0530, Manivannan Sadhasivam wrote:
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

[1/3] soc: qcom: Select REMAP_MMIO for LLCC driver
      commit: 5d2fe2d7b616b8baa18348ead857b504fc2de336

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
