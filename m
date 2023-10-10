Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3541C7BFEAD
	for <lists+linux-edac@lfdr.de>; Tue, 10 Oct 2023 16:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjJJOD3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Oct 2023 10:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjJJOD2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 10 Oct 2023 10:03:28 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E708AA7
        for <linux-edac@vger.kernel.org>; Tue, 10 Oct 2023 07:03:25 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-406650da82bso52724245e9.3
        for <linux-edac@vger.kernel.org>; Tue, 10 Oct 2023 07:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696946604; x=1697551404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5v3iUWeLS86EEWRJtn4MLoNjVrwBJIIYZlwA5/5mquQ=;
        b=KcEmLZ/ScrrBFmj2VnvY7pAZEqwC6yvNr1Msx07dR/VltCioC5huInO5lZ+I/x/Aki
         29A9zY5cIWst5r1DgVNB4jI7ZsMBoBtc7toIASSU9yNSVkKN/Nu/2iUKAOxAratNpA8d
         i/0hSmdUzG2qwfvjpYDhI9X+mmilJd/jDlzS+8i6qyMOnsCWexzl7oAhc6tLvC1EFivR
         3Ouw1spEX3YJKf/FBKiR+FgduQYslwM1hJYNkwa3cNQyki4pnZ5h60+Ka76vlIS/6fN+
         APDx/JAd3SqJmKwKkvMgr9bWn/99ENc22JZzLOLkXDuUaq8Z3+l9Y5gvxwlCzKYulkVg
         jOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696946604; x=1697551404;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5v3iUWeLS86EEWRJtn4MLoNjVrwBJIIYZlwA5/5mquQ=;
        b=NgmOL5VGPrmnVhSIEVHR1vjTUXNLJgp8CvhSoLS9sJQ/bYquFcjDy+bUBgA8KCg9gW
         SIZL07pMgm2xDcgMjgAT/dZL+p+mbQTLpS6kkcGkKHpj1xPEnVfu9mIRGsw414LPqJpI
         U4ORHZLo65juTuP17X9chWp34lQJmo1QsBGukfcBOAcQrAceURIe4OW6IVWafqzltuAw
         ctQ5NGVXaj/MfT3kWY7l/dFPRQi09QmSAtXISkSg4MPgpBo8cOOWrW3mC1+ftPHUEfnt
         1BX1BoUbE8RzevcLWibjDjVoWNhoM51f2f6Khr6ok3gZN0tyS/d+6N+fqrgXmvxIFYcc
         ox6w==
X-Gm-Message-State: AOJu0YwPNUuHJ93E/1DqiSkTpftTik+Ay40JnxgThEIV8JDyLHGOo0aE
        mxRd76NtXeW+lOekcFvuGGV1HQ==
X-Google-Smtp-Source: AGHT+IFBHJmIsmYMHiLjK8rWv+ytKnl7Acts7b678jqlM/fC3JYYufO8nyhL6dFCmJo7kHQTfKQC2w==
X-Received: by 2002:a7b:ce98:0:b0:401:bf56:8ba0 with SMTP id q24-20020a7bce98000000b00401bf568ba0mr15650870wmj.28.1696946604306;
        Tue, 10 Oct 2023 07:03:24 -0700 (PDT)
Received: from [192.168.69.115] (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr. [176.172.113.148])
        by smtp.gmail.com with ESMTPSA id c19-20020a7bc853000000b004064288597bsm14267711wml.30.2023.10.10.07.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 07:03:23 -0700 (PDT)
Message-ID: <ad5dce26-2907-f5d9-61d3-9d96af0e1ac2@linaro.org>
Date:   Tue, 10 Oct 2023 16:03:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 15/21] EDAC/octeon-pci: Convert to platform remove
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
 <20231004131254.2673842-16-u.kleine-koenig@pengutronix.de>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231004131254.2673842-16-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
>   drivers/edac/octeon_edac-pci.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

