Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217AF7BFEB0
	for <lists+linux-edac@lfdr.de>; Tue, 10 Oct 2023 16:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjJJODv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Oct 2023 10:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjJJODv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 10 Oct 2023 10:03:51 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4C1A4
        for <linux-edac@vger.kernel.org>; Tue, 10 Oct 2023 07:03:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-406618d080eso54694325e9.2
        for <linux-edac@vger.kernel.org>; Tue, 10 Oct 2023 07:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696946628; x=1697551428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UdvRmXW1iew14QbNxEmQFkNlLyOKTK7lT27vN956+Lo=;
        b=xfjenavpV2n8i3gciWyuZVdVWpnHIm9xb2bmXn7twuohNJAwU+G6PtzjTiQ/aQ/A+z
         GgwOcQ3dOgFODmD1VO6948lBDFcHIgc1OphYQFDcwm0F/QoHSFxKW3qqfMR8J9sHXhuV
         4eeRphtgSZ1N3qUQwofS1zksudSEpEbOlMi28AzUpwIcbGsGOBqQL/FgUeQV3vv1h0lC
         gwWh+U09lkTGb4kyuTCZttyUP/cxJ0S38Zd3mEqh2OirJmJl3IV6a3sSGy2qKfNTKeXJ
         xFqvQR7imSMoNTqCdBZ96slQMV76amLj82HkIu2xY2XngTbF5zNqooNiyVt3zJ3BVGbl
         UmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696946628; x=1697551428;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UdvRmXW1iew14QbNxEmQFkNlLyOKTK7lT27vN956+Lo=;
        b=bbGLMVPnv6yVpaizq8meYrH486wc28BTRnti9DzM34hLxqYbZNy1T5zxyLr3uXhAii
         MRSKWc27Zevpv3WBt/oS90hdrSvvZiLGrVM+TXBPgLSRDnLmOdUSvlyhe6s9cMCC26/V
         wnreNpEyO6ke8sVpVPA0gC1tSZ5ZWBTeA0i/26HL7uSg4TCJWIq2Yb6mseUaorHno66G
         HdkUb9znUq1SOWW+tZZzRKjZENzX5NR1WrpyItTs+piwMXwDEKexfzvPyCPj39Vwgmww
         Sa8JJTzLKT/73zvQhvOHpblnkAGcItuq4SrnRaVUeqhNTkbqiz1rPK/cFEM5vhWjtXLs
         xFgA==
X-Gm-Message-State: AOJu0YwYNFWyF7PmHVAi4o8AzfQeaTGuw41EbaD39aquSn956KDWP0ok
        dWnAcOjMZ/5jcNXzIHPAohXkHg==
X-Google-Smtp-Source: AGHT+IFU0WrCQmN8C2yzEFwbmnLz6+v1XRMnUENG4BPmUqBvYBFMytZnr4mSqWwqW+hi1kAJVmFWjg==
X-Received: by 2002:a1c:f202:0:b0:407:5ad0:ab5b with SMTP id s2-20020a1cf202000000b004075ad0ab5bmr753352wmc.8.1696946626929;
        Tue, 10 Oct 2023 07:03:46 -0700 (PDT)
Received: from [192.168.69.115] (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr. [176.172.113.148])
        by smtp.gmail.com with ESMTPSA id q15-20020a7bce8f000000b00405391f485fsm14194190wmj.41.2023.10.10.07.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 07:03:46 -0700 (PDT)
Message-ID: <3c74029d-7dc2-e257-201a-aac9667a478a@linaro.org>
Date:   Tue, 10 Oct 2023 16:03:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 12/21] EDAC/octeon-l2c: Convert to platform remove
 callback returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-mips@vger.kernel.org, kernel@pengutronix.de
References: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
 <20231004131254.2673842-13-u.kleine-koenig@pengutronix.de>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231004131254.2673842-13-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 4/10/23 15:12, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/edac/octeon_edac-l2c.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

