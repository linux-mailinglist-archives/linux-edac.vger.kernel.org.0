Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EEA5E4F79
	for <lists+linux-edac@lfdr.de>; Wed, 21 Sep 2022 20:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiIUScr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 21 Sep 2022 14:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiIUScq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 21 Sep 2022 14:32:46 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE6BA032C
        for <linux-edac@vger.kernel.org>; Wed, 21 Sep 2022 11:32:45 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a10so8153278ljq.0
        for <linux-edac@vger.kernel.org>; Wed, 21 Sep 2022 11:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=PIbYqagocLr0JKvexJeJL9Pv8lY5vMffUkinntd0Efo=;
        b=B10kgJHoN1FgYW5aU84UdQursAqxvXWtQjQF22EcfoBEyt5abdLfOZyt3E8NmFxKJW
         W9oYTmRbruG+LsTX4Be31niZL480TqHVJjMo/gX/fccRI6jy5OPpqhcuSEwHBH093ob7
         2A9WqhKWqjwTBl+ZpGi5EYfrC2dNV9eE0DMBMxwpXsKS1PIhipnqcJSDETRINHp6nDMv
         VBv+ShwOzvDEBrr8PuKnv0XNoAmU04l63cxj4O+aA0ZftwHhrYtr2ywUFSfcdD5T3jd/
         nxU4BSI7zSLdjVRCL1TnJVidvGSTWwvOdQDeTs8DTuskFQ4vRc+0D4pTi6m/pmA4Z633
         hoag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PIbYqagocLr0JKvexJeJL9Pv8lY5vMffUkinntd0Efo=;
        b=UeLf2G36EHsiAos9G9nZ4wo2BrzMlSHPkuRtVfa9cNDMJAjukfmnsSF+GBWIBfJfMG
         rPbhrVoqRo9MzntHGKzFWWBPqiBrwKtSotHedYUu1DVKY/0yUJx+Tnma17w3ZW//725j
         qx62nuMhUkEQy8x+KOApUrS9bu8ogZu0uTR2ygvDQkg1gQzalJoY9pXxprcDkFSK1DIw
         jpVmSTBpVTbAuDYXi38aVJpFo5LBk8hrIwOYHcn9AsKzmsCDUu/+AYxZAmg1rwluntCS
         68YB9sd40tZZjMJAWuiknDckKCrJRsDrIkqI9qo0nhsG1YQ3zI59GI/+73LBNVmGPmPT
         RYUA==
X-Gm-Message-State: ACrzQf3tddD/W9hUKnmrva/MvHozRiODXyukH9dLv9Fp93V6TwPGBe+R
        M3BXJez4sxsgTCIXC1Y5rHI9YQ==
X-Google-Smtp-Source: AMsMyM5NTFNxFTeW8aRNkoNs0p2tlJOmwBvUiOfeieErm7jtBzfacE2xRykmpsHIYjiwTntcsI7ueg==
X-Received: by 2002:a2e:a5c6:0:b0:25e:223f:a417 with SMTP id n6-20020a2ea5c6000000b0025e223fa417mr10236283ljp.236.1663785163358;
        Wed, 21 Sep 2022 11:32:43 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j12-20020a056512344c00b00494a1b242dasm551602lfr.14.2022.09.21.11.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 11:32:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     mchehab@kernel.org, robh+dt@kernel.org, michal.simek@xilinx.com,
        Tony Luck <tony.luck@intel.com>,
        Sergey.Semin@baikalelectronics.ru, manish.narani@xilinx.com,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        punnaiah.choudary.kalluri@xilinx.com, krzk@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        rric@kernel.org, james.morse@arm.com,
        Alexey.Malahov@baikalelectronics.ru, dinguyen@kernel.org,
        robh@kernel.org, Michail.Ivanov@baikalelectronics.ru,
        devicetree@vger.kernel.org, Pavel.Parkhomenko@baikalelectronics.ru,
        fancer.lancer@gmail.com
Subject: Re: (subset) [PATCH v2 15/19] dt-bindings: memory: snps: Use more descriptive device name
Date:   Wed, 21 Sep 2022 20:32:37 +0200
Message-Id: <166378514628.18111.374088108487662306.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220910194237.10142-16-Sergey.Semin@baikalelectronics.ru>
References: <20220910194237.10142-1-Sergey.Semin@baikalelectronics.ru> <20220910194237.10142-16-Sergey.Semin@baikalelectronics.ru>
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

On Sat, 10 Sep 2022 22:42:33 +0300, Serge Semin wrote:
> The DT-schema name and the corresponding generic compatible string look
> inappropriate in the current DW uMCTL2 DDRC DT-bindings:
> 1. DT-schema name contains undefined vendor-prefix. It's supposed to be
> "snps", not "synopsys".
> 2. DT-schema name has "ecc" suffix. That is a device property, and has
> nothing to do with the controller actual name.
> 3. The controller name is different. It's DW uMCTL2 DDRC. Just DDRC
> doesn't identify the IP-core in subject.
> 4. There is no much point in using the IP-core version in the device name
> since it can be retrieved from the corresponding device CSR. Moreover the
> DW uMCTL2 DDRC driver doesn't differentiate the IP-core version at the
> current state.
> 
> [...]

Applied, thanks!

[15/19] dt-bindings: memory: snps: Use more descriptive device name
        https://git.kernel.org/krzk/linux-mem-ctrl/c/9f60675a0f2e72f7967cc534f1c97f6da3b47392

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
