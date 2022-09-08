Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA605B2868
	for <lists+linux-edac@lfdr.de>; Thu,  8 Sep 2022 23:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiIHVVG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Sep 2022 17:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiIHVVF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 8 Sep 2022 17:21:05 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749CF11213B;
        Thu,  8 Sep 2022 14:21:04 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id h9-20020a9d5549000000b0063727299bb4so13177990oti.9;
        Thu, 08 Sep 2022 14:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zea8L6rlBHmXjAO+IElkhMFv5+qcblpRlt1yqi1Hz0U=;
        b=4zDPevAUW3GRsvzuLUD3iu2qY+9k+VfowBnMCdRm0Lrgp4fJOZlkjSnn39TgyDSnR6
         Vt8KGoHC6rVmyarmTyGxgnN9imP1cbXnKvaORUFmjASvAitG87v4BaWO9kwTbZc7HObh
         OIajBmHwnQvGdXvVdqqt1OTvDogy4xxry0gSfDASHJpcC86sNTnIuiHttKxIpWXqu98T
         Qjt2SWdAAuTun8uQRTLWO56ou02P0PKXbWAI5rPsuZfAewrU2YiG0y4aTywP+JCC9DzK
         TfRAv2bmhVk7r3E3LAIMghc5FiVu0CzKGuJGkZqBR4SVEhXC+2qfgNMoDd8BIkDjLyP0
         Styg==
X-Gm-Message-State: ACgBeo0tqnt4W57Z9Fykwg5BZTyoFO64qhw3Xts3uWxfRzKv6rdA4PdW
        +jialWJdN9rlQ95NWzgL6Q==
X-Google-Smtp-Source: AA6agR5StZwfeiKTGdEH+EZTRuW8u9tMou5fKVcswY8/NCIuh8yV79DfPdq/ejC4rQ/JKpgyWfYUUQ==
X-Received: by 2002:a05:6830:1d4:b0:636:e44a:a5e2 with SMTP id r20-20020a05683001d400b00636e44aa5e2mr4097741ota.33.1662672063637;
        Thu, 08 Sep 2022 14:21:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o186-20020aca41c3000000b00344afa2b08bsm7962371oia.26.2022.09.08.14.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 14:21:03 -0700 (PDT)
Received: (nullmailer pid 3361921 invoked by uid 1000);
        Thu, 08 Sep 2022 21:21:02 -0000
Date:   Thu, 8 Sep 2022 16:21:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     linux-riscv@lists.infradead.org, conor.dooley@microchip.com,
        palmer@dabbelt.com, krzysztof.kozlowski+dt@linaro.org,
        greentime.hu@sifive.com, robh+dt@kernel.org,
        linux-edac@vger.kernel.org, paul.walmsley@sifive.com,
        ben.dooks@sifive.com, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, bp@alien8.de, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: sifive-ccache: change Sifive L2
 cache to Composable cache
Message-ID: <20220908212102.GA3361862-robh@kernel.org>
References: <20220905083125.29426-1-zong.li@sifive.com>
 <20220905083125.29426-2-zong.li@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905083125.29426-2-zong.li@sifive.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, 05 Sep 2022 08:31:20 +0000, Zong Li wrote:
> Since composable cache may be L3 cache if private L2 cache exists, we
> should use its original name Composable cache to prevent confusion.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Suggested-by: Conor Dooley <conor.dooley@microchip.com>
> Suggested-by: Ben Dooks <ben.dooks@sifive.com>
> ---
>  ...five-l2-cache.yaml => sifive,ccache0.yaml} | 28 +++++++++++++++----
>  1 file changed, 23 insertions(+), 5 deletions(-)
>  rename Documentation/devicetree/bindings/riscv/{sifive-l2-cache.yaml => sifive,ccache0.yaml} (83%)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
