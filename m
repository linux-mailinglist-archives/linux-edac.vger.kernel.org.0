Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FEE64BC4F
	for <lists+linux-edac@lfdr.de>; Tue, 13 Dec 2022 19:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbiLMSrw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Dec 2022 13:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236694AbiLMSrX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 13 Dec 2022 13:47:23 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD0625286
        for <linux-edac@vger.kernel.org>; Tue, 13 Dec 2022 10:47:21 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id cf42so6461505lfb.1
        for <linux-edac@vger.kernel.org>; Tue, 13 Dec 2022 10:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YRwOpyUTyKwZUBQY9S8LUeQA/QLa8sJtEGHZbXqLC9M=;
        b=sGK1i122jhMTjX3eHGkDcjeDAPF73PChEdmzvJsp5X/8qyzjl0rYuKS8H8KKD1St1M
         3OmZ+wPhD4Vlm2UelB8tfS06WQqTNEtXjAHhQgZiwTReGH5hXqz8js+HUGvCTVS+2Dbg
         q1NXNe9Ze62Kr5/Rqg/5/fhnnp2ixYRQDqwhQpQXiBHHyQBPzJe+I7shXo6Tz7v5Szk3
         yV6Et3779dABbPSG/Rksz3t1F2hDgaWsMah3p2sgIkjr/W23kqr57Lt6Ao9m44BPsdOH
         tKEw1IN1sGiQ6SoYx0GwhYSuB0v9RmrnlC9/NrH2T0JoMp/sHXtDC/nl70lZ1f3nc7As
         kUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YRwOpyUTyKwZUBQY9S8LUeQA/QLa8sJtEGHZbXqLC9M=;
        b=L5HTOwVUge42hKbL9QWRp8zt8If89vv6QB2uGykIh1B5QfQ4n4JMwytlC5mJre0W+y
         h7qQG1BM4Hb3sGUK1QE1M/gIfDgXON/32fnICiHO50Qy8vYDxNcSACztZgabKlhtUDot
         gM1PAt/bSJHG7Q9pCfQCMVitAeXk8zTP9ZH1kgT8aHqiFe0aIMVnow19Zo4tdmz6+3rr
         S/LJO2prX7gis/ZuG8hQexJzFr0Y4H3kwJO/1Hg/2bqMQoWhQbiF7n6y0+GuNd9ZTLVB
         /+Kr1/r/plOw0Bu2Zkn94aC/zZWrR131deP5g2N6JB/I/uNOSWuu4yluld8VNJPfKvtO
         o+vw==
X-Gm-Message-State: ANoB5pmwoaD7tpLILL+dyP2yDdL07zCgUP4fiEejE+ORbrxVw1pHrkCS
        Z1ChyU0r+YM5xqGtExdqsEjdUg==
X-Google-Smtp-Source: AA0mqf4EzlyeUXlRyVVkTE9zBWWT/0m5aa7Czf1yi3T8wBUtLN19XL5M4jOioVNHsNguthRiFxrysg==
X-Received: by 2002:ac2:4c24:0:b0:4b4:900c:3a28 with SMTP id u4-20020ac24c24000000b004b4900c3a28mr5168648lfq.60.1670957239616;
        Tue, 13 Dec 2022 10:47:19 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 25-20020ac25699000000b004b58d457f2dsm471838lfr.61.2022.12.13.10.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 10:47:19 -0800 (PST)
Message-ID: <195a55f1-76e7-3f00-da1f-4ae84f7943c0@linaro.org>
Date:   Tue, 13 Dec 2022 19:47:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 00/13] Qcom: LLCC/EDAC: Fix base address used for LLCC
 banks
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Andrew Halaney <ahalaney@redhat.com>, andersson@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        bp@alien8.de, tony.luck@intel.com, quic_saipraka@quicinc.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com, luca.weiss@fairphone.com
References: <20221212123311.146261-1-manivannan.sadhasivam@linaro.org>
 <20221212192340.evgtbpzmw7hcdolb@halaney-x13s>
 <20221213052802.GB4862@thinkpad>
 <ec64e3a0-085d-7830-fd4e-6969c1c9bbdf@linaro.org>
 <20221213175738.GI4862@thinkpad>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213175738.GI4862@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 13/12/2022 18:57, Manivannan Sadhasivam wrote:
> On Tue, Dec 13, 2022 at 05:54:56PM +0100, Krzysztof Kozlowski wrote:
>> On 13/12/2022 06:28, Manivannan Sadhasivam wrote:
>>> On Mon, Dec 12, 2022 at 01:23:40PM -0600, Andrew Halaney wrote:
>>>> On Mon, Dec 12, 2022 at 06:02:58PM +0530, Manivannan Sadhasivam wrote:
>>>>> The Qualcomm LLCC/EDAC drivers were using a fixed register stride for
>>>>> accessing the (Control and Status Regsiters) CSRs of each LLCC bank.
>>>>> This offset only works for some SoCs like SDM845 for which driver support
>>>>> was initially added.
>>>>>
>>>>> But the later SoCs use different register stride that vary between the
>>>>> banks with holes in-between. So it is not possible to use a single register
>>>>> stride for accessing the CSRs of each bank. By doing so could result in a
>>>>> crash with the current drivers. So far this crash is not reported since
>>>>> EDAC_QCOM driver is not enabled in ARM64 defconfig and no one tested the
>>>>> driver extensively by triggering the EDAC IRQ (that's where each bank
>>>>> CSRs are accessed).
>>>>>
>>>>> For fixing this issue, let's obtain the base address of each LLCC bank from
>>>>> devicetree and get rid of the fixed stride.
>>>>>
>>>>> This series affects multiple platforms but I have only tested this on
>>>>> SM8250 and SM8450. Testing on other platforms is welcomed.
>>>>>
>>>>
>>>> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride
>>>>
>>>
>>> Thanks!
>>>
>>>> I took this for a quick spin on the qdrive3 I've got access to without
>>>> any issue:
>>>>
>>>>     [root@localhost ~]# modprobe qcom_edac
>>>>     [root@localhost ~]# dmesg | grep -i edac
>>>>     [    0.620723] EDAC MC: Ver: 3.0.0
>>>>     [    1.165417] ghes_edac: GHES probing device list is empty
>>>>     [  594.688103] EDAC DEVICE0: Giving out device to module qcom_llcc_edac controller llcc: DEV qcom_llcc_edac (INTERRUPT)
>>>>     [root@localhost ~]# cat /proc/interrupts | grep ecc
>>>>     174:          0          0          0          0          0          0          0          0     GICv3 614 Level     llcc_ecc
>>>>     [root@localhost ~]#
>>>>
>>>> Potentially stupid question, but are users expected to manually load the
>>>> driver as I did? I don't see how it would be loaded automatically in the
>>>> current state, but thought it was funny that I needed to modprobe
>>>> myself.
>>>>
>>>> Please let me know if you want me to do any more further testing!
>>>>
>>>
>>> Well, I always ended up using the driver as a built-in. I do make it module for
>>> build test but never really used it as a module, so didn't catch this issue.
>>>
>>> This is due to the module alias not exported by the qcom_edac driver. Below
>>> diff allows kernel to autoload it:
>>>
>>> diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
>>> index f7afb5375293..13919d01c22d 100644
>>> --- a/drivers/edac/qcom_edac.c
>>> +++ b/drivers/edac/qcom_edac.c
>>> @@ -419,3 +419,4 @@ module_platform_driver(qcom_llcc_edac_driver);
>>>  
>>>  MODULE_DESCRIPTION("QCOM EDAC driver");
>>>  MODULE_LICENSE("GPL v2");
>>> +MODULE_ALIAS("platform:qcom_llcc_edac");
>>
>> While this is a way to fix it, but instead of creating aliases for wrong
>> names, either a correct name should be used or driver should receive ID
>> table.
>>
> 
> I'm not sure how you'd fix it with a _correct_ name here. 

Hm, I assumed that it would be enough if driver name would match device
name. Currently these two are not in sync. Maybe it's not enough when
built as module?

> Also, the id table is
> an overkill since there is only one driver that is making use of it. And
> moreover, there is no definite ID to use.

Every driver with a single device support has usually ID table and it's
not a problem...

Best regards,
Krzysztof

