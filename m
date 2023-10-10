Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EFC7BFEAB
	for <lists+linux-edac@lfdr.de>; Tue, 10 Oct 2023 16:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjJJODN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Oct 2023 10:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjJJODM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 10 Oct 2023 10:03:12 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EC2A4
        for <linux-edac@vger.kernel.org>; Tue, 10 Oct 2023 07:03:10 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40651a726acso52841025e9.1
        for <linux-edac@vger.kernel.org>; Tue, 10 Oct 2023 07:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696946589; x=1697551389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/pgXd7ZsMTOAhiuI2qf81wCsCg+Gwny6B+Z040D/KI=;
        b=Wl7DZ6w4JyQ+zYFnwC+BXBHwtAcecX5YA1UMM5hSBKlF1pxHntP2IaCGYZS/LQBnnr
         iWKqf9M0JIoovzb9lDQLXsh1+A8LzYcPcd5McL7Vk4TcmNYO8mbAjltycxNe3+Ob+WvL
         mg7Zehpmas1xRcXhnQP853QsxezzUCcJXiNMSeu1ZeOTayc6Cc6G9ZRzA8k50DTGcim6
         oQudcRUXWwpJhfQ1gikFJLbvqnMCTkrXDBohaixtKztPoHKowHIjLBE2pTC5bVqujM4f
         Ieeurym2tMME4Ol9E/3MWquTlx71nVM21AyssJ4UEG+7g4z6c/g1O0qf5AXRbiCNPQ+Y
         B7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696946589; x=1697551389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/pgXd7ZsMTOAhiuI2qf81wCsCg+Gwny6B+Z040D/KI=;
        b=DF3iIHUMTBCwl8nngixMFp+LGpEK3LVLzLkNbLxPuwFiMekSc1Vu3zoJwOrXUrQcGJ
         Naw2YFudHw0aP3AdtxXnOfYzUQ1cceRBQFp3oZwtBKhQXmYnblKffPMr19U7LM0e6DQb
         RxQFuRU8kpbvVTHCvzdFmMJB7UfX7ncf8lcXCjx2yg1xv2/YyY7BvtynR+aAWnVbuuGt
         x36bk14E1Q6MSciZgJHLpd/YhdZWttBxde9OBjAVv8WXDtk6KIGhSWVoZqualRIG36Dq
         G0sx1ueUId96MVHxl80VwYb68zEon7rT0+iXw/vBheurXFXFUg1qtOl9d3oETb6enpOK
         dQOw==
X-Gm-Message-State: AOJu0YwrlnR7uPrTyozER6WIJqrT0BFYNiQwTYdxQz6M9pxVi/3vddNi
        ziotemmx8xlqkRbyE252xOXMOg==
X-Google-Smtp-Source: AGHT+IGOnQu4oBkhgQcrfYg/4RdEWJ3VnbFld3vcuxY0JFts5H6ytu0EGxtO+Phop9yRR9YlWWNuqQ==
X-Received: by 2002:a1c:7209:0:b0:405:a30:151e with SMTP id n9-20020a1c7209000000b004050a30151emr16973638wmc.12.1696946588281;
        Tue, 10 Oct 2023 07:03:08 -0700 (PDT)
Received: from [192.168.69.115] (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr. [176.172.113.148])
        by smtp.gmail.com with ESMTPSA id c11-20020a7bc84b000000b0040648217f4fsm16565858wml.39.2023.10.10.07.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 07:03:07 -0700 (PDT)
Message-ID: <ad1600d3-626c-ff5e-caea-1363cab71f9d@linaro.org>
Date:   Tue, 10 Oct 2023 16:03:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 14/21] EDAC/octeon-pc: Convert to platform remove callback
 returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-mips@vger.kernel.org, kernel@pengutronix.de
References: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
 <20231004131254.2673842-15-u.kleine-koenig@pengutronix.de>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231004131254.2673842-15-u.kleine-koenig@pengutronix.de>
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
>   drivers/edac/octeon_edac-pc.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

