Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78BD64B977
	for <lists+linux-edac@lfdr.de>; Tue, 13 Dec 2022 17:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbiLMQUP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Dec 2022 11:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiLMQUO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 13 Dec 2022 11:20:14 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3031D21832
        for <linux-edac@vger.kernel.org>; Tue, 13 Dec 2022 08:20:13 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id q6so5711000lfm.10
        for <linux-edac@vger.kernel.org>; Tue, 13 Dec 2022 08:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C5gq5rxJtvWEgDX37cgWvfKS/1Lan6w1P56/EsH95AU=;
        b=xgrydg3tl/HIkUOHlimHlKk9SpoA7fUHHV6zA1gmJfuWPlEO2GYsIlKTQV+HvmuwM5
         Po8OTZCQ7trDomcfSas8sB2pCV+EWb8TCSLpddF/18V7cQU6Xcbpwy0H7Bcu7jdjIrI2
         venMRsgzvuEdOSOD4cCoQMkXqT5p73TnIjtj9BcBlXbcUmA6Ir44NCfMZtLVOKeZS4ti
         qW/puhlWAxe6bbjj2coom8N31HYVehi8pUA4eSEDDRpiFN7pyFubS3qy3hQUXvfrhYHx
         /k9ajDA6R+gAFIRl+Hl6o61lWmR6bnwj5hcRIw7dJEBUGGwvNPvR9ZWhVOAIF0Su46wo
         MWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C5gq5rxJtvWEgDX37cgWvfKS/1Lan6w1P56/EsH95AU=;
        b=FUqT637RNN0a40TB5N2qCM88df/49iI4z9djF0n6pnCxiBfgqCoE9XE8XCG/l6kwUy
         Y6wGbqYxq9s4cO6x1rZVwWthp7UrhAeXnQy6xNWv79se0v9jKU6/Fvab6Eoybm5/bqpD
         QSIpbadnIrq25xPfoKTpKnHVmpBp4GHxriQ649yDF7KfREFb6eZ6qtMZrELm0rtdbbMy
         icGfH7Po/obYX23bSm0SlxlmNYIJnFl5Afo3J4FFpKiFDBsRDq1/lAqRyhOt5ReBFQUS
         0RqL+GzHrwudzrmJeiJ3a7x+33ND1JD7xePhu5AHv2QMgfv6pkNkzsyDda+Us3aALb/0
         azNg==
X-Gm-Message-State: ANoB5plna91cEfOev6uomEmbrHMPYhqP+bhD8QAwcJI3mRwnagDosocd
        xTFkr51XAWC6J2nzvNSHrNdRIg==
X-Google-Smtp-Source: AA0mqf4Y1O9QUR1toVhKYaPxRlbO0VvuJt/XhEarsuy7S0QMszB19/KW8Gj4d1DsTNhsLCrKq6eDCA==
X-Received: by 2002:ac2:4c4a:0:b0:4b6:eb36:e73e with SMTP id o10-20020ac24c4a000000b004b6eb36e73emr2814591lfk.17.1670948411580;
        Tue, 13 Dec 2022 08:20:11 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id g26-20020a19e05a000000b004b094730074sm422858lfj.267.2022.12.13.08.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 08:20:11 -0800 (PST)
Message-ID: <312cf022-25a0-2126-a541-3a8147d50f71@linaro.org>
Date:   Tue, 13 Dec 2022 17:20:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 01/13] dt-bindings: arm: msm: Update the maintainers
 for LLCC
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com
References: <20221212123311.146261-1-manivannan.sadhasivam@linaro.org>
 <20221212123311.146261-2-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221212123311.146261-2-manivannan.sadhasivam@linaro.org>
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

On 12/12/2022 13:32, Manivannan Sadhasivam wrote:
> Rishabh Bhatnagar has left Qualcomm, and there is no evidence of him
> maintaining with a new identity. So his entry needs to be removed.
> 
> Also, Sai Prakash Ranjan's email address should be updated to use
> quicinc domain.
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

