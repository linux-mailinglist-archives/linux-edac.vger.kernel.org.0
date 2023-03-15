Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB18B6BC19B
	for <lists+linux-edac@lfdr.de>; Thu, 16 Mar 2023 00:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjCOXlO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Mar 2023 19:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjCOXk7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 15 Mar 2023 19:40:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB1AABB3F;
        Wed, 15 Mar 2023 16:39:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E6C261EB8;
        Wed, 15 Mar 2023 23:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85201C433A0;
        Wed, 15 Mar 2023 23:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923165;
        bh=gh5+yKKUVl7HJNN8MzKaMlXSjm8j5pMe8Xhwow1tReQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pvR/pMfte1UYzZfyXnhK9+WFTHeBttKgr6z04WElrp4CCF30eYXCNALeZzheN4ECl
         zPjwFGOVZNVJpWtOZPWactmeG4MW+tv7psf+8fx525jbketkoC+n5FXw7AiecdzZkX
         GiboNZ87TMDoMVOUXWDDuEnChsIK7vrFwCVCYxAYaySXMv8jH4HWPcTuXL6JPPk6jW
         LFhInFmQ2tvsFPVkMJFEpmro2kRsBBa4oENxJtCUFlWHi/CrK3m3m9IsNU8Hx6AIZ8
         YSEkFCadQoVsL49KryBuy0/1wg87QUtfm/NuAP9ZnSBD9GeHThT8MQobeLTvoqo4Ej
         dZOkVCIXBEGBg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        bp@alien8.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tony.luck@intel.com
Cc:     ahalaney@redhat.com, linux-arm-msm@vger.kernel.org,
        rric@kernel.org, konrad.dybcio@linaro.org,
        luca.weiss@fairphone.com, mchehab@kernel.org, james.morse@arm.com,
        steev@kali.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com
Subject: Re: (subset) [PATCH v8 00/14] Qcom: LLCC/EDAC: Fix base address used for LLCC banks
Date:   Wed, 15 Mar 2023 16:35:17 -0700
Message-Id: <167892332567.4030021.13563397357786290320.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314080443.64635-1-manivannan.sadhasivam@linaro.org>
References: <20230314080443.64635-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 14 Mar 2023 13:34:29 +0530, Manivannan Sadhasivam wrote:
> The Qualcomm LLCC/EDAC drivers were using a fixed register stride for
> accessing the (Control and Status Regsiters) CSRs of each LLCC bank.
> This offset only works for some SoCs like SDM845 for which driver support
> was initially added.
> 
> But the later SoCs use different register stride that vary between the
> banks with holes in-between. So it is not possible to use a single register
> stride for accessing the CSRs of each bank. By doing so could result in a
> crash with the current drivers. So far this crash is not reported since
> EDAC_QCOM driver is not enabled in ARM64 defconfig and no one tested the
> driver extensively by triggering the EDAC IRQ (that's where each bank
> CSRs are accessed).
> 
> [...]

Applied, thanks!

[03/14] arm64: dts: qcom: sdm845: Fix the base addresses of LLCC banks
        commit: bfe088bde391824040c39cbf277d7fe782042936
[04/14] arm64: dts: qcom: sc7180: Fix the base addresses of LLCC banks
        commit: 116a932bbc7bc740b068fbfe320a465811ca62f8
[05/14] arm64: dts: qcom: sc7280: Fix the base addresses of LLCC banks
        commit: 62e5ee9db98ed67eb50205072135544055cba9c4
[06/14] arm64: dts: qcom: sc8280xp: Fix the base addresses of LLCC banks
        commit: 0fe0955a79b994b8dcabe79f3a7192251fb256ea
[07/14] arm64: dts: qcom: sm8150: Fix the base addresses of LLCC banks
        commit: c5ccf8d33f11f57ef46d12db1dda4afcc4d5150b
[08/14] arm64: dts: qcom: sm8250: Fix the base addresses of LLCC banks
        commit: 42c9b1578233eeb3044656a446486bd2efc87312
[09/14] arm64: dts: qcom: sm8350: Fix the base addresses of LLCC banks
        commit: 7ae317cba6be783cfd6155bceec91d0918f78fb8
[10/14] arm64: dts: qcom: sm8450: Fix the base addresses of LLCC banks
        commit: 413c8ecd48f1df8034c7b13881ded33b3d10171f
[11/14] arm64: dts: qcom: sm6350: Fix the base addresses of LLCC banks
        commit: 65d9975e5dae4601e8902765d08f55c246fd2022

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
