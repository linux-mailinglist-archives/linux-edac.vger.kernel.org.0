Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFDA2125B90
	for <lists+linux-edac@lfdr.de>; Thu, 19 Dec 2019 07:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfLSGuf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Dec 2019 01:50:35 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:53780 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726294AbfLSGuf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 19 Dec 2019 01:50:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576738234; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=xFqqnNZlkXdgS0NnusZ7Jx8AbXtVSYn7KtW5NLzf9ok=;
 b=VOaoF1y8tJiPZ1NUn17jSW5Iy0Le72hPfiuEp+cfmWq/xghoH5ExsQDVpcTUlwJTht5cXJkQ
 41DGQICg94U7PJ01BI4R613mGXAuzSOiygWt2JJWimdFNxD7Py7UyNqHb81Cv8WTIpRNu71o
 WpZTtUZTSkvhLBiAVHnPNoeKMqc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyJlNGY0ZCIsICJsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfb1db6.7fdae2af9df8-smtp-out-n02;
 Thu, 19 Dec 2019 06:50:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 07410C494B5; Thu, 19 Dec 2019 06:50:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 10D61C48B03;
        Thu, 19 Dec 2019 06:50:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 19 Dec 2019 12:20:27 +0530
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
        linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, tsoni@codeaurora.org,
        psodagud@codeaurora.org
Subject: Re: [PATCH 1/2] dt-bindings: edac: Add DT bindings for Kryo EDAC
In-Reply-To: <20191218233714.GA30302@bogus>
References: <cover.1575529553.git.saiprakash.ranjan@codeaurora.org>
 <0101016ed57a3259-eee09e9e-e99a-40f1-ab1c-63e58a42615c-000000@us-west-2.amazonses.com>
 <20191218233714.GA30302@bogus>
Message-ID: <7469b239edd4beed3e8fefdf02f10ada@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Rob,

On 2019-12-19 05:07, Rob Herring wrote:
> On Thu, Dec 05, 2019 at 09:53:05AM +0000, Sai Prakash Ranjan wrote:
>> This adds DT bindings for Kryo EDAC implemented with RAS
>> extensions on KRYO{3,4}XX CPU cores for reporting of cache
>> errors.
>> 
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> ---
>>  .../bindings/edac/qcom-kryo-edac.yaml         | 67 
>> +++++++++++++++++++
>>  1 file changed, 67 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/edac/qcom-kryo-edac.yaml
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/edac/qcom-kryo-edac.yaml 
>> b/Documentation/devicetree/bindings/edac/qcom-kryo-edac.yaml
>> new file mode 100644
>> index 000000000000..1a39429a73b4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/edac/qcom-kryo-edac.yaml
>> @@ -0,0 +1,67 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/edac/qcom-kryo-edac.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Kryo Error Detection and Correction(EDAC)
>> +
>> +maintainers:
>> +  - Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> +
>> +description: |
>> +  Kryo EDAC is defined to describe on-chip error detection and 
>> correction
>> +  for the Kryo CPU cores which implement RAS extensions. It will 
>> report
>> +  all Single Bit Errors and Double Bit Errors found in L1/L2 caches 
>> in
>> +  in two registers ERXSTATUS_EL1 and ERXMISC0_EL1. L3-SCU cache 
>> errors
>> +  are reported in ERR1STATUS and ERR1MISC0 registers.
>> +    ERXSTATUS_EL1 - Selected Error Record Primary Status Register, 
>> EL1
>> +    ERXMISC0_EL1 - Selected Error Record Miscellaneous Register 0, 
>> EL1
>> +    ERR1STATUS - Error Record Primary Status Register
>> +    ERR1MISC0 - Error Record Miscellaneous Register 0
>> +  Current implementation of Kryo ECC(Error Correcting Code) mechanism 
>> is
>> +  based on interrupts.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,kryo-edac
>> +
>> +  interrupts:
>> +    minItems: 1
>> +    maxItems: 4
>> +    items:
>> +      - description: l1-l2 cache faultirq interrupt
>> +      - description: l1-l2 cache errirq interrupt
>> +      - description: l3-scu cache errirq interrupt
>> +      - description: l3-scu cache faultirq interrupt
>> +
>> +  interrupt-names:
>> +    minItems: 1
>> +    maxItems: 4
> 
> You are saying only these combinations are valid:
> 
> l1-l2-faultirq
> 
> l1-l2-faultirq
> l1-l2-errirq
> 
> l1-l2-faultirq
> l1-l2-errirq
> l3-scu-errirq
> 
> l1-l2-faultirq
> l1-l2-errirq
> l3-scu-errirq
> l3-scu-faultirq
> 
> Is that your intent?
> 

No, I want any combination of interrupts to be valid with atleast one 
interrupt as mandatory.
I thought specifying minItems as 1 and maxItems as 4 will take care of 
this,  am I doing something wrong?

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
