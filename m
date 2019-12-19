Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F455126526
	for <lists+linux-edac@lfdr.de>; Thu, 19 Dec 2019 15:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfLSOsv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Dec 2019 09:48:51 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:26530 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726701AbfLSOsv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 19 Dec 2019 09:48:51 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576766930; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=3zKPnWBvxLfobydpG1oWipP1FXmPrlABqmI/X79v9lQ=;
 b=kZNokw8TgLRfbcAjcvWNWmMqD6wA6D6OzrmItX0SdHT7m/TgqmwdxrkoDnoWQJ9gcO3o0Ydn
 gEM6IV2wrPZJfzZkRMSAgA2oDXDYzwiKi9xaLs258+MMi5RVX1vqiuEwCK3MiklwcoECC1uX
 83tDz8FGXC2GAhunBryUwWt3yzQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyJlNGY0ZCIsICJsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfb8dd0.7fb376be70a0-smtp-out-n03;
 Thu, 19 Dec 2019 14:48:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6DD52C00A44; Thu, 19 Dec 2019 14:48:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E782CC5383A;
        Thu, 19 Dec 2019 14:48:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 19 Dec 2019 20:18:47 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Trilok Soni <tsoni@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: Re: [PATCH 1/2] dt-bindings: edac: Add DT bindings for Kryo EDAC
In-Reply-To: <CAL_JsqL-uBGy5ekHUZAJB4L1QYoCpnOw-4QPpZraXnsZ49wZ6w@mail.gmail.com>
References: <cover.1575529553.git.saiprakash.ranjan@codeaurora.org>
 <0101016ed57a3259-eee09e9e-e99a-40f1-ab1c-63e58a42615c-000000@us-west-2.amazonses.com>
 <20191218233714.GA30302@bogus>
 <7469b239edd4beed3e8fefdf02f10ada@codeaurora.org>
 <CAL_JsqL-uBGy5ekHUZAJB4L1QYoCpnOw-4QPpZraXnsZ49wZ6w@mail.gmail.com>
Message-ID: <86b3a0735df320bc7808930f2bbd0d97@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2019-12-19 19:28, Rob Herring wrote:
>> > Is that your intent?
>> >
>> 
>> No, I want any combination of interrupts to be valid with atleast one
>> interrupt as mandatory.
>> I thought specifying minItems as 1 and maxItems as 4 will take care of
>> this,  am I doing something wrong?
> 
> Interrupts (really all properties) have a defined order in DT and an
> 'items' list defines both the order and index. You'll need to use
> oneOf and list out the possibilities. Stick to ones you actually need.
> 

Thanks, I will make the change in the next spin.

-Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
