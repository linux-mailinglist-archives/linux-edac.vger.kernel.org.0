Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0B15F5701
	for <lists+linux-edac@lfdr.de>; Wed,  5 Oct 2022 17:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiJEPCI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 Oct 2022 11:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiJEPAv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 5 Oct 2022 11:00:51 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B879C3A4BE
        for <linux-edac@vger.kernel.org>; Wed,  5 Oct 2022 07:59:58 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 25so15666466lft.9
        for <linux-edac@vger.kernel.org>; Wed, 05 Oct 2022 07:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=G1mmsyFzMUXAP8fh3T2rt3ujMCVYnq0YoBck4B5LpSs=;
        b=v7UjYVJUIRX2qmPgDOo8mvJVMBFW8oHZeZyDYsaN4bBQuL7VyR6se4edzaxI5PxRxf
         t/44LVPLsJbD0tV5J1o2W8WPWUVV+2De9Al2ZIOoT7m+ljl7SxUSR1fgzpFd+tvy5Gis
         RwmCSv1uJddtiI9v41bLbcmDEGETZup/fwJYTs2TcQQw7zOfdkCDYe8b2p+P46BGSkil
         kMdKBlBhyaMkTqPlmULIR8MKShOQuIQpfpQFpR7gC85tm+GcLpr+E+X+r0vW1bxsZiG/
         e20VpL4znmZfKDjoH3lTRJLgMwsIAxNIR3svfsTTjAs4cOl1Ynwr0myTufPoGLM8jiuT
         oMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=G1mmsyFzMUXAP8fh3T2rt3ujMCVYnq0YoBck4B5LpSs=;
        b=SQhiNjIN8fXYXSdzJMiLqYRh95l7dOj/3+24RZ9OI9S3+vkY2jUyTT9OQd1yY9TkAL
         Qcrda8dtpZ5Jr4S2r0KQdVEzi7RUGuKp3Etx+oob6CoyDMEnRdfYUorIcqeiQs0BPW28
         /9iZzh68bz0ZukERJPZW9SD6YGKCpkNmpeS09/X26w3J72iun1vpWHudyvzeyA98wi2x
         irrRFeCVxsoh/J9dz6RPrQD80subug0XcX1e6GhXkvSuGRBou0WfLYEcWW0n72pSW3jd
         J2doaxmpNDKSwYSnrX42zyRFlqXY9vHlP/eAKf/1Oy9n0Q9VZYO1gC/HUF02d25oVtN4
         8U2w==
X-Gm-Message-State: ACrzQf1SmsDnpN7jIJ+Tl9O5Ik7VrwLc0U5hyF29i7f66Qn/TzJcexRH
        B4YiNmU+VwU7AV0Pv4ag5wX0uQ==
X-Google-Smtp-Source: AMsMyM7f3bPSYQsaSmkQEyfKuJEANIHcgCA71MwOL6BqYJNiKyQUSUKDpOSH12ikyN62g9N6Lh5CdA==
X-Received: by 2002:a05:6512:2820:b0:4a0:5395:20f0 with SMTP id cf32-20020a056512282000b004a0539520f0mr87966lfb.384.1664981993943;
        Wed, 05 Oct 2022 07:59:53 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u25-20020ac258d9000000b004a26ba3458fsm221776lfo.62.2022.10.05.07.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 07:59:53 -0700 (PDT)
Message-ID: <3ee1bff2-ab11-2dcd-aede-628d2735d6de@linaro.org>
Date:   Wed, 5 Oct 2022 16:59:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 02/13] dt-bindings: memory: Add Baikal-T1 DDRC
 DT-schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        James Morse <james.morse@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Tony Luck <tony.luck@intel.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>, linux-edac@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Robert Richter <rric@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        linux-arm-kernel@lists.infradead.org,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20220929234121.13955-1-Sergey.Semin@baikalelectronics.ru>
 <20220929234121.13955-3-Sergey.Semin@baikalelectronics.ru>
 <166479586876.1658787.6925988592765037866.robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <166479586876.1658787.6925988592765037866.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 03/10/2022 15:24, Rob Herring wrote:
> On Fri, 30 Sep 2022 02:41:10 +0300, Serge Semin wrote:
>> Baikal-T1 DDR controller is based on the DW uMCTL2 DDRC IP-core v2.51a
>> with up to DDR3 protocol capability and 32-bit data bus + 8-bit ECC. There
>> are individual IRQs for each ECC and DFI events. The dedicated scrubber
>> clock source is absent since it's fully synchronous to the core clock.
>> In addition to that the DFI-DDR PHY CSRs can be accessed via a separate
>> registers space.
>>
>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>>
>> ---
>>
>> Changelog v2:
>> - Keep the alphabetically ordered compatible strings list. (@Krzysztof)
>> - Fix grammar nitpicks in the patch log. (@Krzysztof)
>> - Drop the PHY CSR region. (@Rob)
>> - Move the device bindings to the separate DT-schema.
>> ---
>>  .../memory-controllers/baikal,bt1-ddrc.yaml   | 91 +++++++++++++++++++
>>  1 file changed, 91 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/baikal,bt1-ddrc.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> ./Documentation/devicetree/bindings/memory-controllers/baikal,bt1-ddrc.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/memory-controllers/snps,dw-umctl2-common.yaml

This is result of patch #1 failing to apply:

https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20220929234121.13955-2-Sergey.Semin@baikalelectronics.ru/

The bindings look ok, but anyway it is a merge window now.


Best regards,
Krzysztof

