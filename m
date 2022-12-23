Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F315654DEE
	for <lists+linux-edac@lfdr.de>; Fri, 23 Dec 2022 09:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbiLWI6R (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 23 Dec 2022 03:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbiLWI6M (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 23 Dec 2022 03:58:12 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B27A1C10E
        for <linux-edac@vger.kernel.org>; Fri, 23 Dec 2022 00:58:11 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id f20so4361897lja.4
        for <linux-edac@vger.kernel.org>; Fri, 23 Dec 2022 00:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NYQbSy434GAtK9sinOrrD+9gAo0TIsgULlkeRWIvxP4=;
        b=mpwA1LnjDZ+XRh7LtQGy9eLdArCW/uRQgV6ZV4/6bds+azwgylg7bUgS3qQS7tiMa0
         +laAQenqIH6Wp/fiezhn5ttYhocg2vvsxOP+Qd0qjjE4yLaPWu1zZIAlJ9iLVF6GDRDy
         LdqnJFuhXg7mcwQb8khTjjWcswUoW7KJJynaqS3gcwN6QQsiuh5ayMdZBmVcnZgBFgUG
         nMiqZnxRT71J7CXs3ZJE7+YnOVE33s3EDrpaA72M8Iu8GtMWB9y3BGR2mksyy6J4xIMo
         Hxtz8xfiaGtdR5p7T3krazNgKjpW6OJFdsKJtS2C9EkjofBPRJXRQ309jHBpCrCzDRUn
         bpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYQbSy434GAtK9sinOrrD+9gAo0TIsgULlkeRWIvxP4=;
        b=sg8cXaC6WSQuOhclGfwTGLTxdNLYHFA/ELUcdtt0xL/cssNVNIuQ+oRNNe1tXXMSwU
         FxZuI7W1RbUNJKJgCGjIQGpr1c3VvlAmY9NA89XNhhMBBzW6186UB/kO962CEFK9z4YH
         dt88W7As2Rl1915Jyq6xrgmMRQQTVWiltF5WW4wVV0ob2xf/PygEo8cjjeFx6JxUjGHK
         I+AnAV8wXawoHdn3LWzWJt5JYmyaMV8qrJph3rqy8Or5OUfbbkcL+6zISNfXGCEmL+SI
         i3qGKC7GDtqCTFJvMU26Y/d/M4OLQ9wPwpPJhrB+V+SdDQ+59d/uummIlLKtcPMKNdS2
         IZ3g==
X-Gm-Message-State: AFqh2krIHkFRh/QoymGqLQwAuT1r6c/oPOUPKTGK5kFN5y0ppnr1o53a
        oH/0lUy34QYJcS0Ic0zGyttE/Q==
X-Google-Smtp-Source: AMrXdXtTZ6B9iVWOB1ws3xnA4ZJTh8QIKy6MXXmF599iZ5583Wa27y3w81pyo4ZumBwV3U2CmWfHVw==
X-Received: by 2002:a2e:391e:0:b0:277:8f65:a3ae with SMTP id g30-20020a2e391e000000b002778f65a3aemr2337836lja.27.1671785889565;
        Fri, 23 Dec 2022 00:58:09 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id be35-20020a05651c172300b0027fafca7addsm144294ljb.112.2022.12.23.00.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 00:58:09 -0800 (PST)
Message-ID: <8a1389f8-ec20-ae85-97b9-599f0c10b8b4@linaro.org>
Date:   Fri, 23 Dec 2022 09:58:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 02/16] dt-bindings: arm: msm: Fix register regions used
 for LLCC banks
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org
References: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
 <20221222131656.49584-3-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221222131656.49584-3-manivannan.sadhasivam@linaro.org>
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

On 22/12/2022 14:16, Manivannan Sadhasivam wrote:
> Register regions of the LLCC banks are located at different addresses.
> Currently, the binding just lists the LLCC0 base address and tries to
> cover all the banks using a single size. This is entirely wrong as there
> are other register regions that happen to lie inside the size covered by
> the binding such as the memory controller and holes.
> 
> So this needs to be fixed by specifying the base address of individual
> LLCC banks. This approach will break the existing users of this binding
> as the register regions are splitted and the drivers now cannot use
> LLCC0 register region for accessing rest of the banks (which is wrong
> anyway).
> 
> But considering the fact that the binding was wrong from the day one and
> also the device drivers going wrong by the binding, this breakage is
> acceptable.
> 
> Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

