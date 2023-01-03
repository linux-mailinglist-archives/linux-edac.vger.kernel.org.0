Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B511265C1E5
	for <lists+linux-edac@lfdr.de>; Tue,  3 Jan 2023 15:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjACOZU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Jan 2023 09:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbjACOZE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 3 Jan 2023 09:25:04 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44D812605
        for <linux-edac@vger.kernel.org>; Tue,  3 Jan 2023 06:24:28 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id z26so45852166lfu.8
        for <linux-edac@vger.kernel.org>; Tue, 03 Jan 2023 06:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=veshynjg2VjZ5kIGjQvBUBAmgrL7gj+KyPcOh0zIGRE=;
        b=SORo2KIPDZzlt+p5X1tOp45I/0qUZQuFaGTbCMzqDBKhxBKrdT9+ZtF23ohpFuEBXu
         L+eIL2+gXa47QcpD5js04Birclo7iPfSMs5X/bN1n+J9m1cpvkd0hlGVNGmYG2lHVH9X
         ZbGbMzZ140g8qnD6sARGjH8AROxEikOqGzvaY/Ci6A36q117yX9v4+jTldHDVlb5PylS
         Oug+GzDS/QAlqo7U/cnwV8lzD9oVr/b2L2D3fKSXyNmEl5xelGJujNw348DETDzGrkIT
         kbuWFTc6j2OaX/+1zAZK1CnWLa1gd5oAgtLMBky3NPY98NYh5x/dbZ4vy8sSSUivBy29
         fAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=veshynjg2VjZ5kIGjQvBUBAmgrL7gj+KyPcOh0zIGRE=;
        b=QpR95SInWS/fb/NAGpgGym2MTMvraXDJXAxD4OTBJmbKJJWVlBcrYuWyGwivzFCx0F
         HH5y+6+9kaBy1SdKr8bWsa2HuuRqbg8QTWd93CGxtn95RhPeFA4jaghVbdfjFFEGslkM
         Zifu1fSKmgXyFOnGeo8aOewKmR2L1Vrc3+I85yq8kfiC56tC+BQc9A/IhXkB8StrOvfu
         fb5byP7KgFQfTFFO1eWhGeTYEHaG+GfMOlSV6Q5FsbUOtv2pecVfOrQqhIAucpp7dwH6
         99dZ+QxmNbsdmpW8GX4KOG+2F4bo9KpK+yQehEQkHSafNTjkgSUzFh5KeYKR2U5Gl7bs
         JoHA==
X-Gm-Message-State: AFqh2koTmxz9nl/N28T0jD7k395h1mupq4wPZuOOylFVQxkU55IuaRpU
        P7jRmrA+uQ0RcGCNcUBXCN7Rew==
X-Google-Smtp-Source: AMrXdXtCmGd5P12uFS8OFeoRQZAFKo09XrUh8yQu8OausxRxdjbqOugAf7vv2Hu671XMCZHQJbHheA==
X-Received: by 2002:ac2:5b9a:0:b0:4b5:5da1:4bcc with SMTP id o26-20020ac25b9a000000b004b55da14bccmr12513765lfn.38.1672755867248;
        Tue, 03 Jan 2023 06:24:27 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c14-20020ac244ae000000b004cb43eb09dfsm21867lfm.123.2023.01.03.06.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 06:24:26 -0800 (PST)
Message-ID: <add4e548-c7cd-741d-90e5-5c7c9ec7284f@linaro.org>
Date:   Tue, 3 Jan 2023 15:24:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: RFC on drivers/memory vs drivers/edac memory mapping for DDR
 Controller
To:     "Shenhar, Talel" <talel@amazon.com>, bp@alien8.de
Cc:     talelshenhar@gmail.com, shellykz@amazon.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <2511c7aa-8ce6-a803-a1ea-6121df79c677@amazon.com>
 <8b844f3a-e9b0-28d5-200a-611fe3068bc0@linaro.org>
 <4bd90224-d09a-1f21-92e6-51c967d68a39@amazon.com>
 <21c6dd41-3e6f-26c6-d6ca-25102e992c18@linaro.org>
 <567f14ef-7940-25c5-9323-c673b98e585a@amazon.com>
 <60d2899e-aed3-a98d-4f3e-8203918a23f9@linaro.org>
 <4c91989c-8b63-410b-e06f-99d99ddbb390@amazon.com>
 <a15335d1-fc08-a507-2365-6a14ff6154f6@linaro.org>
 <07109746-6fba-8c66-069b-b5982f460d76@amazon.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <07109746-6fba-8c66-069b-b5982f460d76@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 03/01/2023 14:47, Shenhar, Talel wrote:
> So how would you have the DT described and how would driver/s look like 
> for cases that the unit registers are split interchangeably?
> 
>>
>> You did not Cc relevant here mailing addresses (DT and Rob), so this
>> discussion might miss their feedback.
>>
>> How the drivers map IO address space is independent question and should
>> not determine the hardware description. You want to say that hardware
>> changes depending on OS? One OS means hardware is like that and on other
>> OS it's different?

BTW, you nicely skipped points of my email which are a bit
inconvenient,e.g. how you want to tie DTS and bindings to one specific
driver implementation and ignore the rest...

Best regards,
Krzysztof

