Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8337650D23
	for <lists+linux-edac@lfdr.de>; Mon, 19 Dec 2022 15:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiLSOWF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 19 Dec 2022 09:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiLSOWE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 19 Dec 2022 09:22:04 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678E85F62
        for <linux-edac@vger.kernel.org>; Mon, 19 Dec 2022 06:22:02 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id c1so13856256lfi.7
        for <linux-edac@vger.kernel.org>; Mon, 19 Dec 2022 06:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UWrv8lBgcNHCLzm5GtvSjHAYiNFFdo3OiKB1hWU/9pE=;
        b=AClt4/+6IM4CiIxkFfALoYpOwKNraprGKGusEjHm4WFM1kNpQp+x6T5dahtRa4kFQ+
         6VqNG1c2aa640WdHNUYTonpDGYt62UWgqXZnbsXjo+BSaN4M0Uw4NCwXaQ0RuPiluNK5
         cTOpShJCc8gVCV0dqs/xX+2JC6MBG4C//YpfZr/8LF2nDKC086MPSxmKbm5A6J7Ykfmh
         YwRAodHKOKavJw99+cQxLiGF0jEeV2e5v98g3B/X4sQu88OE6PU3Tlw7llMiD3Ov1IgE
         e7m1xQ54fQgPq7qLLYFu3TP/RGwqVbNfSCjQyPPmf3RI0EX3yDIiKaJy4wHEkC3YMFNE
         x+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWrv8lBgcNHCLzm5GtvSjHAYiNFFdo3OiKB1hWU/9pE=;
        b=1RKqAdCkergbTFYF+utVwFeQdcWrjv2cLqo48mO/wm2XtxQwq57skiJzIWhnAGMIHz
         +79vpHQ6BLqDfbJmPac8eUlZKI/G5q/D2LWSeQ8ZwVpaBmOUGa4kT7RgjIVXGQW7Xr9t
         yJx4lpmONsdEQJISqYm3AZKnUFT5C+U+fVD30ZzwLDPTCReYV+R5xgY0+NvNFWclMlfh
         ADW1Kj36YafZvLGUEISX0JFPgKr5PaQbmJwWOKfM4JSeWQlYra9BrcNYiyhUUo7as8cS
         BsUGtjrwfxcG0c82h8q8PiMXZasjbZfOVgej5037yODNtekWJ4w9mN1lratQna+MSTO1
         4Izg==
X-Gm-Message-State: ANoB5pkJpkPFRkNKjnFDQyF1HF/jrxOM54tSf8kbhdyjmqSJ+4kTrLGU
        YDkgGDDjTpPcbr/E7oj+4HOwYQ==
X-Google-Smtp-Source: AA0mqf7DfqtKnlTO21BkZ/lJrUfLeWDWMGEUJgse8xppt0PUaUzMe2RXnCNpEe1xCdVOmu0TCDr+hg==
X-Received: by 2002:ac2:4c51:0:b0:4a4:8a04:4b37 with SMTP id o17-20020ac24c51000000b004a48a044b37mr16183663lfk.32.1671459720807;
        Mon, 19 Dec 2022 06:22:00 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id y7-20020ac24207000000b004b5831b69dcsm1117502lfh.140.2022.12.19.06.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 06:22:00 -0800 (PST)
Message-ID: <9238a26e-7c4b-00ca-e097-5574ed75210d@linaro.org>
Date:   Mon, 19 Dec 2022 15:21:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
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
 <195a55f1-76e7-3f00-da1f-4ae84f7943c0@linaro.org>
 <20221219135046.GA126558@thinkpad>
 <1df13a83-1926-05b5-f7c7-388ef431a2fa@linaro.org>
 <20221219141643.GB126558@thinkpad>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221219141643.GB126558@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 19/12/2022 15:16, Manivannan Sadhasivam wrote:
> On Mon, Dec 19, 2022 at 03:11:36PM +0100, Krzysztof Kozlowski wrote:
>> On 19/12/2022 14:50, Manivannan Sadhasivam wrote:
>>>
>>>>> Also, the id table is
>>>>> an overkill since there is only one driver that is making use of it. And
>>>>> moreover, there is no definite ID to use.
>>>>
>>>> Every driver with a single device support has usually ID table and it's
>>>> not a problem...
>>>>
>>>
>>> Are you referring to OF/ACPI ID table? Or something else?
>>
>> No, I refer to the driver ID table (I2C, platform whatever the driver is).
>>
> 
> Yeah, that's what I wanted to avoid here. The ID table makes sense if you have
> a bus like I2C or a separate subsystem but here LLCC is an individual driver.
> So creating a separate ID table is an overkill IMO.

Why this is an overkill? Just few lines and many, many drivers have it.
Even duplicated (for legacy reasons) with OF tables.

ALIAS is not the way to go around ID table because essentially you are
re-implementing it.

Best regards,
Krzysztof

