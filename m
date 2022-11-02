Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566C9616DD7
	for <lists+linux-edac@lfdr.de>; Wed,  2 Nov 2022 20:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiKBTbs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Nov 2022 15:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiKBTbr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 2 Nov 2022 15:31:47 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894E1C18
        for <linux-edac@vger.kernel.org>; Wed,  2 Nov 2022 12:31:46 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id h21so7004744qtu.2
        for <linux-edac@vger.kernel.org>; Wed, 02 Nov 2022 12:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p0AELgS4t8UtXBBZgsDFgqP0jEWoHaAvuWjU6NHb6SQ=;
        b=Iakb+OUj9IoilnGvfeNtzEsL01KAarcp13cLMMRklCOMDpUZqiV5lhRzKtuL4rhArf
         i86demCzggw4H1Y2OzwMK4JhIzr4OErllpHp3t0O9k47rbLa0WfnYA770SYQ1WcN9zHM
         AN4RhKtqNB7cdTuT5iqbc11WObd2zQtQRWByyVcyIJn2lAqerE2GLV2QDKgbGd9fEvi0
         ptEVDjLcIFX3YUZd9zcDARKXOnd8Q8CI+qy35CXOeYqSvEQF/jVVCeAxHQTcVzSimtyN
         2tfylbIGALreo1vIg86tFpNtO2ZF922+jvMI0N62YJdpViBKvHdRCPu4BQ+FTXK2Ij36
         +iBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p0AELgS4t8UtXBBZgsDFgqP0jEWoHaAvuWjU6NHb6SQ=;
        b=aNfFEa1wGA/iB/MRoTFvSWnj/c5wezoty/MHDlKxEyQrOn2YRNM1rlUoOucOTRkSTx
         +8mg3JIfUO61fQAyr+2H/VFMw6nruIXjfZ41qUDeeTA+gYTq4AKyskjmNudhbJBQsXAy
         FMAVG/vd6f0v9/QiTO0wI5dvFB9dCXSYcho/Hc4AEFXs+Rgbc9gyG/dFF6Pnd4AqjJwV
         /qzkDiASs5v5ZK8rB+ggBHRNDsyAtj23Uf4BBp/n045HVc5dgPB8KCwpiI4LWxouZYTW
         Q294sHEisZSphyCLYtOdn7u1c1uIlQ13ppPy+ivhyLDot7RFQuZtZOIDD04X+Xip4gMD
         oqsA==
X-Gm-Message-State: ACrzQf38ov2BSyaSDSBNyDSpQA5TbSTUO70dw8HBuVI8/PHZ0Vtxw91V
        DQjZiBxCuXHN0TIjGRLw42al8w==
X-Google-Smtp-Source: AMsMyM7z7rNWIYSPNcicrFJh2jxX77Z71tEvf2c8Chs+n6Cl1yTZ2zCa80YAN1l/iW4cVHjm6qBoaw==
X-Received: by 2002:ac8:4c9a:0:b0:3a5:30b5:ff7c with SMTP id j26-20020ac84c9a000000b003a530b5ff7cmr11768311qtv.10.1667417505672;
        Wed, 02 Nov 2022 12:31:45 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id c5-20020ac80545000000b00399d5d564b7sm6962288qth.56.2022.11.02.12.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 12:31:45 -0700 (PDT)
Message-ID: <7aa2b5f4-c033-89e6-c6a3-f5fcf8c36afa@linaro.org>
Date:   Wed, 2 Nov 2022 15:31:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 2/2] edac: xilinx: Added EDAC support for Xilinx DDR
 controller
Content-Language: en-US
To:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        linux-edac@vger.kernel.org
Cc:     git@amd.com, devicetree@vger.kernel.org, michal.simek@xilinx.com,
        rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org
References: <20221102084608.28894-1-shubhrajyoti.datta@amd.com>
 <20221102084608.28894-3-shubhrajyoti.datta@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221102084608.28894-3-shubhrajyoti.datta@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 02/11/2022 04:46, Shubhrajyoti Datta wrote:
> This patch adds EDAC support for Xilinx DDR Controller, this driver

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> reports Correctable and Uncorrectable errors , and also creates

No spaces before comma.

> debugfs entries for error injection.
> 
> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---
> 
>  MAINTAINERS                      |    7 +
>  drivers/edac/Kconfig             |   11 +
>  drivers/edac/Makefile            |    1 +
>  drivers/edac/xilinx_ddrmc_edac.c | 1250 ++++++++++++++++++++++++++++++
>  4 files changed, 1269 insertions(+)
>  create mode 100644 drivers/edac/xilinx_ddrmc_edac.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cf0f18502372..cfeece1d75c5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22631,6 +22631,13 @@ S:	Maintained
>  F:	drivers/soc/xilinx/xlnx_event_manager.c
>  F:	include/linux/firmware/xlnx-event-manager.h
>  
> +XILINX VERSAL DDRMC EDAC DRIVER
> +M:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> +M:	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml
> +F:	drivers/edac/xilinx_ddrmc_edac.c
> +


Best regards,
Krzysztof

