Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B669E59D631
	for <lists+linux-edac@lfdr.de>; Tue, 23 Aug 2022 11:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242700AbiHWI7x (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Aug 2022 04:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241304AbiHWI7d (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Aug 2022 04:59:33 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E427269D
        for <linux-edac@vger.kernel.org>; Tue, 23 Aug 2022 01:26:54 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id l19so9664207ljg.8
        for <linux-edac@vger.kernel.org>; Tue, 23 Aug 2022 01:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=IS4Gc+TW6Ax9uye5L+Ds92oOy3Kyy05ShRdkS4te/ZY=;
        b=GKZkJ3VMpMNWQ6jlCiB93Ao9kLAkjPR3kJOq9UDspAnH8/JkFK6QNoOPt+iKe5Qoz0
         aE6Q12iy5cmuMmINeCr4d9GkLYNkbd5P04eJ6akCQvccrlghyqVpTZDElJrFBwCQqp4Q
         dXBhjW8IuxGS2TqdTT84VKvOau830OBuTuitUbLo/LfdSWKPlV2WXr8yI526WZr1Y2Fy
         RPM74RWkxzgy3Ufzq0m09hhaqFRJ+cv+avcZlHFnPmTvCfpVwF9I5pQZb9i74bBICgqb
         3AgWLNp+gQNLY/2lpTH/uQbkK0M62PLI946E0/Zxay5bBC8VVLJmr4fwyH/OAKTzImoc
         F4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=IS4Gc+TW6Ax9uye5L+Ds92oOy3Kyy05ShRdkS4te/ZY=;
        b=Qz21vc2qo8FhmNDdgbcB75SCx4ip/tq24S/2GB5sJYlu4wK8WOR+T+b60D1aBoUKR3
         TKUFiRYank+SzHdUKxNS9NghlOXyVORMz3VmLQWMkkCbmmWAd5uhB1gUot8w0R7AF+S/
         JwIMDTyI4UIQ4+Uzy9JrhBHmHBUgArUCBNu0JXjUWXATUMO3WS9/oxFWy/p7uriJSN5t
         6DZwShzQ4i01+B4yDt4MoozqzSn7l5tyBqYd07jqtaengocaothtHRHBQVvfnyTCa+/A
         ryE5Pm2PjCQj4ew+TOmzUbWL88ZFAMIji/Gtmrve9s5wO8JHYmMXBhkX+vgmLb1QWdeL
         cWkQ==
X-Gm-Message-State: ACgBeo0/QY08e2Q7u5v29WV/p7ykGAxugexXR2e0iqX3VqpiaDWeD0sV
        paFtYvgj9cdLG0tp0Talr4hyRw==
X-Google-Smtp-Source: AA6agR7C2k986Ln6dFDCy4ImpK4mVQlexAtn6mm+LIt1nnOi53wB00n4rm8/vHN8ljFafME9dOfKVQ==
X-Received: by 2002:a2e:824e:0:b0:261:bdfd:f9c3 with SMTP id j14-20020a2e824e000000b00261bdfdf9c3mr5001453ljh.347.1661243178039;
        Tue, 23 Aug 2022 01:26:18 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id v20-20020a056512349400b0047f6b4f82d1sm2385866lfr.250.2022.08.23.01.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 01:26:17 -0700 (PDT)
Message-ID: <ab7e2816-8b57-2b25-e2cf-738c1baa5a5e@linaro.org>
Date:   Tue, 23 Aug 2022 11:26:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 16/20] dt-bindings: memory: snps: Detach Zynq DDRC
 controller support
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20220822190730.27277-1-Sergey.Semin@baikalelectronics.ru>
 <20220822190730.27277-17-Sergey.Semin@baikalelectronics.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220822190730.27277-17-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 22/08/2022 22:07, Serge Semin wrote:
> -
> -allOf:
> -  - if:
> -      properties:
> -        compatible:
> -          contains:
> -            enum:
> -              - snps,ddrc-3.80a
> -              - xlnx,zynqmp-ddrc-2.40a
> -    then:
> -      required:
> -        - interrupts
> -    else:
> -      properties:
> -        interrupts: false

This is not a pure "rename"... Organize your patches so only one thing
is done at a time. Rename does not change the functional parts of the
binding...

Best regards,
Krzysztof
