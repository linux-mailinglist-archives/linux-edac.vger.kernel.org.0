Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DA15E4F82
	for <lists+linux-edac@lfdr.de>; Wed, 21 Sep 2022 20:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiIUSfn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 21 Sep 2022 14:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiIUSfm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 21 Sep 2022 14:35:42 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B322AA0243
        for <linux-edac@vger.kernel.org>; Wed, 21 Sep 2022 11:35:39 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s10so8092386ljp.5
        for <linux-edac@vger.kernel.org>; Wed, 21 Sep 2022 11:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=sl/UAQvblHTUcGIJZx+VtfArS6MnYEKjEIDfe07T4DQ=;
        b=ldrsdXh5RNIpCF8ZwynjhTEAlX+J8P2Qllor4Peb0rLlBNZqGez3/nOkb6N3oEsTzL
         LhNelt9tdD+lqwFArr4KpOAKKstKRH3fiovSu1QHwLQWfFYqnzfSaVC9wkTKmChDVlWf
         qca1T/ajuirgU6cUXlJUHRvs3k0DvcHNQIP7yDJV8qU0M6/Ztq4zrWgACGLAmkPASxJQ
         LlwPgsyHLqQUBBPwC/VjqI2SsHbHqBZr3IZDhLYh7Lddh8kQgkuVm7/tVlk/XyI4Syl/
         dOcA5bwtsFTJX9B09NaGxMZ/o0wGU+qeyAdk5Ucxjp/dJdnxrryXK1CrvEGS5INjJRd3
         8cfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sl/UAQvblHTUcGIJZx+VtfArS6MnYEKjEIDfe07T4DQ=;
        b=0hK6iZmlIuIY1iJ0pW8toHBi9B4LHOFtGCZE3PXR7qNoQ+4RbB9/A5gurfycwQADXT
         HSy2TL2sW/e9eQIFEVIc/AK8Bf0Fk5GBVpcKF7M0Atdzw0mVQ/Wf06GlasBL5aJ/gYgQ
         EAzGpv1W6KKJV2nM+Y+YUTxRNscKHfiOQE1IrRa4QswjpB2fhOtNMpZXJLBN+fqk5+gn
         hHk0gqqxkrKeP8QhpQGc8GiZDYx0CZOuUVeN2AwypAK3nVpD2gFrRMfka1iP2+zNrRX6
         aQYBtNkI+kafwrVOgxHKrQQFBa59c5L+fs2Xsdax0DBm/pEsC5pP2ZLCiOyRUQep7quS
         IQbw==
X-Gm-Message-State: ACrzQf2KHOs6HyH4CTU7t0p516STcSIYQhVykr+U+XgiKWnyr7c6O2jh
        Y7+cwoJFxqdfrpO+Zbh8ia1n4Q==
X-Google-Smtp-Source: AMsMyM5lF3Zf2ZgXyM3mti18utpdWM4cFPtDQdb03D4wOXkij5UKrFHebcer8RpZKk2BMRGQryO3MA==
X-Received: by 2002:a2e:bf29:0:b0:25f:fbd5:b693 with SMTP id c41-20020a2ebf29000000b0025ffbd5b693mr9924325ljr.372.1663785338008;
        Wed, 21 Sep 2022 11:35:38 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id i1-20020a2e2201000000b0026c0158b87csm549538lji.29.2022.09.21.11.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 11:35:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     robh+dt@kernel.org, Tony Luck <tony.luck@intel.com>,
        krzysztof.kozlowski+dt@linaro.org, manish.narani@xilinx.com,
        mchehab@kernel.org, michal.simek@xilinx.com,
        Sergey.Semin@baikalelectronics.ru, bp@alien8.de
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        rric@kernel.org, linux-kernel@vger.kernel.org, krzk@kernel.org,
        linux-edac@vger.kernel.org, Michail.Ivanov@baikalelectronics.ru,
        dinguyen@kernel.org, punnaiah.choudary.kalluri@xilinx.com,
        linux-arm-kernel@lists.infradead.org,
        Pavel.Parkhomenko@baikalelectronics.ru, robh@kernel.org,
        james.morse@arm.com, Alexey.Malahov@baikalelectronics.ru,
        devicetree@vger.kernel.org, fancer.lancer@gmail.com
Subject: Re: (subset) [PATCH v2 01/15] dt-bindings: memory: snps: Replace opencoded numbers with macros
Date:   Wed, 21 Sep 2022 20:35:34 +0200
Message-Id: <166378533309.18832.18013091660120902732.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220910195659.11843-2-Sergey.Semin@baikalelectronics.ru>
References: <20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru> <20220910195659.11843-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, 10 Sep 2022 22:56:45 +0300, Serge Semin wrote:
> Xilinx ZynqMP DDRC-based example contains the opencoded numerical literals
> in the IRQ lines definition. It doesn't seem justified since the
> corresponding platform has well defined ARM GIC interface. Let's replace
> the numbers with the corresponding macros then.
> 
> 

Applied, thanks!

[01/15] dt-bindings: memory: snps: Replace opencoded numbers with macros
        https://git.kernel.org/krzk/linux-mem-ctrl/c/fc436e55a1abdac503e5b06ef57862a1bc944275

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
