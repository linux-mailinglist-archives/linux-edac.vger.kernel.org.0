Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC65659863C
	for <lists+linux-edac@lfdr.de>; Thu, 18 Aug 2022 16:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245320AbiHROov (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 18 Aug 2022 10:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245723AbiHROou (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 18 Aug 2022 10:44:50 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0D83E764;
        Thu, 18 Aug 2022 07:44:48 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so2050108pjf.2;
        Thu, 18 Aug 2022 07:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=7v4XktmQiYSbnjprvETwVVhTiVD9OLc1xcjNusmMMB0=;
        b=II0pZdYtOeXttQieTWPsI7peyuGSd4tLirdxbt+wXw4wVRcl95sjo05tFAFD88Wdfw
         XxiX1Llc0CRlFVptNg0sirQxpFPMvFgolVgrKWx9ECTnQtVXL7M8en8whUqK3hCmVOBS
         HlyhF2w2pgWU3S3NY9dfaLNPEO6Ho15eEyDTtNWs9DzuEA48NBOdt4Q/QnslyfHmhoaz
         AMJhHVSo96kCqBnZFAGMmHlKMW6C9ueyrioPp0sxMUR4IF4VI9PWfZn4dzC1NMRd9Xbl
         9IIvniSCeJBBCIOvEbM+N+Aw0dj+4nH77S6sCcucgvapuDUW+wn1frAD+gKcoUlqGfkj
         Tcyw==
X-Gm-Message-State: ACgBeo1/praCQ4uPmhG+fCc7E9sqmuLdlV7cmt5sbS+8ztYUtl7ajqRR
        huo1u+MxAILjG3HWyBRqUQ==
X-Google-Smtp-Source: AA6agR4gZIoeLMHhdkO0CcwKC98NvtuC+kOjfzlxXMvMc09CYmNSc8Qa2z7wSvYYQVvm8ZhiD/nQdg==
X-Received: by 2002:a17:90b:3b47:b0:1fa:d988:c916 with SMTP id ot7-20020a17090b3b4700b001fad988c916mr329024pjb.240.1660833887856;
        Thu, 18 Aug 2022 07:44:47 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:80c2:7290:7acd:8d54:3db6:21d4])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090264cf00b00172a8e628e7sm1476467pli.190.2022.08.18.07.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 07:44:47 -0700 (PDT)
Received: (nullmailer pid 1839513 invoked by uid 1000);
        Thu, 18 Aug 2022 14:44:42 -0000
Date:   Thu, 18 Aug 2022 08:44:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marvin Lin <milkfafa@gmail.com>
Cc:     linux-edac@vger.kernel.org, rric@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, mchehab@kernel.org, bp@alien8.de,
        linux-kernel@vger.kernel.org, KWLIU@nuvoton.com, YSCHU@nuvoton.com,
        benjaminfair@google.com, devicetree@vger.kernel.org,
        avifishman70@gmail.com, venture@google.com,
        openbmc@lists.ozlabs.org, KFTING@nuvoton.com, JJLIU0@nuvoton.com,
        tali.perry1@gmail.com, ctcchien@nuvoton.com, kflin@nuvoton.com,
        tmaimon77@gmail.com
Subject: Re: [PATCH v13 2/3] dt-bindings: edac: nuvoton: Add document for
 NPCM memory controller
Message-ID: <20220818144442.GB1829017-robh@kernel.org>
References: <20220816094641.8484-1-milkfafa@gmail.com>
 <20220816094641.8484-3-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816094641.8484-3-milkfafa@gmail.com>
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

On Tue, Aug 16, 2022 at 05:46:40PM +0800, Marvin Lin wrote:
> Add dt-bindings document for Nuvoton NPCM memory controller.
> 
> Signed-off-by: Marvin Lin <milkfafa@gmail.com>
> ---
>  .../edac/nuvoton,npcm-memory-controller.yaml  | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
