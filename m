Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46F5D148684
	for <lists+linux-edac@lfdr.de>; Fri, 24 Jan 2020 15:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387698AbgAXOE6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 24 Jan 2020 09:04:58 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:13018 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387821AbgAXOE6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 24 Jan 2020 09:04:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579874697; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ajqMb8UmIys1+mfIKmm/Eull7lVgeNOgev7uRgfOCXQ=;
 b=NjWDZDDuiFZ7hJEKfZyIdpdSOdzUcY27pGGjwaQzKnX+TehdHjz6+Kq0+sQAfddXgYaPoGvN
 6KtEQ8V+STDRwyYvkY02TA8Xl87T9O8J0UPjx7jnlmBCxlstV6aMmGl+wpei53b7G4452+Zz
 JhOa0KSEGOAK3Qz6pGiGHTyJqhc=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyJlNGY0ZCIsICJsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2af983.7fb04d188068-smtp-out-n02;
 Fri, 24 Jan 2020 14:04:51 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C96C6C447A3; Fri, 24 Jan 2020 14:04:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0E961C43383;
        Fri, 24 Jan 2020 14:04:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 24 Jan 2020 19:34:51 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     James Morse <james.morse@arm.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org, tsoni@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, psodagud@codeaurora.org,
        linux-arm-kernel@lists.infradead.org, baicar@os.amperecomputing.com
Subject: Re: [PATCH 0/2] Add EDAC support for Kryo CPU core caches
In-Reply-To: <0769b7cb-4e01-eb83-8ad4-b29b4fafafd4@arm.com>
References: <0101016ed57a10a8-bd8fbdb9-a5cd-4460-bae6-c5c35f0eed88-000000@us-west-2.amazonses.com>
 <0769b7cb-4e01-eb83-8ad4-b29b4fafafd4@arm.com>
Message-ID: <4bd9d0f34ff06aa0185616066158349a@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello James,

On 2020-01-16 00:16, James Morse wrote:
> Hi Sai,
> 
> (CC: +Tyler)
> 
> On 05/12/2019 09:52, Sai Prakash Ranjan wrote:
>> This series implements EDAC support for error reporting on
>> Kryo{3,4}XX CPU caches L1,L2, L3-SCU. All the cores(big.LITTLE)
>> in Kryo{3,4}XX CPUs implement RAS extensions and use interrupt
>> based ECC mechanism to report errors.
>> 
>> This series has been tested on SC7180, SDM845, SM8150 SoCs with
>> Kryo{3,4}XX CPU cores based on ARM Cortex-A55, Cortex-A75 and
>> Cortex-A76.
>> 
>> This implementation is platform specific in contrast to the
>> patch posted last time for generic error reporting on arm cortex
>> implementations with RAS extensions by Kyle Yan.
>>  - https://patchwork.kernel.org/patch/10161955/
> 
> I think that series was dropped because it was too soc-specific and
> overlaps with the v8.2
> kernel first support. That series was superseded by:
> lore.kernel.org/r/1562086280-5351-1-git-send-email-baicar@os.amperecomputing.com
> 
> Can you work with Tyler on a combined series? The combined support may
> need to look quite
> different. (DT and big/little being the obvious differences).
> 
> I'm afraid this is the tip of the kernel-first-RAS iceberg.
> 

Sorry for the delayed response. Sure, I will take a look at the series 
posted by Tyler.
It might take some time to come up with that but should be doable with 
your review :)

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
