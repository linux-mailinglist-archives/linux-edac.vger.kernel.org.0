Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1212595D31
	for <lists+linux-edac@lfdr.de>; Tue, 16 Aug 2022 15:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiHPNXw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Aug 2022 09:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbiHPNXt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 Aug 2022 09:23:49 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEDE5A3E0
        for <linux-edac@vger.kernel.org>; Tue, 16 Aug 2022 06:23:46 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u3so14895661lfk.8
        for <linux-edac@vger.kernel.org>; Tue, 16 Aug 2022 06:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=S+ArLWeoG1TThOx9faoKOFi7KAdFAVRoMOAhvK1aN8U=;
        b=fzW5JMpGFN3an7Hi+gemzsUaSyDHiCtIKYr0oam0FCNadNaBkbEQefdd7z1wkUMFzB
         oST7O2VaNFpKbcjAAQG+sJDV7l5ly138cIsQN+9gd0by2tQUH8qrbpLIXFmMm61HfOmZ
         OeB+jjM0xXp++d2J/yrhoJRpkFXYzJIvTa6Mfd9j2wPbS77fJVcV0347ER4OdrJEyxWH
         SgPhYqcs+W2FKCKRPyJphTTP1L56gV/PMZGsfU10Z0ukn/+zGVjYwBY+Wl1SBTG8tjn/
         oHKQgjWNOz8FRH1O+GdhNA5yw6pVtiff+5q3tEGI+sm4kOvelXWHhpLWUnYmeDsCP2vA
         0O+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=S+ArLWeoG1TThOx9faoKOFi7KAdFAVRoMOAhvK1aN8U=;
        b=3dShPAa7kjKEArMGJQDSrdnckJ84qlQiui7Ad5XPvnEiQOfZZiAjQnuyl/f5GCQwn/
         YATv5sr5jOxiFXZc+mW/XU/y2JHpV3UqVJglilbrP3KmDvDzuxQfjBfCAOkD4Qo4ZVr/
         Hz+oaE0az9ah5poCeXjMVOhf4iTJazemLfWEEG+R4Ex6/Qzv7a3pB1CBcQi01adLd9tY
         mupqYwFcUnNW3bzYtgyBnUPbjpstxkq11hoPf8hfgBLe7W10u2C25BsKz3mzCRtnPUsz
         o1ocWQ1uMwNXV2DOwNRcSzqU8P+GJ/QbgKhx7sdQUDeR6ULKKe/5w4Y9VUN96yEG9gjB
         0Sew==
X-Gm-Message-State: ACgBeo2VGQ1ulTxX8IL0mHSURNwyFGTNL47v3SasdsFe0aFXFlpRHIkH
        vQlxgJD/3+W+LKvywjPI6uUR9Q==
X-Google-Smtp-Source: AA6agR4WJLULkwmyBdNibjNTs4DmJssl9enaRWHalUNN2psfpbH0ew6YcJWXXwhmFej5j6GUUKamFg==
X-Received: by 2002:a05:6512:3a84:b0:48c:f59e:3bff with SMTP id q4-20020a0565123a8400b0048cf59e3bffmr7950085lfu.516.1660656225019;
        Tue, 16 Aug 2022 06:23:45 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c031200b0025e728764ebsm1736180ljp.105.2022.08.16.06.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 06:23:44 -0700 (PDT)
Message-ID: <32c92eb8-599a-2525-1306-bdc3beb33f49@linaro.org>
Date:   Tue, 16 Aug 2022 16:23:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] dt-bindings: edac: Add bindings for Xilinx ZynqMP OCM
Content-Language: en-US
To:     "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
References: <20220816073203.27314-1-sai.krishna.potthuri@amd.com>
 <20220816073203.27314-2-sai.krishna.potthuri@amd.com>
 <c7146f96-fec6-5371-7137-9829e635ea20@linaro.org>
 <BY5PR12MB4258CAD5AA8BEFAAB444E4E3DB6B9@BY5PR12MB4258.namprd12.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <BY5PR12MB4258CAD5AA8BEFAAB444E4E3DB6B9@BY5PR12MB4258.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 16/08/2022 15:43, Potthuri, Sai Krishna wrote:
> Hi Krzysztof,
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Tuesday, August 16, 2022 1:29 PM
>> To: Potthuri, Sai Krishna <sai.krishna.potthuri@amd.com>; Rob Herring
>> <robh+dt@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; Michal Simek
>> <michal.simek@xilinx.com>; Borislav Petkov <bp@alien8.de>; Mauro
>> Carvalho Chehab <mchehab@kernel.org>; Tony Luck <tony.luck@intel.com>;
>> James Morse <james.morse@arm.com>; Robert Richter <rric@kernel.org>
>> Cc: devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org; linux-edac@vger.kernel.org;
>> saikrishna12468@gmail.com; git (AMD-Xilinx) <git@amd.com>; Shubhrajyoti
>> Datta <shubhrajyoti.datta@xilinx.com>
>> Subject: Re: [PATCH 1/2] dt-bindings: edac: Add bindings for Xilinx ZynqMP
>> OCM
>>
>> On 16/08/2022 10:32, Sai Krishna Potthuri wrote:
>>> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>>>
>>> Add bindings for Xilinx ZynqMP OCM controller.
>>>
>>> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>>> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
>>> ---
>>>  .../bindings/edac/xlnx,zynqmp-ocmc.yaml       | 41 +++++++++++++++++++
>>>  1 file changed, 41 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/edac/xlnx,zynqmp-ocmc.yaml
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/edac/xlnx,zynqmp-ocmc.yaml
>>> b/Documentation/devicetree/bindings/edac/xlnx,zynqmp-ocmc.yaml
>>> new file mode 100644
>>> index 000000000000..9bcecaccade2
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/edac/xlnx,zynqmp-ocmc.yaml
>>> @@ -0,0 +1,41 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/edac/xlnx,zynqmp-ocmc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Xilinx Zynqmp OCM EDAC driver
>>
>> s/EDAC driver//
>> Is it a memory controller?
> This driver is about Error Detection and Correction feature for OCM (On Chip
> Memory) controller which supports ECC functionality.

I am not talking about driver. What is the hardware exactly? On Chip
Memory Controller sounds like Memory Controller, so use this instead of
EDAC.


Best regards,
Krzysztof
