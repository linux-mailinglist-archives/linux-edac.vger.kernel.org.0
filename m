Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FFE64BA70
	for <lists+linux-edac@lfdr.de>; Tue, 13 Dec 2022 17:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbiLMQ5V (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Dec 2022 11:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbiLMQ4U (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 13 Dec 2022 11:56:20 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F3323E88
        for <linux-edac@vger.kernel.org>; Tue, 13 Dec 2022 08:55:02 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id h10so3895492ljk.11
        for <linux-edac@vger.kernel.org>; Tue, 13 Dec 2022 08:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K+q9dHIAvDf5WdQnh9GflHshtAb0HGooV+00C3PXCO0=;
        b=DDbr/cxiZKAiaoP5Z9oe6GAJInMKVGPFMv2FHk0AjMWMYDqxxydgX/t/B9vqdyVkLH
         eeGztqCjsey5soHWK/I3+egsrPRKaO18Tbu1TelbxboVjuSklVo3Kd5W4CaOuvGAnFS1
         Z2odjCQmKRTtGmqPkG8id7yxfjfqtNkPQPSBhnQAZstmsRYzgBQA4gNhpcNwyIkaWvNF
         8AzFlf5bKX5S8zj+146jUXzJd0UD8DjOxF+lGmpr3Uuq4SoCYly6eeDbgMoBQc8ImHrX
         MK3uBgNLTA3o3KcFkQBMj28vY+oHzaDojD4qzTCd6LhaHvxwKxTQu7BRahDKSPYiSF5y
         OtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K+q9dHIAvDf5WdQnh9GflHshtAb0HGooV+00C3PXCO0=;
        b=03NUCwG6yB0gV20qxuqVAPWJdQHvYZm87p4pZHckRaSSF9P47DIHIXEeaCqIWnES9M
         5sy7yOCDtkU7KOhdBNgV+NCgYQbIiUyA1J51B+YePYMxv+ELqjB+WKKmI46YRvAtVoyg
         QhzrkJ6jGaYLE1X8/oRazmXoPeGEkQT8aZgzJUnsSnhVsTgca4wYqHEcRX/v17mpujzC
         m1uZN7rrd+4QTCZOW65rjJ8oZ1I5WaemToAJZyKmVp1cQR44HKFqG5asMn9Z4ezWY7dt
         jZO2EGFVPpINQm5uYH26JK3S9ujiONUUYz/dura7Q7DLuv0uHAFN0FKshruhwQKdG5BD
         KAyw==
X-Gm-Message-State: ANoB5pkZH/JoSRr4QMy2o20MFX8jgb6Eu7hw5uIEaZZGmj6MXZCXZ1OQ
        zDqr6n1jx8NX4qlcPfyZbLQ1mQ==
X-Google-Smtp-Source: AA0mqf5xUeTGSPd6Jz0TOmt+lk6CT5hymUSCegIYfi/Kvmu8yr9GUDkGvV8J1kmF32Ft5oXa3uxiWw==
X-Received: by 2002:a05:651c:247:b0:277:af4:aa34 with SMTP id x7-20020a05651c024700b002770af4aa34mr4957085ljn.36.1670950498042;
        Tue, 13 Dec 2022 08:54:58 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 13-20020a05651c128d00b0026dd4be2290sm323317ljc.90.2022.12.13.08.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 08:54:57 -0800 (PST)
Message-ID: <ec64e3a0-085d-7830-fd4e-6969c1c9bbdf@linaro.org>
Date:   Tue, 13 Dec 2022 17:54:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 00/13] Qcom: LLCC/EDAC: Fix base address used for LLCC
 banks
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com, quic_saipraka@quicinc.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com, luca.weiss@fairphone.com
References: <20221212123311.146261-1-manivannan.sadhasivam@linaro.org>
 <20221212192340.evgtbpzmw7hcdolb@halaney-x13s>
 <20221213052802.GB4862@thinkpad>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213052802.GB4862@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 13/12/2022 06:28, Manivannan Sadhasivam wrote:
> On Mon, Dec 12, 2022 at 01:23:40PM -0600, Andrew Halaney wrote:
>> On Mon, Dec 12, 2022 at 06:02:58PM +0530, Manivannan Sadhasivam wrote:
>>> The Qualcomm LLCC/EDAC drivers were using a fixed register stride for
>>> accessing the (Control and Status Regsiters) CSRs of each LLCC bank.
>>> This offset only works for some SoCs like SDM845 for which driver support
>>> was initially added.
>>>
>>> But the later SoCs use different register stride that vary between the
>>> banks with holes in-between. So it is not possible to use a single register
>>> stride for accessing the CSRs of each bank. By doing so could result in a
>>> crash with the current drivers. So far this crash is not reported since
>>> EDAC_QCOM driver is not enabled in ARM64 defconfig and no one tested the
>>> driver extensively by triggering the EDAC IRQ (that's where each bank
>>> CSRs are accessed).
>>>
>>> For fixing this issue, let's obtain the base address of each LLCC bank from
>>> devicetree and get rid of the fixed stride.
>>>
>>> This series affects multiple platforms but I have only tested this on
>>> SM8250 and SM8450. Testing on other platforms is welcomed.
>>>
>>
>> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride
>>
> 
> Thanks!
> 
>> I took this for a quick spin on the qdrive3 I've got access to without
>> any issue:
>>
>>     [root@localhost ~]# modprobe qcom_edac
>>     [root@localhost ~]# dmesg | grep -i edac
>>     [    0.620723] EDAC MC: Ver: 3.0.0
>>     [    1.165417] ghes_edac: GHES probing device list is empty
>>     [  594.688103] EDAC DEVICE0: Giving out device to module qcom_llcc_edac controller llcc: DEV qcom_llcc_edac (INTERRUPT)
>>     [root@localhost ~]# cat /proc/interrupts | grep ecc
>>     174:          0          0          0          0          0          0          0          0     GICv3 614 Level     llcc_ecc
>>     [root@localhost ~]#
>>
>> Potentially stupid question, but are users expected to manually load the
>> driver as I did? I don't see how it would be loaded automatically in the
>> current state, but thought it was funny that I needed to modprobe
>> myself.
>>
>> Please let me know if you want me to do any more further testing!
>>
> 
> Well, I always ended up using the driver as a built-in. I do make it module for
> build test but never really used it as a module, so didn't catch this issue.
> 
> This is due to the module alias not exported by the qcom_edac driver. Below
> diff allows kernel to autoload it:
> 
> diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
> index f7afb5375293..13919d01c22d 100644
> --- a/drivers/edac/qcom_edac.c
> +++ b/drivers/edac/qcom_edac.c
> @@ -419,3 +419,4 @@ module_platform_driver(qcom_llcc_edac_driver);
>  
>  MODULE_DESCRIPTION("QCOM EDAC driver");
>  MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:qcom_llcc_edac");

While this is a way to fix it, but instead of creating aliases for wrong
names, either a correct name should be used or driver should receive ID
table.

Best regards,
Krzysztof

