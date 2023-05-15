Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1DA702447
	for <lists+linux-edac@lfdr.de>; Mon, 15 May 2023 08:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbjEOGQz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 May 2023 02:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjEOGQz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 May 2023 02:16:55 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2199EE54
        for <linux-edac@vger.kernel.org>; Sun, 14 May 2023 23:16:53 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50be0d835aaso21815102a12.3
        for <linux-edac@vger.kernel.org>; Sun, 14 May 2023 23:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684131411; x=1686723411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mZ5kJ511V5u6WUmG5YfaTjlPGFBPqbatIvhaf5zTdqs=;
        b=VuyeuFRJI64MXgzuJK1WDorl7u6mnSd6M0HJ8lg0XzMeni30ZjRRIw840m8FQKcmwh
         DdyFDmREcChDzoRD/tnwuOCdoiUOmbtJ2QLt2gl9ULqaFfhxbOYBCKjfgmVIhHUTi4Gc
         56SWn2+g2FFqRUlbljxL9h8a+ZGmPfmcZzrO+7BdBnGJT4I36hkeweFJi3r7Btpxibm7
         +3YLuMjS+vuZZa8F9e9yrAAyH8A/dc/0N8o9OBn2nV4F9lM8O8csLU43f4SJBvkiJ6Jp
         lWcUVoUQDB65nZ1ZWuTk4bWYt59CiZDlkg40SsJYvkK5ZXhYFEVo82CRzez4u3dA6d4R
         ZQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684131411; x=1686723411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZ5kJ511V5u6WUmG5YfaTjlPGFBPqbatIvhaf5zTdqs=;
        b=i7ZbiLN/4M0JH4tZuH7KHytZzVGQsqS1Ab8DqG4+3aQJpteW1KDqzIVxW24ecd0RP5
         M993fEMLbCRC6GNI3l0KKO9iH4hF9PFvKzJxVCUiwC83UHRm9IFyKQ3GexZDfgLlCfob
         qG9kvITplfNHoCr/cYSmPtfnjIPAwiOGFDKPPnNG2oAeyuHe36vrBKma63o8GZ71au02
         ZpQA4I0KQ5zPv7TftGhrf68NgeDALF2rsbs35VFe72CtMT0Q13/sMhuPDVm+iEqhSEX+
         T9FjHVc9kX1ud6EzUp8OmMvFHA4vAbPU57rqJ4DS4X225Tyq7dbGnV+FYk8yc8GlGJOT
         ST6A==
X-Gm-Message-State: AC+VfDylVmXz3Nwdq40/Oe38cCRJvQzH4Xtc7hBVZhEp4llXKj5bA/sQ
        18vbg+9kgSAzCjMNfMvYgubSWA==
X-Google-Smtp-Source: ACHHUZ43MvCNly+ACjj3Ax0quy88zzu2VF57GZ6fBNDMqBAYJgfySRCBsmHbOLilHbum7IvU4GddGA==
X-Received: by 2002:a17:906:eeca:b0:965:d17b:292 with SMTP id wu10-20020a170906eeca00b00965d17b0292mr27943156ejb.60.1684131411544;
        Sun, 14 May 2023 23:16:51 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6470:25b8:7c2d:1992? ([2a02:810d:15c0:828:6470:25b8:7c2d:1992])
        by smtp.gmail.com with ESMTPSA id j11-20020a1709062a0b00b0094e62aa8bcesm9042798eje.29.2023.05.14.23.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 May 2023 23:16:51 -0700 (PDT)
Message-ID: <7b890572-c6a4-425c-4583-1c56f382acb8@linaro.org>
Date:   Mon, 15 May 2023 08:16:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND PATCH v6 1/2] dt-bindings: edac: Add bindings for Xilinx
 Versal EDAC for DDRMC
To:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        linux-edac@vger.kernel.org
Cc:     git@amd.com, devicetree@vger.kernel.org, rric@kernel.org,
        shubhrajyoti.datta@gmail.com, james.morse@arm.com,
        tony.luck@intel.com, mchehab@kernel.org, bp@alien8.de,
        robh+dt@kernel.org, sai.krishna.potthuri@amd.com
References: <20230514172432.12505-1-shubhrajyoti.datta@amd.com>
 <20230514172432.12505-2-shubhrajyoti.datta@amd.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230514172432.12505-2-shubhrajyoti.datta@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 14/05/2023 19:24, Shubhrajyoti Datta wrote:
> Add device tree bindings for Xilinx Versal EDAC for DDR
> controller.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---

I believe there were changes... Subject prefix needs fixing, not edac
anymore.

While at it:
Subject: drop second/last, redundant "bindings for". The "dt-bindings"
prefix is already stating that these are bindings.

Best regards,
Krzysztof

