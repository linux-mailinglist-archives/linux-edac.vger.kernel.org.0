Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B2F623E4E
	for <lists+linux-edac@lfdr.de>; Thu, 10 Nov 2022 10:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiKJJLE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Nov 2022 04:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiKJJLD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Nov 2022 04:11:03 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4038710B73
        for <linux-edac@vger.kernel.org>; Thu, 10 Nov 2022 01:11:02 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id z24so714769ljn.4
        for <linux-edac@vger.kernel.org>; Thu, 10 Nov 2022 01:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TyiGZEVWf0yEmJpOUu/TQoYQ5IgN+baA9Fut+Wev4A=;
        b=wQab/wOr4XpExF9P8sjOKer2pU5imYc+Q4yC3i9/H+hqt9Da53ljUonrNuz/LIwiT1
         xI2BXNkxcdyxSZwkxaaso4v6klBxSqKgYFfWlhfC1O8F8hacIpgnYbbpfeMTq+gMTjVh
         8K24xUq05gkaFcHS+J+Irshz6eQ7im34sULYQIrvyEcuQ5CjLgCV0KetwEaIL+YS6LX9
         7LqWQy9PyszO585bAL267oTrkAMiGl7RjL1uxNThdlbfRisMfqQ6SwOQ7A4yN8MTiYTB
         vo/l2Os3cXHTVKT5doFORKT0uwuX1S3fbOwHf+oVZUrhclz6D2n5aGq30NUDIA527Wic
         TNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TyiGZEVWf0yEmJpOUu/TQoYQ5IgN+baA9Fut+Wev4A=;
        b=VU413974NBXDpQMMFV5YBkf8LjrP9Fz5Wv2YV/wsUcytSX692YlXcd6Hp1T913n/Cv
         dJ9MAbTVnteJMdLygVuRuiHgJ0tzEFb4qljXLzOlhuPFsHLbStGDJxYW3cQTBV0LsJzr
         6Q2UOxYtyyQy7MfG+6tTfaXZ7PXW0jZ3FYgEqLc11CzdB5mNpCC3lTm2Wmwx4/hNrz8b
         ArSmQ5oLnRzxHHtNRSgKJQt/b5VMLc2CyWoYJ6cmbh38SttU8tvJp7NdnfJiXiY8dKDk
         ztBW7pMqDaT8rbQYliMzzWCZGgad+2uaivUkCaGIx2ALTRkD7BZbOGy/oM2ZVAJuqnNw
         LX8A==
X-Gm-Message-State: ACrzQf31qAkKCQFW115mQAtKvSvQL2bFuFoT4TESqBKwtuOR0ShO+rQa
        KKETScKNS2ynHDcsEGXXRQkMIRNipEi2UQ==
X-Google-Smtp-Source: AMsMyM4ZsUaP8G4gP32y6A2vfosoDS6jJRGdaLbEenyn6ojqn5cy6wbGQXfzrZmkTC9AZcgoc6R7/A==
X-Received: by 2002:a2e:a314:0:b0:277:c53:4c45 with SMTP id l20-20020a2ea314000000b002770c534c45mr8879775lje.132.1668071460419;
        Thu, 10 Nov 2022 01:11:00 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id c10-20020a056512324a00b004afc1607130sm2658713lfr.8.2022.11.10.01.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 01:10:59 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-edac@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, tony.luck@intel.com,
        mchehab@kernel.org, michal.simek@xilinx.com, git@amd.com,
        bp@alien8.de, robh+dt@kernel.org, james.morse@arm.com,
        rric@kernel.org
Subject: Re: (subset) [PATCH v2 1/2] dt-bindings: edac: Add bindings for Xilinx Versal EDAC for DDRMC
Date:   Thu, 10 Nov 2022 10:10:56 +0100
Message-Id: <166807145377.16822.15787804198836912482.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221107062413.9642-2-shubhrajyoti.datta@amd.com>
References: <20221107062413.9642-1-shubhrajyoti.datta@amd.com> <20221107062413.9642-2-shubhrajyoti.datta@amd.com>
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

On Mon, 7 Nov 2022 11:54:12 +0530, Shubhrajyoti Datta wrote:
> Add device tree bindings for Xilinx Versal EDAC for DDR
> controller.
> 
> 

Applied, thanks!

[1/2] dt-bindings: edac: Add bindings for Xilinx Versal EDAC for DDRMC
      https://git.kernel.org/krzk/linux-mem-ctrl/c/9342498ca3a499faa2152216ecd644b0888f98d7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
