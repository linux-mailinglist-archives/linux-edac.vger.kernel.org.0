Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FB0656897
	for <lists+linux-edac@lfdr.de>; Tue, 27 Dec 2022 09:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiL0I6w (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 27 Dec 2022 03:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiL0I6v (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 27 Dec 2022 03:58:51 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6240464E6
        for <linux-edac@vger.kernel.org>; Tue, 27 Dec 2022 00:58:50 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id x11so13146440ljh.7
        for <linux-edac@vger.kernel.org>; Tue, 27 Dec 2022 00:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tVbUqG301zD6b7p//pgiz+zEzWPjeCB1ediCFosqECs=;
        b=XXcoidDQCJ8fTqk6uHhBL5R5v3MLnaBOQVzvZ8bXpmL87EhGfPJXIyyDJbJSYWhxqi
         vrym3iMDB3O+Sy5JeCAotl4YavoPmsN2U05vFE7auTn1h+oiEcZ7liHYGGmNarit/Tam
         WUxxAe+5nEakJdVTQ3F/qR6rNsBBeB4AxNLdxQl8PaVBzI6d14aGdLDm2f9PwEXATkVq
         ph2WhtHeM/cMSsNzrNV1FBChqrvs6ell/ozq3hGGvyDHx8h2CheqSh8x68E6oeqma2+l
         3JN9Rdc3SfqElnUF6esvC5aEGjfRhP4SqQdLDQlvhEx82vFGE+sMD1BIHMSy/Or5FmQZ
         2zWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tVbUqG301zD6b7p//pgiz+zEzWPjeCB1ediCFosqECs=;
        b=oiou80xTUpkS4cofdF9HaCLTuCEyeSZvOeApoV1XOC7DpgOu2TDW+XNRw3xIfePQtq
         33Z6nTN65WsDzgYa/buRegNngpKmBD8QAn2HfpPNb1975T0kXguf5WqSDt47wLNHCsYy
         YYbxt2mphsS5wD1YpSkfbVVAwAk9Y6c3/JDeh2cDM1Yy6Jp+14P5KbLLQz01vjljnLmf
         smNUIYrXvA1PgnWoWiZ6KJ5eFybr7PozPEsgBqZ1sa33rc2UxNEnayqQ9FLosrtjoQHe
         d0xKRTfGxTLOQScBfMFsrA90QMyJTML/0oN/rf702ESyNpqYZRQiZP4fgHCSk04pKdHI
         NymA==
X-Gm-Message-State: AFqh2kpfVHrlVzQ193AAROhcQGN8gJyN0zaRsVJcMsvOCcQQSTuL9qBf
        bv4O1ISwUapR/O2nvQ6KTLwVng==
X-Google-Smtp-Source: AMrXdXsLYfS30he2m+dSFeYpEYOwW+unDSqPqqOgipENxKRxkT9HFgMWJqaHMMu8i9zqJHka7WES/g==
X-Received: by 2002:a2e:b626:0:b0:27f:ae39:671e with SMTP id s6-20020a2eb626000000b0027fae39671emr4048993ljn.6.1672131528644;
        Tue, 27 Dec 2022 00:58:48 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f1-20020a05651c03c100b0027d75b38fd6sm1562773ljp.43.2022.12.27.00.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 00:58:48 -0800 (PST)
Message-ID: <2a88ee33-91ab-431f-b9ce-472dc64f7430@linaro.org>
Date:   Tue, 27 Dec 2022 09:58:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v17 2/3] dt-bindings: edac: nuvoton: Add document for NPCM
 memory controller
Content-Language: en-US
To:     Marvin Lin <milkfafa@gmail.com>, robh+dt@kernel.org, bp@alien8.de,
        tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, benjaminfair@google.com, yuenn@google.com,
        venture@google.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, ctcchien@nuvoton.com,
        kflin@nuvoton.com, Rob Herring <robh@kernel.org>
References: <20221223032859.3055638-1-milkfafa@gmail.com>
 <20221223032859.3055638-3-milkfafa@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221223032859.3055638-3-milkfafa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 23/12/2022 04:28, Marvin Lin wrote:
> Add dt-bindings document for Nuvoton NPCM memory controller.

Subject: use "memory-controllers" prefix, not edac.



Best regards,
Krzysztof

