Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889476574DA
	for <lists+linux-edac@lfdr.de>; Wed, 28 Dec 2022 10:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiL1Jnq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 28 Dec 2022 04:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbiL1Jnn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 28 Dec 2022 04:43:43 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55706445
        for <linux-edac@vger.kernel.org>; Wed, 28 Dec 2022 01:43:41 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id f34so22890445lfv.10
        for <linux-edac@vger.kernel.org>; Wed, 28 Dec 2022 01:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tLt2/tARhWw9FJ/bni+IKZjdgOEWGbMZLOXuNNZkku0=;
        b=U0Bj45Iogz3JHSFeVGGW2wvY1Jj1j1BQ1UryTKBa6lZ4x0gip4tyfOhRGJ+aXfMdzV
         fIrr4ITa3vKoXn6SiVB1UjGHBZUsBg4t4Dc+I2NHePNJSN34WiwpPxYX50fol9013W+h
         xf+zsbS3VdwbOedPh7CHLO0II6b5QAPB5KKjf4a5GemYLyG/P0qi+HASdWrcICyl6RgO
         NE7ES7EaQmddk5iomCaEq7blNgpeeHbp9ujaBYUr03KF7oLCG8SLuLRBmZK25RBLcK3v
         jMQvFG8R/VV3uCD+vYMVGT187EmnvT+CA4UC1qlZvwncq5ig9Zx33jFFTxN8mlXymuEA
         Sd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tLt2/tARhWw9FJ/bni+IKZjdgOEWGbMZLOXuNNZkku0=;
        b=CKFNl4dBJIAPZdiGpmdpem8RFpsv5I8kvMy1rVdg4SQLtnSRwtSqauhNydYtpZQv30
         zK8XFNqfyXRQYLBWFBPSxGc5/Oa+l3OidA7xkrhomRy39Z0em6ZCZ6gAG+KBn3CSljYp
         kqENJWOUfm8WSUnwMcemdil1/AEu7Dp0LH8cnHB6TB9/0xJUWlI8hRqb6bQBibpbDMnh
         k2DbA6TTKh4V2+ObJ3oN68pJOhnv8PvBTA9aPiK+xUhH/2nUONDENRGwoVt+Yr63bCR/
         N1ITLa2ow+MCytEmxxtC7GwKbXYNJZSDHlAiksh2rKxeOyDByS4S0cU7UV9PUDDIQlOR
         ua6A==
X-Gm-Message-State: AFqh2kq1F0x7qgc9YG1j83HCdAsRvrK3NsptdfjU/EvBncANb45tCjzL
        DTmQixEeKrNo+ig4/6Eoq8PD4w==
X-Google-Smtp-Source: AMrXdXtqX2zL6xY+y3eU9K9EZc2nA2JVwP5IsjM2v6VK3zH36XfOdkqEoUKKJ3WS1HsjUni7g//1hA==
X-Received: by 2002:a05:6512:2821:b0:4b5:26f3:2247 with SMTP id cf33-20020a056512282100b004b526f32247mr8029985lfb.69.1672220620149;
        Wed, 28 Dec 2022 01:43:40 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v14-20020a2e7a0e000000b0027fd474e7aasm2193ljc.74.2022.12.28.01.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 01:43:39 -0800 (PST)
Message-ID: <e6144427-6759-8a08-d6dd-4dc0a499c4d4@linaro.org>
Date:   Wed, 28 Dec 2022 10:43:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 15/16] qcom: llcc/edac: Fix the base address used for
 accessing LLCC banks
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        bp@alien8.de, tony.luck@intel.com, quic_saipraka@quicinc.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com, luca.weiss@fairphone.com,
        ahalaney@redhat.com, steev@kali.org
References: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
 <20221222131656.49584-16-manivannan.sadhasivam@linaro.org>
 <20221228042944.g4g6vvaapiln6ces@builder.lan>
 <20221228065353.GB30143@thinkpad>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221228065353.GB30143@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 28/12/2022 07:53, Manivannan Sadhasivam wrote:
> On Tue, Dec 27, 2022 at 10:29:44PM -0600, Bjorn Andersson wrote:
>> On Thu, Dec 22, 2022 at 06:46:55PM +0530, Manivannan Sadhasivam wrote:
>>> First index is LLCC bank 0 and last index is LLCC broadcast. If the SoC
>>> supports more than one bank, then those needs to be defined in devicetree
>>> for index from 1..N-1.
>>>
>>
>> What happened to my request for dropping the reliance on reg-names and
>> pick reg entries per the logic you describe here?
>>
>> Was it request just lost or was there a reason why you stuck with the
>> reg-names?
>>
> 
> The driver uses index to map the resources from DT and not using reg-names.
> See qcom_llcc_init_mmio().
> 
> But the reg-names property is kept in the devicetree as per Krzysztof's
> request. I've recorded these in the changelog.

For the record, my comment was about keeping the reg-names in the DTS
and bindings (as non-required, although that part I maybe did not
express explicitly).

Best regards,
Krzysztof

