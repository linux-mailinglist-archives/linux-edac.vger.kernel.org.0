Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5B672C549
	for <lists+linux-edac@lfdr.de>; Mon, 12 Jun 2023 15:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbjFLNA0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Jun 2023 09:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjFLNA0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Jun 2023 09:00:26 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018E9E4C
        for <linux-edac@vger.kernel.org>; Mon, 12 Jun 2023 06:00:25 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-977d0ee1736so624525966b.0
        for <linux-edac@vger.kernel.org>; Mon, 12 Jun 2023 06:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686574823; x=1689166823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wo+1PodCdHHB0tD1Y4UaF7/JGvZd1Adl0KqOZuyCrYQ=;
        b=hmGzaL/1fj4DxM7vQM6aLIC7mcImR1hXuEfn+ACYbTVsZKQzCpzR8zD6hhLAxosEhA
         RaWLvToMqnRT3rIITCOEJwEz1S1SIlRt6ykOhDCQ0bMTeQzKTIZbmX7cHf4/0k1vzo81
         72zCI1PWJRlbabQkCA9TJRsdQIKyjYaaT4BBmX5HpHxJheD4jxtEOenAg1lv+O1AnmKL
         eou1Cs5EwqNGjVQpMjmJfGB75ZFsP4ZUw6mZL4XaB8pvV9OWsl6rnK+qtJNEbYtWhSgD
         eBZxi5FhD0caIzAnWiCUcD4yBP1Y3PVf8Et2l1L3JhVVyKhls+1r7x7r3Vh8HvZw2Xre
         +pLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574823; x=1689166823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wo+1PodCdHHB0tD1Y4UaF7/JGvZd1Adl0KqOZuyCrYQ=;
        b=HIP/xyKnFnYT4GhiwVNrnE9barhccJaJzwxXn9fR2BicLxZrgEOv44Ovz16o5pvXal
         nvP65GHPmd3mrekZYdQTipgbLdFejTV27J2Wx7zxmQVn3T+VbqdIJggKGQEul4JqhfyR
         WwHhetpKua149ZA8vkdOZ8b5Wa4/tt6P+kAi1b3sK0IHIsyPNw2LvV7yMfEOmErgvYeM
         spgLsXtVy7arogacoSqlro0tmMFCGO51zfB+841N2BhryKycZvFqGhSdytEU8PaZGFHf
         zQTymZ12GhF2WERAgvCJojecmAPu+lSxhc//BS5ye1z3ZltuQT1oIcL32XcMan+XpHeG
         J5Og==
X-Gm-Message-State: AC+VfDyjj4+tyr3c9KnlB69QOTISvWqrOl6Oi0XKDuLOH9v+iBvIQ0qR
        LYQy6Js/hkHaYPZUpPnYGp8JyQ==
X-Google-Smtp-Source: ACHHUZ6jYurA4SzJZWnpU4r2a9vrK80Vq4jKofL3dpTyho0SzI6ysux5e/lKnYhD8iQ8gZrCaJ4czg==
X-Received: by 2002:a17:907:96ab:b0:96f:f98c:ac71 with SMTP id hd43-20020a17090796ab00b0096ff98cac71mr8490655ejc.67.1686574823483;
        Mon, 12 Jun 2023 06:00:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id n24-20020a170906379800b0096a6bf89259sm5168854ejc.167.2023.06.12.06.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 06:00:22 -0700 (PDT)
Message-ID: <e0171cb6-54e7-41bd-4b08-fa667fe58ff4@linaro.org>
Date:   Mon, 12 Jun 2023 15:00:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v18 1/3] ARM: dts: nuvoton: Add node for NPCM memory
 controller
To:     Borislav Petkov <bp@alien8.de>
Cc:     Marvin Lin <milkfafa@gmail.com>, robh+dt@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, benjaminfair@google.com, yuenn@google.com,
        venture@google.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, KWLIU@nuvoton.com, YSCHU@nuvoton.com,
        ctcchien@nuvoton.com, kflin@nuvoton.com
References: <20230111093245.318745-1-milkfafa@gmail.com>
 <20230111093245.318745-2-milkfafa@gmail.com>
 <20230612110401.GPZIb7oZPdsPGFzSDc@fat_crate.local>
 <38c30778-9526-cba6-4ddb-00bcefeb5647@linaro.org>
 <20230612120107.GFZIcJA3zktkiyTS2+@fat_crate.local>
 <99795947-0584-df42-a28a-aa89d7e21c7e@linaro.org>
 <20230612123925.GGZIcR/dUrcu03z6V+@fat_crate.local>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230612123925.GGZIcR/dUrcu03z6V+@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 12/06/2023 14:39, Borislav Petkov wrote:
> On Mon, Jun 12, 2023 at 02:09:33PM +0200, Krzysztof Kozlowski wrote:
>> Please route the DTS (1/3) via Nuvoton SoC tree.
> 
> Don't all three need to go together?

No, the DTS is always independent because it describes the hardware.
Linux should work fine regardless of hardware description. Tying Linux
to specific DTS is usually sign of an ABI break.

Best regards,
Krzysztof

