Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E037BFEA8
	for <lists+linux-edac@lfdr.de>; Tue, 10 Oct 2023 16:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjJJOC4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Oct 2023 10:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjJJOCz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 10 Oct 2023 10:02:55 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BB7A4
        for <linux-edac@vger.kernel.org>; Tue, 10 Oct 2023 07:02:53 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40651a726acso52837255e9.1
        for <linux-edac@vger.kernel.org>; Tue, 10 Oct 2023 07:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696946572; x=1697551372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8nfDNCtMcEPuI4DO7wfn0711gh7d8cHHJ+9EAn1Xevw=;
        b=P1hoExbnXD7XqB22VHfvsD/m+i2O2l6wCv/C17BF0pva9UxYAQaFGCizlVGY5Sr2mc
         Y5lfuJeV1CVSTt9IYcu/iLpzbUzLASw1bt/hhfNXjGHzbEWm5Y63v3fClLyIrSWLmHJr
         P9mcwTvRRZa8q5VUJSku9RDOLDHHjNt6JbvnkLaVJz+/5J3W3e6CoojTSGgmMidX/RAZ
         E+31xQMgBBR6fNE65ZI7VyEXzx58TFtIfQ+UyE9J+1W2dGxIfmCDQ5z+fSNXRwztuT3B
         xWoSoaVle4e3ZfKQ7BlO+QuxsSsBaoX+BD8Ixw/gfoPjc1CoRHvTxDz5gQuL3qByDHNW
         7rEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696946572; x=1697551372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8nfDNCtMcEPuI4DO7wfn0711gh7d8cHHJ+9EAn1Xevw=;
        b=NDYCTSq+qy+EMwiWuTQsj8vQxTeauahz6zR5dCTssiJGKiyocz7LU0DBZQrWcklAKc
         jOyzDj2JtjvgoYQ/nli+AOHW0qCF1Ico88UEt7nWo0NEieOrYCFehAQ90MUg21obWCLn
         RQvUan3OJ1RAv01KJ0NE6Qx09Z6aoMvrjFG07z6SAEXX4sgwwVka597hT4kbi2U5xceY
         t1UxtHLrSfKYmPBhW9dEhRr39b/9DuRXpBevxHsVApTTHlWi1PjQ1h1KBaGQISQgfcSa
         QL2LaJgEjaJ1Agfkr/4rKjplToO4MWnMFu0Nsvk4TIG93ScRCNPYmBrIhJNo0LrWrsIE
         m0Ag==
X-Gm-Message-State: AOJu0YwFD2jXjLqITEi3stTt3TtRZjKw/I+PM8lwJAthdMkZc9ozw38R
        H/9OSxpCBOXE6Mohmd/Lh5+CRg==
X-Google-Smtp-Source: AGHT+IHWxyt/1W1tRrDF1CtE5KlbqalqgsPVsrNOykm+j7UtsSYfbxIclsR6wQS9Bns886X6Oz60zg==
X-Received: by 2002:a05:600c:2044:b0:402:e68f:8896 with SMTP id p4-20020a05600c204400b00402e68f8896mr16373209wmg.0.1696946571416;
        Tue, 10 Oct 2023 07:02:51 -0700 (PDT)
Received: from [192.168.69.115] (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr. [176.172.113.148])
        by smtp.gmail.com with ESMTPSA id u7-20020a7bc047000000b004063cced50bsm14302912wmc.23.2023.10.10.07.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 07:02:51 -0700 (PDT)
Message-ID: <9ef5dbf2-c103-608c-9e57-98eaa36aa894@linaro.org>
Date:   Tue, 10 Oct 2023 16:02:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 13/21] EDAC/octeon-lmc: Convert to platform remove
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
 <20231004131254.2673842-14-u.kleine-koenig@pengutronix.de>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231004131254.2673842-14-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
>   drivers/edac/octeon_edac-lmc.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

